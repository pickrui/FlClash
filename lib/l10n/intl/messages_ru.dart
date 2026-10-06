// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(value) => "Доступно ${value}";

  static String m1(count, skipped) =>
      "Будет добавлено: ${count}, пропущено (уже есть): ${skipped}";

  static String m2(status) => "Сервер вернул HTTP ${status}";

  static String m3(error) => "Напрямую: ${error}";

  static String m4(error) => "Локальный прокси: ${error}";

  static String m5(code) => "Системная ошибка ${code}";

  static String m6(value) => "Комиссия ${value}";

  static String m7(line) => "Неверный формат конфигурации в строке ${line}.";

  static String m8(expected, actual) =>
      "Ожидалось: ${expected}; получено: ${actual}.";

  static String m9(code) =>
      "Windows заблокировала запуск ядра прокси (системная ошибка ${code}). Проверьте журнал защиты в Безопасности Windows, политику контроля приложений, источник и подпись установщика.";

  static String m10(name) =>
      "${name} все еще используется группой, правилом или цепочкой прокси";

  static String m11(example) =>
      "Проверьте содержимое для этого типа правила. Пример: ${example}";

  static String m12(name) =>
      "${name} недоступен. Выберите существующий источник правил.";

  static String m13(name) =>
      "${name} недоступна. Выберите цель из текущей конфигурации.";

  static String m14(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m15(label) =>
      "Вы уверены, что хотите удалить выбранные ${label}?";

  static String m16(label) =>
      "Вы уверены, что хотите удалить текущий ${label}?";

  static String m17(label) => "Детали: ${label}";

  static String m18(count) =>
      "Пройдено ${count} из 2 независимых проверок HTTPS";

  static String m19(label) => "${label} не может быть пустым";

  static String m20(count) => "${count} записей";

  static String m21(label) => "Текущий ${label} уже существует";

  static String m22(date) => "Истекает: ${date}";

  static String m23(name) => "${name} пропущено";

  static String m24(name) => "${name} обновлено";

  static String m25(name) => "Обновление ${name}...";

  static String m26(name) =>
      "Циклическая ссылка группы «${name}». Выберите другого участника.";

  static String m27(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m28(count) => "${count} часов";

  static String m29(target) => "${target} — недопустимая политика";

  static String m30(ruleSet) => "${ruleSet} — недопустимый набор правил";

  static String m31(subRule) => "${subRule} — недопустимый SUB_RULE";

  static String m32(line, message) => "Строка ${line}: ${message}";

  static String m33(appName) =>
      "1. Откройте Системные настройки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте ${appName} в списке\n\nПосле настройки вернитесь в приложение и продолжайте работу. Спасибо за сотрудничество.";

  static String m34(label, max) => "«${label}» — не более ${max} символов";

  static String m35(size) => "Освобождено ${size}";

  static String m36(count) =>
      "${Intl.plural(count, one: '${count} минута назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m37(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m38(code) =>
      "Сервер запретил доступ (HTTP ${code}). Возможно, ссылка устарела или учётные данные неверны";

  static String m39(code) => "Сервер отклонил запрос (HTTP ${code})";

  static String m40(code) =>
      "По этому адресу ничего не найдено (HTTP ${code}). Проверьте правильность URL";

  static String m41(detail) => "Сетевой запрос не выполнен: ${detail}";

  static String m42(code) =>
      "На сервере произошла ошибка (HTTP ${code}). Повторите попытку позже";

  static String m43(kept, total) => "Оставлено ${kept} из ${total} узлов";

  static String m44(name) => "${name}, исключён";

  static String m45(name) => "${name}, оставлен";

  static String m46(label) => "${label} пока отсутствуют";

  static String m47(label) => "${label} должно быть числом";

  static String m48(name) =>
      "Имя «${name}» уже используется. Переименуйте личную группу.";

  static String m49(name) =>
      "Имя ${name} уже занято другим прокси или группой прокси";

  static String m50(path) =>
      "Группы прокси ссылаются друг на друга по кругу: ${path}";

  static String m51(names) => "Эти провайдеры прокси не существуют: ${names}";

  static String m52(names) => "Эти прокси или политики не существуют: ${names}";

  static String m53(name) =>
      "${name} — встроенное имя политики, его нельзя использовать";

  static String m54(id) => "Тариф #${id}";

  static String m55(port) => "Подставлен рекомендуемый порт ${port}.";

  static String m56(label) => "${label} должен быть числом от 1024 до 49151";

  static String m57(port) =>
      "Не удалось начать прослушивание смешанного порта ${port}. Возможно, он занят другим приложением. Измените порт, чтобы сразу повторить попытку.";

  static String m58(profiles) => "Ресурс используется в ${profiles}";

  static String m59(profiles) => "Переименование изменит ссылки в ${profiles}";

  static String m60(profiles) =>
      "Перед переименованием измените ссылки в исходном профиле: ${profiles}";

  static String m61(profiles) =>
      "Не удалось прочитать профили для проверки ссылок: ${profiles}";

  static String m62(count) => "${count} прокси";

  static String m63(name) =>
      "Узел ${name} уже используется другой включенной цепочкой или имеет конфликт связей цепочки прокси";

  static String m64(name) => "Узел ${name} недоступен для этой позиции";

  static String m65(address) =>
      "До запуска системный прокси указывал на ${address}.";

  static String m66(name) =>
      "До запуска трафик шёл через другой VPN или виртуальный адаптер: ${name}.";

  static String m67(count) => "${count}д";

  static String m68(count) => "${count}ч";

  static String m69(count) => "${count}мин";

  static String m70(time) => "Куплено: ${time}";

  static String m71(name, path) =>
      "${name} используется исходной конфигурацией в ${path}";

  static String m72(min, max) => "Допустимый диапазон ${min} – ${max}";

  static String m73(value) => "Осталось: ${value}";

  static String m74(count) => "Осталось ${count}";

  static String m75(seconds) => "Повтор через ${seconds} с";

  static String m76(count) =>
      "${Intl.plural(count, one: '${count} правило', few: '${count} правила', many: '${count} правил', other: '${count} правила')}";

  static String m77(appName) => "${appName} (Безопасный режим)";

  static String m78(count) => "${count} секунд";

  static String m79(label) => "«${label}» — только одно значение";

  static String m80(fields) => "Проверьте настройки: ${fields}";

  static String m81(count) => "Устройства (${count})";

  static String m82(name, profile) =>
      "${name} все еще используется правилом или группой в профиле «${profile}»";

  static String m83(region) => "Ретранслятор ${region}";

  static String m84(name) =>
      "Это устройство выйдет из сети ${name}, а данные входа будут удалены с него. Если сеть сейчас недоступна, удалите устройство в консоли администратора Tailscale.";

  static String m85(build) => "Номер сборки: ${build}";

  static String m86(version) => "Версия: ${version}";

  static String m87(label) => "${label} должен быть URL";

  static String m88(count) =>
      "${Intl.plural(count, one: '${count} год назад', few: '${count} года назад', many: '${count} лет назад', other: '${count} года назад')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("О программе"),
    "accessControl": MessageLookupByLibrary.simpleMessage("Контроль доступа"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить только выбранным приложениям доступ к VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка доступа приложений к прокси",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные приложения будут исключены из VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки контроля доступа",
    ),
    "accessToken": MessageLookupByLibrary.simpleMessage("Токен доступа"),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("Баланс"),
    "action": MessageLookupByLibrary.simpleMessage("Действие"),
    "action_copyEnv": MessageLookupByLibrary.simpleMessage(
      "Копировать переменные прокси",
    ),
    "action_delayTest": MessageLookupByLibrary.simpleMessage(
      "Проверить задержку узлов",
    ),
    "action_directMode": MessageLookupByLibrary.simpleMessage(
      "Прямое подключение",
    ),
    "action_exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "action_globalMode": MessageLookupByLibrary.simpleMessage(
      "Глобальный режим",
    ),
    "action_mode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "action_ruleMode": MessageLookupByLibrary.simpleMessage("Режим правил"),
    "action_start": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_updateProfiles": MessageLookupByLibrary.simpleMessage(
      "Обновить профили",
    ),
    "action_view": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "activate": MessageLookupByLibrary.simpleMessage("Активировать"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "Активировать этот тариф? Он станет вашим активным тарифом.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage(
      "Активировать тариф",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Добавить профиль"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Добавить группу прокси",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавить правило"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Добавленные правила"),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressCopied": MessageLookupByLibrary.simpleMessage("Адрес скопирован"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("Адрес сервера WebDAV"),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный адрес WebDAV",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Расширенная конфигурация",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Предоставляет разнообразные варианты конфигурации",
    ),
    "allServices": MessageLookupByLibrary.simpleMessage("Все сервисы"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешить приложениям обходить VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Некоторые приложения могут обходить VPN при включении",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Разрешить LAN"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ к прокси через локальную сеть",
    ),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage(
      "Временно разрешить",
    ),
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("К доплате"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("К оплате"),
    "announcement": MessageLookupByLibrary.simpleMessage("Объявление"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "API-сервис работает нормально",
    ),
    "apiAvailableWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "API доступен с временным исключением для сертификата. Аккаунт и конфигурация узлов не синхронизированы. Устраните проблему с сертификатом и повторите проверку.",
        ),
    "app": MessageLookupByLibrary.simpleMessage("Приложение"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
    ),
    "appProviderLibrary": MessageLookupByLibrary.simpleMessage(
      "Библиотека провайдеров",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Добавить системный DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Принудительно добавить системный DNS к конфигурации",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Приложение"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с приложением",
    ),
    "authentication": MessageLookupByLibrary.simpleMessage(
      "Аутентификация локального прокси",
    ),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось применить настройки аутентификации",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя и пароль для HTTP/SOCKS. Автонастройка системного HTTP-прокси приостановлена; TUN/VPN остаётся доступен.",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "От 1 до 255 байт UTF-8, без управляющих символов",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Не применяется при включённой аутентификации локального прокси",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "От 1 до 255 байт UTF-8, без двоеточий и управляющих символов",
    ),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автоматическое закрытие соединений",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически закрывать соединения после смены узла",
    ),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("Авто IPv6"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "Автопереключение IPv6 по поддержке локальной сети",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Следовать автозапуску системы",
    ),
    "autoRenewOff": MessageLookupByLibrary.simpleMessage("Автопродление: выкл"),
    "autoRenewOn": MessageLookupByLibrary.simpleMessage("Автопродление: вкл"),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматический запуск при открытии приложения",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автоматическая настройка системного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления (минуты)",
    ),
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("Выберите тариф"),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование и восстановление",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Синхронизация данных через WebDAV или файлы",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана более новой версией приложения. Обновите приложение перед восстановлением",
    ),
    "backupRetention": MessageLookupByLibrary.simpleMessage("Хранить копий"),
    "backupRetentionDesc": MessageLookupByLibrary.simpleMessage(
      "При каждом резервном копировании старые копии этого устройства в WebDAV удаляются",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование успешно",
    ),
    "balance": MessageLookupByLibrary.simpleMessage("Баланс"),
    "balanceDeductionHint": MessageLookupByLibrary.simpleMessage(
      "Покупки сначала списываются с баланса, а недостающая сумма покрывается комиссией.",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфигурация"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное изменение базовых настроек",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Основная информация"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Массовое добавление"),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному значению на строку или через запятую",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной записи на строку: ключ, пробел, значение",
    ),
    "batchPreviewTip": m1,
    "behavior": MessageLookupByLibrary.simpleMessage("Поведение"),
    "billingPeriodLabel": MessageLookupByLibrary.simpleMessage("Период оплаты"),
    "bind": MessageLookupByLibrary.simpleMessage("Привязать"),
    "bindCoupon": MessageLookupByLibrary.simpleMessage("Применить купон"),
    "bindCouponIntro": MessageLookupByLibrary.simpleMessage(
      "Введите официальный код купона. Разница рассчитывается за оставшийся срок, а повторяющийся купон также меняет цену продления.",
    ),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режим черного списка",
    ),
    "blockQuic": MessageLookupByLibrary.simpleMessage("Блокировать QUIC"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "Отклонять трафик UDP 443, чтобы соединения переключались на TCP",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("Блокировать WebRTC"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "Отклонять STUN-трафик для снижения утечек IP через WebRTC. Звонки и прямые аудиотрансляции могут перестать работать.",
    ),
    "buy": MessageLookupByLibrary.simpleMessage("Купить"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Обход домена"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только при включенном системном прокси",
    ),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("Алгоритм кэша"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш поврежден. Хотите очистить его?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Размер кэша"),
    "calculatingQuote": MessageLookupByLibrary.simpleMessage("Расчёт…"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к камере в системных настройках, чтобы сканировать QR-коды, или выберите изображение QR-кода из галереи.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется доступ к камере",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Камера недоступна",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Отменить выбор всего",
    ),
    "certificateCheckOnlyHint": MessageLookupByLibrary.simpleMessage(
      "Это действие только проверяет доступность API. Вход в аккаунт и загрузка конфигурации узлов не выполняются.",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage(
      "Срок действия сертификата истёк",
    ),
    "certificateHostnameHint": MessageLookupByLibrary.simpleMessage(
      "Попробуйте другую сеть и завершите авторизацию Wi-Fi. Если ошибка остаётся, попросите поставщика сервиса проверить соответствие сертификата домену сервера.",
    ),
    "certificateHostnameMismatch": MessageLookupByLibrary.simpleMessage(
      "Сертификат не соответствует запрошенному домену",
    ),
    "certificateNotYetValid": MessageLookupByLibrary.simpleMessage(
      "Сертификат ещё не вступил в силу",
    ),
    "certificateRevoked": MessageLookupByLibrary.simpleMessage(
      "Сертификат отозван",
    ),
    "certificateRevokedHint": MessageLookupByLibrary.simpleMessage(
      "Попросите поставщика сервиса заменить отозванный сертификат. Повторные попытки или изменение времени системы не устранят отзыв сертификата.",
    ),
    "certificateSyncRetryDescription": MessageLookupByLibrary.simpleMessage(
      "После подтверждения будут проверены соединение, обновлены данные аккаунта и загружена конфигурация узлов. Исключение для сертификата отменяется по завершении этой синхронизации.",
    ),
    "certificateUnknownHint": MessageLookupByLibrary.simpleMessage(
      "Проверьте дату и время системы и попробуйте другую сеть. Если проверка по-прежнему не проходит, передайте эту ошибку поставщику сервиса.",
    ),
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "Цепочка сертификатов не является доверенной",
    ),
    "certificateUntrustedHint": MessageLookupByLibrary.simpleMessage(
      "Попробуйте другую сеть, например точку доступа телефона, и проверьте обновления системы. Если антивирус или корпоративная сеть проверяет HTTPS, обратитесь к администратору. Если ошибка остаётся, попросите поставщика сервиса проверить цепочку сертификатов.",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "Сначала синхронизируйте системную дату и время. Если время верное, необходимо исправить сертификат на сервере.",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Важные изменения",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Новые функции"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Исправления"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage(
      "Производительность",
    ),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Откаты"),
    "checkApi": MessageLookupByLibrary.simpleMessage("Проверить API"),
    "checkRouting": MessageLookupByLibrary.simpleMessage(
      "Проверить конфигурацию",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Проверить обновления"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "Текущее приложение уже является последней версией",
    ),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить обновления. Проверьте сеть и повторите попытку",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("Проверка..."),
    "chooseMembers": MessageLookupByLibrary.simpleMessage("Выбрать участников"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("Очистить всё"),
    "clearData": MessageLookupByLibrary.simpleMessage("Очистить данные"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Удалить настройку цепочки",
    ),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Очистить поиск"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Импорт из буфера обмена",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось скопировать в буфер обмена. Возможно, выделение слишком велико",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "closeAllConnections": MessageLookupByLibrary.simpleMessage(
      "Закрыть все соединения",
    ),
    "cloudApiAccessDenied": MessageLookupByLibrary.simpleMessage(
      "Доступ к сети запрещён",
    ),
    "cloudApiAddressInUse": MessageLookupByLibrary.simpleMessage(
      "Сетевой адрес или порт уже используется",
    ),
    "cloudApiAddressUnavailable": MessageLookupByLibrary.simpleMessage(
      "Сетевой адрес недоступен",
    ),
    "cloudApiBadGateway": MessageLookupByLibrary.simpleMessage(
      "Шлюз получил некорректный ответ вышестоящего сервера",
    ),
    "cloudApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "Сервер отклонил запрос как некорректный",
    ),
    "cloudApiClockSkew": MessageLookupByLibrary.simpleMessage(
      "Часы устройства слишком расходятся с сервером. Включите автоматическую установку времени и повторите.",
    ),
    "cloudApiConnectTimeout": MessageLookupByLibrary.simpleMessage(
      "Время ожидания подключения истекло",
    ),
    "cloudApiConnectionAborted": MessageLookupByLibrary.simpleMessage(
      "Соединение прервано",
    ),
    "cloudApiConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка подключения",
    ),
    "cloudApiConnectionRefused": MessageLookupByLibrary.simpleMessage(
      "В подключении отказано",
    ),
    "cloudApiConnectionReset": MessageLookupByLibrary.simpleMessage(
      "Соединение сброшено",
    ),
    "cloudApiDnsEmpty": MessageLookupByLibrary.simpleMessage(
      "DNS вернул пустой ответ: возможны помехи или сбой системного DNS",
    ),
    "cloudApiDnsFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка разрешения DNS",
    ),
    "cloudApiDnsUnknownHost": MessageLookupByLibrary.simpleMessage(
      "DNS не нашёл этот домен",
    ),
    "cloudApiForbidden": MessageLookupByLibrary.simpleMessage(
      "Доступ запрещён сервером",
    ),
    "cloudApiGatewayTimeout": MessageLookupByLibrary.simpleMessage(
      "Шлюз не дождался ответа вышестоящего сервера",
    ),
    "cloudApiHttpError": m2,
    "cloudApiInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Неверный формат ответа сервера",
    ),
    "cloudApiMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Метод запроса не разрешён",
    ),
    "cloudApiNetworkAuthRequired": MessageLookupByLibrary.simpleMessage(
      "Для доступа к этой сети требуется авторизация",
    ),
    "cloudApiNetworkResourcesExhausted": MessageLookupByLibrary.simpleMessage(
      "Недостаточно сетевых ресурсов системы",
    ),
    "cloudApiNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "Сеть недоступна",
    ),
    "cloudApiNotFound": MessageLookupByLibrary.simpleMessage(
      "Запрошенный API или ресурс не найден",
    ),
    "cloudApiProxyAuthFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка аутентификации прокси (HTTP 407)",
    ),
    "cloudApiProxyFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка подключения к прокси",
    ),
    "cloudApiRateLimited": MessageLookupByLibrary.simpleMessage(
      "Слишком много запросов; повторите позже",
    ),
    "cloudApiReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Время ожидания ответа истекло",
    ),
    "cloudApiRedirectInvalid": MessageLookupByLibrary.simpleMessage(
      "Некорректное перенаправление сервера",
    ),
    "cloudApiRedirectLimit": MessageLookupByLibrary.simpleMessage(
      "Слишком много перенаправлений сервера",
    ),
    "cloudApiRedirectLoop": MessageLookupByLibrary.simpleMessage(
      "Обнаружен цикл перенаправлений сервера",
    ),
    "cloudApiRequestCanceled": MessageLookupByLibrary.simpleMessage(
      "Запрос отменён",
    ),
    "cloudApiRequestTooLarge": MessageLookupByLibrary.simpleMessage(
      "Запрос превышает допустимый для сервера размер",
    ),
    "cloudApiResponseInterrupted": MessageLookupByLibrary.simpleMessage(
      "Соединение закрыто до получения полного ответа",
    ),
    "cloudApiResponseTooLarge": MessageLookupByLibrary.simpleMessage(
      "Ответ сервера превышает допустимый размер",
    ),
    "cloudApiRouteDirect": m3,
    "cloudApiRouteProxy": m4,
    "cloudApiSendTimeout": MessageLookupByLibrary.simpleMessage(
      "Время отправки запроса истекло",
    ),
    "cloudApiServerError": MessageLookupByLibrary.simpleMessage(
      "Внутренняя ошибка сервера",
    ),
    "cloudApiServerRequestTimeout": MessageLookupByLibrary.simpleMessage(
      "Сервер не получил запрос вовремя",
    ),
    "cloudApiServerUnconfigured": MessageLookupByLibrary.simpleMessage(
      "На сервере не настроен ключ для этого приложения. Обратитесь в поддержку.",
    ),
    "cloudApiServiceUnavailable": MessageLookupByLibrary.simpleMessage(
      "Сервис временно недоступен",
    ),
    "cloudApiSignatureRejected": MessageLookupByLibrary.simpleMessage(
      "Сервер отклонил подпись приложения. Переустановите последнюю официальную сборку.",
    ),
    "cloudApiSystemError": m5,
    "cloudApiTimeout": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса истекло",
    ),
    "cloudApiTlsAlgorithmFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось согласовать криптографические алгоритмы TLS",
    ),
    "cloudApiTlsFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка рукопожатия TLS",
    ),
    "cloudApiTlsInterrupted": MessageLookupByLibrary.simpleMessage(
      "Соединение закрыто до завершения рукопожатия TLS",
    ),
    "cloudApiTlsProtocolFailed": MessageLookupByLibrary.simpleMessage(
      "Несовместимый протокол TLS или некорректный ответ TLS",
    ),
    "cloudCertificateSyncFailed": MessageLookupByLibrary.simpleMessage(
      "Проверка API пройдена, но синхронизация аккаунта или конфигурации узлов не удалась: ",
    ),
    "cloudConfigSyncIncomplete": MessageLookupByLibrary.simpleMessage(
      "Конфигурация узлов не загружена. Устраните ошибку загрузки и повторите синхронизацию.",
    ),
    "cloudSyncedWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "Аккаунт и конфигурация синхронизированы с временным исключением для сертификата. Проверка восстановлена; устраните проблему до следующей синхронизации.",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Код подтверждения отправлен",
    ),
    "collapseList": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "commission": MessageLookupByLibrary.simpleMessage("Комиссия"),
    "commissionBalance": m6,
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Данные обнаружены в конфигурации",
    ),
    "configParseErrorAtLine": m7,
    "configRecoveryKeyring": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить доступ к системной связке ключей (Secret Service). Включите и разблокируйте KWallet или GNOME Keyring в настройках системы, затем повторите попытку.",
    ),
    "configRecoveryMessage": MessageLookupByLibrary.simpleMessage(
      "Локальные настройки временно недоступны. Ваши данные сохранены. Разблокируйте устройство и повторите попытку или откройте приложение позже.",
    ),
    "configRecoveryMissingKey": MessageLookupByLibrary.simpleMessage(
      "Ключ шифрования существующих настроек отсутствует или недействителен. Запустите приложение от исходного пользователя на исходном устройстве или восстановите резервную копию. Повторная попытка не воссоздаст утерянный ключ.",
    ),
    "configRecoveryReset": MessageLookupByLibrary.simpleMessage(
      "Создать копию и сбросить",
    ),
    "configRecoveryResetConfirm": MessageLookupByLibrary.simpleMessage(
      "Создать зашифрованную резервную копию всех локальных настроек, подписок, правил и данных аккаунта, затем сбросить приложение? Потребуется снова войти и восстановить или импортировать подписки и настройки. Копия защищена текущим пользователем Windows, но не восстановит утерянный ключ шифрования.",
    ),
    "configRecoveryResetDone": MessageLookupByLibrary.simpleMessage(
      "Зашифрованная резервная копия исходных данных сохранена в указанной ниже папке. Закройте и снова откройте приложение для повторной настройки.",
    ),
    "configRecoveryResetFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось завершить зашифрованное резервное копирование и сброс. Оставшиеся исходные данные не будут удалены без проверенной копии. Повторите операцию или закройте и снова откройте приложение для её завершения.",
    ),
    "configRecoveryRetry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "configRecoveryStorage": MessageLookupByLibrary.simpleMessage(
      "Не удалось прочитать или сохранить локальные настройки либо ключ шифрования. Проверьте доступ к папке данных приложения и системному защищённому хранилищу, затем повторите попытку.",
    ),
    "configRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Восстановление локальных настроек",
    ),
    "configRecoveryUnreadable": MessageLookupByLibrary.simpleMessage(
      "Локальные настройки не удаётся расшифровать, либо файл повреждён. Исходные файлы сохранены. Восстановите подходящие ключ и резервную копию настроек или создайте копию и выполните сброс.",
    ),
    "configRecoveryUseLocalStorage": MessageLookupByLibrary.simpleMessage(
      "Хранить в локальном файле",
    ),
    "configRecoveryUseLocalStorageConfirm":
        MessageLookupByLibrary.simpleMessage(
          "Хранить ключи шифрования и учётные данные аккаунта не в системной связке ключей, а в файле в папке данных приложения, доступном только вашему пользователю? Любая программа, запущенная от вашего имени, сможет прочитать их и расшифровать локальные настройки. Этот выбор будет действовать и дальше.",
        ),
    "configTypeMismatch": m8,
    "configValueTypeBoolean": MessageLookupByLibrary.simpleMessage(
      "логическое значение",
    ),
    "configValueTypeInteger": MessageLookupByLibrary.simpleMessage(
      "целое число",
    ),
    "configValueTypeList": MessageLookupByLibrary.simpleMessage("список"),
    "configValueTypeNull": MessageLookupByLibrary.simpleMessage(
      "пустое значение",
    ),
    "configValueTypeNumber": MessageLookupByLibrary.simpleMessage("число"),
    "configValueTypeObject": MessageLookupByLibrary.simpleMessage("объект"),
    "configValueTypeText": MessageLookupByLibrary.simpleMessage("текст"),
    "configYamlFormatHint": MessageLookupByLibrary.simpleMessage(
      "Проверьте отступы и маркеры списка \"-\" рядом с этой строкой.",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите очистить все данные?",
    ),
    "confirmClearCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Очистить пользовательские группы прокси и правила текущего профиля? Содержимое подписки, добавленные правила, цепочки прокси и пользовательские узлы сохранятся.",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно аварийно завершить работу ядра?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "Существующие данные будут перезаписаны после подтверждения",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Введите пароль ещё раз",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirmPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirmPurchase": MessageLookupByLibrary.simpleMessage(
      "Подтвердить покупку",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Подключено"),
    "connecting": MessageLookupByLibrary.simpleMessage("Подключение..."),
    "connection": MessageLookupByLibrary.simpleMessage("Соединение"),
    "connections": MessageLookupByLibrary.simpleMessage("Соединения"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр текущих данных о соединениях",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Связь："),
    "content": MessageLookupByLibrary.simpleMessage("Содержание"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная тема"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Управление глобальными добавленными правилами",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Копирование переменных окружения",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Копировать ссылку"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Копирование успешно"),
    "core": MessageLookupByLibrary.simpleMessage("Ядро"),
    "coreBlockedByPolicyTip": m9,
    "coreStatus": MessageLookupByLibrary.simpleMessage("Основной статус"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест на сбои"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "currentRoute": MessageLookupByLibrary.simpleMessage("Текущие правила"),
    "custom": MessageLookupByLibrary.simpleMessage("Пользовательский"),
    "customOutboundInUse": m10,
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Заполните свои настройки маршрутизации, затем выберите режим «Пользовательский». Редактирование черновика не меняет текущий режим.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "Выберите источник правил",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage(
      "Выберите цель",
    ),
    "customRuleDomainSuffixHint": MessageLookupByLibrary.simpleMessage(
      "Совпадает с доменом и его поддоменами. Введите домен без https:// и пути.",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("Форма"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "Это правило использует сложный синтаксис. Редактируйте текст, чтобы сохранить все параметры.",
    ),
    "customRuleInvalidContent": m11,
    "customRuleInvalidSyntax": MessageLookupByLibrary.simpleMessage(
      "Введите полное правило с допустимыми типом, содержимым и целью.",
    ),
    "customRuleMatchHint": MessageLookupByLibrary.simpleMessage(
      "Совпадает со всем оставшимся трафиком. Правила ниже не будут применяться.",
    ),
    "customRuleNoResolveHint": MessageLookupByLibrary.simpleMessage(
      "Проверять известные IP-адреса без разрешения доменных имён.",
    ),
    "customRuleRaw": MessageLookupByLibrary.simpleMessage("Текст правила"),
    "customRuleRawHint": MessageLookupByLibrary.simpleMessage(
      "Введите одно полное правило. Сложные выражения сохраняются без изменений.",
    ),
    "customRuleTargetHint": MessageLookupByLibrary.simpleMessage(
      "Выберите группу, прокси или встроенное действие.",
    ),
    "customRuleType": MessageLookupByLibrary.simpleMessage("Тип правила"),
    "customRuleUnavailableProvider": m12,
    "customRuleUnavailableTarget": m13,
    "customUserAgent": MessageLookupByLibrary.simpleMessage(
      "Свой вариант (ввести вручную)",
    ),
    "customUserAgentHint": MessageLookupByLibrary.simpleMessage(
      "Введите полное значение User-Agent",
    ),
    "customUserAgentInvalid": MessageLookupByLibrary.simpleMessage(
      "Используйте только латинские буквы, цифры, пробелы и стандартные знаки препинания",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Темный"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель управления"),
    "daysAgo": m14,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Сервер имен по умолчанию",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения DNS-сервера",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("По умолчанию"),
    "delay": MessageLookupByLibrary.simpleMessage("Задержка"),
    "delayConcurrency": MessageLookupByLibrary.simpleMessage(
      "Параллельные проверки в группе",
    ),
    "delayConcurrencyAndroidDesc": MessageLookupByLibrary.simpleMessage(
      "По умолчанию 16 на Android. Уменьшите при перегрузке сети; действует со следующей групповой проверки",
    ),
    "delayConcurrencyDesc": MessageLookupByLibrary.simpleMessage(
      "По умолчанию 50. Уменьшите при перегрузке сети; действует со следующей групповой проверки",
    ),
    "delayTest": MessageLookupByLibrary.simpleMessage("Тест задержки"),
    "delayTestFailed": MessageLookupByLibrary.simpleMessage("Ошибка проверки"),
    "delayTestQueued": MessageLookupByLibrary.simpleMessage("В очереди"),
    "delayTestRunning": MessageLookupByLibrary.simpleMessage("Проверка"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "Удалить эту резервную копию из WebDAV?",
    ),
    "deleteMultipTip": m15,
    "deleteTip": m16,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначение"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "Геолокация назначения",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("ASN назначения"),
    "details": m17,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Опирается на сторонний API, только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Режим разработчика"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика активирован.",
    ),
    "diagAllFailed": MessageLookupByLibrary.simpleMessage(
      "Все проверки узлов в этой группе завершились неудачно. Адрес проверки также может быть недоступен. Запустите диагностику сети",
    ),
    "diagCanceled": MessageLookupByLibrary.simpleMessage(
      "Проверка отменена, результаты неполные",
    ),
    "diagCaptureHint": MessageLookupByLibrary.simpleMessage(
      "Включите системный прокси или TUN либо настройте локальный прокси в нужном приложении.",
    ),
    "diagClock": MessageLookupByLibrary.simpleMessage(
      "Сравнение системного времени",
    ),
    "diagClockHint": MessageLookupByLibrary.simpleMessage(
      "Включите автоматическую настройку даты и времени и повторите проверку. Ошибка часов может влиять на сертификаты и подписи DNS oixCloud.",
    ),
    "diagClockReady": MessageLookupByLibrary.simpleMessage(
      "В выборке не обнаружено устойчивого большого расхождения времени",
    ),
    "diagClockSkew": MessageLookupByLibrary.simpleMessage(
      "Два независимых ответа указывают на возможное расхождение времени не менее пяти минут",
    ),
    "diagClockUnknown": MessageLookupByLibrary.simpleMessage(
      "Недостаточно некэшированных HTTPS-ответов для сравнения времени",
    ),
    "diagCopy": MessageLookupByLibrary.simpleMessage("Копировать отчёт"),
    "diagCore": MessageLookupByLibrary.simpleMessage("Ответ ядра"),
    "diagCoreDns": MessageLookupByLibrary.simpleMessage("DNS ядра"),
    "diagCoreHint": MessageLookupByLibrary.simpleMessage(
      "Проверьте переключатель подключения и исключения Wi-Fi. Если ядро не отвечает, перезапустите его и проверьте совместимость версий клиента и ядра.",
    ),
    "diagCoreReady": MessageLookupByLibrary.simpleMessage(
      "Ядро ответило и сообщило об активных слушателях",
    ),
    "diagCoreStopped": MessageLookupByLibrary.simpleMessage(
      "Ядро сообщает, что передача трафика остановлена",
    ),
    "diagCoreUnknown": MessageLookupByLibrary.simpleMessage(
      "Диагностика ядра недоступна или конфигурация изменилась",
    ),
    "diagDisabled": MessageLookupByLibrary.simpleMessage(
      "Этот параметр выключен",
    ),
    "diagDnsHint": MessageLookupByLibrary.simpleMessage(
      "Проверьте переопределения DNS и попробуйте другую сеть. Если системный DNS работает, а DNS ядра нет, проверьте DNS в конфигурации.",
    ),
    "diagDnsNoAnswer": MessageLookupByLibrary.simpleMessage(
      "DNS не вернул подходящий адрес; это само по себе не доказывает ошибку аутентификации",
    ),
    "diagDnsPartial": MessageLookupByLibrary.simpleMessage(
      "Разрешена только часть проверенных имён",
    ),
    "diagDnsReady": MessageLookupByLibrary.simpleMessage(
      "Проверенные имена успешно разрешены",
    ),
    "diagDnsRefused": MessageLookupByLibrary.simpleMessage(
      "DNS-запрос отклонён",
    ),
    "diagEntryHint": MessageLookupByLibrary.simpleMessage(
      "Проверка ядра, системного прокси, TUN и DNS",
    ),
    "diagFailed": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "diagFixApplyProfile": MessageLookupByLibrary.simpleMessage(
      "Применить конфигурацию",
    ),
    "diagFixEnableSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Включить системный прокси",
    ),
    "diagFixFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось применить исправление. Следуйте рекомендации выше",
    ),
    "diagFixRestartConnection": MessageLookupByLibrary.simpleMessage(
      "Переподключиться",
    ),
    "diagFixRestartCore": MessageLookupByLibrary.simpleMessage(
      "Перезапустить ядро",
    ),
    "diagFixRetest": MessageLookupByLibrary.simpleMessage(
      "Повторить тест узлов",
    ),
    "diagFixStart": MessageLookupByLibrary.simpleMessage(
      "Запустить подключение",
    ),
    "diagFixSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Переустановить системный прокси",
    ),
    "diagFixTun": MessageLookupByLibrary.simpleMessage("Включить TUN заново"),
    "diagFixing": MessageLookupByLibrary.simpleMessage(
      "Применяется исправление, затем проверка повторится",
    ),
    "diagListener": MessageLookupByLibrary.simpleMessage(
      "Локальный вход прокси",
    ),
    "diagListenerFailed": MessageLookupByLibrary.simpleMessage(
      "Ожидаемый порт не ответил или отличается от порта ядра",
    ),
    "diagListenerHint": MessageLookupByLibrary.simpleMessage(
      "Проверьте конфликт порта и работу слушателя. Переподключитесь; при необходимости измените смешанный порт в настройках сети.",
    ),
    "diagListenerReady": MessageLookupByLibrary.simpleMessage(
      "Ожидаемый порт ответил по протоколу прокси",
    ),
    "diagNoCapture": MessageLookupByLibrary.simpleMessage(
      "Системный прокси и TUN выключены",
    ),
    "diagOixDns": MessageLookupByLibrary.simpleMessage(
      "Подписанный DNS oixCloud",
    ),
    "diagOixDnsAuthMissing": MessageLookupByLibrary.simpleMessage(
      "Функция подписи управляемого DNS не готова",
    ),
    "diagOixDnsHint": MessageLookupByLibrary.simpleMessage(
      "Проверьте версию клиента и системное время, обновите подписку. Если ошибка остаётся, передайте отчёт поддержке.",
    ),
    "diagOixDnsNoSample": MessageLookupByLibrary.simpleMessage(
      "Нет управляемого доменного имени узла для проверки",
    ),
    "diagPassed": MessageLookupByLibrary.simpleMessage("Пройдено"),
    "diagProfile": MessageLookupByLibrary.simpleMessage(
      "Применённая конфигурация",
    ),
    "diagProfileHint": MessageLookupByLibrary.simpleMessage(
      "Выберите действующую конфигурацию и запустите подключение, затем повторите проверку.",
    ),
    "diagProfileMissing": MessageLookupByLibrary.simpleMessage(
      "Выбранная конфигурация ещё не применена",
    ),
    "diagProfileReady": MessageLookupByLibrary.simpleMessage(
      "Выбранная конфигурация применена",
    ),
    "diagProxyAutomatic": MessageLookupByLibrary.simpleMessage(
      "Обнаружена автоматическая настройка прокси; фактический маршрут не проверен",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "Прокси ОС не совпадает с портом приложения",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "Клиент запросил системный прокси, но в ОС он выключен",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "Включите системный прокси повторно и проверьте влияние других прокси-приложений или политик организации. Некоторые приложения используют собственные настройки.",
    ),
    "diagProxyPath": MessageLookupByLibrary.simpleMessage(
      "Доступ через локальный прокси",
    ),
    "diagProxyPathHint": MessageLookupByLibrary.simpleMessage(
      "Если системный путь работает, проверьте выбранный узел, правила и DNS ядра. Сбой одного проверочного сайта не означает отказ всех узлов.",
    ),
    "diagProxyReady": MessageLookupByLibrary.simpleMessage(
      "HTTP и HTTPS прокси указывают на ожидаемый локальный порт",
    ),
    "diagRun": MessageLookupByLibrary.simpleMessage("Начать проверку"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "Проверяется текущая связь на небольшой выборке. Системный путь также может проходить через TUN. Результат не охватывает все приложения и узлы.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("Пропущено"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "Передача приостановлена настройкой исключения текущей Wi-Fi сети",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("Системный DNS"),
    "diagSystemPath": MessageLookupByLibrary.simpleMessage(
      "Системный сетевой путь",
    ),
    "diagSystemPathHint": MessageLookupByLibrary.simpleMessage(
      "Этот путь не использует HTTP-прокси приложения явно, но может идти через TUN. Сбой выборки может быть связан с DNS, фильтрацией или сайтом проверки; сравните с результатом прокси.",
    ),
    "diagSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Системные настройки прокси",
    ),
    "diagTitle": MessageLookupByLibrary.simpleMessage("Диагностика сети"),
    "diagTrafficCapture": MessageLookupByLibrary.simpleMessage(
      "Перехват трафика",
    ),
    "diagTun": MessageLookupByLibrary.simpleMessage("Интерфейс TUN и маршрут"),
    "diagTunHint": MessageLookupByLibrary.simpleMessage(
      "Переключите TUN и подтвердите системное разрешение. При несовпадении маршрута проверьте другие VPN. IPv6, UDP и исключения приложений проверяются отдельно.",
    ),
    "diagTunMissing": MessageLookupByLibrary.simpleMessage(
      "Активный интерфейс TUN, соответствующий ядру, не найден",
    ),
    "diagTunReady": MessageLookupByLibrary.simpleMessage(
      "Интерфейс TUN ядра активен, проверенный маршрут IPv4 проходит через него",
    ),
    "diagTunRouteMismatch": MessageLookupByLibrary.simpleMessage(
      "TUN активен, но проверенный маршрут IPv4 проходит через другой интерфейс",
    ),
    "diagTunRouteUnknown": MessageLookupByLibrary.simpleMessage(
      "TUN активен, но его маршрут IPv4 не удалось проверить",
    ),
    "diagUnknown": MessageLookupByLibrary.simpleMessage("Не удалось проверить"),
    "diagWarning": MessageLookupByLibrary.simpleMessage("Требует внимания"),
    "diagWebResult": m18,
    "dialerProxy": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения",
    ),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Исход, через который идёт обращение к NTP-серверу",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Отключить UDP"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "Отменить изменения?",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Отключено"),
    "discountCode": MessageLookupByLibrary.simpleMessage("Код купона"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Промокод (необязательно)",
    ),
    "discountCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Введите код купона",
    ),
    "discountedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Цена со скидкой",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Обновление настроек, связанных с DNS",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS-перехват"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS-запросы"),
    "dnsQueriesDesc": MessageLookupByLibrary.simpleMessage(
      "Последние 500 запросов резолвера",
    ),
    "dnsQueryAll": MessageLookupByLibrary.simpleMessage("Все запросы"),
    "dnsQueryAnswers": MessageLookupByLibrary.simpleMessage("Ответы"),
    "dnsQueryCached": MessageLookupByLibrary.simpleMessage("Из кеша"),
    "dnsQueryFailures": MessageLookupByLibrary.simpleMessage(
      "Неудачные запросы",
    ),
    "dnsQueryInitiatorApp": MessageLookupByLibrary.simpleMessage("Приложение"),
    "dnsQueryInitiatorDirect": MessageLookupByLibrary.simpleMessage(
      "Прямое соединение",
    ),
    "dnsQueryInitiatorOther": MessageLookupByLibrary.simpleMessage("Другое"),
    "dnsQueryInitiatorProxy": MessageLookupByLibrary.simpleMessage(
      "Соединение с прокси",
    ),
    "dnsQueryInitiatorRule": MessageLookupByLibrary.simpleMessage(
      "Подбор правила",
    ),
    "dnsQueryRcode": MessageLookupByLibrary.simpleMessage("Код ответа"),
    "dnsQueryType": MessageLookupByLibrary.simpleMessage("Тип запроса"),
    "dnsQueryUpstream": MessageLookupByLibrary.simpleMessage(
      "Вышестоящий сервер",
    ),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Вы хотите пропустить",
    ),
    "documentCenter": MessageLookupByLibrary.simpleMessage(
      "Центр документации",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "download": MessageLookupByLibrary.simpleMessage("Скачивание"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "Автоматически добавляет узлы конфигурации при обновлении подписки. Фильтр имени, например Japan|JP.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Изменить свои настройки",
    ),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Редактировать глобальные правила",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage(
      "Редактировать профиль",
    ),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Редактировать группу прокси",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Редактировать правило"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Редактор недоступен",
    ),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите 6-значный код",
    ),
    "emailCodeLabel": MessageLookupByLibrary.simpleMessage("Код из письма"),
    "emailCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Введите код из письма",
    ),
    "emailFormatValidation": MessageLookupByLibrary.simpleMessage(
      "Неверный формат email",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage(
      "Введите адрес электронной почты",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailPassword": MessageLookupByLibrary.simpleMessage("Email и пароль"),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите email",
    ),
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "Пользовательское переопределение пусто. Используйте быстрое заполнение или добавьте правила и группы прокси. Чтобы сохранить содержимое подписки, выберите режим «Дополнение».",
    ),
    "emptyTip": m19,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Включить автопродление",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "entriesCount": m20,
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Скрыть из последних задач",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Когда приложение находится в фоновом режиме, оно скрыто из последних задач",
    ),
    "excludeNetworks": MessageLookupByLibrary.simpleMessage(
      "Приостановка прокси по IP или шлюзу",
    ),
    "excludeNetworksDesc": MessageLookupByLibrary.simpleMessage(
      "Пауза при совпадении IPv4, подсети или шлюза Wi-Fi/Ethernet; возобновление после выхода. Через запятую: 192.168.1.0/24,gateway:192.168.1.1",
    ),
    "excludeNetworksInvalid": MessageLookupByLibrary.simpleMessage(
      "До 16 правил: допустимые IPv4, CIDR или gateway:адрес",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Исключить фильтр прокси",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Исключённые SSID"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Приостанавливать прокси в указанных сетях Wi-Fi; возобновлять после отключения, только если приложение остаётся запущенным.",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Тип исключения"),
    "existsTip": m21,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйти из полноэкранного режима",
    ),
    "expand": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "expandList": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожидаемый статус"),
    "expireDate": m22,
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("Истекает"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт успешен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экспрессивные"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "При включении ядро Clash можно контролировать на настроенном порту",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("Внешнее получение"),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя ссылка"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fakeip"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Режим фильтра Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "blacklist исключает совпадения, whitelist — только их, rule — по правилам",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fakeip"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Диапазон Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("Резервный"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Обычно используется оффшорный DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage(
      "Фильтр резервного DNS",
    ),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить записи о покупках",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить тарифы",
    ),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Прямая загрузка профиля"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл был изменен. Хотите сохранить изменения?",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage(
      "Режим поиска процесса",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "При включении возможны небольшие потери производительности",
    ),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "Плавающая навигация",
    ),
    "floatingNavigationBarDesc": MessageLookupByLibrary.simpleMessage(
      "Использовать плавающую панель в компактном режиме",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профиле"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Семейство шрифтов"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Размер"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно перезапустить ядро?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "format": MessageLookupByLibrary.simpleMessage("Формат"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый микс"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления должен быть от 1 до 8760 часов",
    ),
    "geoBackupSource": MessageLookupByLibrary.simpleMessage("Резервный CDN"),
    "geoDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить GEO",
    ),
    "geoDownloadRecoveryHint": MessageLookupByLibrary.simpleMessage(
      "Загрузка использует текущие правила сети или прямое соединение, если прокси ещё не запущен. Повторите попытку, выберите другой источник или введите URL. После проверки операция продолжится.",
    ),
    "geoDownloadUrl": MessageLookupByLibrary.simpleMessage("URL загрузки"),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "Введите корректный HTTP или HTTPS URL",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Настройки Geo"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage("Текущий адрес"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Ресурсы Geo"),
    "geoSkipped": m23,
    "geoUpdated": m24,
    "geoUpdating": m25,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Режим низкого потребления памяти для геоданных",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Включение будет использовать загрузчик геоданных с низким потреблением памяти",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Код Geoip"),
    "getProfileSuccess": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно получен",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Глобальный"),
    "go": MessageLookupByLibrary.simpleMessage("Перейти"),
    "goLogin": MessageLookupByLibrary.simpleMessage("Войти"),
    "goPay": MessageLookupByLibrary.simpleMessage("Оплатить"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Перейти к настройке скрипта",
    ),
    "groupCycleError": m26,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "Фильтрует автоматически добавленные узлы и провайдеры. Участники, выбранные вручную, сохраняются.",
    ),
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage(
      "Переключение при сбое",
    ),
    "groupTypeFallbackHint": MessageLookupByLibrary.simpleMessage(
      "Выбирает участников по порядку и переключается при сбое.",
    ),
    "groupTypeLoadBalance": MessageLookupByLibrary.simpleMessage(
      "Балансировка нагрузки",
    ),
    "groupTypeLoadBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Распределяет соединения между доступными участниками.",
    ),
    "groupTypeSelect": MessageLookupByLibrary.simpleMessage("Ручной выбор"),
    "groupTypeSelectHint": MessageLookupByLibrary.simpleMessage(
      "Выбирайте активного участника на странице прокси.",
    ),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage(
      "Автоматический выбор",
    ),
    "groupTypeUrlTestHint": MessageLookupByLibrary.simpleMessage(
      "Периодически проверяет участников и выбирает узел с низкой задержкой.",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Хотите сохранить изменения в кэше?",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Уже есть аккаунт?",
    ),
    "hide": MessageLookupByLibrary.simpleMessage("Скрыть"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Скрыть из списка"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Скрыть IP"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Скрывать узлы с ошибкой проверки",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Сохранять выбранный узел и узлы с незавершённой проверкой",
    ),
    "host": MessageLookupByLibrary.simpleMessage("Хост"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавить Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфликт горячих клавиш",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Управление горячими клавишами",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Использование клавиатуры для управления приложением",
    ),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не удалось зарегистрировать сочетание",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Часов"),
    "hoursAgo": m27,
    "hoursCount": m28,
    "iHavePaid": MessageLookupByLibrary.simpleMessage("Я оплатил"),
    "icon": MessageLookupByLibrary.simpleMessage("Иконка"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("Недавние значки"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль иконки"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL иконки"),
    "import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "importFile": MessageLookupByLibrary.simpleMessage("Импорт из файла"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Импорт из URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Импорт по URL"),
    "includeAll": MessageLookupByLibrary.simpleMessage(
      "Включить все прокси и провайдеры",
    ),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Включить все прокси",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Включить всех провайдеров прокси",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage(
      "Долгосрочное действие",
    ),
    "init": MessageLookupByLibrary.simpleMessage("Инициализация"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите правильную горячую клавишу",
    ),
    "installedAppsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить список приложений. Повторите попытку.",
    ),
    "installedAppsPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение не предоставлено. Его можно включить в системных настройках.",
    ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к списку установленных приложений, чтобы выбрать приложения для VPN.",
    ),
    "installedAppsPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Нужно разрешение на доступ к списку приложений",
    ),
    "insufficientBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Недостаточно средств. Пополните баланс, чтобы продолжить.",
    ),
    "insufficientBalanceRecharge": MessageLookupByLibrary.simpleMessage(
      "Пополните баланс и повторите попытку.",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Интеллектуальный выбор",
    ),
    "interfaceAutomatic": MessageLookupByLibrary.simpleMessage(
      "Снять привязку (автовыбор интерфейса)",
    ),
    "interfaceFollowProfile": MessageLookupByLibrary.simpleMessage(
      "Из профиля",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Имя интерфейса"),
    "internet": MessageLookupByLibrary.simpleMessage("Интернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Интервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Внутренний IP"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage(
      "Введите корректную сумму",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Неверный файл резервной копии",
    ),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить сертификат сервера. При пропуске проверки сервер может оказаться поддельным, а передаваемые или получаемые учётные данные и данные подписки могут быть украдены или изменены.\n\nПродолжайте, только если доверяете этой сети и серверу. Исключение действует лишь для этой повторной попытки с тем же сервером и сертификатом и отменяется после завершения операции.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "Ошибка проверки сертификата",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Метка DSCP не может превышать 63",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только tcp и udp",
    ),
    "invalidPolicy": m29,
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Этот QR-код не содержит ссылку на профиль",
    ),
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Введите числа или диапазоны, например 80 или 8000-9000, через /",
    ),
    "invalidRuleSet": m30,
    "invalidSubRule": m31,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("Код приглашения"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "ipAsn": MessageLookupByLibrary.simpleMessage("ASN"),
    "ipFlagAbuser": MessageLookupByLibrary.simpleMessage("Злоупотребления"),
    "ipFlagNo": MessageLookupByLibrary.simpleMessage("Нет"),
    "ipFlagProxy": MessageLookupByLibrary.simpleMessage("Прокси"),
    "ipFlagTor": MessageLookupByLibrary.simpleMessage("Tor"),
    "ipFlagVpn": MessageLookupByLibrary.simpleMessage("VPN"),
    "ipFlagYes": MessageLookupByLibrary.simpleMessage("Да"),
    "ipFlags": MessageLookupByLibrary.simpleMessage("Метки"),
    "ipOrganization": MessageLookupByLibrary.simpleMessage("Организация"),
    "ipQualityDetails": MessageLookupByLibrary.simpleMessage("Качество IP"),
    "ipQualityFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить тип IP",
    ),
    "ipQualityGood": MessageLookupByLibrary.simpleMessage("Хороший"),
    "ipQualityLevel": MessageLookupByLibrary.simpleMessage("Уровень"),
    "ipQualityNormal": MessageLookupByLibrary.simpleMessage("Обычный"),
    "ipQualityQueryHint": MessageLookupByLibrary.simpleMessage(
      "Запрос IPQuery, IPLocate, ipapi.is и proxycheck.io по нажатию",
    ),
    "ipQualityRetry": MessageLookupByLibrary.simpleMessage("Проверить снова"),
    "ipQualityRisky": MessageLookupByLibrary.simpleMessage("Рискованный"),
    "ipQualitySource": MessageLookupByLibrary.simpleMessage("Источник ответа"),
    "ipQualitySources": MessageLookupByLibrary.simpleMessage("Источники"),
    "ipSourceIpMismatch": MessageLookupByLibrary.simpleMessage(
      "Другой исходящий IP",
    ),
    "ipSourceNoType": MessageLookupByLibrary.simpleMessage("Тип не определён"),
    "ipSourceRateLimited": MessageLookupByLibrary.simpleMessage(
      "Лимит запросов",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Тип"),
    "ipTypeBusiness": MessageLookupByLibrary.simpleMessage("Бизнес"),
    "ipTypeHosting": MessageLookupByLibrary.simpleMessage("Дата-центр"),
    "ipTypeInferred": MessageLookupByLibrary.simpleMessage("Предположение"),
    "ipTypeMobile": MessageLookupByLibrary.simpleMessage("Мобильная сеть"),
    "ipTypeResidential": MessageLookupByLibrary.simpleMessage("Домашний"),
    "ipTypeUnknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "При включении будет возможно получать IPv6 трафик",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить входящий IPv6",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут IPv6 (мс)"),
    "ja": MessageLookupByLibrary.simpleMessage("Японский"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал поддержания TCP-соединения",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Последнее обновление"),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "lazy": MessageLookupByLibrary.simpleMessage("Ленивая загрузка"),
    "light": MessageLookupByLibrary.simpleMessage("Светлый"),
    "lineIssueTip": m32,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Перенос строк"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Слушать"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "Только Linux",
    ),
    "loadTest": MessageLookupByLibrary.simpleMessage("Тест загрузки"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "local": MessageLookupByLibrary.simpleMessage("Локальный"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на локальный диск",
    ),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "Доступ к локальной сети не разрешён; для этого подключения используется gVisor. Прокси и сервисы в локальной сети могут оставаться недоступны",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage(
      "Перейти к выбранному узлу",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию отклонено, поэтому невозможно получить имя текущей сети Wi-Fi. Включите разрешение на геолокацию вручную в системных настройках.",
    ),
    "locationPermissionGuide": m33,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение на геолокацию",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Журнал"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Уровень логов"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Отключение скроет запись логов",
    ),
    "loggedOutViewDesc": MessageLookupByLibrary.simpleMessage(
      "Войдите, чтобы просмотреть информацию об учетной записи и управлять подписками",
    ),
    "loggedOutViewTitle": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Вход выполнен успешно",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Вход"),
    "logoutContent": MessageLookupByLibrary.simpleMessage("Выйти из аккаунта?"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Выход"),
    "logs": MessageLookupByLibrary.simpleMessage("Логи"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Записи захвата логов"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест журналов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Инструмент разблокировки Loopback",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разблокировки Loopback UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "Может не подходить для сетей материкового Китая",
    ),
    "manageServices": MessageLookupByLibrary.simpleMessage(
      "Управление сервисами",
    ),
    "manageUserAgents": MessageLookupByLibrary.simpleMessage(
      "Управление списком",
    ),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "Куда направляются правила с целью MATCH-TARGET. По умолчанию — цель последнего правила MATCH этого профиля.",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Цель MATCH"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. количество неудач",
    ),
    "maxLengthTip": m34,
    "maximize": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "Порядок выбора определяет порядок переключения. Повторный выбор перемещает участника в конец.",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Резидентная память",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage(
      "Приложение и общая",
    ),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage(
      "Свободная куча",
    ),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage(
      "Используемая куча",
    ),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "Ядро не запущено",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage(
      "Накладные расходы среды",
    ),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage("Стеки горутин"),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "Оценка по резидентной памяти процессов; может отличаться от данных системы.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "Ядро работает в процессе приложения. Его доля оценивается по статистике среды выполнения, остальное относится к приложению и общей памяти.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Информация о памяти"),
    "memoryReleased": MessageLookupByLibrary.simpleMessage(
      "Память освобождена",
    ),
    "memoryReleasedSize": m35,
    "messageTest": MessageLookupByLibrary.simpleMessage(
      "Тестирование сообщения",
    ),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это сообщение."),
    "min": MessageLookupByLibrary.simpleMessage("Мин"),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage(
      "Минимальная конфигурация",
    ),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "Использовать сокращенный набор правил для меньшего профиля",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Свернуть при выходе",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Изменить стандартное событие выхода из системы",
    ),
    "minutesAgo": m36,
    "mipsStackDesc": MessageLookupByLibrary.simpleMessage(
      "Стек в пространстве пользователя с низким потреблением памяти; на каналах с высокой задержкой скорость может снизиться",
    ),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m37,
    "more": MessageLookupByLibrary.simpleMessage("Ещё"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Купленные тарифы"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Сервер имен"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения домена",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика сервера имен",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Указать соответствующую политику сервера имен",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Сеть"),
    "networkAccessDeniedError": m38,
    "networkBadResponseError": m39,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "Запрос отменён",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "Не удалось подключиться к серверу. Проверьте подключение к сети или настройки прокси",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с сетью",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Обнаружение сети",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Ошибка сети, проверьте соединение и попробуйте еще раз",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить адрес сервера. Проверьте правильность URL и работу DNS",
    ),
    "networkNotFoundError": m40,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Слишком много запросов (HTTP 429). Подождите немного и повторите попытку",
    ),
    "networkRequestFailed": m41,
    "networkServerError": m42,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Скорость сети"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса истекло. Проверьте сеть или прокси и повторите попытку",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить защищённое соединение. Сертификат сервера может быть недействителен, или соединение перехватывается",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Тип сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральные"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "nextMatch": MessageLookupByLibrary.simpleMessage("Следующее совпадение"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage(
      "Буквы и цифры, до 12 символов",
    ),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("Никнейм"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "Введите никнейм",
    ),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "Нет доступных тарифов",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Нет данных"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("Нет горячей клавиши"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Нет информации"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Нет сети"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Приложение без сети"),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "Нет доступных способов оплаты",
    ),
    "noProxy": MessageLookupByLibrary.simpleMessage("Нет прокси"),
    "noPurchaseRecords": MessageLookupByLibrary.simpleMessage(
      "Купленных тарифов пока нет",
    ),
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage(
      "В WebDAV нет резервных копий",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage("Нет совпадений"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Ничего не найдено",
    ),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "Нет тарифов для улучшения",
    ),
    "nodeCoreValidationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Запустите Core перед проверкой узла",
    ),
    "nodeDefinition": MessageLookupByLibrary.simpleMessage("Определение узла"),
    "nodeFilter": MessageLookupByLibrary.simpleMessage("Фильтр узлов"),
    "nodeFilterAccountNote": MessageLookupByLibrary.simpleMessage(
      "Фильтр сохраняется в аккаунте и действует на всех устройствах, где выполнен вход в это приложение.",
    ),
    "nodeFilterAny": MessageLookupByLibrary.simpleMessage("Любые"),
    "nodeFilterCustomized": MessageLookupByLibrary.simpleMessage("Настроено"),
    "nodeFilterExclude": MessageLookupByLibrary.simpleMessage("Исключить"),
    "nodeFilterKeepOne": MessageLookupByLibrary.simpleMessage(
      "Оставьте хотя бы один узел",
    ),
    "nodeFilterKept": m43,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("Линии"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage(
      "Имя содержит",
    ),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage(
      "Имя не содержит",
    ),
    "nodeFilterNodeExcluded": m44,
    "nodeFilterNodeKept": m45,
    "nodeFilterOnly": MessageLookupByLibrary.simpleMessage("Только"),
    "nodeFilterPreview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "nodeFilterRegions": MessageLookupByLibrary.simpleMessage("Регионы"),
    "nodeFilterRetry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "nodeFilterSearch": MessageLookupByLibrary.simpleMessage("Поиск узлов"),
    "nodeFilterSmartSelection": MessageLookupByLibrary.simpleMessage(
      "Умный выбор",
    ),
    "nodeInvalidDefinition": MessageLookupByLibrary.simpleMessage(
      "Введите одно полное определение узла с name и type",
    ),
    "nodeQuickFields": MessageLookupByLibrary.simpleMessage(
      "Быстрое редактирование",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущая группа прокси не может быть выбрана.",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал синхронизации (минуты)",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Брать время с NTP-сервера, а не из системных часов",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Нет профиля, пожалуйста, добавьте профиль",
    ),
    "nullTip": m46,
    "numberTip": m47,
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Только иконка"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Только статистика прокси",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "При включении будет учитываться только трафик прокси",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("Открыть панель"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("Открыть в браузере"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Операция не выполнена",
    ),
    "operationSuccess": MessageLookupByLibrary.simpleMessage(
      "Операция выполнена успешно",
    ),
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "outboundIp": MessageLookupByLibrary.simpleMessage("Исходящий IP"),
    "outboundMode": MessageLookupByLibrary.simpleMessage(
      "Режим исходящего трафика",
    ),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "Недоступно в этой конфигурации. Удалите или замените.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Личные настройки хранятся отдельно и применяются после обновлений. Новые группы блокируют соединения, если нет подходящих участников.",
    ),
    "overlayNameConflict": m48,
    "override": MessageLookupByLibrary.simpleMessage("Переопределить"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Переопределяются только выбранные поля, остальные берутся из профиля",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Переопределяемые параметры",
    ),
    "overrideFieldsDesc": MessageLookupByLibrary.simpleMessage(
      "Переопределяются только выбранные поля, остальные берутся из профиля",
    ),
    "overrideFieldsEmpty": MessageLookupByLibrary.simpleMessage(
      "Добавьте поля для переопределения или измените YAML",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режим переопределения",
    ),
    "overrideNtp": MessageLookupByLibrary.simpleMessage("Переопределить NTP"),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скрипт переопределения",
    ),
    "overwriteIssueDuplicateName": m49,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Имя не задано",
    ),
    "overwriteIssueGroupLoop": m50,
    "overwriteIssueMissingProviders": m51,
    "overwriteIssueMissingProxies": m52,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "Не выбраны ни прокси, ни провайдеры прокси, поэтому ядро отклонит эту группу",
    ),
    "overwriteIssueReservedName": m53,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Пользовательский",
    ),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Пользовательский режим, полная настройка групп прокси и правил",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("Дополнение"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "Сохраняет правила и группы подписки и добавляет ваши настройки. Личные правила имеют приоритет над подпиской; существующие дополнительные правила сохраняют свой приоритет.",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палитра"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "passwordRuleHint": MessageLookupByLibrary.simpleMessage(
      "10-36 символов: буквы разного регистра, цифра и символ",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите пароль",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Вставить"),
    "pauseUpdates": MessageLookupByLibrary.simpleMessage(
      "Приостановить обновление",
    ),
    "payWithBalance": MessageLookupByLibrary.simpleMessage(
      "Оплатить с баланса",
    ),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("Сумма платежа"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Способ оплаты"),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось выполнить запрос оплаты",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage(
      "Оплата прошла успешно",
    ),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "Платёжный endpoint вернул неизвестный формат",
    ),
    "personalRouting": MessageLookupByLibrary.simpleMessage(
      "Личная маршрутизация",
    ),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Выбрать из галереи"),
    "pinWindow": MessageLookupByLibrary.simpleMessage(
      "Закрепить поверх всех окон",
    ),
    "planEnded": MessageLookupByLibrary.simpleMessage("Завершён"),
    "planInUse": MessageLookupByLibrary.simpleMessage("Используется"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Ожидает активации",
    ),
    "planNumber": m54,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("Недоступно"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, привяжите WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите название скрипта",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите пароль администратора",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, загрузите действительный QR-код",
    ),
    "points": MessageLookupByLibrary.simpleMessage("Баллы"),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введите другой порт",
    ),
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "Если запущено другое прокси-приложение, сначала закройте его.",
    ),
    "portSuggestionTip": m55,
    "portTip": m56,
    "portUnavailableMessage": m57,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Порт недоступен",
    ),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Приоритетное использование HTTP/3 для DOH",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, нажмите клавишу.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Предыдущее совпадение",
    ),
    "process": MessageLookupByLibrary.simpleMessage("процесс"),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, введите действительный формат интервала времени",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, введите интервал времени для автообновления",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профиль был изменен. Хотите отключить автообновление?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите имя профиля",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "Ошибка разбора профиля",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный URL профиля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите URL профиля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профили"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортировка профилей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "providerChanged": MessageLookupByLibrary.simpleMessage(
      "Ресурс изменился во время редактирования. Откройте его снова",
    ),
    "providerContent": MessageLookupByLibrary.simpleMessage(
      "Содержимое ресурса",
    ),
    "providerContentInvalid": MessageLookupByLibrary.simpleMessage(
      "Недопустимое содержимое или формат ресурса",
    ),
    "providerContentTooLarge": MessageLookupByLibrary.simpleMessage(
      "Размер ресурса превышает 32 МиБ",
    ),
    "providerInUse": m58,
    "providerLocal": MessageLookupByLibrary.simpleMessage("Локальный файл"),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Введите непустое имя без запятых и переводов строк",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("Удалённый URL"),
    "providerRenameShadowed": m59,
    "providerSourceReference": m60,
    "providerSourceUnavailable": m61,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Введите HTTP/HTTPS URL без встроенных учётных данных",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Провайдеры"),
    "proxies": MessageLookupByLibrary.simpleMessage("Прокси"),
    "proxiesCount": m62,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Доступные узлы",
    ),
    "proxyChainConflictTip": m63,
    "proxyChainCustomNode": MessageLookupByLibrary.simpleMessage(
      "Пользовательский узел",
    ),
    "proxyChainCustomNodes": MessageLookupByLibrary.simpleMessage(
      "Пользовательские узлы",
    ),
    "proxyChainEmpty": MessageLookupByLibrary.simpleMessage(
      "В цепочке прокси нет узлов",
    ),
    "proxyChainEntry": MessageLookupByLibrary.simpleMessage("Вход"),
    "proxyChainExit": MessageLookupByLibrary.simpleMessage("Выход"),
    "proxyChainInstruction": MessageLookupByLibrary.simpleMessage(
      "Добавляйте узлы по порядку: первый узел входной, последний выходной. После сохранения выберите выходной узел, чтобы использовать цепочку.",
    ),
    "proxyChainMinimumNodes": MessageLookupByLibrary.simpleMessage(
      "Для цепочки прокси нужно минимум 2 узла",
    ),
    "proxyChainMinimumNodesHint": MessageLookupByLibrary.simpleMessage(
      "Для цепочки прокси нужно минимум 2 узла. Добавьте выходной узел.",
    ),
    "proxyChainNodeAdded": MessageLookupByLibrary.simpleMessage(
      "Узел добавлен в цепочку прокси",
    ),
    "proxyChainOtherNodes": MessageLookupByLibrary.simpleMessage("Другие узлы"),
    "proxyChainRelatedChainsUpdated": MessageLookupByLibrary.simpleMessage(
      "Связанные цепочки прокси обновлены",
    ),
    "proxyChainSavedAndApplied": MessageLookupByLibrary.simpleMessage(
      "Цепочка прокси сохранена и применена. Выберите выходной узел, чтобы использовать ее",
    ),
    "proxyChainSelectedNodes": MessageLookupByLibrary.simpleMessage(
      "Цепочка прокси",
    ),
    "proxyChainUnavailableNodeTip": m64,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Поддерживаемые форматы: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "Цепочка прокси может заметно снизить скорость сети. Оставьте ее выключенной, если она явно не нужна.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочки прокси"),
    "proxyConflictAutoConfig": MessageLookupByLibrary.simpleMessage(
      "До запуска системный прокси использовал сценарий автоматической настройки.",
    ),
    "proxyConflictHint": MessageLookupByLibrary.simpleMessage(
      "Если это другое прокси-приложение или VPN, закройте его: одновременная работа может нарушить подключение.",
    ),
    "proxyConflictSystemProxy": m65,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "Возможен конфликт прокси",
    ),
    "proxyConflictVpn": m66,
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Фильтр прокси"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа прокси"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Группа прокси пуста",
    ),
    "proxyGroupMembersEmpty": MessageLookupByLibrary.simpleMessage(
      "Добавьте прокси, провайдера или включите добавление всех",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "Имя группы прокси не может быть пустым",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "Прокси-сервер имен",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Домен для разрешения прокси-узлов",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Прокси-узел"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("Порт прокси"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Очистить кэш"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Автопродление",
    ),
    "purchaseDays": m67,
    "purchaseHours": m68,
    "purchaseMinutes": m69,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage("Цена покупки"),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Выкл."),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("Вкл."),
    "purchaseRenewalPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Стоимость продления",
    ),
    "purchaseTime": m70,
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Общий трафик",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Время покупки"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто черный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код для получения профиля",
    ),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Быстрое добавление"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Быстрое редактирование"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радужные"),
    "rawOutboundInUse": m71,
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Адрес получателя",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Пополнить"),
    "rechargeAllowedRange": m72,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Сумма пополнения (¥)",
    ),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "Сумма выходит за пределы диапазона этого способа оплаты",
    ),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "Скидка сохранится при автопродлении",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir-порт"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "После оплаты потяните вниз, чтобы обновить и проверить результат",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("Возврат"),
    "register": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "registerClosed": MessageLookupByLibrary.simpleMessage(
      "Регистрация в настоящее время закрыта",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка регистрации",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Создать аккаунт"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "Группы Relay удалены из ядра. Выберите другой тип.",
    ),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Освободить память"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось освободить память",
    ),
    "remaining": m73,
    "remainingStock": m74,
    "remainingTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Оставшееся время",
    ),
    "remainingTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Оставшийся трафик",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Удаленный"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Удалённое назначение",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage("Цена продления"),
    "replace": MessageLookupByLibrary.simpleMessage("Заменить"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Заменить все"),
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр последних записей запросов",
    ),
    "resendCodeIn": m75,
    "reset": MessageLookupByLibrary.simpleMessage("Сброс"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Письмо отправлено. Вставьте ссылку или код из письма ниже.",
    ),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "На текущей странице есть изменения. Вы уверены, что хотите сбросить?",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Пароль сброшен, войдите с новым паролем",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Убедитесь, что хотите сбросить",
    ),
    "resetTokenLabel": MessageLookupByLibrary.simpleMessage(
      "Ссылка или код сброса",
    ),
    "resetTokenValidation": MessageLookupByLibrary.simpleMessage(
      "Введите ссылку или код сброса",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Ресурсы"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Информация, связанная с внешними ресурсами",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдение правил"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-соединение следует правилам, необходимо настроить proxy-server-nameserver",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("Перезапустить"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите перезапустить ядро?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Восстановить"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Восстановить все данные",
    ),
    "restoreDefault": MessageLookupByLibrary.simpleMessage(
      "Восстановить по умолчанию",
    ),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Ошибка восстановления",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановить данные из файла",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановить данные через WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Восстановить только файлы конфигурации",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия восстановления",
    ),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Совместимый",
    ),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Перезаписать",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Восстановление успешно",
    ),
    "resumeUpdates": MessageLookupByLibrary.simpleMessage(
      "Возобновить обновление",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "retryCloudSyncWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "Временно разрешить и синхронизировать",
        ),
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "Временно проверить API",
    ),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "Обратная разработка, декомпиляция, дизассемблирование или анализ этого приложения с помощью ИИ строго запрещены.",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адрес маршрутизации"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка адреса прослушивания маршрутизации",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режим маршрутизации"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обход частных адресов маршрутизации",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage(
      "Использовать конфигурацию",
    ),
    "routingApplied": MessageLookupByLibrary.simpleMessage(
      "Личные настройки применены.",
    ),
    "routingApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Изменения сохранены, но не применены. Проверьте конфигурацию и повторите.",
    ),
    "routingChanged": MessageLookupByLibrary.simpleMessage(
      "Конфигурация изменилась во время редактирования или проверки. Откройте редактор заново или повторите проверку.",
    ),
    "routingChecked": MessageLookupByLibrary.simpleMessage(
      "Конфигурация корректна. Личные настройки сохранены в этом профиле.",
    ),
    "routingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Сохраните черновик, чтобы исправить другие элементы. Настройки применяются только после проверки всей конфигурации.",
    ),
    "routingGroupType": MessageLookupByLibrary.simpleMessage("Тип группы"),
    "ru": MessageLookupByLibrary.simpleMessage("Русский"),
    "rule": MessageLookupByLibrary.simpleMessage("Правило"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое правило AND",
    ),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить полный домен",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ключевое слово в домене",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению домена",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить суффикс домена",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставление по маске; поддерживаются только * и ?",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить метку DSCP (только для входящих tproxy UDP)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон портов назначения",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить код страны IP-адреса",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить домены из Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить имя входящего подключения",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить входящий порт",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить тип входящего подключения",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить имя пользователя входящего подключения; несколько имён разделяются /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ASN, которой принадлежит IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов; IP-CIDR6 — просто псевдоним",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон суффиксов IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставляет все запросы, условия не нужны",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить TCP или UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое правило NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое правило OR",
    ),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по имени процесса; на Android соответствует имени пакета",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению имени процесса; на Android соответствует имени пакета",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по маске имени процесса; поддерживаются только * и ?",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по полному пути процесса",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению пути процесса",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по маске пути процесса; поддерживаются только * и ?",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить имя повторного сопоставления; несколько имён разделяются /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Ссылка на набор правил; требуется настроить rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить код страны IP источника",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ASN IP источника",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов источника",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон суффиксов IP источника",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон портов источника",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Переход к подправилу; обратите внимание на скобки",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить Linux USER ID",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Правило пусто"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent напрямую",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Блокировать DNS over TLS",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage(
      "Блокировать QUIC",
    ),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage(
      "Блокировать STUN",
    ),
    "rulePresetInsertHint": MessageLookupByLibrary.simpleMessage(
      "Выбранные наборы добавляются перед существующими правилами. Одинаковые правила не дублируются.",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage(
      "Локальная сеть напрямую",
    ),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple и Microsoft напрямую",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "rulesCount": m76,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Личные правила действуют в режиме правил.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("Время работы"),
    "safeMode": MessageLookupByLibrary.simpleMessage("Безопасный режим"),
    "safeModeAppTitle": m77,
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage(
      "Сохранить и повторить",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения?"),
    "saveRoutingDraft": MessageLookupByLibrary.simpleMessage(
      "Сохранить черновик",
    ),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage(
      "Оплата сканированием / переводом",
    ),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте через Alipay / WeChat",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Скрипт"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Режим скрипта, использование внешних расширяющих скриптов, предоставление возможности переопределения конфигурации одним кликом",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("Параметры скрипта"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "В этом скрипте нет настраиваемых переключателей",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seconds": MessageLookupByLibrary.simpleMessage("Секунд"),
    "secondsCount": m78,
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать все"),
    "selectBackup": MessageLookupByLibrary.simpleMessage(
      "Выберите резервную копию",
    ),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Выберите тариф для улучшения",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Отправить код"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage(
      "Отправить письмо для сброса",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Сервер"),
    "serviceAvailability": MessageLookupByLibrary.simpleMessage(
      "Доступность сервисов",
    ),
    "serviceAvailable": MessageLookupByLibrary.simpleMessage("Доступен"),
    "serviceBlocked": MessageLookupByLibrary.simpleMessage("Заблокирован"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Проверка сервиса не удалась",
    ),
    "serviceComingSoon": MessageLookupByLibrary.simpleMessage("Скоро"),
    "serviceDisallowedIsp": MessageLookupByLibrary.simpleMessage(
      "Провайдер не поддерживается",
    ),
    "serviceOriginalsOnly": MessageLookupByLibrary.simpleMessage(
      "Только оригинальный контент",
    ),
    "servicePending": MessageLookupByLibrary.simpleMessage("Не проверено"),
    "serviceProbeHint": MessageLookupByLibrary.simpleMessage(
      "Обновите, чтобы проверить маршрут и ответы сервисов",
    ),
    "serviceProbeStale": MessageLookupByLibrary.simpleMessage(
      "Маршрут изменён — обновите проверку",
    ),
    "serviceProbeStart": MessageLookupByLibrary.simpleMessage(
      "Запустите ядро для проверки (в безопасном режиме отключено)",
    ),
    "serviceRestricted": MessageLookupByLibrary.simpleMessage("Ограничен"),
    "serviceStatus": MessageLookupByLibrary.simpleMessage("Состояние сервисов"),
    "serviceTimeout": MessageLookupByLibrary.simpleMessage(
      "Время ожидания истекло",
    ),
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage("Недоступен"),
    "serviceUnsupportedRegion": MessageLookupByLibrary.simpleMessage(
      "Регион не поддерживается",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "showLess": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "showMore": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка остановки в уведомлении",
    ),
    "shrink": MessageLookupByLibrary.simpleMessage("Сжать"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Размытие боковой панели",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать полупрозрачный системный фон боковой панели",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тихий запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в фоновом режиме",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("По одному"),
    "singleValueTip": m79,
    "size": MessageLookupByLibrary.simpleMessage("Размер"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks-порт"),
    "softwareCenter": MessageLookupByLibrary.simpleMessage("Центр ПО"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Распродано"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "source": MessageLookupByLibrary.simpleMessage("Источник"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Исходный IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Специальный прокси"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Специальные правила"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Статистика скорости",
    ),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к геолокации для чтения имён Wi-Fi. На Android разрешите точное местоположение всегда и включите геолокацию.",
    ),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режим стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Стандартный режим, переопределение базовой конфигурации, предоставление возможности простого добавления правил",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Старт"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно импортирован. Хотите запустить ядро сейчас?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage("Подсказка"),
    "startSuccess": MessageLookupByLibrary.simpleMessage("Запущено успешно"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запуск VPN..."),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "Две последние попытки запуска завершились с ошибкой. В этот раз автоматическое применение профиля и запуск VPN приостановлены. Выбранный профиль и настройки сохранены. Проверьте конфигурацию и нажмите «Запустить» для повторной попытки. Уже работающее VPN-соединение сохраняется.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Восстановление запуска",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Системный DNS будет использоваться при выключении",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Стоп"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Остановка VPN..."),
    "store": MessageLookupByLibrary.simpleMessage("Магазин"),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Покупка, продление и улучшение тарифов",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправило"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о подписке",
    ),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage(
      "Приостанавливать прокси при бездействии",
    ),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "Приостанавливать передачу трафика для экономии энергии, когда экран выключен и система переходит в режим бездействия. Звонки и прямые аудиотрансляции могут прерываться.",
    ),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Сменить профиль"),
    "sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
    "system": MessageLookupByLibrary.simpleMessage("Система"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Системное приложение"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прикрепить HTTP-прокси к VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладка"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анимация вкладок"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Действительно только в мобильном виде",
    ),
    "tabAnimationFade": MessageLookupByLibrary.simpleMessage("Растворение"),
    "tabAnimationSlide": MessageLookupByLibrary.simpleMessage("Сдвиг"),
    "tailscaleAccount": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "tailscaleAddNetwork": MessageLookupByLibrary.simpleMessage(
      "Добавить сеть",
    ),
    "tailscaleAdvanced": MessageLookupByLibrary.simpleMessage("Дополнительно"),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage(
      "Ключ авторизации",
    ),
    "tailscaleAuthKeyInvalid": MessageLookupByLibrary.simpleMessage(
      "Это не похоже на ключ авторизации",
    ),
    "tailscaleAuthKeySaved": MessageLookupByLibrary.simpleMessage(
      "На этом устройстве сохранён ключ авторизации. Введите новый, чтобы заменить его.",
    ),
    "tailscaleAutoRoute": MessageLookupByLibrary.simpleMessage(
      "Автоматическая маршрутизация",
    ),
    "tailscaleAutoRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Направлять адреса узлов, имена MagicDNS и одобренные подсети через эту сеть",
    ),
    "tailscaleAvailableExitNodes": MessageLookupByLibrary.simpleMessage(
      "Доступные выходные узлы",
    ),
    "tailscaleCheckSettings": m80,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("Подключено"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage("Подключение"),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage(
      "Адрес сервера управления",
    ),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "Данные авторизации и идентификатор устройства хранятся только на этом устройстве.",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage(
      "Имя устройства",
    ),
    "tailscaleDevices": m81,
    "tailscaleDirect": MessageLookupByLibrary.simpleMessage("Напрямую"),
    "tailscaleEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Добавьте сеть, войдите на этом устройстве и запустите прокси, чтобы получить доступ к своим устройствам.",
    ),
    "tailscaleEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Доступ к вашей сети tailnet",
    ),
    "tailscaleEnterAuthKey": MessageLookupByLibrary.simpleMessage(
      "Введите ключ авторизации, чтобы войти на этом устройстве.",
    ),
    "tailscaleEntryHint": MessageLookupByLibrary.simpleMessage(
      "Доступ к устройствам в вашей сети tailnet",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("Выходной узел"),
    "tailscaleExitNodeActive": MessageLookupByLibrary.simpleMessage(
      "Используемый выходной узел",
    ),
    "tailscaleExitNodeAllowLan": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ к локальной сети",
    ),
    "tailscaleExitNodeDesc": MessageLookupByLibrary.simpleMessage(
      "Оставьте пустым, чтобы не использовать, или укажите auto, имя узла либо его IP-адрес.",
    ),
    "tailscaleGuide": MessageLookupByLibrary.simpleMessage("Инструкция"),
    "tailscaleGuideDevices": MessageLookupByLibrary.simpleMessage(
      "Устройства и MagicDNS",
    ),
    "tailscaleGuideDevicesBody": MessageLookupByLibrary.simpleMessage(
      "Автоматическая маршрутизация направляет в эту сеть адреса и имена MagicDNS известных узлов, а также подсети, одобренные в tailnet. Остальной трафик идёт по вашим правилам.\nОна применяется после добавленных и пользовательских правил и до собственных правил профиля.\nС собственным доменом сервера управления маршрутизируются только известные имена устройств, поэтому публичные сайты домена остаются доступны.\nАдреса подсети внутри локальной сети этого устройства остаются локальными. Чтобы попасть в удалённую подсеть с теми же адресами, добавьте правило, указывающее на эту сеть.\nИмя хоста, которое разрешается в одобренную подсеть, тоже идёт через эту сеть. Если профиль сразу отдаёт такое имя прокси, добавьте доменное правило, указывающее на эту сеть.",
    ),
    "tailscaleGuideExitNodes": MessageLookupByLibrary.simpleMessage(
      "Выходные узлы",
    ),
    "tailscaleGuideExitNodesBody": MessageLookupByLibrary.simpleMessage(
      "Если указан выходной узел, сеть появляется в группах выбора профиля. Трафик идёт через него, только когда вы выберете сеть в группе или направите на неё правило.\nОставьте поле пустым, чтобы не использовать выходной узел. auto выбирает доступный выходной узел, имя или адрес устройства — конкретное устройство.",
    ),
    "tailscaleGuideGetStarted": MessageLookupByLibrary.simpleMessage(
      "Начало работы",
    ),
    "tailscaleGuideGetStartedBody": MessageLookupByLibrary.simpleMessage(
      "Добавьте сеть и выберите «Сохранить и войти». Откройте страницу входа и авторизуйте это устройство — вход завершится сам.\nЧтобы войти по ключу авторизации, выберите «Ключ авторизации» и введите его. Браузер не нужен.\nСеть работает только при запущенном прокси. Сам по себе вход не перенаправляет трафик.",
    ),
    "tailscaleGuideSignIn": MessageLookupByLibrary.simpleMessage(
      "Вход и резервное копирование",
    ),
    "tailscaleGuideSignInBody": MessageLookupByLibrary.simpleMessage(
      "Настройки сети входят в резервную копию. Ключи авторизации и идентификатор устройства остаются только на этом устройстве, поэтому после восстановления на другом устройстве войдите снова.\nКогда истечёт срок ключа узла, снова выберите «Сохранить и войти». Одобрение устройств и доступ настраиваются в вашем tailnet.\nУдаление сети выполняет выход этого устройства и удаляет его идентификатор с этого устройства.",
    ),
    "tailscaleGuideTroubleshooting": MessageLookupByLibrary.simpleMessage(
      "Устранение неполадок",
    ),
    "tailscaleGuideTroubleshootingBody": MessageLookupByLibrary.simpleMessage(
      "Проверьте, что прокси запущен, устройство одобрено, а узел в сети. Для подсетей и интернета также проверьте одобрение маршрутов и выходной узел.\n«Не применено» означает, что текущая конфигурация не содержит сеть: выберите профиль и убедитесь, что в нём нет узла с таким же именем.\nПриложение только подключается к вашему tailnet: оно не принимает входящие соединения и не предлагает это устройство как маршрутизатор подсети или выходной узел.",
    ),
    "tailscaleHostnameInvalid": MessageLookupByLibrary.simpleMessage(
      "Только строчные буквы, цифры и дефисы, не более 63 символов",
    ),
    "tailscaleInteractiveLogin": MessageLookupByLibrary.simpleMessage(
      "Интерактивный",
    ),
    "tailscaleKeyExpired": MessageLookupByLibrary.simpleMessage(
      "Срок действия ключа узла истёк",
    ),
    "tailscaleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось войти в Tailscale",
    ),
    "tailscaleLoginFooter": MessageLookupByLibrary.simpleMessage(
      "Достаточно один раз войти в каждую сеть на этом устройстве.",
    ),
    "tailscaleLoginHint": MessageLookupByLibrary.simpleMessage(
      "Вход авторизует это устройство. Чтобы пользоваться сетью, запустите прокси.",
    ),
    "tailscaleLoginMethod": MessageLookupByLibrary.simpleMessage(
      "Способ входа",
    ),
    "tailscaleLoginTimeout": MessageLookupByLibrary.simpleMessage(
      "Вход не был завершён за пять минут. Попробуйте ещё раз.",
    ),
    "tailscaleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Откройте страницу входа или отсканируйте код. Вход завершится автоматически после подтверждения.",
    ),
    "tailscaleLogout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "tailscaleNameInUse": MessageLookupByLibrary.simpleMessage(
      "Это имя уже используется",
    ),
    "tailscaleNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Не более 64 символов, без запятых",
    ),
    "tailscaleNeedsApproval": MessageLookupByLibrary.simpleMessage(
      "Ожидается одобрение устройства",
    ),
    "tailscaleNeedsLogin": MessageLookupByLibrary.simpleMessage(
      "Требуется вход",
    ),
    "tailscaleNetworkInUse": m82,
    "tailscaleNetworkName": MessageLookupByLibrary.simpleMessage(
      "Название сети",
    ),
    "tailscaleNetworks": MessageLookupByLibrary.simpleMessage("Сети"),
    "tailscaleNotApplied": MessageLookupByLibrary.simpleMessage("Не применено"),
    "tailscaleNotAppliedHint": MessageLookupByLibrary.simpleMessage(
      "Сеть не входит в текущую конфигурацию. Выберите профиль и убедитесь, что в нём нет узла с таким же именем.",
    ),
    "tailscaleNotSignedIn": MessageLookupByLibrary.simpleMessage(
      "Вход не выполнен",
    ),
    "tailscaleOffline": MessageLookupByLibrary.simpleMessage("Не в сети"),
    "tailscaleOnline": MessageLookupByLibrary.simpleMessage("В сети"),
    "tailscaleOpenLoginPage": MessageLookupByLibrary.simpleMessage(
      "Открыть страницу входа",
    ),
    "tailscaleRelay": m83,
    "tailscaleRemoveConfirm": m84,
    "tailscaleRemoveNetwork": MessageLookupByLibrary.simpleMessage(
      "Удалить сеть",
    ),
    "tailscaleSaveAndLogin": MessageLookupByLibrary.simpleMessage(
      "Сохранить и войти",
    ),
    "tailscaleSignedIn": MessageLookupByLibrary.simpleMessage("Вход выполнен"),
    "tailscaleSigningIn": MessageLookupByLibrary.simpleMessage(
      "Выполняется вход",
    ),
    "tailscaleStatus": MessageLookupByLibrary.simpleMessage("Состояние"),
    "tailscaleStopped": MessageLookupByLibrary.simpleMessage("Остановлено"),
    "tailscaleThisDevice": MessageLookupByLibrary.simpleMessage(
      "Это устройство",
    ),
    "tailscaleUnavailable": MessageLookupByLibrary.simpleMessage(
      "Подключение недоступно",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP параллелизм"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Включение позволит использовать параллелизм TCP",
    ),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "Включите эту опцию для ускорения установки TCP-соединения",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("Тест URL"),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштабирование текста"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Цвет темы"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Установить темный режим, настроить цвет",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим темы"),
    "tight": MessageLookupByLibrary.simpleMessage("Плотный"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "timeout": MessageLookupByLibrary.simpleMessage("Таймаут"),
    "tip": MessageLookupByLibrary.simpleMessage("подсказка"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Использовано сегодня"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage(
      "Переключить фонарик",
    ),
    "toggleNavigationLabels": MessageLookupByLibrary.simpleMessage(
      "Переключить подписи навигации",
    ),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Токен доступа"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите токен доступа",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Допуск"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "total": MessageLookupByLibrary.simpleMessage("Всего"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy-порт"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Использование трафика",
    ),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "После завершения перевода система подтвердит автоматически, и выбранный тариф будет активирован.",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось включить TUN: запрос прав администратора отклонён. Разрешите системный запрос прав и повторите попытку.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "действительно только в режиме администратора",
    ),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "По умолчанию 9000; можно попробовать 1480 или 4064. Перезапустите Android VPN",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "Введите целое число от 1280 до 65535",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Выключить"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Включить"),
    "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage(
      "Унифицированная задержка",
    ),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Убрать дополнительные задержки, такие как рукопожатие",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Неизвестная сетевая ошибка",
    ),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Свернуть в окно"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без имени"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Открепить окно"),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
    "updateAppImageTip": MessageLookupByLibrary.simpleMessage(
      "AppImage нельзя установить автоматически. Замените текущую программу скачанным файлом; его папка открыта.",
    ),
    "updateBuildNumber": m85,
    "updateCancelDownload": MessageLookupByLibrary.simpleMessage(
      "Отменить загрузку",
    ),
    "updateDownloadBackground": MessageLookupByLibrary.simpleMessage(
      "Скачать в фоне",
    ),
    "updateDownloadBrowser": MessageLookupByLibrary.simpleMessage(
      "Скачать в браузере",
    ),
    "updateDownloadConfirm": MessageLookupByLibrary.simpleMessage(
      "Скачать обновление",
    ),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось скачать обновление",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage(
      "Загрузка обновления",
    ),
    "updateInstall": MessageLookupByLibrary.simpleMessage(
      "Установить обновление",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Позже"),
    "updateNotice": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "updatePackageFormat": MessageLookupByLibrary.simpleMessage(
      "Выберите формат пакета",
    ),
    "updatePackageFormatTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить способ установки. Выберите подходящий формат.",
    ),
    "updatePackageManagerTip": MessageLookupByLibrary.simpleMessage(
      "Эта сборка установлена пакетным менеджером. Обновите её тем же способом, каким устанавливали.",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage(
      "Обновление готово к установке",
    ),
    "updateReadyHint": MessageLookupByLibrary.simpleMessage(
      "Обновление скачано. Установите его в удобное время.",
    ),
    "updateReleaseNotes": MessageLookupByLibrary.simpleMessage("Что нового"),
    "updateReleaseNotesFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить список изменений. Повторите попытку.",
    ),
    "updateVersionNumber": m86,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Улучшить тариф"),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль через URL",
    ),
    "urlTip": m87,
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системные hosts",
    ),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Использованный трафик",
    ),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userCenter": MessageLookupByLibrary.simpleMessage("Центр пользователя"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "Центр пользователя (резервный)",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("Проверить"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркие"),
    "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Обнаружено изменение конфигурации VPN",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически направляет весь системный трафик через VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Изменения вступят в силу после перезапуска VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Конфигурация WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режим белого списка",
    ),
    "writeToSystem": MessageLookupByLibrary.simpleMessage(
      "Записывать в систему",
    ),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "Также устанавливать системные часы; Android это игнорирует",
    ),
    "yearsAgo": m88,
    "zh_CN": MessageLookupByLibrary.simpleMessage("Упрощенный китайский"),
  };
}
