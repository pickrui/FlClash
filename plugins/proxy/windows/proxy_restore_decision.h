#ifndef FLUTTER_PLUGIN_PROXY_RESTORE_DECISION_H_
#define FLUTTER_PLUGIN_PROXY_RESTORE_DECISION_H_

namespace proxy::internal {

inline bool ShouldCommitPending(bool abandoned, bool has_pending) {
  return !abandoned && has_pending;
}

inline bool HasOwnedField(
    bool owns_flags,
    bool owns_server,
    bool owns_bypass) {
  return owns_flags || owns_server || owns_bypass;
}

inline bool ShouldRestoreOwnedField(
    bool matches_before,
    bool matches_applied,
    bool matches_pending) {
  return !matches_before && (matches_applied || matches_pending);
}

}  // namespace proxy::internal

#endif  // FLUTTER_PLUGIN_PROXY_RESTORE_DECISION_H_