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

  static String m0(value) => "Комиссия ¥ ${value}";

  static String m1(line) => "Неверный формат конфигурации в строке ${line}.";

  static String m2(expected, actual) =>
      "Ожидалось: ${expected}; получено: ${actual}.";

  static String m3(name) =>
      "${name} все еще используется группой, правилом или цепочкой прокси";

  static String m4(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m5(label) =>
      "Вы уверены, что хотите удалить выбранные ${label}?";

  static String m6(label) => "Вы уверены, что хотите удалить текущий ${label}?";

  static String m7(label) => "Детали {}";

  static String m8(label) => "${label} не может быть пустым";

  static String m9(count) => "${count} записей";

  static String m10(label) => "Текущий ${label} уже существует";

  static String m11(date) => "Истекает: ${date}";

  static String m12(name) => "${name} пропущено";

  static String m13(name) => "${name} обновлено";

  static String m14(name) => "Обновление ${name}...";

  static String m15(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m16(count) => "${count} часов";

  static String m17(count) =>
      "${Intl.plural(count, one: '${count} минута назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m18(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m19(label) => "${label} пока отсутствуют";

  static String m20(label) => "${label} должно быть числом";

  static String m21(id) => "Тариф #${id}";

  static String m22(label) => "${label} должен быть числом от 1024 до 49151";

  static String m23(name) =>
      "Узел ${name} уже используется другой включенной цепочкой или имеет конфликт связей цепочки прокси";

  static String m24(name) => "Узел ${name} недоступен для этой позиции";

  static String m25(time) => "Куплено: ${time}";

  static String m26(name, path) =>
      "${name} используется исходной конфигурацией в ${path}";

  static String m27(value) => "Осталось: ${value}";

  static String m28(count) => "Осталось ${count}";

  static String m29(seconds) => "Повтор через ${seconds} с";

  static String m30(count) => "${count} секунд";

  static String m31(count) => "Выбрано ${count} элементов";

  static String m32(label) => "${label} должен быть URL";

  static String m33(count) =>
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
    "action_mode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "action_start": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "activate": MessageLookupByLibrary.simpleMessage("Активировать"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "Активировать этот тариф? Он станет вашим активным тарифом.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage(
      "Активировать тариф",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
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
    "announcement": MessageLookupByLibrary.simpleMessage("Объявление"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "API-сервис работает нормально",
    ),
    "app": MessageLookupByLibrary.simpleMessage("Приложение"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
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
    "availablePlans": MessageLookupByLibrary.simpleMessage("Выберите тариф"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование и восстановление",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Синхронизация данных через WebDAV или файлы",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование успешно",
    ),
    "balance": MessageLookupByLibrary.simpleMessage("Баланс"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфигурация"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное изменение базовых настроек",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Привязать"),
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
    "buyWithBalance": MessageLookupByLibrary.simpleMessage(
      "Использовать баланс",
    ),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Обход домена"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только при включенном системном прокси",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш поврежден. Хотите очистить его?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Отменить выбор всего",
    ),
    "checkApi": MessageLookupByLibrary.simpleMessage("Проверить API"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Проверить обновления"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "Текущее приложение уже является последней версией",
    ),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить обновления. Проверьте сеть и повторите попытку",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("Проверка..."),
    "clearData": MessageLookupByLibrary.simpleMessage("Очистить данные"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Удалить настройку цепочки",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Импорт из буфера обмена",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Код подтверждения отправлен",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "commission": MessageLookupByLibrary.simpleMessage("Комиссия"),
    "commissionBalance": m0,
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Данные обнаружены в конфигурации",
    ),
    "configParseErrorAtLine": m1,
    "configTypeMismatch": m2,
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
    "coreStatus": MessageLookupByLibrary.simpleMessage("Основной статус"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест на сбои"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "custom": MessageLookupByLibrary.simpleMessage("Пользовательский"),
    "customOutboundInUse": m3,
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Темный"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель управления"),
    "daysAgo": m4,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Сервер имен по умолчанию",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения DNS-сервера",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("По умолчанию"),
    "delay": MessageLookupByLibrary.simpleMessage("Задержка"),
    "delayTest": MessageLookupByLibrary.simpleMessage("Тест задержки"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
    "deleteAccountAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Я понимаю, что мой аккаунт будет удалён безвозвратно",
    ),
    "deleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить аккаунт",
    ),
    "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Аккаунт удалён",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Безвозвратное удаление аккаунта удалит аккаунт, активные тарифы, баланс, историю покупок и связанные облачные данные. Это действие нельзя отменить.",
    ),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначение"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "Геолокация назначения",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("ASN назначения"),
    "details": m7,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Опирается на сторонний API, только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Режим разработчика"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика активирован.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Отключить UDP"),
    "disconnected": MessageLookupByLibrary.simpleMessage("Отключено"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Промокод (необязательно)",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Обновление настроек, связанных с DNS",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS-перехват"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Вы хотите пропустить",
    ),
    "documentCenter": MessageLookupByLibrary.simpleMessage(
      "Центр документации",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "download": MessageLookupByLibrary.simpleMessage("Скачивание"),
    "earlyRenew": MessageLookupByLibrary.simpleMessage("Досрочное продление"),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Редактировать глобальные правила",
    ),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Редактировать группу прокси",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Редактировать правило"),
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
    "emergencyMode": MessageLookupByLibrary.simpleMessage("Аварийный режим"),
    "emergencyModeDesc": MessageLookupByLibrary.simpleMessage(
      "Включите эту опцию для переключения на резервные узлы, когда обычные линии недоступны",
    ),
    "emptyTip": m8,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Включить автопродление",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "entriesCount": m9,
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Скрыть из последних задач",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Когда приложение находится в фоновом режиме, оно скрыто из последних задач",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Исключить фильтр прокси",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Тип исключения"),
    "existsTip": m10,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "expand": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожидаемый статус"),
    "expireDate": m11,
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
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fakeip"),
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
    "fontFamily": MessageLookupByLibrary.simpleMessage("Семейство шрифтов"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно перезапустить ядро?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый микс"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления должен быть от 1 до 8760 часов",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Настройки Geo"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Ресурсы Geo"),
    "geoSkipped": m12,
    "geoUpdated": m13,
    "geoUpdating": m14,
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
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Хотите сохранить изменения в кэше?",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Уже есть аккаунт?",
    ),
    "hide": MessageLookupByLibrary.simpleMessage("Скрыть"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Скрыть из списка"),
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
    "hours": MessageLookupByLibrary.simpleMessage("Часов"),
    "hoursAgo": m15,
    "hoursCount": m16,
    "iHavePaid": MessageLookupByLibrary.simpleMessage("Я оплатил"),
    "icon": MessageLookupByLibrary.simpleMessage("Иконка"),
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
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Интеллектуальный выбор",
    ),
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
      "Не удалось проверить сертификат сервера. Если вы доверяете этой сети и серверу, можно пропустить проверку только для этой попытки.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "Ошибка проверки сертификата",
    ),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("Код приглашения"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "При включении будет возможно получать IPv6 трафик",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить входящий IPv6",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Японский"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал поддержания TCP-соединения",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "lazy": MessageLookupByLibrary.simpleMessage("Ленивая загрузка"),
    "light": MessageLookupByLibrary.simpleMessage("Светлый"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Слушать"),
    "loadTest": MessageLookupByLibrary.simpleMessage("Тест загрузки"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "local": MessageLookupByLibrary.simpleMessage("Локальный"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на локальный диск",
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
    "logoutAndDeleteToken": MessageLookupByLibrary.simpleMessage(
      "Выйти и удалить токен",
    ),
    "logoutContent": MessageLookupByLibrary.simpleMessage(
      "В любом случае токен будет удален с этого устройства. Его удаление из oixCloud может привести к выходу на других устройствах, использующих тот же токен.",
    ),
    "logoutLocalOnly": MessageLookupByLibrary.simpleMessage("Только выйти"),
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
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. количество неудач",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Информация о памяти"),
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
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Свернуть при выходе",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Изменить стандартное событие выхода из системы",
    ),
    "minutesAgo": m17,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m18,
    "more": MessageLookupByLibrary.simpleMessage("Еще"),
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
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с сетью",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Обнаружение сети",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Ошибка сети, проверьте соединение и попробуйте еще раз",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Скорость сети"),
    "networkType": MessageLookupByLibrary.simpleMessage("Тип сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральные"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("Новый пароль"),
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
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "Нет тарифов для улучшения",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущая группа прокси не может быть выбрана.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Нет профиля, пожалуйста, добавьте профиль",
    ),
    "nullTip": m19,
    "numberTip": m20,
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
    "optionalParameters": MessageLookupByLibrary.simpleMessage(
      "Дополнительные параметры",
    ),
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "orderAndPay": MessageLookupByLibrary.simpleMessage("Оплатить онлайн"),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "outboundMode": MessageLookupByLibrary.simpleMessage(
      "Режим исходящего трафика",
    ),
    "override": MessageLookupByLibrary.simpleMessage("Переопределить"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Включение переопределит настройки DNS в профиле",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режим переопределения",
    ),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скрипт переопределения",
    ),
    "overseasNetworkEnvironment": MessageLookupByLibrary.simpleMessage(
      "Зарубежная сетевая среда",
    ),
    "overseasNetworkEnvironmentDesc": MessageLookupByLibrary.simpleMessage(
      "Включите эту опцию, если вы находитесь за пределами материкового Китая",
    ),
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Пользовательский",
    ),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Пользовательский режим, полная настройка групп прокси и правил",
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
    "planEnded": MessageLookupByLibrary.simpleMessage("Завершён"),
    "planInUse": MessageLookupByLibrary.simpleMessage("Используется"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Ожидает активации",
    ),
    "planNumber": m21,
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
    "portTip": m22,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Приоритетное использование HTTP/3 для DOH",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, нажмите клавишу.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
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
    "providers": MessageLookupByLibrary.simpleMessage("Провайдеры"),
    "proxies": MessageLookupByLibrary.simpleMessage("Прокси"),
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Доступные узлы",
    ),
    "proxyChainConflictTip": m23,
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
    "proxyChainUnavailableNodeTip": m24,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Поддерживаемые форматы: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "Цепочка прокси может заметно снизить скорость сети. Оставьте ее выключенной, если она явно не нужна.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочки прокси"),
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
    "proxyPort": MessageLookupByLibrary.simpleMessage("Порт прокси"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Очистить кэш"),
    "purchaseTime": m25,
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто черный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код для получения профиля",
    ),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радужные"),
    "rawOutboundInUse": m26,
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Адрес получателя",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Пополнить"),
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Сумма пополнения (¥)",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir-порт"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "После оплаты потяните вниз, чтобы обновить и проверить результат",
    ),
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
    "remaining": m27,
    "remainingStock": m28,
    "remote": MessageLookupByLibrary.simpleMessage("Удаленный"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Удалённое назначение",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр последних записей запросов",
    ),
    "resendCodeIn": m29,
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
    "ru": MessageLookupByLibrary.simpleMessage("Русский"),
    "rule": MessageLookupByLibrary.simpleMessage("Правило"),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Правило пусто"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения?"),
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
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seconds": MessageLookupByLibrary.simpleMessage("Секунд"),
    "secondsCount": m30,
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать все"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Выберите тариф для улучшения",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
    "selectedCountTitle": m31,
    "sendCode": MessageLookupByLibrary.simpleMessage("Отправить код"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage(
      "Отправить письмо для сброса",
    ),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Проверка сервиса не удалась",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "shrink": MessageLookupByLibrary.simpleMessage("Сжать"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тихий запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в фоновом режиме",
    ),
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
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Системный DNS будет использоваться при выключении",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Стоп"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Остановка VPN..."),
    "store": MessageLookupByLibrary.simpleMessage("Магазин"),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Покупка тарифов · Пополнение · Продление и апгрейд",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправило"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
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
    "timeSyncTip": MessageLookupByLibrary.simpleMessage(
      "Протокол прокси требует, чтобы время устройства не отличалось от времени UTC более чем на 30 секунд. Пожалуйста, убедитесь, что время на вашем устройстве точное.",
    ),
    "timeout": MessageLookupByLibrary.simpleMessage("Таймаут"),
    "tip": MessageLookupByLibrary.simpleMessage("подсказка"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Использовано сегодня"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Токен доступа"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите токен доступа",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Допуск"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy-порт"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Использование трафика",
    ),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "После завершения перевода система подтвердит автоматически, и выбранный тариф будет активирован.",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "действительно только в режиме администратора",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Выключить"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Включить"),
    "twoFactorCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Код двухфакторной аутентификации (если включена)",
    ),
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
    "unnamed": MessageLookupByLibrary.simpleMessage("Без имени"),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Улучшить тариф"),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль через URL",
    ),
    "urlTip": m32,
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системные hosts",
    ),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userCenter": MessageLookupByLibrary.simpleMessage("Центр пользователя"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "Центр пользователя (резервный)",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
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
    "yearsAgo": m33,
    "zh_CN": MessageLookupByLibrary.simpleMessage("Упрощенный китайский"),
  };
}
