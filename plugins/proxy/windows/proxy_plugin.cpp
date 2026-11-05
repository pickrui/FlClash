#include "proxy_plugin.h"
#include "proxy_restore_decision.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <WinInet.h>
#include <Ras.h>
#include <RasError.h>
#include <algorithm>
#include <cstdint>
#include <cwchar>
#include <cwctype>
#include <optional>
#include <string>
#include <unordered_set>
#include <utility>
#include <vector>

#pragma comment(lib, "advapi32")
#pragma comment(lib, "wininet")
#pragma comment(lib, "Rasapi32")

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>

namespace
{

std::wstring Utf8ToWide(const std::string& value)
{
  if (value.empty())
  {
    return {};
  }
  const int size = MultiByteToWideChar(
      CP_UTF8, 0, value.c_str(), static_cast<int>(value.size()), nullptr, 0);
  if (size <= 0)
  {
    return std::wstring(value.begin(), value.end());
  }
  std::wstring result(size, L'\0');
  MultiByteToWideChar(
      CP_UTF8, 0, value.c_str(), static_cast<int>(value.size()),
      result.data(), size);
  return result;
}

std::wstring BuildBypassList(const flutter::EncodableList& bypassDomain)
{
  std::wstring bypassList;
  for (const auto& domain : bypassDomain) {
    const auto* value = std::get_if<std::string>(&domain);
    if (value == nullptr)
    {
      continue;
    }
    if (!bypassList.empty()) {
       bypassList += L";";
    }
    bypassList += Utf8ToWide(*value);
  }
  return bypassList;
}

bool IsValidBypassList(const flutter::EncodableList& bypassDomain)
{
  size_t totalSize = 0;
  for (const auto& domain : bypassDomain)
  {
    const auto* value = std::get_if<std::string>(&domain);
    if (value == nullptr || value->find('\0') != std::string::npos ||
        value->size() > 4096)
    {
      return false;
    }
    totalSize += value->size() + 1;
    if (totalSize > 32767)
    {
      return false;
    }
  }
  return true;
}

bool SetOptionsForConnection(
    INTERNET_PER_CONN_OPTION_LIST& list,
    LPTSTR connection)
{
  list.pszConnection = connection;
  return InternetSetOption(
      nullptr,
      INTERNET_OPTION_PER_CONNECTION_OPTION,
      &list,
      sizeof(list)) != FALSE;
}

struct ConnectionTarget
{
  bool isDefault;
  std::wstring name;
};

struct ConnectionProxyState
{
  ConnectionTarget target;
  DWORD flags;
  std::wstring proxyServer;
  std::wstring proxyBypass;
};

struct ConnectionRestoreState
{
  ConnectionProxyState before;
  ConnectionProxyState applied;
  std::optional<ConnectionProxyState> pending;
  bool abandoned = false;
};

struct ProxyRestoreSnapshot
{
  std::vector<ConnectionRestoreState> states;
  bool needsNotify = false;
};

std::optional<ProxyRestoreSnapshot> restoreSnapshot;

constexpr wchar_t kRestoreRegistryPath[] =
    L"Software\\FlClash\\ProxyRestore";
constexpr wchar_t kPendingRestoreRegistryPath[] =
  L"Software\\FlClash\\ProxyRestorePending";
constexpr wchar_t kRestoreRegistryParentPath[] = L"Software\\FlClash";
constexpr wchar_t kRestoreRegistryName[] = L"ProxyRestore";
constexpr wchar_t kPendingRestoreRegistryName[] = L"ProxyRestorePending";
constexpr DWORD kRestoreRegistryVersion = 2;

bool WriteRegistryDword(HKEY key, const std::wstring& name, DWORD value)
{
  return RegSetValueExW(
      key,
      name.c_str(),
      0,
      REG_DWORD,
      reinterpret_cast<const BYTE*>(&value),
      sizeof(value)) == ERROR_SUCCESS;
}

bool WriteRegistryString(
    HKEY key,
    const std::wstring& name,
    const std::wstring& value)
{
  const DWORD size = static_cast<DWORD>(
      (value.size() + 1) * sizeof(wchar_t));
  return RegSetValueExW(
      key,
      name.c_str(),
      0,
      REG_SZ,
      reinterpret_cast<const BYTE*>(value.c_str()),
      size) == ERROR_SUCCESS;
}

bool ReadRegistryDword(HKEY key, const std::wstring& name, DWORD& value)
{
  DWORD type = 0;
  DWORD size = sizeof(value);
  return RegQueryValueExW(
      key,
      name.c_str(),
      nullptr,
      &type,
      reinterpret_cast<BYTE*>(&value),
      &size) == ERROR_SUCCESS &&
      type == REG_DWORD &&
      size == sizeof(value);
}

bool ReadRegistryString(
    HKEY key,
    const std::wstring& name,
    std::wstring& value)
{
  DWORD type = 0;
  DWORD size = 0;
  auto status = RegQueryValueExW(
      key, name.c_str(), nullptr, &type, nullptr, &size);
  if (status != ERROR_SUCCESS || type != REG_SZ ||
      size < sizeof(wchar_t) || size > 64 * 1024 ||
      size % sizeof(wchar_t) != 0)
  {
    return false;
  }
  std::vector<wchar_t> buffer(size / sizeof(wchar_t));
  status = RegQueryValueExW(
      key,
      name.c_str(),
      nullptr,
      &type,
      reinterpret_cast<BYTE*>(buffer.data()),
      &size);
  if (status != ERROR_SUCCESS || type != REG_SZ || buffer.empty() ||
      buffer.back() != L'\0')
  {
    return false;
  }
  value.assign(buffer.data());
  return true;
}

bool ClearRegistryTree(const wchar_t* path)
{
  const auto status = RegDeleteTreeW(HKEY_CURRENT_USER, path);
    return status == ERROR_SUCCESS || status == ERROR_FILE_NOT_FOUND ||
      status == ERROR_PATH_NOT_FOUND;
}

bool ClearPersistedRestoreStates()
{
  const bool liveCleared = ClearRegistryTree(kRestoreRegistryPath);
  const bool pendingCleared = ClearRegistryTree(kPendingRestoreRegistryPath);
  return liveCleared && pendingCleared;
}

bool WriteRestoreSnapshot(
  const wchar_t* path,
  const ProxyRestoreSnapshot& snapshot)
{
  if ((snapshot.states.empty() && !snapshot.needsNotify) ||
      snapshot.states.size() > 256)
  {
    return false;
  }
  if (!ClearRegistryTree(path))
  {
    return false;
  }
  HKEY key = nullptr;
  if (RegCreateKeyExW(
          HKEY_CURRENT_USER,
      path,
          0,
          nullptr,
          REG_OPTION_NON_VOLATILE,
          KEY_SET_VALUE | KEY_QUERY_VALUE,
          nullptr,
          &key,
          nullptr) != ERROR_SUCCESS)
  {
    return false;
  }
  bool success = WriteRegistryDword(key, L"Complete", 0) &&
      WriteRegistryDword(key, L"Version", kRestoreRegistryVersion) &&
      WriteRegistryDword(
          key, L"Count", static_cast<DWORD>(snapshot.states.size())) &&
        WriteRegistryDword(
          key, L"NeedsNotify", snapshot.needsNotify ? 1 : 0);
      for (size_t i = 0; success && i < snapshot.states.size(); i++)
  {
    const auto prefix = std::to_wstring(i) + L"_";
      const auto& state = snapshot.states[i];
    success = WriteRegistryDword(
              key, prefix + L"Default",
              state.before.target.isDefault ? 1 : 0) &&
        WriteRegistryString(
          key, prefix + L"Name", state.before.target.name) &&
        WriteRegistryDword(
          key, prefix + L"BeforeFlags", state.before.flags) &&
        WriteRegistryString(
          key, prefix + L"BeforeServer", state.before.proxyServer) &&
        WriteRegistryString(
          key, prefix + L"BeforeBypass", state.before.proxyBypass) &&
        WriteRegistryDword(
          key, prefix + L"AppliedFlags", state.applied.flags) &&
        WriteRegistryString(
          key, prefix + L"AppliedServer", state.applied.proxyServer) &&
        WriteRegistryString(
          key, prefix + L"AppliedBypass", state.applied.proxyBypass) &&
        WriteRegistryDword(
          key, prefix + L"HasPending", state.pending.has_value() ? 1 : 0);
    success = success && WriteRegistryDword(
        key, prefix + L"Abandoned", state.abandoned ? 1 : 0);
      if (success && state.pending.has_value())
      {
        success = WriteRegistryDword(
              key, prefix + L"PendingFlags", state.pending->flags) &&
          WriteRegistryString(
            key, prefix + L"PendingServer", state.pending->proxyServer) &&
          WriteRegistryString(
            key, prefix + L"PendingBypass", state.pending->proxyBypass);
      }
  }
  if (success)
  {
    success = RegFlushKey(key) == ERROR_SUCCESS &&
        WriteRegistryDword(key, L"Complete", 1) &&
        RegFlushKey(key) == ERROR_SUCCESS;
  }
  RegCloseKey(key);
  if (!success)
  {
    ClearRegistryTree(path);
  }
  return success;
}

bool PersistRestoreSnapshot(const ProxyRestoreSnapshot& snapshot)
{
  if (!WriteRestoreSnapshot(kPendingRestoreRegistryPath, snapshot))
  {
    return false;
  }
  HKEY parent = nullptr;
  if (RegOpenKeyExW(
      HKEY_CURRENT_USER,
      kRestoreRegistryParentPath,
      0,
      KEY_WRITE,
      &parent) != ERROR_SUCCESS)
  {
    return false;
  }
  const bool liveCleared = ClearRegistryTree(kRestoreRegistryPath);
  const bool renamed = liveCleared &&
    RegRenameKey(
      parent,
      kPendingRestoreRegistryName,
      kRestoreRegistryName) == ERROR_SUCCESS;
  RegCloseKey(parent);
  return renamed;
}

enum class PersistedRestoreResult
{
  none,
  loaded,
  legacy,
  invalid,
};

PersistedRestoreResult LoadRestoreSnapshotAtPath(
  const wchar_t* path,
  ProxyRestoreSnapshot& snapshot)
{
  HKEY key = nullptr;
  const auto openStatus = RegOpenKeyExW(
      HKEY_CURRENT_USER,
    path,
      0,
      KEY_QUERY_VALUE,
      &key);
  if (openStatus == ERROR_FILE_NOT_FOUND)
  {
    return PersistedRestoreResult::none;
  }
  if (openStatus != ERROR_SUCCESS)
  {
    return PersistedRestoreResult::invalid;
  }
  DWORD complete = 0;
  if (!ReadRegistryDword(key, L"Complete", complete) || complete != 1)
  {
    RegCloseKey(key);
    ClearRegistryTree(path);
    return PersistedRestoreResult::none;
  }
  DWORD version = 0;
  DWORD count = 0;
  if (!ReadRegistryDword(key, L"Version", version) ||
      !ReadRegistryDword(key, L"Count", count))
  {
    RegCloseKey(key);
    return PersistedRestoreResult::invalid;
  }
  DWORD needsNotify = 0;
  const bool legacy = version == 1;
  if ((!legacy && version != kRestoreRegistryVersion) || count > 256 ||
      (legacy && count == 0) ||
      (!legacy &&
       (!ReadRegistryDword(key, L"NeedsNotify", needsNotify) ||
        needsNotify > 1 || (count == 0 && needsNotify == 0))))
  {
    RegCloseKey(key);
    return PersistedRestoreResult::invalid;
  }
  snapshot.needsNotify = needsNotify == 1;
  std::unordered_set<std::wstring> targetNames;
  bool hasDefault = false;
  for (DWORD i = 0; i < count; i++)
  {
    const auto prefix = std::to_wstring(i) + L"_";
    DWORD isDefault = 0;
    ConnectionRestoreState state = {};
    DWORD hasPending = 0;
    DWORD abandoned = 0;
    if (!ReadRegistryDword(key, prefix + L"Default", isDefault) ||
        isDefault > 1 ||
      !ReadRegistryString(
        key, prefix + L"Name", state.before.target.name) ||
      !ReadRegistryDword(
        key,
        prefix + (legacy ? L"Flags" : L"BeforeFlags"),
        state.before.flags) ||
        !ReadRegistryString(
        key,
        prefix + (legacy ? L"Server" : L"BeforeServer"),
        state.before.proxyServer) ||
        !ReadRegistryString(
        key,
        prefix + (legacy ? L"Bypass" : L"BeforeBypass"),
        state.before.proxyBypass) ||
      (!legacy &&
       (!ReadRegistryDword(
          key, prefix + L"AppliedFlags", state.applied.flags) ||
        !ReadRegistryString(
          key, prefix + L"AppliedServer", state.applied.proxyServer) ||
        !ReadRegistryString(
          key, prefix + L"AppliedBypass", state.applied.proxyBypass) ||
        !ReadRegistryDword(key, prefix + L"HasPending", hasPending) ||
        hasPending > 1)))
    {
      RegCloseKey(key);
      return PersistedRestoreResult::invalid;
    }
    state.before.target.isDefault = isDefault == 1;
    state.applied.target = state.before.target;
    if (legacy)
    {
      state.applied = state.before;
    }
    if (!legacy)
    {
      if (!ReadRegistryDword(key, prefix + L"Abandoned", abandoned))
      {
        abandoned = 0;
      }
      if (abandoned > 1)
      {
        RegCloseKey(key);
        return PersistedRestoreResult::invalid;
      }
      state.abandoned = abandoned == 1;
    }
    if (hasPending == 1)
    {
      ConnectionProxyState pending = {};
      pending.target = state.before.target;
      if (!ReadRegistryDword(
              key, prefix + L"PendingFlags", pending.flags) ||
          !ReadRegistryString(
              key, prefix + L"PendingServer", pending.proxyServer) ||
          !ReadRegistryString(
              key, prefix + L"PendingBypass", pending.proxyBypass))
      {
        RegCloseKey(key);
        return PersistedRestoreResult::invalid;
      }
      state.pending = std::move(pending);
    }
    if (state.before.target.isDefault)
    {
      if (hasDefault || !state.before.target.name.empty())
      {
        RegCloseKey(key);
        return PersistedRestoreResult::invalid;
      }
      hasDefault = true;
    }
    else if (state.before.target.name.empty() ||
         !targetNames.insert(state.before.target.name).second)
    {
      RegCloseKey(key);
      return PersistedRestoreResult::invalid;
    }
    snapshot.states.push_back(std::move(state));
  }
  RegCloseKey(key);
  if (legacy && !hasDefault)
  {
    return PersistedRestoreResult::invalid;
  }
  return legacy
      ? PersistedRestoreResult::legacy
      : PersistedRestoreResult::loaded;
}

PersistedRestoreResult LoadPersistedRestoreSnapshot(
  ProxyRestoreSnapshot& snapshot)
{
  ProxyRestoreSnapshot pendingSnapshot;
  const auto pendingResult = LoadRestoreSnapshotAtPath(
    kPendingRestoreRegistryPath, pendingSnapshot);
  if (pendingResult != PersistedRestoreResult::none)
  {
    if (pendingResult == PersistedRestoreResult::loaded ||
      pendingResult == PersistedRestoreResult::legacy)
    {
      snapshot = std::move(pendingSnapshot);
    }
    return pendingResult;
  }
  ProxyRestoreSnapshot liveSnapshot;
  const auto liveResult = LoadRestoreSnapshotAtPath(
    kRestoreRegistryPath, liveSnapshot);
  if (liveResult == PersistedRestoreResult::loaded ||
    liveResult == PersistedRestoreResult::legacy)
  {
    snapshot = std::move(liveSnapshot);
  }
  return liveResult;
}

LPTSTR ConnectionName(ConnectionTarget& target)
{
  return target.isDefault ? nullptr : target.name.data();
}

bool GetConnectionTargets(std::vector<ConnectionTarget>& targets)
{
  targets.push_back({true, {}});

  DWORD size = 0;
  DWORD count = 0;
  auto ret = RasEnumEntries(nullptr, nullptr, nullptr, &size, &count);
  if (ret == ERROR_SUCCESS && count == 0)
  {
    return true;
  }
  if (ret != ERROR_BUFFER_TOO_SMALL || size == 0 ||
    size > 4 * 1024 * 1024)
  {
    return false;
  }
  std::unordered_set<std::wstring> names;
  for (int attempt = 0; attempt < 3; attempt++)
  {
    const auto capacity =
      (size + sizeof(RASENTRYNAME) - 1) / sizeof(RASENTRYNAME);
    if (capacity == 0 || capacity > 4096)
    {
      return false;
    }
    std::vector<RASENTRYNAME> entries(capacity);
    entries[0].dwSize = sizeof(RASENTRYNAME);
    DWORD requestedSize = static_cast<DWORD>(
      entries.size() * sizeof(RASENTRYNAME));
    count = 0;
    ret = RasEnumEntries(
      nullptr, nullptr, entries.data(), &requestedSize, &count);
    if (ret == ERROR_SUCCESS)
    {
      if (count > entries.size())
      {
        return false;
      }
      for (DWORD i = 0; i < count; i++)
      {
        const std::wstring name = entries[i].szEntryName;
        if (!name.empty() && names.insert(name).second)
        {
          targets.push_back({false, name});
        }
      }
      return true;
    }
    if (ret != ERROR_BUFFER_TOO_SMALL || requestedSize <= size ||
      requestedSize > 4 * 1024 * 1024)
    {
      return false;
    }
    size = requestedSize;
  }
  return false;
}

void FreeOptionStrings(std::vector<INTERNET_PER_CONN_OPTION>& options)
{
  for (auto& option : options)
  {
    if (option.dwOption != INTERNET_PER_CONN_FLAGS &&
      option.dwOption != INTERNET_PER_CONN_FLAGS_UI &&
        option.Value.pszValue != nullptr)
    {
      GlobalFree(option.Value.pszValue);
      option.Value.pszValue = nullptr;
    }
  }
}

bool CaptureConnectionState(
    ConnectionTarget target,
    ConnectionProxyState& state)
{
  std::vector<INTERNET_PER_CONN_OPTION> options(3);
  options[0].dwOption = INTERNET_PER_CONN_FLAGS_UI;
  options[1].dwOption = INTERNET_PER_CONN_PROXY_SERVER;
  options[2].dwOption = INTERNET_PER_CONN_PROXY_BYPASS;

  INTERNET_PER_CONN_OPTION_LIST list = {};
  list.dwSize = sizeof(list);
  list.pszConnection = ConnectionName(target);
  list.dwOptionCount = static_cast<DWORD>(options.size());
  list.pOptions = options.data();
  DWORD size = sizeof(list);
  bool success = InternetQueryOption(
      nullptr,
      INTERNET_OPTION_PER_CONNECTION_OPTION,
      &list,
      &size) != FALSE;
  if (!success)
  {
    FreeOptionStrings(options);
    options[0].dwOption = INTERNET_PER_CONN_FLAGS;
    options[1].dwOption = INTERNET_PER_CONN_PROXY_SERVER;
    options[2].dwOption = INTERNET_PER_CONN_PROXY_BYPASS;
    size = sizeof(list);
    success = InternetQueryOption(
        nullptr,
        INTERNET_OPTION_PER_CONNECTION_OPTION,
        &list,
        &size) != FALSE;
  }
  if (success)
  {
    state.target = std::move(target);
    state.flags = options[0].Value.dwValue;
    state.proxyServer = options[1].Value.pszValue == nullptr
        ? L""
        : options[1].Value.pszValue;
    state.proxyBypass = options[2].Value.pszValue == nullptr
        ? L""
        : options[2].Value.pszValue;
  }
  FreeOptionStrings(options);
  return success;
}

bool CaptureConnectionStates(std::vector<ConnectionProxyState>& states)
{
  std::vector<ConnectionTarget> targets;
  if (!GetConnectionTargets(targets))
  {
    return false;
  }
  for (auto& target : targets)
  {
    ConnectionProxyState state = {};
    if (!CaptureConnectionState(std::move(target), state))
    {
      return false;
    }
    states.push_back(std::move(state));
  }
  return true;
}

bool ApplyConnectionState(ConnectionProxyState& state)
{
  std::vector<INTERNET_PER_CONN_OPTION> options(3);
  options[0].dwOption = INTERNET_PER_CONN_FLAGS;
  options[0].Value.dwValue = state.flags;
  options[1].dwOption = INTERNET_PER_CONN_PROXY_SERVER;
  options[1].Value.pszValue = state.proxyServer.data();
  options[2].dwOption = INTERNET_PER_CONN_PROXY_BYPASS;
  options[2].Value.pszValue = state.proxyBypass.data();

  INTERNET_PER_CONN_OPTION_LIST list = {};
  list.dwSize = sizeof(list);
  list.dwOptionCount = static_cast<DWORD>(options.size());
  list.pOptions = options.data();
  return SetOptionsForConnection(list, ConnectionName(state.target));
}

bool ApplyConnectionStateFields(
    ConnectionProxyState& state,
    bool restoreFlags,
    bool restoreServer,
    bool restoreBypass)
{
  std::vector<INTERNET_PER_CONN_OPTION> options;
  if (restoreFlags)
  {
    INTERNET_PER_CONN_OPTION option = {};
    option.dwOption = INTERNET_PER_CONN_FLAGS;
    option.Value.dwValue = state.flags;
    options.push_back(option);
  }
  if (restoreServer)
  {
    INTERNET_PER_CONN_OPTION option = {};
    option.dwOption = INTERNET_PER_CONN_PROXY_SERVER;
    option.Value.pszValue = state.proxyServer.data();
    options.push_back(option);
  }
  if (restoreBypass)
  {
    INTERNET_PER_CONN_OPTION option = {};
    option.dwOption = INTERNET_PER_CONN_PROXY_BYPASS;
    option.Value.pszValue = state.proxyBypass.data();
    options.push_back(option);
  }
  if (options.empty())
  {
    return true;
  }
  INTERNET_PER_CONN_OPTION_LIST list = {};
  list.dwSize = sizeof(list);
  list.dwOptionCount = static_cast<DWORD>(options.size());
  list.pOptions = options.data();
  return SetOptionsForConnection(list, ConnectionName(state.target));
}

bool SameConnectionTarget(
    const ConnectionTarget& left,
    const ConnectionTarget& right);

bool SameConnectionState(
    const ConnectionProxyState& left,
    const ConnectionProxyState& right)
{
  return SameConnectionTarget(left.target, right.target) &&
      left.flags == right.flags &&
      left.proxyServer == right.proxyServer &&
      left.proxyBypass == right.proxyBypass;
}

bool NotifySettingsChanged();

bool SameConnectionTarget(
    const ConnectionTarget& left,
    const ConnectionTarget& right)
{
  return left.isDefault == right.isDefault &&
      (left.isDefault || left.name == right.name);
}

ConnectionProxyState* FindConnectionState(
    std::vector<ConnectionProxyState>& states,
    const ConnectionTarget& target)
{
  for (auto& state : states)
  {
    if (SameConnectionTarget(state.target, target))
    {
      return &state;
    }
  }
  return nullptr;
}

const ConnectionRestoreState* FindRestoreState(
    const ProxyRestoreSnapshot& snapshot,
    const ConnectionTarget& target)
{
  for (const auto& state : snapshot.states)
  {
    if (SameConnectionTarget(state.before.target, target))
    {
      return &state;
    }
  }
  return nullptr;
}

ConnectionProxyState ManagedConnectionState(
    const ConnectionTarget& target,
    const std::wstring& server,
    const std::wstring& bypass)
{
  return {
      target,
      PROXY_TYPE_DIRECT | PROXY_TYPE_PROXY,
      server,
      bypass,
  };
}

bool LoadRestoreSnapshotIfNeeded()
{
  if (restoreSnapshot.has_value())
  {
    return true;
  }
  ProxyRestoreSnapshot persistedSnapshot;
  const auto result = LoadPersistedRestoreSnapshot(persistedSnapshot);
  if (result == PersistedRestoreResult::none)
  {
    return true;
  }
  if (result == PersistedRestoreResult::legacy)
  {
	return ClearPersistedRestoreStates();
  }
  if (result != PersistedRestoreResult::loaded)
  {
    return false;
  }
  restoreSnapshot = std::move(persistedSnapshot);
  return true;
}

bool RestoreOwnedProxyState()
{
  if (!LoadRestoreSnapshotIfNeeded())
  {
    return false;
  }
  if (!restoreSnapshot.has_value())
  {
    return true;
  }
  std::vector<ConnectionProxyState> currentStates;
  if (!CaptureConnectionStates(currentStates))
  {
    return false;
  }
  bool restored = true;
  bool changed = false;
  struct OwnedFields
  {
    size_t index;
    bool flags;
    bool server;
    bool bypass;
  };
  auto collectOwnedFields = [&]() {
    std::vector<OwnedFields> fields;
    for (size_t index = 0; index < restoreSnapshot->states.size(); index++)
    {
      auto& state = restoreSnapshot->states[index];
      if (state.abandoned)
      {
        continue;
      }
      auto* current = FindConnectionState(currentStates, state.before.target);
      if (current == nullptr)
      {
        continue;
      }
      const auto* pending = state.pending.has_value() ? &*state.pending : nullptr;
      const bool restoreFlags = proxy::internal::ShouldRestoreOwnedField(
          current->flags == state.before.flags,
          current->flags == state.applied.flags,
          pending != nullptr && current->flags == pending->flags);
      const bool restoreServer = proxy::internal::ShouldRestoreOwnedField(
          current->proxyServer == state.before.proxyServer,
          current->proxyServer == state.applied.proxyServer,
          pending != nullptr && current->proxyServer == pending->proxyServer);
      const bool restoreBypass = proxy::internal::ShouldRestoreOwnedField(
          current->proxyBypass == state.before.proxyBypass,
          current->proxyBypass == state.applied.proxyBypass,
          pending != nullptr && current->proxyBypass == pending->proxyBypass);
      if (restoreFlags || restoreServer || restoreBypass)
      {
        fields.push_back({index, restoreFlags, restoreServer, restoreBypass});
      }
    }
    return fields;
  };
  auto ownedStates = collectOwnedFields();
  if (!ownedStates.empty() && !restoreSnapshot->needsNotify)
  {
    auto transition = *restoreSnapshot;
    transition.needsNotify = true;
    if (!PersistRestoreSnapshot(transition))
    {
      return false;
    }
    restoreSnapshot = std::move(transition);
    ownedStates = collectOwnedFields();
  }
  for (const auto& owned : ownedStates)
  {
    changed = true;
    auto& before = restoreSnapshot->states[owned.index].before;
    restored = ApplyConnectionStateFields(
        before, owned.flags, owned.server, owned.bypass) && restored;
  }
  const bool notified =
    (!changed && !restoreSnapshot->needsNotify) || NotifySettingsChanged();
  if (!restored || !notified || !ClearPersistedRestoreStates())
  {
    restoreSnapshot->needsNotify = !notified;
    PersistRestoreSnapshot(*restoreSnapshot);
    return false;
  }
  restoreSnapshot.reset();
  return true;
}

bool NotifySettingsChanged()
{
  const bool changed = InternetSetOption(
      nullptr, INTERNET_OPTION_SETTINGS_CHANGED, nullptr, 0) != FALSE;
  const bool refreshed = InternetSetOption(
      nullptr, INTERNET_OPTION_REFRESH, nullptr, 0) != FALSE;
  return changed && refreshed;
}

bool startProxy(const int port, const flutter::EncodableList& bypassDomain)
{
  const bool hasUnfinishedTransition =
    restoreSnapshot.has_value() &&
    (restoreSnapshot->needsNotify ||
     std::any_of(
       restoreSnapshot->states.begin(),
       restoreSnapshot->states.end(),
       [](const ConnectionRestoreState& state) {
         return state.pending.has_value();
       }));
  if ((!restoreSnapshot.has_value() || hasUnfinishedTransition) &&
    !RestoreOwnedProxyState())
  {
    return false;
  }
  std::vector<ConnectionProxyState> currentStates;
  if (!CaptureConnectionStates(currentStates))
  {
    return false;
  }
  const auto previousSnapshot = restoreSnapshot;
  const auto server = Utf8ToWide("127.0.0.1:" + std::to_string(port));
  const auto bypassList = BuildBypassList(bypassDomain);
  ProxyRestoreSnapshot transition;
  transition.needsNotify = previousSnapshot.has_value() &&
    previousSnapshot->needsNotify;
  if (previousSnapshot.has_value())
  {
    for (const auto& restoreState : previousSnapshot->states)
    {
      if (restoreState.abandoned)
      {
        transition.states.push_back(restoreState);
        continue;
      }
      auto* current = FindConnectionState(
          currentStates, restoreState.before.target);
    if (current == nullptr)
      {
        auto abandoned = restoreState;
        abandoned.pending.reset();
        abandoned.abandoned = true;
        transition.states.push_back(std::move(abandoned));
        continue;
      }
      auto next = restoreState;
      const bool ownsFlags =
          current->flags == restoreState.applied.flags;
      const bool ownsServer =
          current->proxyServer == restoreState.applied.proxyServer;
      const bool ownsBypass =
          current->proxyBypass == restoreState.applied.proxyBypass;
      if (!proxy::internal::HasOwnedField(
              ownsFlags, ownsServer, ownsBypass))
      {
        next.pending.reset();
        next.abandoned = true;
        transition.states.push_back(std::move(next));
        continue;
      }
      const auto managed = ManagedConnectionState(
          restoreState.before.target, server, bypassList);
      auto pending = *current;
      if (ownsFlags)
      {
        pending.flags = managed.flags;
      }
      else
      {
        next.before.flags = current->flags;
        next.applied.flags = current->flags;
      }
      if (ownsServer)
      {
        pending.proxyServer = managed.proxyServer;
      }
      else
      {
        next.before.proxyServer = current->proxyServer;
        next.applied.proxyServer = current->proxyServer;
      }
      if (ownsBypass)
      {
        pending.proxyBypass = managed.proxyBypass;
      }
      else
      {
        next.before.proxyBypass = current->proxyBypass;
        next.applied.proxyBypass = current->proxyBypass;
      }
      next.pending = std::move(pending);
      transition.states.push_back(std::move(next));
    }
    for (const auto& current : currentStates)
    {
      if (FindRestoreState(*previousSnapshot, current.target) == nullptr)
      {
        ConnectionRestoreState next = {};
        next.before = current;
        next.applied = current;
        next.pending = ManagedConnectionState(
            current.target, server, bypassList);
        transition.states.push_back(std::move(next));
      }
    }
  }
  else
  {
    for (const auto& current : currentStates)
    {
      ConnectionRestoreState next = {};
      next.before = current;
      next.applied = current;
      next.pending = ManagedConnectionState(
          current.target, server, bypassList);
      transition.states.push_back(std::move(next));
    }
  }
  if (transition.states.empty())
  {
    if (previousSnapshot.has_value())
    {
      if (!ClearPersistedRestoreStates())
      {
        return false;
      }
      restoreSnapshot.reset();
    }
    return false;
  }
  if (!PersistRestoreSnapshot(transition))
  {
    return false;
  }
  restoreSnapshot = transition;
  const bool hasManagedTarget = std::any_of(
      restoreSnapshot->states.begin(),
      restoreSnapshot->states.end(),
      [](const ConnectionRestoreState& state) {
        return proxy::internal::ShouldCommitPending(
            state.abandoned, state.pending.has_value());
      });
  if (!hasManagedTarget)
  {
    return false;
  }
  std::vector<ConnectionProxyState> rollbackStates;
  bool applied = true;
  for (auto& state : restoreSnapshot->states)
  {
    if (state.abandoned)
    {
      continue;
    }
    auto* current = FindConnectionState(currentStates, state.before.target);
    if (current == nullptr || !state.pending.has_value())
    {
      applied = false;
      break;
    }
    rollbackStates.push_back(*current);
    if (!ApplyConnectionState(*state.pending))
    {
      applied = false;
      break;
    }
  }
  const bool notified = NotifySettingsChanged();
  if (applied && notified)
  {
    auto committed = *restoreSnapshot;
    for (auto& state : committed.states)
    {
      if (!proxy::internal::ShouldCommitPending(
              state.abandoned, state.pending.has_value()))
      {
        continue;
      }
      state.applied = *state.pending;
      state.pending.reset();
    }
    if (PersistRestoreSnapshot(committed))
    {
      restoreSnapshot = std::move(committed);
      return true;
    }
  }
  auto rollbackTransition = *restoreSnapshot;
  rollbackTransition.needsNotify = true;
  if (!PersistRestoreSnapshot(rollbackTransition))
  {
    return false;
  }
  restoreSnapshot = std::move(rollbackTransition);
  bool rolledBack = true;
  std::vector<ConnectionProxyState> rollbackCurrentStates;
  if (!CaptureConnectionStates(rollbackCurrentStates))
  {
    rolledBack = false;
  }
  for (size_t i = 0; rolledBack && i < rollbackStates.size(); i++)
  {
    auto* current = FindConnectionState(
      rollbackCurrentStates, rollbackStates[i].target);
    auto* restoreState = FindRestoreState(
        *restoreSnapshot, rollbackStates[i].target);
    if (restoreState == nullptr)
    {
      continue;
    }
    const auto& pending = restoreState->pending;
    if (current == nullptr || !pending.has_value())
    {
      continue;
    }
    if (SameConnectionState(*current, *pending))
    {
      rolledBack = ApplyConnectionState(rollbackStates[i]) && rolledBack;
    }
  }
  const bool rollbackNotified = NotifySettingsChanged();
  rolledBack = rollbackNotified && rolledBack;
  if (rolledBack)
  {
    if (previousSnapshot.has_value())
    {
      if (PersistRestoreSnapshot(*previousSnapshot))
      {
        restoreSnapshot = previousSnapshot;
      }
    }
    else if (ClearPersistedRestoreStates())
    {
      restoreSnapshot.reset();
    }
  }
  return false;
}

bool stopProxy()
{
  return RestoreOwnedProxyState();
}

}  // namespace

