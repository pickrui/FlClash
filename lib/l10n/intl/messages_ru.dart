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

  static String m0(status) => "Сервер вернул HTTP ${status}";

  static String m1(error) => "Напрямую: ${error}";

  static String m2(error) => "Локальный прокси: ${error}";

  static String m3(code) => "Системная ошибка ${code}";

  static String m4(value) => "Комиссия ¥ ${value}";

  static String m5(line) => "Неверный формат конфигурации в строке ${line}.";

  static String m6(expected, actual) =>
      "Ожидалось: ${expected}; получено: ${actual}.";

  static String m7(code) =>
      "Windows заблокировала запуск ядра прокси (системная ошибка ${code}). Проверьте журнал защиты в Безопасности Windows, политику контроля приложений, источник и подпись установщика.";

  static String m8(name) =>
      "${name} все еще используется группой, правилом или цепочкой прокси";

  static String m9(example) =>
      "Проверьте содержимое для этого типа правила. Пример: ${example}";

  static String m10(name) =>
      "${name} недоступен. Выберите существующий источник правил.";

  static String m11(name) =>
      "${name} недоступна. Выберите цель из текущей конфигурации.";

  static String m12(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m13(label) =>
      "Вы уверены, что хотите удалить выбранные ${label}?";

  static String m14(label) =>
      "Вы уверены, что хотите удалить текущий ${label}?";

  static String m15(label) => "Детали {}";

  static String m16(count) =>
      "Пройдено ${count} из 2 независимых проверок HTTPS";

  static String m17(label) => "${label} не может быть пустым";

  static String m18(count) => "${count} записей";

  static String m19(label) => "Текущий ${label} уже существует";

  static String m20(date) => "Истекает: ${date}";

  static String m21(name) => "${name} пропущено";

  static String m22(name) => "${name} обновлено";

  static String m23(name) => "Обновление ${name}...";

  static String m24(name) =>
      "Циклическая ссылка группы «${name}». Выберите другого участника.";

  static String m25(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m26(count) => "${count} часов";

  static String m27(appName) =>
      "1. Откройте Системные настройки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте ${appName} в списке\n\nПосле настройки вернитесь в приложение и продолжайте работу. Спасибо за сотрудничество.";

  static String m28(count) =>
      "${Intl.plural(count, one: '${count} минута назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m29(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m30(label) => "${label} пока отсутствуют";

  static String m31(label) => "${label} должно быть числом";

  static String m32(name) =>
      "Имя «${name}» уже используется. Переименуйте личную группу.";

  static String m33(id) => "Тариф #${id}";

  static String m34(label) => "${label} должен быть числом от 1024 до 49151";

  static String m35(port) =>
      "Не удалось начать прослушивание смешанного порта ${port}. Возможно, он занят другим приложением. Измените порт, чтобы сразу повторить попытку.";

  static String m36(name) =>
      "Узел ${name} уже используется другой включенной цепочкой или имеет конфликт связей цепочки прокси";

  static String m37(name) => "Узел ${name} недоступен для этой позиции";

  static String m38(count) => "${count}д";

  static String m39(count) => "${count}ч";

  static String m40(count) => "${count}мин";

  static String m41(time) => "Куплено: ${time}";

  static String m42(name, path) =>
      "${name} используется исходной конфигурацией в ${path}";

  static String m43(value) => "Осталось: ${value}";

  static String m44(count) => "Осталось ${count}";

  static String m45(seconds) => "Повтор через ${seconds} с";

  static String m46(count) => "${count} секунд";

  static String m47(version) => "Версия: ${version}";

  static String m48(label) => "${label} должен быть URL";

  static String m49(count) =>
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
    "allNodes": MessageLookupByLibrary.simpleMessage("Все узлы"),
    "allNodesDesc": MessageLookupByLibrary.simpleMessage(
      "Получить все узлы, доступные в вашем тарифе",
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
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("К доплате"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("К оплате"),
    "announcement": MessageLookupByLibrary.simpleMessage("Объявление"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "API-сервис работает нормально",
    ),
    "apiAvailableWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "API доступен, но для этой проверки был разрешён пропуск проверки сертификата. Нажмите «Проверить API», чтобы проверить соединение снова.",
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
    "calculatingQuote": MessageLookupByLibrary.simpleMessage("Расчёт…"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Отменить выбор всего",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage(
      "Срок действия сертификата истёк",
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
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "Цепочка сертификатов не является доверенной",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "Сначала синхронизируйте системную дату и время. Если время верное, необходимо исправить сертификат на сервере.",
    ),
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
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Импорт из буфера обмена",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
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
    "cloudApiHttpError": m0,
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
    "cloudApiRouteDirect": m1,
    "cloudApiRouteProxy": m2,
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
    "cloudApiSystemError": m3,
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
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Код подтверждения отправлен",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "commission": MessageLookupByLibrary.simpleMessage("Комиссия"),
    "commissionBalance": m4,
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Данные обнаружены в конфигурации",
    ),
    "configParseErrorAtLine": m5,
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
    "configTypeMismatch": m6,
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
    "coreBlockedByPolicyTip": m7,
    "coreStatus": MessageLookupByLibrary.simpleMessage("Основной статус"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест на сбои"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "custom": MessageLookupByLibrary.simpleMessage("Пользовательский"),
    "customOutboundInUse": m8,
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
    "customRuleInvalidContent": m9,
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
    "customRuleUnavailableProvider": m10,
    "customRuleUnavailableTarget": m11,
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
    "daysAgo": m12,
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
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteMultipTip": m13,
    "deleteTip": m14,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначение"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "Геолокация назначения",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("ASN назначения"),
    "details": m15,
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
    "diagWebResult": m16,
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Отключить UDP"),
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
    "earlyRenew": MessageLookupByLibrary.simpleMessage("Досрочное продление"),
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
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "Пользовательское переопределение пусто. Используйте быстрое заполнение или добавьте правила и группы прокси. Чтобы сохранить содержимое подписки, выберите режим «Дополнение».",
    ),
    "emptyTip": m17,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Включить автопродление",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "entriesCount": m18,
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
    "existsTip": m19,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйти из полноэкранного режима",
    ),
    "expand": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожидаемый статус"),
    "expireDate": m20,
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
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профиле"),
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
    "geoSkipped": m21,
    "geoUpdated": m22,
    "geoUpdating": m23,
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
    "groupCycleError": m24,
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
    "hoursAgo": m25,
    "hoursCount": m26,
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
      "Недостаточно средств. Пополните баланс перед применением.",
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
      "Не удалось проверить сертификат сервера. При пропуске проверки сервер может оказаться поддельным, а передаваемые или получаемые учётные данные и данные подписки могут быть украдены или изменены.\n\nПродолжайте, только если доверяете этой сети и серверу. Исключение действует лишь для этой повторной попытки с тем же сервером и сертификатом и отменяется после завершения операции.",
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
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию отклонено, поэтому невозможно получить имя текущей сети Wi-Fi. Включите разрешение на геолокацию вручную в системных настройках.",
    ),
    "locationPermissionGuide": m27,
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
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "Куда направляются правила с целью MATCH-TARGET. По умолчанию — цель последнего правила MATCH этого профиля.",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Цель MATCH"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. количество неудач",
    ),
    "maximize": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "Порядок выбора определяет порядок переключения. Повторный выбор перемещает участника в конец.",
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
    "minimize": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Свернуть при выходе",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Изменить стандартное событие выхода из системы",
    ),
    "minutesAgo": m28,
    "mipsStackDesc": MessageLookupByLibrary.simpleMessage(
      "Стек в пространстве пользователя с низким потреблением памяти; на каналах с высокой задержкой скорость может снизиться",
    ),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m29,
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
    "noSearchResult": MessageLookupByLibrary.simpleMessage("Нет совпадений"),
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
    "nullTip": m30,
    "numberTip": m31,
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
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "Недоступно в этой конфигурации. Удалите или замените.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Личные настройки хранятся отдельно и применяются после обновлений. Новые группы блокируют соединения, если нет подходящих участников.",
    ),
    "overlayNameConflict": m32,
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
    "pinWindow": MessageLookupByLibrary.simpleMessage(
      "Закрепить поверх всех окон",
    ),
    "planEnded": MessageLookupByLibrary.simpleMessage("Завершён"),
    "planInUse": MessageLookupByLibrary.simpleMessage("Используется"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Ожидает активации",
    ),
    "planNumber": m33,
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
    "portTip": m34,
    "portUnavailableMessage": m35,
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
    "proxyChainConflictTip": m36,
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
    "proxyChainUnavailableNodeTip": m37,
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
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Автопродление",
    ),
    "purchaseDays": m38,
    "purchaseHours": m39,
    "purchaseMinutes": m40,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage("Цена покупки"),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Выкл."),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("Вкл."),
    "purchaseRenewalPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Стоимость продления",
    ),
    "purchaseTime": m41,
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Общий трафик",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Время покупки"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто черный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код для получения профиля",
    ),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радужные"),
    "rawOutboundInUse": m42,
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Адрес получателя",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Пополнить"),
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Сумма пополнения (¥)",
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
    "remaining": m43,
    "remainingStock": m44,
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
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр последних записей запросов",
    ),
    "resendCodeIn": m45,
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
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "Пропустить проверку и повторить",
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
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Правило пусто"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Личные правила действуют в режиме правил.",
    ),
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
    "secondsCount": m46,
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать все"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Выберите тариф для улучшения",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
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
      "Покупка тарифов · Пополнение · Продление и апгрейд",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправило"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage(
      "Приостанавливать прокси при бездействии",
    ),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "Приостанавливать передачу трафика для экономии энергии, когда экран выключен и система переходит в режим бездействия. Звонки и прямые аудиотрансляции могут прерываться.",
    ),
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
    "updateVersionNumber": m47,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Улучшить тариф"),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль через URL",
    ),
    "urlTip": m48,
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
    "yearsAgo": m49,
    "zh_CN": MessageLookupByLibrary.simpleMessage("Упрощенный китайский"),
  };
}
