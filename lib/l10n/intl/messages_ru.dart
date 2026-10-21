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

  static String m10(url) => "Создать профиль по ссылке ${url}?";

  static String m11(count) =>
      "${Intl.plural(count, one: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${count} правило SUB-RULE', few: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${count} правила SUB-RULE', many: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${count} правил SUB-RULE', other: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${count} правила SUB-RULE')}";

  static String m12(count) =>
      "${Intl.plural(count, one: '${count} прокси без имени или типа', few: '${count} прокси без имени или типа', many: '${count} прокси без имени или типа', other: '${count} прокси без имени или типа')}";

  static String m13(count) =>
      "Проблем: ${count}, применение профиля может завершиться ошибкой";

  static String m14(name) =>
      "${name} все еще используется группой, правилом или цепочкой прокси";

  static String m15(example) =>
      "Проверьте содержимое для этого типа правила. Пример: ${example}";

  static String m16(name) =>
      "${name} недоступен. Выберите существующий источник правил.";

  static String m17(name) =>
      "${name} недоступна. Выберите цель из текущей конфигурации.";

  static String m18(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m19(count) => "${count} дн. назад";

  static String m20(label) =>
      "Вы уверены, что хотите удалить выбранные ${label}?";

  static String m21(label) =>
      "Вы уверены, что хотите удалить текущий ${label}?";

  static String m22(label) => "Детали: ${label}";

  static String m23(port) =>
      "Локальный адрес: 127.0.0.1\nСмешанный порт (текущая конфигурация): ${port}\nИспользуйте этот порт для HTTP, проксирования сайтов HTTPS и SOCKS5 только на этом устройстве.";

  static String m24(count) =>
      "Пройдено ${count} из 2 независимых проверок HTTPS";

  static String m25(name) =>
      "Подключение через ${name} ведёт обратно к прокси, который его использует, поэтому соединение остановлено";

  static String m26(label) => "${label} не может быть пустым";

  static String m27(label) => "Текущий ${label} уже существует";

  static String m28(date) => "Истекает: ${date}";

  static String m29(label, message) => "${label}: ${message}";

  static String m30(name) => "${name} пропущено";

  static String m31(name) => "${name} обновлено";

  static String m32(name) => "Обновление ${name}...";

  static String m33(count) => "Групп: ${count}";

  static String m34(name) =>
      "Циклическая ссылка группы «${name}». Выберите другого участника.";

  static String m35(count) => "Тайм-аут: ${count}";

  static String m36(action) =>
      "Уже используется для «${action}». При сохранении будет перенесено сюда.";

  static String m37(modifiers) =>
      "Добавьте хотя бы одну из клавиш: ${modifiers}";

  static String m38(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m39(count) => "${count} ч назад";

  static String m40(count) => "${count} часов";

  static String m41(target) => "${target} — недопустимая политика";

  static String m42(providerName) =>
      "${providerName} — недопустимый провайдер прокси";

  static String m43(ruleSet) => "${ruleSet} — недопустимый набор правил";

  static String m44(subRule) => "${subRule} — недопустимый SUB_RULE";

  static String m45(count) =>
      "${Intl.plural(count, one: '${count} элемент', few: '${count} элемента', many: '${count} элементов', other: '${count} элемента')}";

  static String m46(line, message) => "Строка ${line}: ${message}";

  static String m47(appName) =>
      "1. Откройте Системные настройки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте ${appName} в списке\n\nПосле настройки вернитесь в приложение и продолжайте работу. Спасибо за сотрудничество.";

  static String m48(label, max) => "«${label}» — не более ${max} символов";

  static String m49(size) => "Освобождено ${size}";

  static String m50(count) =>
      "${Intl.plural(count, one: '${count} минута назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m51(count) => "${count} мин назад";

  static String m52(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m53(count) => "${count} мес. назад";

  static String m54(code) =>
      "Сервер запретил доступ (HTTP ${code}). Возможно, ссылка устарела или учётные данные неверны";

  static String m55(code) => "Сервер отклонил запрос (HTTP ${code})";

  static String m56(code) =>
      "По этому адресу ничего не найдено (HTTP ${code}). Проверьте правильность URL";

  static String m57(code) =>
      "На сервере произошла ошибка (HTTP ${code}). Повторите попытку позже";

  static String m58(kept, total) => "Оставлено ${kept} из ${total} узлов";

  static String m59(name) => "${name}, исключён";

  static String m60(name) => "${name}, оставлен";

  static String m61(label) => "${label} пока отсутствуют";

  static String m62(label, min, max) =>
      "Значение «${label}» должно быть от ${min} до ${max}";

  static String m63(label) => "${label} должно быть числом";

  static String m64(name) =>
      "Имя «${name}» уже используется. Переименуйте личную группу.";

  static String m65(name) =>
      "Имя ${name} уже занято другим прокси или группой прокси";

  static String m66(name) =>
      "Резервный выход пустой группы должен быть существующим узлом или встроенным выходом, а не группой прокси: ${name}";

  static String m67(path) =>
      "Группы прокси ссылаются друг на друга по кругу: ${path}";

  static String m68(names) => "Эти провайдеры прокси не существуют: ${names}";

  static String m69(names) => "Эти прокси или политики не существуют: ${names}";

  static String m70(name) =>
      "${name} — встроенное имя политики, его нельзя использовать";

  static String m71(count) =>
      "Проблем: ${count}, применение переопределения может завершиться ошибкой";

  static String m72(id) => "Тариф #${id}";

  static String m73(port) => "Подставлен рекомендуемый порт ${port}.";

  static String m74(label) => "${label} должен быть числом от 1024 до 49151";

  static String m75(port) =>
      "Не удалось начать прослушивание смешанного порта ${port}. Возможно, он занят другим приложением. Измените порт, чтобы сразу повторить попытку.";

  static String m76(port) => "Порт ${port}";

  static String m77(days) => "Осталось дней: ${days}";

  static String m78(date, days) => "Истекает ${date}, осталось дней: ${days}";

  static String m79(profiles) =>
      "Этот профиль — провайдер прокси в ${profiles}. Сначала удалите его там.";

  static String m80(time) => "Обновлено ${time}";

  static String m81(profiles) => "Ресурс используется в ${profiles}";

  static String m82(profiles) => "Переименование изменит ссылки в ${profiles}";

  static String m83(profiles) =>
      "Перед переименованием измените ссылки в исходном профиле: ${profiles}";

  static String m84(profiles) =>
      "Не удалось прочитать профили для проверки ссылок: ${profiles}";

  static String m85(count) => "${count} прокси";

  static String m86(name) =>
      "Узел ${name} уже используется другой включенной цепочкой или имеет конфликт связей цепочки прокси";

  static String m87(name) => "Узел ${name} недоступен для этой позиции";

  static String m88(address) =>
      "До запуска системный прокси указывал на ${address}.";

  static String m89(name) =>
      "До запуска трафик шёл через другой VPN или виртуальный адаптер: ${name}.";

  static String m90(count) =>
      "${Intl.plural(count, one: '${count} группа прокси', few: '${count} группы прокси', many: '${count} групп прокси', other: '${count} группы прокси')}";

  static String m91(count) => "${count}д";

  static String m92(count) => "${count}ч";

  static String m93(count) => "${count}мин";

  static String m94(name, path) =>
      "${name} используется исходной конфигурацией в ${path}";

  static String m95(min, max) => "Допустимый диапазон ${min} – ${max}";

  static String m96(value) => "Осталось: ${value}";

  static String m97(count) => "Осталось ${count}";

  static String m98(seconds) => "Повтор через ${seconds} с";

  static String m99(limit) => "Размер ресурса превышает ${limit}";

  static String m100(count) =>
      "${Intl.plural(count, one: '${count} правило', few: '${count} правила', many: '${count} правил', other: '${count} правила')}";

  static String m101(appName) => "${appName} (Безопасный режим)";

  static String m102(count) => "Добавлено (${count})";

  static String m103(count) => "Изменено (${count})";

  static String m104(count) => "Удалено (${count})";

  static String m105(count) => "${count} секунд";

  static String m106(count) => "Действуют: ${count}";

  static String m107(count) =>
      "${Intl.plural(count, one: '${count} настройка', few: '${count} настройки', many: '${count} настроек', other: '${count} настройки')}";

  static String m108(count) =>
      "${Intl.plural(count, one: 'Из ссылок добавлен ${count} узел', few: 'Из ссылок добавлено ${count} узла', many: 'Из ссылок добавлено ${count} узлов', other: 'Из ссылок добавлено ${count} узла')}";

  static String m109(count) =>
      "${Intl.plural(count, one: 'Не удалось прочитать ${count} ссылку', few: 'Не удалось прочитать ${count} ссылки', many: 'Не удалось прочитать ${count} ссылок', other: 'Не удалось прочитать ${count} ссылки')}";

  static String m110(label) => "«${label}» — только одно значение";

  static String m111(fields) => "Проверьте настройки: ${fields}";

  static String m112(count) => "Устройства (${count})";

  static String m113(name, profile) =>
      "${name} все еще используется правилом или группой в профиле «${profile}»";

  static String m114(region) => "Ретранслятор ${region}";

  static String m115(name) =>
      "Это устройство выйдет из сети ${name}, а данные входа будут удалены с него. Если сеть сейчас недоступна, удалите устройство в консоли администратора Tailscale.";

  static String m116(value) => "Пик ${value}";

  static String m117(value) => "Всего ${value}";

  static String m118(build) => "Номер сборки: ${build}";

  static String m119(version) => "Версия: ${version}";

  static String m120(label) => "${label} должен быть URL";

  static String m121(count) =>
      "${Intl.plural(count, one: '${count} год назад', few: '${count} года назад', many: '${count} лет назад', other: '${count} года назад')}";

  static String m122(count) =>
      "${Intl.plural(count, one: '${count} г. назад', few: '${count} г. назад', many: '${count} л. назад', other: '${count} г. назад')}";

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
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений отключён",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные приложения будут исключены из VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки контроля доступа",
    ),
    "accessToken": MessageLookupByLibrary.simpleMessage("Access Token"),
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
    "addNodes": MessageLookupByLibrary.simpleMessage("Добавить узлы"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Добавить профиль"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Добавить группу прокси",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавить правило"),
    "addSettingEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addSsid": MessageLookupByLibrary.simpleMessage("Добавить SSID"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Добавленные правила"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Дополнительные параметры",
    ),
    "additionalPrefix": MessageLookupByLibrary.simpleMessage("Префикс имени"),
    "additionalSuffix": MessageLookupByLibrary.simpleMessage("Суффикс имени"),
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
    "ageDecryptFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось расшифровать профиль. Проверьте секретный ключ age и повторите попытку.",
    ),
    "ageSecretKey": MessageLookupByLibrary.simpleMessage("Секретный ключ age"),
    "ageSecretKeyRequiredTip": MessageLookupByLibrary.simpleMessage(
      "Профиль зашифрован с помощью age, для расшифровки нужен секретный ключ age",
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
    "allowedIps": MessageLookupByLibrary.simpleMessage("Разрешённые IP"),
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
      "Добавлять системный DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Принудительно добавить системный DNS к конфигурации",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Приложение"),
    "authentication": MessageLookupByLibrary.simpleMessage(
      "Аутентификация локального прокси",
    ),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось применить настройки аутентификации",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Аутентификация локального прокси требует имя пользователя и пароль для HTTP/SOCKS. Пока она включена, системный HTTP-прокси не настраивается; TUN/VPN остаётся доступен",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "От 1 до 255 байт UTF-8, без управляющих символов",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Пока включена аутентификация локального прокси, системный прокси не применяется",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "От 1 до 255 байт UTF-8, без двоеточий и управляющих символов",
    ),
    "authorized": MessageLookupByLibrary.simpleMessage("Разрешено"),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автозакрытие соединений",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически закрывать соединения после смены узла",
    ),
    "autoInclude": MessageLookupByLibrary.simpleMessage(
      "Автоматическое включение",
    ),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("Авто IPv6"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "«Авто IPv6» включает и выключает IPv6 в зависимости от поддержки локальной сетью",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Следовать автозапуску системы",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автовключение"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматический запуск при открытии приложения",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автонастройка системного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления",
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
    "basicInfo": MessageLookupByLibrary.simpleMessage("Основная информация"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Базовые политики"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Массовое добавление"),
    "batchLinkInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной ссылке на строку",
    ),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному значению на строку или через запятую",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной записи на строку: ключ, пробел, значение",
    ),
    "batchPreviewTip": m1,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Игнорирование оптимизации батареи позволяет приложению работать в фоне",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Из-за системных ограничений во время работы невозможно корректно получить статус оптимизации батареи",
    ),
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
      "Отклонять STUN-трафик для снижения утечек IP через WebRTC.",
    ),
    "brightness": MessageLookupByLibrary.simpleMessage("Яркость"),
    "buy": MessageLookupByLibrary.simpleMessage("Купить"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Исключённые домены"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Исключённые домены действуют только при включённом системном прокси",
    ),
    "bypassPrivateRoute": MessageLookupByLibrary.simpleMessage(
      "Обходить частные адреса",
    ),
    "bypassPrivateRouteDesc": MessageLookupByLibrary.simpleMessage(
      "При обходе частных адресов адреса LAN, loopback и multicast идут в обход TUN",
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
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось переключить прокси; восстановлен предыдущий выбор",
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
    "cipher": MessageLookupByLibrary.simpleMessage("Шифр"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("Очистить всё"),
    "clearData": MessageLookupByLibrary.simpleMessage("Очистить данные"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Удалить настройку цепочки",
    ),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Очистить поиск"),
    "clientFingerprint": MessageLookupByLibrary.simpleMessage(
      "Отпечаток клиента",
    ),
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
    "colorStyle": MessageLookupByLibrary.simpleMessage("Стиль палитры"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "commission": MessageLookupByLibrary.simpleMessage("Комиссия"),
    "commissionBalance": m6,
    "compact": MessageLookupByLibrary.simpleMessage("Компактный"),
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
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить эту группу прокси?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите закрыть текущее окно?",
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
    "congestionControl": MessageLookupByLibrary.simpleMessage(
      "Управление перегрузкой",
    ),
    "congestionController": MessageLookupByLibrary.simpleMessage(
      "Управление перегрузкой TCP",
    ),
    "congestionControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Управление перегрузкой TCP действует только со стеком mips",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Подключено"),
    "connecting": MessageLookupByLibrary.simpleMessage("Подключение..."),
    "connection": MessageLookupByLibrary.simpleMessage("Соединение"),
    "connectionStats": MessageLookupByLibrary.simpleMessage(
      "Статистика подключений",
    ),
    "connectionStatsDesc": MessageLookupByLibrary.simpleMessage(
      "Подключения, запросы и DNS-запросы",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("Соединения"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр текущих данных о соединениях",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Связь："),
    "content": MessageLookupByLibrary.simpleMessage("Содержание"),
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
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Windows заблокировала FlClashCore.exe; Smart App Control включён. Проверьте сведения в разделе «Безопасность Windows → Управление приложениями и браузером» и используйте проверенный выпуск из доверенного источника.",
    ),
    "coreNotConnected": MessageLookupByLibrary.simpleMessage(
      "Ядро не подключено",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Основной статус"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест на сбои"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createProfileFromUrlTip": m10,
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "currentOutboundDesc": MessageLookupByLibrary.simpleMessage(
      "Содержит кнопку запуска, удалить нельзя",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Пользовательский"),
    "customColor": MessageLookupByLibrary.simpleMessage("Свой цвет"),
    "customImportCloudRefused": MessageLookupByLibrary.simpleMessage(
      "Адреса oixCloud нельзя импортировать в пользовательский профиль",
    ),
    "customImportDroppedSubRules": m11,
    "customImportNotImported": MessageLookupByLibrary.simpleMessage(
      "Не импортировано",
    ),
    "customImportUnnamedProxies": m12,
    "customIssuesSummary": m13,
    "customOutboundInUse": m14,
    "customProfile": MessageLookupByLibrary.simpleMessage(
      "Пользовательский профиль",
    ),
    "customProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Группы прокси и правила из своих узлов, библиотеки провайдеров и других профилей",
    ),
    "customProfileResources": MessageLookupByLibrary.simpleMessage(
      "Ресурсы пользовательских профилей",
    ),
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Заполните свои настройки маршрутизации, затем выберите режим «Пользовательский». Редактирование черновика не меняет текущий режим.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "Выберите источник правил",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage(
      "Выберите цель",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("Форма"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "Это правило использует сложный синтаксис. Редактируйте текст, чтобы сохранить все параметры.",
    ),
    "customRuleInvalidContent": m15,
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
    "customRuleUnavailableProvider": m16,
    "customRuleUnavailableTarget": m17,
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Темный"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель управления"),
    "dashboardAddableSection": MessageLookupByLibrary.simpleMessage(
      "Можно добавить",
    ),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Обнаружены изменения данных. Сохранить их?",
    ),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить изменение. Проверьте текущее значение и повторите попытку.",
    ),
    "daysAgo": m18,
    "daysAgoShort": m19,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Сервер имен по умолчанию",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Сервер имен по умолчанию разрешает домены DNS-серверов",
    ),
    "defaultSelected": MessageLookupByLibrary.simpleMessage(
      "Выбор по умолчанию",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("По умолчанию"),
    "definitionNotMap": MessageLookupByLibrary.simpleMessage(
      "Конфигурация должна быть YAML-словарём с полями name и type",
    ),
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
    "deleteMultipTip": m20,
    "deleteTip": m21,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначение"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "Геолокация назначения",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("ASN назначения"),
    "details": m22,
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
    "diagCopyProxyAddress": MessageLookupByLibrary.simpleMessage(
      "Копировать адрес прокси",
    ),
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
      "Проверьте, не занят ли порт и запущен ли локальный прокси. Переподключитесь; если ошибка остаётся, откройте «Порты и аутентификация» и проверьте или смените смешанный порт.",
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
    "diagOpenDnsSettings": MessageLookupByLibrary.simpleMessage(
      "Переопределение DNS",
    ),
    "diagOpenNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки сети и TUN",
    ),
    "diagOpenPortSettings": MessageLookupByLibrary.simpleMessage(
      "Порты и аутентификация",
    ),
    "diagOpenSettingsFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть системные настройки. Откройте их вручную по указанному выше пути.",
    ),
    "diagOpenSystemSettings": MessageLookupByLibrary.simpleMessage(
      "Открыть системные настройки",
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
    "diagProxyAutomaticHint": MessageLookupByLibrary.simpleMessage(
      "Скрипт PAC или автообнаружение могут выбирать разные прокси для разных сайтов. Это не обязательно означает сбой связи. Перед изменением проверьте источник настроек.",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "Прокси ОС не совпадает с портом приложения",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "Клиент запросил системный прокси, но в ОС он выключен",
    ),
    "diagProxyGuide": MessageLookupByLibrary.simpleMessage(
      "Диагностика и ручная настройка",
    ),
    "diagProxyGuideApp": MessageLookupByLibrary.simpleMessage(
      "На этом устройстве откройте настройки прокси нужного приложения, выберите HTTP или SOCKS5 и введите адрес и порт ниже.\nAndroid предоставляет системный прокси через службу VPN. Для доступа через VPN проверьте переключатель VPN и контроль доступа приложений в сетевых настройках FlClash.",
    ),
    "diagProxyGuideAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Включена аутентификация локального прокси, поэтому FlClash не задаёт системный прокси автоматически.\nВ приложении с поддержкой аутентификации прокси выберите HTTP или SOCKS5 и введите адрес и порт ниже. Имя пользователя и пароль доступны в FlClash → Переопределение → Общие → Входящие подключения → Аутентификация.\nНе включайте учётные данные в отчёты диагностики.",
    ),
    "diagProxyGuideInvalidPort": MessageLookupByLibrary.simpleMessage(
      "Смешанный порт недоступен. Задайте допустимый порт в разделе «Порты и аутентификация» и запустите подключение.",
    ),
    "diagProxyGuideLinux": MessageLookupByLibrary.simpleMessage(
      "Откройте настройки рабочего стола → Сеть → Сетевой прокси и выберите ручной режим (названия зависят от окружения).\nУкажите адрес и порт ниже для HTTP и HTTPS и примените настройки. Если системной панели прокси нет, настройте нужное приложение.\nПеред заменой автоматической конфигурации проверьте её источник и необходимость для сети.",
    ),
    "diagProxyGuideMacos": MessageLookupByLibrary.simpleMessage(
      "Системные настройки → Сеть → активное подключение Wi-Fi или Ethernet → Подробнее → Прокси\nmacOS 12: Системные настройки → Сеть → активное подключение → Дополнительно → Прокси\nЕсли автоматические настройки остались от другого приложения и больше не нужны сети, отключите автообнаружение и автоматическую конфигурацию прокси.\nВключите веб-прокси (HTTP) и защищённый веб-прокси (HTTPS), укажите адрес и порт ниже для обоих и сохраните. Оставьте необходимые сети исключения.",
    ),
    "diagProxyGuideManualTitle": MessageLookupByLibrary.simpleMessage(
      "2. Проверьте или введите настройки",
    ),
    "diagProxyGuidePrepare": MessageLookupByLibrary.simpleMessage(
      "Выберите действующий профиль, запустите подключение в FlClash и дождитесь успешной проверки локального прокси перед вводом адреса.\nЗакройте другие прокси-приложения, меняющие системные настройки. Если настройки управляются компанией или учебным заведением, заблокированы или восстанавливаются, обратитесь к администратору.",
    ),
    "diagProxyGuidePrepareTitle": MessageLookupByLibrary.simpleMessage(
      "1. Проверьте локальный прокси",
    ),
    "diagProxyGuideValues": m23,
    "diagProxyGuideVerify": MessageLookupByLibrary.simpleMessage(
      "Вернитесь и нажмите «Проверить снова», затем повторите попытку в используемом браузере или приложении.\nЕсли локальный прокси проходит проверку, но приложение не работает, проверьте его собственные настройки прокси и расширения. Системный прокси действует не на все приложения.\nПосле остановки FlClash может потребоваться вручную отключить заданный прокси или вернуть прежние настройки, чтобы сохранить доступ к интернету.",
    ),
    "diagProxyGuideVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "3. Сохраните и проверьте приложение",
    ),
    "diagProxyGuideWindows": MessageLookupByLibrary.simpleMessage(
      "Параметры → Сеть и Интернет → Прокси-сервер\nЕсли автоматические настройки остались от другого приложения и больше не нужны сети, отключите сценарий настройки и автоматическое определение параметров.\nВ разделе ручной настройки включите прокси-сервер, введите адрес и порт ниже в отдельные поля и сохраните. Не добавляйте http:// к адресу. Сохраните необходимые сети исключения.",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "Откройте «Диагностика и ручная настройка» и проверьте адрес и порт системного прокси. Если настройки возвращаются, проверьте другие прокси-приложения и политики управления устройством.",
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
    "diagRecheck": MessageLookupByLibrary.simpleMessage("Проверить снова"),
    "diagRun": MessageLookupByLibrary.simpleMessage("Начать проверку"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "Проверяется текущая связь на небольшой выборке. Системный путь также может проходить через TUN. Результат не охватывает все приложения и узлы.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("Пропущено"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "Передача приостановлена настройкой исключения текущей Wi-Fi сети",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("Системный DNS"),
    "diagSystemDnsHint": MessageLookupByLibrary.simpleMessage(
      "Попробуйте другую сеть и проверьте DNS-серверы активного подключения в ОС. Изменение только настроек DNS клиента может не исправить системное разрешение имён.",
    ),
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
    "diagWebResult": m24,
    "dialerProxy": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения",
    ),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения — исход, через который идёт обращение к NTP-серверу",
    ),
    "dialerProxyLoopStopped": m25,
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "directNameserver": MessageLookupByLibrary.simpleMessage(
      "Сервер имен для прямых соединений",
    ),
    "directNameserverFollowPolicy": MessageLookupByLibrary.simpleMessage(
      "Сервер имен для прямых соединений следует политике",
    ),
    "disableIcmpForwarding": MessageLookupByLibrary.simpleMessage(
      "Отключить пересылку ICMP",
    ),
    "disableIcmpForwardingDesc": MessageLookupByLibrary.simpleMessage(
      "При отключённой пересылке ICMP TUN сам отвечает на ping, поэтому ping больше не показывает реальную задержку",
    ),
    "disableKeepAlive": MessageLookupByLibrary.simpleMessage(
      "Отключить TCP keep-alive",
    ),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Отключить UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Выключено"),
    "discard": MessageLookupByLibrary.simpleMessage("Не сохранять"),
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
    "dnsHijackDesc": MessageLookupByLibrary.simpleMessage(
      "Без этого параметра TUN перехватывает все DNS-запросы на порт 53 (any:53)",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("Перехват DNS"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "dnsOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Добавленные здесь параметры заменяют настройки DNS всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет",
    ),
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
    "docked": MessageLookupByLibrary.simpleMessage("Закреплённая"),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "done": MessageLookupByLibrary.simpleMessage("Готово"),
    "download": MessageLookupByLibrary.simpleMessage("Скачивание"),
    "downloadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Скорость загрузки",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Длительность"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "Автоматически добавляет узлы конфигурации при обновлении подписки. Фильтр имени, например Japan|JP.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Изменить свои настройки",
    ),
    "editDashboard": MessageLookupByLibrary.simpleMessage("Изменить панель"),
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
    "editSsid": MessageLookupByLibrary.simpleMessage("Изменить SSID"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Редактор недоступен",
    ),
    "elapsed": MessageLookupByLibrary.simpleMessage("Время"),
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
    "emptyCustomProfile": MessageLookupByLibrary.simpleMessage(
      "Сначала добавьте в этот профиль группу прокси или правило",
    ),
    "emptyFallback": MessageLookupByLibrary.simpleMessage(
      "Резерв для пустой группы",
    ),
    "emptyTip": m26,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Включить автопродление",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Включено"),
    "enabledOnStart": MessageLookupByLibrary.simpleMessage(
      "Включится при запуске",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Подробности ошибки"),
    "es": MessageLookupByLibrary.simpleMessage("Испанский"),
    "exclude": MessageLookupByLibrary.simpleMessage("Скрыть из недавних задач"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Когда приложение находится в фоновом режиме, оно скрыто из последних задач",
    ),
    "excludeDstPort": MessageLookupByLibrary.simpleMessage(
      "Исключённые порты назначения",
    ),
    "excludeDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик на исключённые порты назначения идёт в обход TUN",
    ),
    "excludeInterface": MessageLookupByLibrary.simpleMessage(
      "Исключённые интерфейсы",
    ),
    "excludeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик с исключённых интерфейсов, например с docker0, идёт в обход TUN",
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
    "excludeSrcPort": MessageLookupByLibrary.simpleMessage(
      "Исключённые исходные порты",
    ),
    "excludeSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик с исключённых исходных портов идёт в обход TUN",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage(
      "Сети Wi-Fi для приостановки прокси",
    ),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Приостанавливать прокси в указанных сетях Wi-Fi; возобновлять после отключения, только если приложение остаётся запущенным.",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Тип исключения"),
    "excludeUid": MessageLookupByLibrary.simpleMessage(
      "Исключённые ID пользователей",
    ),
    "excludeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик процессов исключённых ID пользователей идёт в обход TUN",
    ),
    "existsTip": m27,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйти из полноэкранного режима",
    ),
    "exitNodes": MessageLookupByLibrary.simpleMessage("Выходные узлы"),
    "expandList": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожидаемый статус"),
    "expireDate": m28,
    "expireTime": MessageLookupByLibrary.simpleMessage("Срок действия"),
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("Истекает"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт успешен"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер позволяет управлять ядром по заданному адресу",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя ссылка"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Очень крупный"),
    "fade": MessageLookupByLibrary.simpleMessage("Растворение"),
    "failedItem": m29,
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fake-IP"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Режим фильтра Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "В режиме фильтра Fake-IP blacklist исключает совпадения, whitelist применяется только к ним, rule — по правилам",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fake-IP"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Диапазон Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("Резервный"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Для резервного сервера обычно используют зарубежный DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Фильтр fallback"),
    "fallbackLazyQuery": MessageLookupByLibrary.simpleMessage(
      "Отложенный запрос к резервному серверу",
    ),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить записи о покупках",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить тарифы",
    ),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Прямая загрузка профиля"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл был изменен. Хотите сохранить изменения?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "filters": MessageLookupByLibrary.simpleMessage("Фильтры"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Поиск процесса"),
    "findProcessModeAutomaticDesc": MessageLookupByLibrary.simpleMessage(
      "Процесс определяется только при проверке правил процессов",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "При включении возможны небольшие потери производительности",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("Плавающая"),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "Плавающая навигация",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профиле"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Как в системе"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрифт"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Размер"),
    "forceDnsMapping": MessageLookupByLibrary.simpleMessage(
      "Принудительно для DNS-сопоставлений",
    ),
    "forceDnsMappingDesc": MessageLookupByLibrary.simpleMessage(
      "«Принудительно для DNS-сопоставлений» анализирует и соединения, домен которых получен из DNS-сопоставления",
    ),
    "forceDomain": MessageLookupByLibrary.simpleMessage(
      "Принудительные домены",
    ),
    "forceDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Принудительные домены тоже анализируются; остальные соединения с доменом не затрагиваются",
    ),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно перезапустить ядро?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "format": MessageLookupByLibrary.simpleMessage("Формат"),
    "fr": MessageLookupByLibrary.simpleMessage("Французский"),
    "general": MessageLookupByLibrary.simpleMessage("Общие"),
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
    "geoFileMissing": MessageLookupByLibrary.simpleMessage("Не загружено"),
    "geoFileReadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось прочитать файл ресурса",
    ),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "Введите корректный HTTP или HTTPS URL",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Настройки Geo"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage("Текущий адрес"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Ресурсы Geo"),
    "geoSkipped": m30,
    "geoUpdated": m31,
    "geoUpdating": m32,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo: экономия памяти",
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
    "goToConfigureAddedRules": MessageLookupByLibrary.simpleMessage(
      "Перейти к настройке добавленных правил",
    ),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Перейти к настройке скрипта",
    ),
    "googleLoginInvalidCallback": MessageLookupByLibrary.simpleMessage(
      "Не удалось подтвердить вход через Google. Повторите попытку.",
    ),
    "googleLoginTimedOut": MessageLookupByLibrary.simpleMessage(
      "Время ожидания входа через Google истекло. Повторите попытку.",
    ),
    "googleLoginUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть вход через Google. Повторите попытку.",
    ),
    "googleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Завершите вход через Google в браузере",
    ),
    "grid": MessageLookupByLibrary.simpleMessage("Сетка"),
    "groupCount": m33,
    "groupCountUnit": MessageLookupByLibrary.simpleMessage("групп"),
    "groupCycleError": m34,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "Фильтрует автоматически добавленные узлы и провайдеры. Участники, выбранные вручную, сохраняются.",
    ),
    "groupTimeoutCount": m35,
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
    "hashByInUser": MessageLookupByLibrary.simpleMessage(
      "Хешировать по пользователю входящего подключения",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Уже есть аккаунт?",
    ),
    "healthCheck": MessageLookupByLibrary.simpleMessage("Проверка состояния"),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Служба Helper недоступна, поэтому TUN-режим включить нельзя. Переустановите FlClash.",
    ),
    "hex": MessageLookupByLibrary.simpleMessage("Hex"),
    "hide": MessageLookupByLibrary.simpleMessage("Скрыть"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Скрыть из списка"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Скрыть IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Скрыть пароль"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Скрывать узлы с ошибкой проверки",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Сохранять выбранный узел и узлы с незавершённой проверкой",
    ),
    "hopInterval": MessageLookupByLibrary.simpleMessage("Интервал перескока"),
    "host": MessageLookupByLibrary.simpleMessage("Хост"),
    "hostname": MessageLookupByLibrary.simpleMessage("Имя хоста"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавить Hosts"),
    "hotkeyConflictWith": m36,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальные горячие клавиши работают, даже когда окно скрыто. Нажмите на действие, чтобы записать сочетание клавиш.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Управление горячими клавишами",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Использование клавиатуры для управления приложением",
    ),
    "hotkeyNeedsModifier": m37,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Не задано"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не удалось зарегистрировать сочетание",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Часов"),
    "hoursAgo": m38,
    "hoursAgoShort": m39,
    "hoursCount": m40,
    "hue": MessageLookupByLibrary.simpleMessage("Оттенок"),
    "iHavePaid": MessageLookupByLibrary.simpleMessage("Я оплатил"),
    "icon": MessageLookupByLibrary.simpleMessage("Иконка"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("Недавние значки"),
    "iconSets": MessageLookupByLibrary.simpleMessage("Наборы значков"),
    "iconSetsEmptyTip": MessageLookupByLibrary.simpleMessage(
      "Наборов значков пока нет. Добавьте их в разделе «Ресурсы пользовательских профилей → Наборы значков»",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль иконки"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("С подложкой"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Скрыто"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Без подложки"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL иконки"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Игнорировать оптимизацию батареи",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "importConfig": MessageLookupByLibrary.simpleMessage("Импорт конфигурации"),
    "importConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Собрать пользовательский профиль из прокси, групп, правил и настроек конфигурации",
    ),
    "importConfigInvalid": MessageLookupByLibrary.simpleMessage(
      "Это не конфигурация, которую можно импортировать",
    ),
    "importConfigReplaceTip": MessageLookupByLibrary.simpleMessage(
      "Импорт заменит текущие узлы, группы прокси, правила и настройки этого профиля",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage("Импорт из файла"),
    "importFromLink": MessageLookupByLibrary.simpleMessage("Импорт по ссылке"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Импорт из URL"),
    "importText": MessageLookupByLibrary.simpleMessage("Импорт из текста"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Импорт по URL"),
    "inbound": MessageLookupByLibrary.simpleMessage("Входящие"),
    "includeAll": MessageLookupByLibrary.simpleMessage(
      "Включить все прокси и провайдеры",
    ),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Включить все прокси",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Включить всех провайдеров прокси",
    ),
    "includeInterface": MessageLookupByLibrary.simpleMessage(
      "Включённые интерфейсы",
    ),
    "includeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Через TUN идёт только трафик с включённых интерфейсов, а исключённые интерфейсы больше не действуют",
    ),
    "includeUid": MessageLookupByLibrary.simpleMessage(
      "Включённые ID пользователей",
    ),
    "includeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Через TUN идёт только трафик процессов включённых ID пользователей",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage(
      "Долгосрочное действие",
    ),
    "init": MessageLookupByLibrary.simpleMessage("Инициализация"),
    "initFailed": MessageLookupByLibrary.simpleMessage("Не удалось запустить"),
    "initFailedTip": MessageLookupByLibrary.simpleMessage(
      "При запуске приложения произошла критическая ошибка, и работа не может быть продолжена.",
    ),
    "initiatorShort": MessageLookupByLibrary.simpleMessage("Источник"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Введите название группы прокси",
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
    "installedFonts": MessageLookupByLibrary.simpleMessage(
      "Установленные шрифты",
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
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Имя интерфейса задаёт сетевой интерфейс для исходящих соединений",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Исходящий интерфейс",
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
    "invalidCidrContent": MessageLookupByLibrary.simpleMessage(
      "Введите диапазон IP в формате CIDR, например 192.168.0.0/16",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Метка DSCP не может превышать 63",
    ),
    "invalidHostContent": MessageLookupByLibrary.simpleMessage(
      "Введите домен или IP-адрес",
    ),
    "invalidIpv6CidrContent": MessageLookupByLibrary.simpleMessage(
      "Введите диапазон IPv6 в формате CIDR, например fd00::/8",
    ),
    "invalidLinkTip": MessageLookupByLibrary.simpleMessage(
      "Это не ссылка на подписку и не ссылка на прокси",
    ),
    "invalidListenContent": MessageLookupByLibrary.simpleMessage(
      "Введите адрес и порт, например 0.0.0.0:1053",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только tcp и udp",
    ),
    "invalidPolicy": m41,
    "invalidPortRangeContent": MessageLookupByLibrary.simpleMessage(
      "Введите порт или диапазон, например 443 или 8000-9000",
    ),
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Этот QR-код не содержит ссылку на профиль",
    ),
    "invalidProxyProvider": m42,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Введите числа или диапазоны, например 80 или 8000-9000, через /",
    ),
    "invalidRuleSet": m43,
    "invalidSubRule": m44,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("Код приглашения"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Тип"),
    "ipVersion": MessageLookupByLibrary.simpleMessage("Версия IP"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Трафик IPv6 принимается, только когда IPv6 включён",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "При включённом IPv6 VPN принимает входящий IPv6",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут IPv6 (мс)"),
    "itemsCount": m45,
    "ja": MessageLookupByLibrary.simpleMessage("Японский"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIdle": MessageLookupByLibrary.simpleMessage(
      "Простой TCP keep-alive",
    ),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал TCP keep-alive",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "ko": MessageLookupByLibrary.simpleMessage("Корейский"),
    "label": MessageLookupByLibrary.simpleMessage("Метка"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "large": MessageLookupByLibrary.simpleMessage("Крупный"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Последнее обновление"),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "lazy": MessageLookupByLibrary.simpleMessage("Ленивая загрузка"),
    "light": MessageLookupByLibrary.simpleMessage("Светлый"),
    "lineIssueTip": m46,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Перенос строк"),
    "link": MessageLookupByLibrary.simpleMessage("Ссылка"),
    "linkDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль по ссылке на подписку или на прокси",
    ),
    "liquidGlass": MessageLookupByLibrary.simpleMessage("Жидкое стекло"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Прослушивание"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации действует только в Linux",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage(
      "Активные соединения",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "local": MessageLookupByLibrary.simpleMessage("Локальный"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на локальный диск",
    ),
    "localImage": MessageLookupByLibrary.simpleMessage("Локальное изображение"),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "Доступ к локальной сети не разрешён; для этого подключения используется gVisor. Прокси и сервисы в локальной сети могут оставаться недоступны",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage(
      "Перейти к выбранному узлу",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию",
    ),
    "locationPermissionGuide": m47,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение на геолокацию",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Журнал"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Уровень логов"),
    "logcat": MessageLookupByLibrary.simpleMessage("Захват логов"),
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
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Логи и диагностика",
    ),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Записи захвата логов"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест журналов"),
    "lookupProxyConfig": MessageLookupByLibrary.simpleMessage(
      "Найти конфигурацию узла",
    ),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Снятие ограничения loopback для UWP",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разблокировки Loopback UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "Может не подходить для сетей материкового Китая",
    ),
    "matchCase": MessageLookupByLibrary.simpleMessage("Учитывать регистр"),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Цель MATCH"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. количество неудач",
    ),
    "maxLengthTip": m48,
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
    "memoryInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Память приложения и ядра",
    ),
    "memoryReleased": MessageLookupByLibrary.simpleMessage(
      "Память освобождена",
    ),
    "memoryReleasedSize": m49,
    "messageTest": MessageLookupByLibrary.simpleMessage(
      "Тестирование сообщения",
    ),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это сообщение."),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage(
      "Минимальная конфигурация",
    ),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "Использовать сокращенный набор правил для меньшего профиля",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Сворачивать при выходе",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Изменить стандартное событие выхода из системы",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("минут"),
    "minutesAgo": m50,
    "minutesAgoShort": m51,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m52,
    "monthsAgoShort": m53,
    "more": MessageLookupByLibrary.simpleMessage("Ещё"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Купленные тарифы"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "nameCustomProfileTip": MessageLookupByLibrary.simpleMessage(
      "Назовите этот профиль",
    ),
    "nameserver": MessageLookupByLibrary.simpleMessage("Сервер имен"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Сервер имен разрешает домены",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика сервера имен",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Политика сервера имен задаёт сервер имен для подходящих доменов",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("Нижняя панель"),
    "network": MessageLookupByLibrary.simpleMessage("Сеть"),
    "networkAccessDeniedError": m54,
    "networkBadResponseError": m55,
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
    "networkName": MessageLookupByLibrary.simpleMessage("Имя сети"),
    "networkNotFoundError": m56,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Слишком много запросов (HTTP 429). Подождите немного и повторите попытку",
    ),
    "networkSecret": MessageLookupByLibrary.simpleMessage("Секрет сети"),
    "networkServerError": m57,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Скорость сети"),
    "networkTakeover": MessageLookupByLibrary.simpleMessage("Перехват трафика"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса истекло. Проверьте сеть или прокси и повторите попытку",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить защищённое соединение. Сертификат сервера может быть недействителен, или соединение перехватывается",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Тип сети"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "nextMatch": MessageLookupByLibrary.simpleMessage("Следующее совпадение"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage(
      "Буквы и цифры, до 12 символов",
    ),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("Никнейм"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "Введите никнейм",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "Нет доступных тарифов",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Нет данных"),
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
    "nodeFilterKept": m58,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("Линии"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage(
      "Имя содержит",
    ),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage(
      "Имя не содержит",
    ),
    "nodeFilterNodeExcluded": m59,
    "nodeFilterNodeKept": m60,
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
    "nodes": MessageLookupByLibrary.simpleMessage("Узлы"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "Этот внешний ресурс не является текстовым файлом",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notRunning": MessageLookupByLibrary.simpleMessage("Не запущено"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущая группа прокси не может быть выбрана.",
    ),
    "ntpDesc": MessageLookupByLibrary.simpleMessage(
      "Обновление настроек, связанных с NTP",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал синхронизации (минуты)",
    ),
    "ntpOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Добавленные здесь параметры заменяют настройки NTP всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "NTP берёт время с NTP-сервера, а не из системных часов",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Нет профиля, пожалуйста, добавьте профиль",
    ),
    "nullTip": m61,
    "numberRangeTip": m62,
    "numberTip": m63,
    "obfs": MessageLookupByLibrary.simpleMessage("Обфускация"),
    "obfsHost": MessageLookupByLibrary.simpleMessage("Хост обфускации"),
    "obfsMode": MessageLookupByLibrary.simpleMessage("Режим обфускации"),
    "obfsParam": MessageLookupByLibrary.simpleMessage("Параметр обфускации"),
    "obfsPassword": MessageLookupByLibrary.simpleMessage("Пароль обфускации"),
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onDemand": MessageLookupByLibrary.simpleMessage("По условию"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "«По условию» приостанавливает и возобновляет прокси в зависимости от Wi-Fi или сетевых условий",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Учитывать только трафик прокси",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "При включении будет учитываться только трафик прокси",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("Открыть панель"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("Открыть в браузере"),
    "openLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть ссылку. Убедитесь, что браузер установлен, и повторите попытку.",
    ),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Операция не выполнена",
    ),
    "operationSuccess": MessageLookupByLibrary.simpleMessage(
      "Операция выполнена успешно",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Необязательно"),
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "outbound": MessageLookupByLibrary.simpleMessage("Исходящие"),
    "outboundExit": MessageLookupByLibrary.simpleMessage("Выход"),
    "outboundMode": MessageLookupByLibrary.simpleMessage(
      "Режим исходящего трафика",
    ),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "Недоступно в этой конфигурации. Удалите или замените.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Личные настройки хранятся отдельно и применяются после обновлений. Новые группы блокируют соединения, если нет подходящих участников.",
    ),
    "overlayNameConflict": m64,
    "override": MessageLookupByLibrary.simpleMessage("Переопределить"),
    "overrideDestination": MessageLookupByLibrary.simpleMessage(
      "Подменять адрес назначения",
    ),
    "overrideDestinationDesc": MessageLookupByLibrary.simpleMessage(
      "«Подменять адрес назначения» подключается к обнаруженному домену вместо исходного адреса",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Переопределяемые параметры",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режим переопределения",
    ),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скрипт переопределения",
    ),
    "overwriteIssueDuplicateName": m65,
    "overwriteIssueEmptyFallback": m66,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Имя не задано",
    ),
    "overwriteIssueGroupLoop": m67,
    "overwriteIssueMissingProviders": m68,
    "overwriteIssueMissingProxies": m69,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "Не выбраны ни прокси, ни провайдеры прокси, поэтому ядро отклонит эту группу",
    ),
    "overwriteIssueReservedName": m70,
    "overwriteIssuesSummary": m71,
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
    "parsePureIp": MessageLookupByLibrary.simpleMessage("Разбирать чистые IP"),
    "parsePureIpDesc": MessageLookupByLibrary.simpleMessage(
      "«Разбирать чистые IP» анализирует соединения, у которых есть только IP-адрес",
    ),
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
    "paymentPending": MessageLookupByLibrary.simpleMessage(
      "Платёж ещё не получен. Повторите проверку чуть позже.",
    ),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось выполнить запрос оплаты",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage(
      "Оплата прошла успешно",
    ),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "Платёжный endpoint вернул неизвестный формат",
    ),
    "peers": MessageLookupByLibrary.simpleMessage("Пиры"),
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
    "planNumber": m72,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("Недоступно"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, привяжите WebDAV",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите пароль администратора",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, загрузите действительный QR-код",
    ),
    "plugin": MessageLookupByLibrary.simpleMessage("Плагин"),
    "pluginHost": MessageLookupByLibrary.simpleMessage("Хост плагина"),
    "pluginMode": MessageLookupByLibrary.simpleMessage("Режим плагина"),
    "points": MessageLookupByLibrary.simpleMessage("Баллы"),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введите другой порт",
    ),
    "portHopping": MessageLookupByLibrary.simpleMessage("Перескок портов"),
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "Если запущено другое прокси-приложение, сначала закройте его.",
    ),
    "portSuggestionTip": m73,
    "portTip": m74,
    "portUnavailableMessage": m75,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Порт недоступен",
    ),
    "portValue": m76,
    "ports": MessageLookupByLibrary.simpleMessage("Порты"),
    "preSharedKey": MessageLookupByLibrary.simpleMessage("Общий ключ"),
    "preferH3": MessageLookupByLibrary.simpleMessage("Предпочитать HTTP/3"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "«Предпочитать HTTP/3» сначала пробует HTTP/3 для серверов DoH",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage(
      "Предварительные условия",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, нажмите клавишу.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Предыдущее совпадение",
    ),
    "privateKey": MessageLookupByLibrary.simpleMessage("Закрытый ключ"),
    "privateKeyPassphrase": MessageLookupByLibrary.simpleMessage(
      "Пароль закрытого ключа",
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
    "profileDaysLeft": m77,
    "profileExpiresIn": m78,
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профиль был изменен. Хотите отключить автообновление?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите имя профиля",
    ),
    "profileOverrideSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только для этого профиля и имеет приоритет над переопределяемыми параметрами в настройках DNS и NTP приложения; не добавленные параметры следуют им",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "Ошибка разбора профиля",
    ),
    "profileProviderInUse": m79,
    "profileSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только для этого профиля; не добавленные параметры используют значения по умолчанию",
    ),
    "profileTunSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только для этого профиля и имеет приоритет над переопределяемыми параметрами TUN в настройках сети",
    ),
    "profileUpdatedAt": m80,
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный URL профиля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите URL профиля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профили"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортировка профилей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "protocol": MessageLookupByLibrary.simpleMessage("Протокол"),
    "protocolParam": MessageLookupByLibrary.simpleMessage("Параметр протокола"),
    "protocolVersion": MessageLookupByLibrary.simpleMessage("Версия протокола"),
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
    "providerInUse": m81,
    "providerLocal": MessageLookupByLibrary.simpleMessage("Локальный файл"),
    "providerLookupFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось прочитать активную конфигурацию узла. Обновите ресурс и повторите попытку.",
    ),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Введите непустое имя без запятых и переводов строк",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("Удалённый URL"),
    "providerRenameShadowed": m82,
    "providerSourceApp": MessageLookupByLibrary.simpleMessage(
      "Библиотека приложения",
    ),
    "providerSourceProfile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "providerSourceReference": m83,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage(
      "Подписка",
    ),
    "providerSourceUnavailable": m84,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Введите HTTP/HTTPS URL без встроенных учётных данных",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Провайдеры"),
    "proxies": MessageLookupByLibrary.simpleMessage("Прокси"),
    "proxiesCount": m85,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Доступные узлы",
    ),
    "proxyChainConflictTip": m86,
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
    "proxyChainUnavailableNodeTip": m87,
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
    "proxyConflictSystemProxy": m88,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "Возможен конфликт прокси",
    ),
    "proxyConflictVpn": m89,
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
    "proxyGroupsAfterStart": MessageLookupByLibrary.simpleMessage(
      "Группы появятся здесь после запуска ядра",
    ),
    "proxyGroupsCount": m90,
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "Прокси-сервер имен",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Прокси-сервер имен разрешает домены прокси-узлов",
    ),
    "proxyNameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика прокси-сервера имен",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Прокси-узел"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("Порт прокси"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "proxyType": MessageLookupByLibrary.simpleMessage("Тип прокси"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Очистить кэш"),
    "publicKey": MessageLookupByLibrary.simpleMessage("Открытый ключ"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Автопродление",
    ),
    "purchaseDays": m91,
    "purchaseHours": m92,
    "purchaseMinutes": m93,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage("Цена покупки"),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Выкл."),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("Вкл."),
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Общий трафик",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Время покупки"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("Чисто чёрный"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто черный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код для получения профиля",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Быстрые действия"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Быстрое добавление"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Быстрое редактирование"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rawOutboundInUse": m94,
    "readFullAnnouncement": MessageLookupByLibrary.simpleMessage(
      "Читать полностью",
    ),
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Адрес получателя",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Пополнить"),
    "rechargeAllowedRange": m95,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Сумма пополнения (¥)",
    ),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "Сумма выходит за пределы диапазона этого способа оплаты",
    ),
    "recommendedIcons": MessageLookupByLibrary.simpleMessage("Рекомендуемые"),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "Скидка сохранится при автопродлении",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Порт Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "После оплаты потяните вниз, чтобы обновить и проверить результат",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("Возврат"),
    "regex": MessageLookupByLibrary.simpleMessage("Регулярное выражение"),
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
    "remaining": m96,
    "remainingStock": m97,
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
    "remoteDnsResolve": MessageLookupByLibrary.simpleMessage(
      "Удалённое разрешение DNS",
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
    "required": MessageLookupByLibrary.simpleMessage("Обязательно"),
    "resendCodeIn": m98,
    "reset": MessageLookupByLibrary.simpleMessage("Сброс"),
    "resetDns": MessageLookupByLibrary.simpleMessage("Сбросить DNS"),
    "resetDnsFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось сбросить DNS. Проверьте подключение к ядру и повторите попытку.",
    ),
    "resetDnsSuccess": MessageLookupByLibrary.simpleMessage(
      "Состояние DNS очищено",
    ),
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
    "resourceSizeLimitTip": m99,
    "resources": MessageLookupByLibrary.simpleMessage("Ресурсы"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Информация, связанная с внешними ресурсами",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдать правила"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "«Соблюдать правила» направляет DNS-соединения по правилам; нужен прокси-сервер имен",
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
    "result": MessageLookupByLibrary.simpleMessage("Результат"),
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
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адреса маршрутов"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка адреса прослушивания маршрутизации",
    ),
    "routeExcludeAddress": MessageLookupByLibrary.simpleMessage(
      "Исключённые адреса маршрутов",
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
    "routingMark": MessageLookupByLibrary.simpleMessage("Метка маршрутизации"),
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
    "ruleListInvalid": MessageLookupByLibrary.simpleMessage(
      "Правила должны быть YAML-списком, по одному правилу в элементе, например - DOMAIN,example.com,DIRECT",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent напрямую",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Блокировать DNS over TLS",
    ),
    "rulePresetBlockLoopback": MessageLookupByLibrary.simpleMessage(
      "Защита от петли прокси",
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
    "ruleSetBusyTip": MessageLookupByLibrary.simpleMessage(
      "Выполняется другая операция с набором правил. Повторите попытку позже",
    ),
    "ruleSetConvert": MessageLookupByLibrary.simpleMessage(
      "Преобразовать в MRS",
    ),
    "ruleSetConvertRemote": MessageLookupByLibrary.simpleMessage(
      "Скачать как локальный MRS",
    ),
    "ruleSetDetect": MessageLookupByLibrary.simpleMessage(
      "Определить формат и тип правил",
    ),
    "ruleSetEmptyTip": MessageLookupByLibrary.simpleMessage(
      "В наборе правил нет пригодных записей",
    ),
    "ruleSetInvalidTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось прочитать набор правил. Проверьте формат и записи",
    ),
    "ruleSetMixedTip": MessageLookupByLibrary.simpleMessage(
      "В наборе смешаны домены и диапазоны IP. Для их объединения используйте правила classical",
    ),
    "ruleSetNeedsConversionTip": MessageLookupByLibrary.simpleMessage(
      "Этот удалённый набор правил требует нормализации. Скачайте его как локальный MRS",
    ),
    "ruleSetSizeTip": MessageLookupByLibrary.simpleMessage(
      "Набор правил превышает лимит обработки. Разделите его на меньшие наборы",
    ),
    "ruleSetUnsupportedTip": MessageLookupByLibrary.simpleMessage(
      "Эти правила нельзя преобразовать в MRS без изменения их поведения",
    ),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "rulesCount": m100,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Личные правила действуют в режиме правил.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("Время работы"),
    "running": MessageLookupByLibrary.simpleMessage("Работает"),
    "runtimeConfig": MessageLookupByLibrary.simpleMessage(
      "Конфигурация выполнения",
    ),
    "safeMode": MessageLookupByLibrary.simpleMessage("Безопасный режим"),
    "safeModeAppTitle": m101,
    "saturation": MessageLookupByLibrary.simpleMessage("Насыщенность"),
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
    "scriptChanged": MessageLookupByLibrary.simpleMessage(
      "Скрипт изменён или удалён. Откройте его заново и повторите попытку.",
    ),
    "scriptChanges": MessageLookupByLibrary.simpleMessage("Изменения скрипта"),
    "scriptChangesAdded": m102,
    "scriptChangesDescription": MessageLookupByLibrary.simpleMessage(
      "Поля верхнего уровня, добавленные, изменённые или удалённые скриптом. Полная конфигурация также включает настройки приложения.",
    ),
    "scriptChangesEmpty": MessageLookupByLibrary.simpleMessage(
      "Скрипт не изменил конфигурацию",
    ),
    "scriptChangesModified": m103,
    "scriptChangesRemoved": m104,
    "scriptFullConfig": MessageLookupByLibrary.simpleMessage(
      "Вся конфигурация",
    ),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Режим скрипта, использование внешних расширяющих скриптов, предоставление возможности переопределения конфигурации одним кликом",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("Параметры скрипта"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "В этом скрипте нет настраиваемых переключателей",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seconds": MessageLookupByLibrary.simpleMessage("Секунд"),
    "secondsCount": m105,
    "secretKey": MessageLookupByLibrary.simpleMessage("Ключ"),
    "sectionsInEffect": m106,
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
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Проверка сервиса не удалась",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage("Ошибка проверки"),
    "settingEntries": MessageLookupByLibrary.simpleMessage("параметры"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "settingsCount": m107,
    "shareLinkNodesAdded": m108,
    "shareLinksNotRead": m109,
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "showLess": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "showMore": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка остановки в уведомлении",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Показать пароль"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Размытие боковой панели",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать полупрозрачный системный фон боковой панели",
    ),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Войти через Google",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тихий запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в фоновом режиме",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("По одному"),
    "singleValueTip": m110,
    "size": MessageLookupByLibrary.simpleMessage("Размер"),
    "skipCertVerify": MessageLookupByLibrary.simpleMessage(
      "Пропускать проверку сертификата",
    ),
    "skipDomain": MessageLookupByLibrary.simpleMessage("Пропускаемые домены"),
    "skipDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Обнаруженный домен из пропускаемых доменов не используется",
    ),
    "skipDstAddress": MessageLookupByLibrary.simpleMessage(
      "Пропускаемые адреса назначения",
    ),
    "skipSrcAddress": MessageLookupByLibrary.simpleMessage(
      "Пропускаемые адреса источника",
    ),
    "slide": MessageLookupByLibrary.simpleMessage("Сдвиг"),
    "sliders": MessageLookupByLibrary.simpleMessage("Ползунки"),
    "sniffProtocols": MessageLookupByLibrary.simpleMessage("Протоколы"),
    "sniffer": MessageLookupByLibrary.simpleMessage("Сниффер"),
    "snifferStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Сниффер определяет домен по трафику TLS, HTTP и QUIC, чтобы правила могли его сопоставить",
    ),
    "socksPort": MessageLookupByLibrary.simpleMessage("Порт SOCKS"),
    "softStyle": MessageLookupByLibrary.simpleMessage("Мягкий"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Распродано"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "source": MessageLookupByLibrary.simpleMessage("Источник"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Исходный IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Специальный прокси"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Специальные правила"),
    "spectrum": MessageLookupByLibrary.simpleMessage("Спектр"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Статистика скорости",
    ),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к геолокации для чтения имён Wi-Fi. На Android разрешите точное местоположение всегда и включите геолокацию.",
    ),
    "ssidPermissionMacosGuide": MessageLookupByLibrary.simpleMessage(
      "Для чтения имён Wi-Fi разрешите этому приложению использовать службы геолокации в системных настройках.",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("Список SSID пуст"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режим стека"),
    "stackTrace": MessageLookupByLibrary.simpleMessage("Трассировка стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Стандартный режим, переопределение базовой конфигурации, предоставление возможности простого добавления правил",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Старт"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно импортирован. Хотите запустить ядро сейчас?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage("Подсказка"),
    "startFromScratch": MessageLookupByLibrary.simpleMessage("С нуля"),
    "startSuccess": MessageLookupByLibrary.simpleMessage("Запущено успешно"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запуск VPN..."),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Запуск и фоновая работа",
    ),
    "startupDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Диагностика запуска",
    ),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "Предыдущий запуск не завершился. Автоматическое применение конфигурации и запуск VPN приостановлены на этот раз. Выбранный профиль и настройки сохранены. Проверьте конфигурацию и нажмите «Запустить»; уже работающий VPN останется подключённым.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Восстановление запуска",
    ),
    "startupTimeoutTip": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запуска истекло. Закройте и снова откройте приложение. Если проблема повторится, скопируйте диагностические сведения ниже.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "При отключённом DNS используется системный DNS",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Стоп"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Остановка VPN..."),
    "store": MessageLookupByLibrary.simpleMessage("Магазин"),
    "storeOutcomeUnknown": MessageLookupByLibrary.simpleMessage(
      "Запрос мог быть обработан. Прежде чем повторять, проверьте «Купленные тарифы».",
    ),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Покупка, продление и улучшение тарифов",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "strictRoute": MessageLookupByLibrary.simpleMessage(
      "Строгая маршрутизация",
    ),
    "strictRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Строгая маршрутизация не даёт трафику вроде DNS обходить TUN, а при выключенном IPv6 блокирует IPv6-соединения этого устройства",
    ),
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
      "«Приостанавливать прокси при бездействии» останавливает передачу трафика и проверки узлов, когда экран выключен и система бездействует; звонки и прямые аудиотрансляции могут прерываться, а push-уведомления — задерживаться",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("Приостановлено…"),
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
    "tailscaleCheckSettings": m111,
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
    "tailscaleDevices": m112,
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
    "tailscaleNetworkInUse": m113,
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
    "tailscaleRelay": m114,
    "tailscaleRemoveConfirm": m115,
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
    "tapIconToRetry": MessageLookupByLibrary.simpleMessage(
      "Нажмите на значок, чтобы повторить",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы разрешить",
    ),
    "target": MessageLookupByLibrary.simpleMessage("Цель"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("Параллельный TCP"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Включение позволит использовать параллелизм TCP",
    ),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "Включите эту опцию для ускорения установки TCP-соединения",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал тестирования",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("URL для теста"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage(
      "Тестировать при использовании",
    ),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштабирование текста"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Так будет выглядеть текст в приложении",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Цвет темы"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Установить темный режим, настроить цвет",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим темы"),
    "tight": MessageLookupByLibrary.simpleMessage("Плотный"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "timeout": MessageLookupByLibrary.simpleMessage("Таймаут"),
    "tintedStyle": MessageLookupByLibrary.simpleMessage("Тонированный"),
    "tip": MessageLookupByLibrary.simpleMessage("подсказка"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Использовано сегодня"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage(
      "Переключить фонарик",
    ),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Access Token"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите токен доступа",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Допуск"),
    "tools": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "total": MessageLookupByLibrary.simpleMessage("Всего"),
    "totalDownload": MessageLookupByLibrary.simpleMessage("Скачано"),
    "totalUpload": MessageLookupByLibrary.simpleMessage("Загружено"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Порт TProxy"),
    "traffic": MessageLookupByLibrary.simpleMessage("Трафик"),
    "trafficPeak": m116,
    "trafficTotal": m117,
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Использование трафика",
    ),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "После завершения перевода система подтвердит автоматически, и выбранный тариф будет активирован.",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("Транспорт"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAdminAccountRequired": MessageLookupByLibrary.simpleMessage(
      "Для TUN нужна учётная запись администратора этого Mac. Войдите как администратор и включите TUN.",
    ),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось включить TUN: запрос прав администратора отклонён. Разрешите системный запрос прав и повторите попытку.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "TUN работает только в режиме администратора",
    ),
    "tunHelperInstallFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось включить TUN: ошибка установки или запуска Helper. Проверьте целостность установки приложения и состояние системной службы, затем повторите попытку.",
    ),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "По умолчанию 9000; можно попробовать 1480 или 4064. Перезапустите Android VPN",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "Введите целое число от 1280 до 65535",
    ),
    "tunOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Добавленные здесь параметры заменяют настройки TUN всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Выключить"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Включить"),
    "udpRelayMode": MessageLookupByLibrary.simpleMessage(
      "Режим ретрансляции UDP",
    ),
    "udpTimeout": MessageLookupByLibrary.simpleMessage("Тайм-аут UDP"),
    "udpTimeoutDesc": MessageLookupByLibrary.simpleMessage(
      "Тайм-аут UDP задаётся в секундах и действует только со стеками gvisor, system и mixed",
    ),
    "ultra": MessageLookupByLibrary.simpleMessage("Максимум"),
    "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Единая задержка"),
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
    "updateApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Автоматическое обновление не завершено. Повторите попытку или обновите приложение со страницы загрузки.",
    ),
    "updateBuildNumber": m118,
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
    "updateRestart": MessageLookupByLibrary.simpleMessage(
      "Обновить и перезапустить",
    ),
    "updateRestartHint": MessageLookupByLibrary.simpleMessage(
      "Приложение закроется, обновится и откроется снова. Ваши настройки сохранятся.",
    ),
    "updateVersionNumber": m119,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Улучшить тариф"),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "uploadBandwidth": MessageLookupByLibrary.simpleMessage("Скорость отдачи"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль через URL",
    ),
    "urlTip": m120,
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системный hosts",
    ),
    "usedShort": MessageLookupByLibrary.simpleMessage("использовано"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Использованный трафик",
    ),
    "userCenter": MessageLookupByLibrary.simpleMessage("Центр пользователя"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "Центр пользователя (резервный)",
    ),
    "userGuide": MessageLookupByLibrary.simpleMessage(
      "Руководство пользователя",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("Проверить"),
    "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
    "virtualIpv4": MessageLookupByLibrary.simpleMessage("Виртуальный IPv4"),
    "vividStyle": MessageLookupByLibrary.simpleMessage("Яркий"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Обнаружено изменение конфигурации VPN",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VPN автоматически направляет весь системный трафик через VpnService",
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
      "«Записывать в систему» также устанавливает системные часы; Android это игнорирует",
    ),
    "yearsAgo": m121,
    "yearsAgoShort": m122,
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Упрощенный китайский"),
  };
}