namespace proxy
{

  // static
  void ProxyPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "proxy",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<ProxyPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  ProxyPlugin::ProxyPlugin() {}

  ProxyPlugin::~ProxyPlugin() {}

  void ProxyPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("StopProxy") == 0)
    {
      result->Success(stopProxy());
    }
    else if (method_call.method_name().compare("StartProxy") == 0)
    {
      auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments == nullptr)
      {
        result->Error("bad_args", "StartProxy requires argument map");
        return;
      }
      auto portIt = arguments->find(flutter::EncodableValue("port"));
      auto bypassDomainIt = arguments->find(flutter::EncodableValue("bypassDomain"));
      if (portIt == arguments->end() || bypassDomainIt == arguments->end())
      {
        result->Error("bad_args", "StartProxy requires port and bypassDomain");
        return;
      }
      auto *port = std::get_if<int>(&portIt->second);
      auto *bypassDomain = std::get_if<flutter::EncodableList>(&bypassDomainIt->second);
      if (port == nullptr || *port < 1 || *port > 65535 ||
        bypassDomain == nullptr || !IsValidBypassList(*bypassDomain))
      {
        result->Error("bad_args", "StartProxy argument types are invalid");
        return;
      }
      result->Success(startProxy(*port, *bypassDomain));
    }
    else
    {
      result->NotImplemented();
    }
  }
} // namespace proxy
