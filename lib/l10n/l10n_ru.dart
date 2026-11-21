// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get applyNow => 'Применить сейчас';

  @override
  String get rule => 'Правило';

  @override
  String get global => 'Глобальный';

  @override
  String get direct => 'Прямой';

  @override
  String get dashboard => 'Панель управления';

  @override
  String get proxies => 'Прокси';

  @override
  String get profile => 'Профиль';

  @override
  String get profiles => 'Профили';

  @override
  String get tools => 'Инструменты';

  @override
  String get logs => 'Логи';

  @override
  String get logsDesc => 'Записи захвата логов';

  @override
  String get resources => 'Ресурсы';

  @override
  String get resourcesDesc => 'Информация, связанная с внешними ресурсами';

  @override
  String get trafficUsage => 'Использование трафика';

  @override
  String get networkSpeed => 'Скорость сети';

  @override
  String get outboundMode => 'Режим исходящего трафика';

  @override
  String get networkDetection => 'Обнаружение сети';

  @override
  String get upload => 'Загрузка';

  @override
  String get download => 'Скачивание';

  @override
  String get noProxy => 'Нет прокси';

  @override
  String get nullProfileDesc => 'Нет профиля, пожалуйста, добавьте профиль';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get defaultText => 'По умолчанию';

  @override
  String get more => 'Ещё';

  @override
  String get other => 'Другое';

  @override
  String get about => 'О программе';

  @override
  String get en => 'Английский';

  @override
  String get ja => 'Японский';

  @override
  String get ru => 'Русский';

  @override
  String get fr => 'Французский';

  @override
  String get es => 'Испанский';

  @override
  String get ko => 'Корейский';

  @override
  String get zh_CN => 'Упрощенный китайский';

  @override
  String get theme => 'Тема';

  @override
  String get themeDesc => 'Установить темный режим, настроить цвет';

  @override
  String get overrideLabel => 'Переопределить';

  @override
  String get allowLan => 'Разрешить LAN';

  @override
  String get tun => 'TUN';

  @override
  String get tunDesc => 'TUN работает только в режиме администратора';

  @override
  String get minimizeOnExit => 'Сворачивать при выходе';

  @override
  String get autoLaunch => 'Автозапуск';

  @override
  String get silentLaunch => 'Тихий запуск';

  @override
  String get silentLaunchDesc => 'Запуск в фоновом режиме';

  @override
  String get autoRun => 'Автовключение';

  @override
  String get autoRunDesc => 'Автоматический запуск при открытии приложения';

  @override
  String get logcat => 'Захват логов';

  @override
  String get logcatDesc => 'Отключение скроет запись логов';

  @override
  String get accessControl => 'Контроль доступа';

  @override
  String get accessControlDesc => 'Настройка доступа приложений к прокси';

  @override
  String get application => 'Приложение';

  @override
  String get edit => 'Редактировать';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get update => 'Обновить';

  @override
  String get add => 'Добавить';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get hours => 'Часов';

  @override
  String get seconds => 'Секунд';

  @override
  String get qrcode => 'QR-код';

  @override
  String get qrcodeDesc => 'Сканируйте QR-код для получения профиля';

  @override
  String get url => 'URL';

  @override
  String get file => 'Файл';

  @override
  String get name => 'Имя';

  @override
  String get profileNameNullValidationDesc => 'Пожалуйста, введите имя профиля';

  @override
  String get profileUrlNullValidationDesc => 'Пожалуйста, введите URL профиля';

  @override
  String get profileUrlInvalidValidationDesc =>
      'Пожалуйста, введите действительный URL профиля';

  @override
  String get autoUpdate => 'Автообновление';

  @override
  String get autoUpdateInterval => 'Интервал автообновления';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc =>
      'Пожалуйста, введите интервал времени для автообновления';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc =>
      'Пожалуйста, введите действительный формат интервала времени';

  @override
  String get themeMode => 'Режим темы';

  @override
  String get themeColor => 'Цвет темы';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get auto => 'Авто';

  @override
  String get light => 'Светлый';

  @override
  String get dark => 'Темный';

  @override
  String get submit => 'Отправить';

  @override
  String createProfileFromUrlTip(Object url) {
    return 'Создать профиль по ссылке $url?';
  }

  @override
  String get create => 'Создать';

  @override
  String get pleaseUploadValidQrcode =>
      'Пожалуйста, загрузите действительный QR-код';

  @override
  String get blacklistMode => 'Режим черного списка';

  @override
  String get whitelistMode => 'Режим белого списка';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get cancelSelectAll => 'Отменить выбор всего';

  @override
  String get appAccessControl => 'Контроль доступа приложений';

  @override
  String get accessControlAllowDesc =>
      'Через VPN проходят только выбранные приложения';

  @override
  String get accessControlNotAllowDesc =>
      'Выбранные приложения исключаются из VPN';

  @override
  String get accessControlDisabledDesc =>
      'Контроль доступа приложений отключён';

  @override
  String accessControlSelectedCount(num count) {
    return 'Выбрано: $count';
  }

  @override
  String get profileParseErrorDesc => 'Ошибка разбора профиля';

  @override
  String get proxyPort => 'Порт прокси';

  @override
  String get port => 'Порт';

  @override
  String get logLevel => 'Уровень логов';

  @override
  String get show => 'Показать';

  @override
  String get hide => 'Скрыть';

  @override
  String get exit => 'Выход';

  @override
  String get systemProxy => 'Системный прокси';

  @override
  String get custom => 'Пользовательский';

  @override
  String get project => 'Проект';

  @override
  String get core => 'Ядро';

  @override
  String get reverseEngineeringNotice =>
      'Обратная разработка, декомпиляция, дизассемблирование или анализ этого приложения с помощью ИИ строго запрещены.';

  @override
  String get tabAnimation => 'Анимация вкладок';

  @override
  String get desc =>
      'Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.';

  @override
  String get startVpn => 'Запуск VPN...';

  @override
  String get stopVpn => 'Остановка VPN...';

  @override
  String get discovery => 'Обнаружена новая версия';

  @override
  String get compatible => 'Режим совместимости';

  @override
  String get notSelectedTip => 'Текущая группа прокси не может быть выбрана.';

  @override
  String get tip => 'подсказка';

  @override
  String get account => 'Аккаунт';

  @override
  String get backup => 'Резервное копирование';

  @override
  String get backupSuccess => 'Резервное копирование успешно';

  @override
  String get noInfo => 'Нет информации';

  @override
  String get pleaseBindWebDAV => 'Пожалуйста, привяжите WebDAV';

  @override
  String get bind => 'Привязать';

  @override
  String get connectivity => 'Связь：';

  @override
  String get webDAVConfiguration => 'Конфигурация WebDAV';

  @override
  String get address => 'Адрес';

  @override
  String get addressHelp => 'Адрес сервера WebDAV';

  @override
  String get addressTip => 'Пожалуйста, введите действительный адрес WebDAV';

  @override
  String get password => 'Пароль';

  @override
  String get checkUpdate => 'Проверить обновления';

  @override
  String get checkUpdateError =>
      'Текущее приложение уже является последней версией';

  @override
  String get checkUpdateFailed =>
      'Не удалось проверить обновления. Проверьте сеть и повторите попытку';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get search => 'Поиск';

  @override
  String get allowBypass => 'Разрешить приложениям обходить VPN';

  @override
  String get externalController => 'Внешний контроллер';

  @override
  String get externalControllerDesc =>
      'Внешний контроллер позволяет управлять ядром по заданному адресу';

  @override
  String get openDashboard => 'Открыть панель';

  @override
  String get ipv6Desc => 'Трафик IPv6 принимается, только когда IPv6 включён';

  @override
  String get autoIpv6 => 'Авто IPv6';

  @override
  String get autoIpv6Desc =>
      '«Авто IPv6» включает и выключает IPv6 в зависимости от поддержки локальной сетью';

  @override
  String get app => 'Приложение';

  @override
  String get unifiedDelay => 'Единая задержка';

  @override
  String get tcpConcurrent => 'Параллельный TCP';

  @override
  String get geodataLoader => 'Geo: экономия памяти';

  @override
  String get requests => 'Запросы';

  @override
  String get requestsDesc => 'Просмотр недавних запросов и активных соединений';

  @override
  String get findProcessMode => 'Поиск процесса';

  @override
  String get init => 'Инициализация';

  @override
  String get infiniteTime => 'Долгосрочное действие';

  @override
  String get connections => 'Соединения';

  @override
  String get intranetIP => 'Внутренний IP';

  @override
  String get view => 'Просмотр';

  @override
  String get cut => 'Вырезать';

  @override
  String get copy => 'Копировать';

  @override
  String get paste => 'Вставить';

  @override
  String get userAgent => 'User-Agent';

  @override
  String get testUrl => 'URL для теста';

  @override
  String get delayTestTimeout => 'Тайм-аут теста задержки';

  @override
  String get sync => 'Синхронизация';

  @override
  String get exclude => 'Скрыть из недавних задач';

  @override
  String get compact => 'Компактный';

  @override
  String get filter => 'Фильтр';

  @override
  String get tab => 'Вкладка';

  @override
  String get list => 'Список';

  @override
  String get delay => 'Задержка';

  @override
  String get style => 'Стиль';

  @override
  String get size => 'Размер';

  @override
  String get sort => 'Сортировка';

  @override
  String get columns => 'Столбцы';

  @override
  String get proxyGroup => 'Группа прокси';

  @override
  String get go => 'Перейти';

  @override
  String get externalLink => 'Внешняя ссылка';

  @override
  String get autoCloseConnections => 'Автозакрытие соединений';

  @override
  String get autoCloseConnectionsDesc =>
      'После смены узла закрывать все соединения или только проходящие через изменённую группу прокси, включая вложенные группы';

  @override
  String get connectionCloseScope => 'Область закрытия соединений';

  @override
  String get closeCurrentGroupConnections => 'Только текущая группа прокси';

  @override
  String get onlyStatisticsProxy => 'Учитывать только трафик прокси';

  @override
  String get pureBlackMode => 'Чисто черный режим';

  @override
  String get keepAliveIntervalDesc => 'Интервал TCP keep-alive';

  @override
  String get entries => ' записей';

  @override
  String secondsCount(Object count) {
    return '$count секунд';
  }

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count элемента',
      many: '$count элементов',
      few: '$count элемента',
      one: '$count элемент',
    );
    return '$_temp0';
  }

  @override
  String get geoAutoUpdate => 'Автообновление';

  @override
  String get geoAutoUpdateInterval => 'Интервал автообновления';

  @override
  String get geoAutoUpdateIntervalTip =>
      'Интервал автообновления должен быть от 1 до 8760 часов';

  @override
  String get geoResources => 'Ресурсы Geo';

  @override
  String geoUpdating(Object name) {
    return 'Обновление $name...';
  }

  @override
  String geoSkipped(Object name) {
    return '$name пропущено';
  }

  @override
  String geoUpdated(Object name) {
    return '$name обновлено';
  }

  @override
  String get local => 'Локальный';

  @override
  String get remote => 'Удаленный';

  @override
  String get remoteBackupDesc =>
      'Резервное копирование локальных данных на WebDAV';

  @override
  String get localBackupDesc =>
      'Резервное копирование локальных данных на локальный диск';

  @override
  String get mode => 'Режим';

  @override
  String get time => 'Время';

  @override
  String get source => 'Источник';

  @override
  String get action => 'Действие';

  @override
  String get intelligentSelected => 'Интеллектуальный выбор';

  @override
  String get clipboardNoPackageNames =>
      'В буфере обмена нет допустимых имён пакетов';

  @override
  String get clipboardImport => 'Импорт из буфера обмена';

  @override
  String get clipboardExport => 'Экспорт в буфер обмена';

  @override
  String get layout => 'Макет';

  @override
  String get tight => 'Плотный';

  @override
  String get standard => 'Стандартный';

  @override
  String get loose => 'Свободный';

  @override
  String get profilesSort => 'Сортировка профилей';

  @override
  String get start => 'Старт';

  @override
  String get stop => 'Стоп';

  @override
  String get key => 'Ключ';

  @override
  String get value => 'Значение';

  @override
  String get vpnTip => 'Изменения вступят в силу после перезапуска VPN';

  @override
  String get vpnEnableDesc =>
      'VPN автоматически направляет весь системный трафик через VpnService';

  @override
  String get options => 'Опции';

  @override
  String get loopback => 'Снятие ограничения loopback для UWP';

  @override
  String get providers => 'Провайдеры';

  @override
  String get proxyProviders => 'Провайдеры прокси';

  @override
  String get ruleProviders => 'Провайдеры правил';

  @override
  String get status => 'Статус';

  @override
  String get statusDesc => 'При отключённом DNS используется системный DNS';

  @override
  String get preferH3Desc =>
      '«Предпочитать HTTP/3» сначала пробует HTTP/3 для серверов DoH';

  @override
  String get respectRules => 'Соблюдать правила';

  @override
  String get respectRulesDesc =>
      '«Соблюдать правила» направляет DNS-соединения по правилам; нужен прокси-сервер имен';

  @override
  String get dnsMode => 'Режим DNS';

  @override
  String get fakeipRange => 'Диапазон Fake-IP';

  @override
  String get fakeipFilter => 'Фильтр Fake-IP';

  @override
  String get defaultNameserver => 'Сервер имен по умолчанию';

  @override
  String get defaultNameserverDesc =>
      'Разрешает имена других DNS-серверов. Только IP-адреса.';

  @override
  String get nameserver => 'Сервер имен';

  @override
  String get nameserverDesc =>
      'DNS-серверы по умолчанию, например 223.5.5.5, tls://1.1.1.1 или https://dns.google/dns-query.';

  @override
  String get useHosts => 'Использовать hosts';

  @override
  String get useSystemHosts => 'Использовать системный hosts';

  @override
  String get nameserverPolicy => 'Политика сервера имен';

  @override
  String get nameserverPolicyDesc =>
      'Совпавшие домены используют указанный здесь DNS-сервер вместо Nameserver и Fallback.';

  @override
  String get proxyNameserver => 'Прокси-сервер имен';

  @override
  String get fallback => 'Резервный';

  @override
  String get fallbackDesc =>
      'Используются вместо Nameserver, когда фильтр fallback считает его ответ подменённым.';

  @override
  String get preferH3 => 'Предпочитать HTTP/3';

  @override
  String get fallbackLazyQuery => 'Отложенный запрос к резервному серверу';

  @override
  String get proxyNameserverPolicy => 'Политика прокси-сервера имен';

  @override
  String get directNameserver => 'Сервер имен для прямых соединений';

  @override
  String get directNameserverFollowPolicy =>
      'Сервер имен для прямых соединений следует политике';

  @override
  String get fallbackFilter => 'Фильтр fallback';

  @override
  String get geoipCode => 'Код Geoip';

  @override
  String get ipcidr => 'IPCIDR';

  @override
  String get domain => 'Домен';

  @override
  String get reset => 'Сброс';

  @override
  String get action_view => 'Показать/Скрыть';

  @override
  String get action_start => 'Старт/Стоп';

  @override
  String get action_mode => 'Переключить режим';

  @override
  String get action_proxy => 'Системный прокси';

  @override
  String get action_tun => 'TUN';

  @override
  String get hotkeyManagement => 'Управление горячими клавишами';

  @override
  String get hotkeyManagementDesc =>
      'Использование клавиатуры для управления приложением';

  @override
  String get pressKeyboard => 'Пожалуйста, нажмите клавишу.';

  @override
  String get remove => 'Удалить';

  @override
  String get noNetwork => 'Нет сети';

  @override
  String get ipv6InboundDesc =>
      'При включённом IPv6 VPN принимает входящий IPv6';

  @override
  String get exportLogs => 'Экспорт логов';

  @override
  String get exportSuccess => 'Экспорт успешен';

  @override
  String get iconStyle => 'Стиль иконки';

  @override
  String get iconStyleFilled => 'С подложкой';

  @override
  String get iconStylePlain => 'Без подложки';

  @override
  String get iconStyleHidden => 'Скрыто';

  @override
  String get stackMode => 'Режим стека';

  @override
  String get network => 'Сеть';

  @override
  String get bypassDomain => 'Исключённые домены';

  @override
  String get bypassDomainDesc =>
      'Исключённые домены действуют только при включённом системном прокси';

  @override
  String get resetTip => 'Убедитесь, что хотите сбросить';

  @override
  String get icon => 'Иконка';

  @override
  String get noData => 'Нет данных';

  @override
  String get fontFamily => 'Шрифт';

  @override
  String get installedFonts => 'Установленные шрифты';

  @override
  String get toggle => 'Переключить';

  @override
  String get system => 'Система';

  @override
  String get bypassPrivateRoute => 'Обходить частные адреса';

  @override
  String get bypassPrivateRouteDesc =>
      'При обходе частных адресов адреса LAN, loopback и multicast идут в обход TUN';

  @override
  String get routeAddress => 'Адреса маршрутов';

  @override
  String get pleaseInputAdminPassword =>
      'Пожалуйста, введите пароль администратора';

  @override
  String get tunAuthorizationFailed =>
      'Не удалось включить TUN: запрос прав администратора отклонён. Разрешите системный запрос прав и повторите попытку.';

  @override
  String get tunHelperInstallFailed =>
      'Не удалось включить TUN: ошибка установки или запуска Helper. Проверьте целостность установки приложения и состояние системной службы, затем повторите попытку.';

  @override
  String get tunAdminAccountRequired =>
      'Для TUN нужна учётная запись администратора этого Mac. Войдите как администратор и включите TUN.';

  @override
  String get copyEnvVar => 'Копирование переменных окружения';

  @override
  String get memoryInfo => 'Информация о памяти';

  @override
  String get dialog => 'Диалог';

  @override
  String get cancel => 'Отмена';

  @override
  String get fileIsUpdate => 'Файл был изменен. Хотите сохранить изменения?';

  @override
  String get profileHasUpdate =>
      'Профиль был изменен. Хотите отключить автообновление?';

  @override
  String get copySuccess => 'Копирование успешно';

  @override
  String get copyLink => 'Копировать ссылку';

  @override
  String get exportFile => 'Экспорт файла';

  @override
  String get cacheCorrupt => 'Кэш поврежден. Хотите очистить его?';

  @override
  String get listen => 'Прослушивание';

  @override
  String get undo => 'Отменить';

  @override
  String get redo => 'Повторить';

  @override
  String get none => 'Нет';

  @override
  String get required => 'Обязательно';

  @override
  String get advancedConfig => 'Расширенная конфигурация';

  @override
  String get advancedConfigDesc =>
      'Предоставляет разнообразные варианты конфигурации';

  @override
  String get addRule => 'Добавить правило';

  @override
  String get ruleName => 'Название правила';

  @override
  String get content => 'Содержание';

  @override
  String get subRule => 'Подправило';

  @override
  String get ruleTarget => 'Цель правила';

  @override
  String get sourceIp => 'Исходный IP';

  @override
  String get noResolve => 'Не разрешать IP';

  @override
  String get saveChanges => 'Сохранить изменения?';

  @override
  String get findProcessModeAutomaticDesc =>
      'Процесс определяется только при проверке правил процессов';

  @override
  String get monochromeScheme => 'Монохром';

  @override
  String get colorStyle => 'Стиль палитры';

  @override
  String get vividStyle => 'Яркий';

  @override
  String get tintedStyle => 'Тонированный';

  @override
  String get softStyle => 'Мягкий';

  @override
  String get customColor => 'Свой цвет';

  @override
  String get grid => 'Сетка';

  @override
  String get spectrum => 'Спектр';

  @override
  String get sliders => 'Ползунки';

  @override
  String get hue => 'Оттенок';

  @override
  String get saturation => 'Насыщенность';

  @override
  String get brightness => 'Яркость';

  @override
  String get hex => 'Hex';

  @override
  String get liquidGlass => 'Жидкое стекло';

  @override
  String get ultra => 'Максимум';

  @override
  String get developerMode => 'Режим разработчика';

  @override
  String get developerModeEnableTip => 'Режим разработчика активирован.';

  @override
  String get messageTest => 'Тестирование сообщения';

  @override
  String get messageTestTip => 'Это сообщение.';

  @override
  String get crashTest => 'Тест на сбои';

  @override
  String get clearData => 'Очистить данные';

  @override
  String get textScale => 'Масштабирование текста';

  @override
  String get internet => 'Интернет';

  @override
  String get systemApp => 'Системное приложение';

  @override
  String get noNetworkApp => 'Приложение без сети';

  @override
  String get restoreStrategy => 'Стратегия восстановления';

  @override
  String get restoreStrategy_override => 'Перезаписать';

  @override
  String get restoreStrategy_compatible => 'Совместимый';

  @override
  String get logsTest => 'Тест журналов';

  @override
  String emptyTip(Object label) {
    return '$label не может быть пустым';
  }

  @override
  String urlTip(Object label) {
    return '$label должен быть URL';
  }

  @override
  String numberTip(Object label) {
    return '$label должно быть числом';
  }

  @override
  String get interval => 'Интервал';

  @override
  String existsTip(Object label) {
    return 'Текущий $label уже существует';
  }

  @override
  String deleteTip(Object label) {
    return 'Вы уверены, что хотите удалить текущий $label?';
  }

  @override
  String deleteMultipTip(Object label) {
    return 'Вы уверены, что хотите удалить выбранные $label?';
  }

  @override
  String nullTip(Object label) {
    return '$label пока отсутствуют';
  }

  @override
  String get script => 'Скрипт';

  @override
  String get color => 'Цвет';

  @override
  String get rename => 'Переименовать';

  @override
  String get unnamed => 'Без имени';

  @override
  String get mixedPort => 'Смешанный порт';

  @override
  String get socksPort => 'Порт SOCKS';

  @override
  String get redirPort => 'Порт Redir';

  @override
  String get tproxyPort => 'Порт TProxy';

  @override
  String portTip(Object label) {
    return '$label должен быть числом от 1024 до 49151';
  }

  @override
  String get portConflictTip => 'Введите другой порт';

  @override
  String get portUnavailableTitle => 'Порт недоступен';

  @override
  String portUnavailableMessage(Object port) {
    return 'Не удалось начать прослушивание смешанного порта $port. Возможно, он занят другим приложением. Измените порт, чтобы сразу повторить попытку.';
  }

  @override
  String get saveAndRetry => 'Сохранить и повторить';

  @override
  String portSuggestionTip(Object port) {
    return 'Подставлен рекомендуемый порт $port.';
  }

  @override
  String get portProxyAppTip =>
      'Если запущено другое прокси-приложение, сначала закройте его.';

  @override
  String get import => 'Импорт';

  @override
  String get importFile => 'Импорт из файла';

  @override
  String get importUrl => 'Импорт по URL';

  @override
  String get autoSetSystemDns => 'Автонастройка системного DNS';

  @override
  String get suspendOnIdle => 'Приостанавливать прокси при бездействии';

  @override
  String get suspendOnIdleDesc =>
      '«Приостанавливать прокси при бездействии» останавливает передачу трафика и проверки узлов, когда экран выключен и система бездействует; звонки и прямые аудиотрансляции могут прерываться, а push-уведомления — задерживаться';

  @override
  String details(Object label) {
    return 'Детали: $label';
  }

  @override
  String get creationTime => 'Время создания';

  @override
  String get process => 'процесс';

  @override
  String get host => 'Хост';

  @override
  String get destination => 'Назначение';

  @override
  String get destinationGeoIP => 'Геолокация назначения';

  @override
  String get destinationIPASN => 'ASN назначения';

  @override
  String get specialProxy => 'Специальный прокси';

  @override
  String get specialRules => 'Специальные правила';

  @override
  String get remoteDestination => 'Удалённое назначение';

  @override
  String get networkType => 'Тип сети';

  @override
  String get proxyChains => 'Цепочки прокси';

  @override
  String get proxyChainWarning =>
      'Цепочка прокси может заметно снизить скорость сети. Оставьте ее выключенной, если она явно не нужна.';

  @override
  String get proxyChainInstruction =>
      'Расположите переходы от входа к выходу. На любом переходе можно использовать узел или группу. Прокси группы используют предыдущий переход; вложенные группы и DIRECT/REJECT не изменяются. После сохранения цепочка появится под своим именем как группа политик в списке прокси и в целях правил. Задержки в редакторе показаны для отдельных переходов; проверяйте группу цепочки для измерения фактического маршрута.';

  @override
  String get proxyChainMinimumNodes => 'Для цепочки нужны вход и выход';

  @override
  String get proxyChainMinimumNodesHint => 'Выберите выходной узел или группу.';

  @override
  String get proxyChainPolicyGroups => 'Группы политик';

  @override
  String get proxyChainUnsupportedGroupTip =>
      'В цепочке допустимы только группы select, url-test, fallback и load-balance.';

  @override
  String get proxyChainEntry => 'Вход';

  @override
  String get proxyChainExit => 'Выход';

  @override
  String get clearProxyChain => 'Удалить настройку цепочки';

  @override
  String get proxyChainCustomNodes => 'Пользовательские узлы';

  @override
  String get proxyChainCustomNode => 'Пользовательский узел';

  @override
  String get addProxyChainNode => 'Добавить';

  @override
  String get proxyChainOtherNodes => 'Другие узлы';

  @override
  String get proxyChainSavedAndApplied =>
      'Цепочка сохранена и применена. Выберите её по имени в правилах или в списке прокси.';

  @override
  String proxyChainConflictTip(Object name) {
    return 'Прокси $name конфликтует с другой включённой цепочкой или создаёт цикл';
  }

  @override
  String proxyChainUnavailableNodeTip(Object name) {
    return 'Прокси $name недоступен для этой позиции';
  }

  @override
  String proxyChainUnavailableReference(Object chainName, Object nodeName) {
    return 'В цепочке прокси «$chainName» недоступен узел или группа политик «$nodeName». Выберите его заново в разделе «Цепочки прокси» или отключите эту цепочку.';
  }

  @override
  String get proxyChainRelatedChainsUpdated =>
      'Связанные цепочки прокси обновлены';

  @override
  String get proxyChainSelectedNodes => 'Цепочка прокси';

  @override
  String get proxyChainAvailableNodes => 'Доступные узлы и группы';

  @override
  String get proxyChainEmpty => 'В цепочке прокси нет узлов';

  @override
  String get proxyChainNodeAdded => 'Узел добавлен в цепочку прокси';

  @override
  String get proxyChainUriNodeSupportedFormats =>
      'Поддерживаемые форматы: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://';

  @override
  String get log => 'Журнал';

  @override
  String get connection => 'Соединение';

  @override
  String get request => 'Запрос';

  @override
  String get connected => 'Подключено';

  @override
  String get disconnected => 'Отключено';

  @override
  String get connecting => 'Подключение...';

  @override
  String get restartCoreTip => 'Вы уверены, что хотите перезапустить ядро?';

  @override
  String get forceRestartCoreTip =>
      'Вы уверены, что хотите принудительно перезапустить ядро?';

  @override
  String get dnsHijacking => 'Перехват DNS';

  @override
  String get coreStatus => 'Основной статус';

  @override
  String get liveStatus => 'Текущее состояние';

  @override
  String liveStatusPosition(Object index, Object count) {
    return '$index из $count';
  }

  @override
  String get liveStatusTest => 'Тест карточек текущего состояния';

  @override
  String get coreStopped => 'Ядро остановлено';

  @override
  String get restartCore => 'Перезапустить ядро';

  @override
  String get coreStarting => 'Запуск ядра';

  @override
  String get coreStartingDesc => 'Подключение к ядру';

  @override
  String get coreRunning => 'Ядро работает';

  @override
  String get coreRunningDesc => 'Приложение подключено к ядру';

  @override
  String get forceRestartCore => 'Принудительный перезапуск';

  @override
  String get forceRestartCoreAsk => 'Принудительно перезапустить ядро?';

  @override
  String get forceRestartCoreAskDesc => 'Текущие соединения будут разорваны';

  @override
  String get stopUpdateDownloadTip => 'Остановить загрузку обновления?';

  @override
  String get stopUpdateDownloadDesc => 'Уже загруженная часть будет удалена';

  @override
  String get stopDownload => 'Стоп';

  @override
  String get coreNotConnected => 'Ядро не подключено';

  @override
  String get appendSystemDns => 'Добавлять системный DNS';

  @override
  String get blockQuic => 'Блокировать QUIC';

  @override
  String get blockQuicDesc =>
      'Отклонять трафик UDP 443, чтобы соединения переключались на TCP';

  @override
  String get blockWebRtc => 'Блокировать WebRTC';

  @override
  String get blockWebRtcDesc =>
      'Отклонять STUN-трафик для снижения утечек IP через WebRTC.';

  @override
  String get editRule => 'Редактировать правило';

  @override
  String get overrideMode => 'Режим переопределения';

  @override
  String get standardModeDesc =>
      'Стандартный режим, при необходимости запускает скрипт переопределения, затем добавляет правила поверх конфигурации';

  @override
  String get addedRulesAfterScript =>
      'Добавляются после выполнения скрипта, перед правилами профиля';

  @override
  String get addedRules => 'Добавленные правила';

  @override
  String get controlGlobalAddedRules =>
      'Управление глобальными добавленными правилами';

  @override
  String get overrideScript => 'Скрипт переопределения';

  @override
  String get goToConfigureScript => 'Перейти к настройке скрипта';

  @override
  String get editGlobalRules => 'Редактировать глобальные правила';

  @override
  String get confirmForceCrashCore =>
      'Вы уверены, что хотите принудительно аварийно завершить работу ядра?';

  @override
  String get confirmClearAllData =>
      'Вы уверены, что хотите очистить все данные?';

  @override
  String get loading => 'Загрузка...';

  @override
  String yearsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count года назад',
      many: '$count лет назад',
      few: '$count года назад',
      one: '$count год назад',
    );
    return '$_temp0';
  }

  @override
  String monthsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count месяца назад',
      many: '$count месяцев назад',
      few: '$count месяца назад',
      one: '$count месяц назад',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня назад',
      many: '$count дней назад',
      few: '$count дня назад',
      one: '$count день назад',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часа назад',
      many: '$count часов назад',
      few: '$count часа назад',
      one: '$count час назад',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минуты назад',
      many: '$count минут назад',
      few: '$count минуты назад',
      one: '$count минута назад',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Только что';

  @override
  String get turnOn => 'Включить';

  @override
  String get turnOff => 'Выключить';

  @override
  String get vpnConfigChangeDetected =>
      'Настройки VPN изменены. Нажмите, чтобы перезапустить';

  @override
  String get restart => 'Перезапустить';

  @override
  String get speedStatistics => 'Статистика скорости';

  @override
  String get resetPageChangesTip =>
      'На текущей странице есть изменения. Вы уверены, что хотите сбросить?';

  @override
  String get overwriteTypeCustom => 'Пользовательский';

  @override
  String get overwriteTypeCustomDesc =>
      'Пользовательский режим, полная настройка групп прокси и правил';

  @override
  String get emptyCustomOverwrite =>
      'Пользовательское переопределение пусто. Используйте быстрое заполнение или добавьте правила и группы прокси. Чтобы сохранить содержимое подписки, выберите режим «Дополнение».';

  @override
  String get proxyGroupEmpty => 'Группа прокси пуста';

  @override
  String get proxyGroupNameEmpty => 'Имя группы прокси не может быть пустым';

  @override
  String get ruleEmpty => 'Правило пусто';

  @override
  String get confirmOverwriteTip =>
      'Существующие данные будут перезаписаны после подтверждения';

  @override
  String get configDataDetected => 'Данные обнаружены в конфигурации';

  @override
  String get quickFill => 'Быстрое заполнение';

  @override
  String get clearCustomRouting => 'Очистить всё';

  @override
  String get confirmClearCustomRouting =>
      'Очистить пользовательские группы прокси и правила текущего профиля? Содержимое подписки, добавленные правила, цепочки прокси и пользовательские узлы сохранятся.';

  @override
  String get addProxyGroup => 'Добавить группу прокси';

  @override
  String get editProxyGroup => 'Редактировать группу прокси';

  @override
  String get lazy => 'Ленивая загрузка';

  @override
  String get proxyFilter => 'Фильтр прокси';

  @override
  String get excludeProxyFilter => 'Исключить фильтр прокси';

  @override
  String get excludeType => 'Тип исключения';

  @override
  String get expectedStatus => 'Ожидаемый статус';

  @override
  String get maxFailedTimes => 'Макс. количество неудач';

  @override
  String get timeout => 'Таймаут';

  @override
  String get strategy => 'Стратегия';

  @override
  String get iconUrl => 'URL иконки';

  @override
  String get disableUDP => 'Отключить UDP';

  @override
  String get hideFromList => 'Скрыть из списка';

  @override
  String get includeAll => 'Включить все прокси и провайдеры';

  @override
  String get includeAllProxies => 'Включить все прокси';

  @override
  String get includeAllProxyProviders => 'Включить всех провайдеров прокси';

  @override
  String get proxyGroupMembersEmpty =>
      'Добавьте прокси, провайдера или включите добавление всех';

  @override
  String get tolerance => 'Допуск';

  @override
  String customOutboundInUse(Object name) {
    return '$name все еще используется группой, правилом или цепочкой прокси';
  }

  @override
  String get relayGroupUnsupported =>
      'Группы Relay удалены из ядра. Выберите другой тип.';

  @override
  String rawOutboundInUse(Object name, Object path) {
    return '$name используется исходной конфигурацией в $path';
  }

  @override
  String get unknownNetworkError => 'Неизвестная сетевая ошибка';

  @override
  String get restoreException => 'Ошибка восстановления';

  @override
  String get networkException =>
      'Ошибка сети, проверьте соединение и попробуйте еще раз';

  @override
  String get invalidBackupFile => 'Неверный файл резервной копии';

  @override
  String get backupFromNewerVersion =>
      'Резервная копия создана более новой версией приложения. Обновите приложение перед восстановлением';

  @override
  String get pruneCache => 'Очистить кэш';

  @override
  String get backupAndRestore => 'Резервное копирование и восстановление';

  @override
  String get backupAndRestoreDesc =>
      'Синхронизация данных через WebDAV или файлы';

  @override
  String get restore => 'Восстановить';

  @override
  String get restoreDefault => 'Восстановить по умолчанию';

  @override
  String get restoreSuccess => 'Восстановление успешно';

  @override
  String get restoreFromWebDAVDesc => 'Восстановить данные через WebDAV';

  @override
  String get restoreFromFileDesc => 'Восстановить данные из файла';

  @override
  String get restoreOnlyConfig => 'Восстановить только файлы конфигурации';

  @override
  String get restoreAllData => 'Восстановить все данные';

  @override
  String get backupRetention => 'Хранить копий';

  @override
  String get backupRetentionDesc =>
      'При каждом резервном копировании старые копии этого устройства в WebDAV удаляются';

  @override
  String get selectBackup => 'Выберите резервную копию';

  @override
  String get noRemoteBackup => 'В WebDAV нет резервных копий';

  @override
  String get deleteBackupTip => 'Удалить эту резервную копию из WebDAV?';

  @override
  String get addProfile => 'Добавить профиль';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get delayTest => 'Тест задержки';

  @override
  String get userCenter => 'Центр пользователя';

  @override
  String get userCenterFallback => 'Центр пользователя (резервный)';

  @override
  String get userGuide => 'Руководство пользователя';

  @override
  String get oixCloud => 'oixCloud';

  @override
  String get register => 'Регистрация';

  @override
  String get registerTitle => 'Создать аккаунт';

  @override
  String get registerFailed => 'Ошибка регистрации';

  @override
  String get registerClosed => 'Регистрация в настоящее время закрыта';

  @override
  String get haveAccountAlready => 'Уже есть аккаунт?';

  @override
  String get goLogin => 'Войти';

  @override
  String get nicknameLabel => 'Никнейм';

  @override
  String get nicknameHint => 'Буквы и цифры, до 12 символов';

  @override
  String get nicknameValidation => 'Введите никнейм';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get confirmPasswordHint => 'Введите пароль ещё раз';

  @override
  String get confirmPasswordValidation => 'Подтвердите пароль';

  @override
  String get passwordMismatch => 'Пароли не совпадают';

  @override
  String get passwordRuleHint =>
      '10-36 символов: буквы разного регистра, цифра и символ';

  @override
  String get inviteCodeLabel => 'Код приглашения';

  @override
  String get inviteCodeHint => 'Введите код приглашения';

  @override
  String get inviteCodeValidation => 'Введите код приглашения';

  @override
  String get emailCodeLabel => 'Код из письма';

  @override
  String get emailCodeHint => 'Введите 6-значный код';

  @override
  String get emailCodeValidation => 'Введите код из письма';

  @override
  String get sendCode => 'Отправить код';

  @override
  String resendCodeIn(Object seconds) {
    return 'Повтор через $seconds с';
  }

  @override
  String get codeSent => 'Код подтверждения отправлен';

  @override
  String get loggedOutViewTitle => 'oixCloud';

  @override
  String get loggedOutViewDesc =>
      'Войдите, чтобы просмотреть информацию об учетной записи и управлять подписками';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get googleLoginWaiting => 'Завершите вход через Google в браузере';

  @override
  String get googleLoginUnavailable =>
      'Не удалось открыть вход через Google. Повторите попытку.';

  @override
  String get googleLoginTimedOut =>
      'Время ожидания входа через Google истекло. Повторите попытку.';

  @override
  String get googleLoginInvalidCallback =>
      'Не удалось подтвердить вход через Google. Повторите попытку.';

  @override
  String get loginTitle => 'Вход';

  @override
  String get startCorePromptTitle => 'Подсказка';

  @override
  String get startCorePromptContent =>
      'Профиль успешно импортирован. Хотите запустить ядро сейчас?';

  @override
  String get logoutTitle => 'Выход';

  @override
  String get logoutContent => 'Выйти из аккаунта?';

  @override
  String get loginSuccess => 'Вход выполнен успешно';

  @override
  String get getProfileSuccess => 'Профиль успешно получен';

  @override
  String get startSuccess => 'Запущено успешно';

  @override
  String get loginFailed => 'Ошибка входа';

  @override
  String get invalidCertificateTitle => 'Ошибка проверки сертификата';

  @override
  String get certificateExpired => 'Срок действия сертификата истёк';

  @override
  String get certificateNotYetValid => 'Сертификат ещё не вступил в силу';

  @override
  String get certificateHostnameMismatch =>
      'Сертификат не соответствует запрошенному домену';

  @override
  String get certificateUntrusted =>
      'Цепочка сертификатов не является доверенной';

  @override
  String get certificateValidityHint =>
      'Сначала синхронизируйте системную дату и время. Если время верное, необходимо исправить сертификат на сервере.';

  @override
  String get invalidCertificateContent =>
      'Не удалось проверить сертификат сервера. При пропуске проверки сервер может оказаться поддельным, а передаваемые или получаемые учётные данные и данные подписки могут быть украдены или изменены.\n\nПродолжайте, только если доверяете этой сети и серверу. Исключение действует лишь для этой повторной попытки с тем же сервером и сертификатом и отменяется после завершения операции.';

  @override
  String get allowTemporarily => 'Временно разрешить';

  @override
  String get retryWithoutCertificateVerification => 'Временно проверить API';

  @override
  String get apiAvailableWithCertificateException =>
      'API доступен с временным исключением для сертификата. Аккаунт и конфигурация узлов не синхронизированы. Устраните проблему с сертификатом и повторите проверку.';

  @override
  String get certificateUntrustedHint =>
      'Попробуйте другую сеть, например точку доступа телефона, и проверьте обновления системы. Если антивирус или корпоративная сеть проверяет HTTPS, обратитесь к администратору. Если ошибка остаётся, попросите поставщика сервиса проверить цепочку сертификатов.';

  @override
  String get certificateHostnameHint =>
      'Попробуйте другую сеть и завершите авторизацию Wi-Fi. Если ошибка остаётся, попросите поставщика сервиса проверить соответствие сертификата домену сервера.';

  @override
  String get certificateRevokedHint =>
      'Попросите поставщика сервиса заменить отозванный сертификат. Повторные попытки или изменение времени системы не устранят отзыв сертификата.';

  @override
  String get certificateUnknownHint =>
      'Проверьте дату и время системы и попробуйте другую сеть. Если проверка по-прежнему не проходит, передайте эту ошибку поставщику сервиса.';

  @override
  String get certificateCheckOnlyHint =>
      'Это действие только проверяет доступность API. Вход в аккаунт и загрузка конфигурации узлов не выполняются.';

  @override
  String get certificateSyncRetryDescription =>
      'После подтверждения будут проверены соединение, обновлены данные аккаунта и загружена конфигурация узлов. Исключение для сертификата отменяется по завершении этой синхронизации.';

  @override
  String get retryCloudSyncWithCertificateException =>
      'Временно разрешить и синхронизировать';

  @override
  String get cloudSyncedWithCertificateException =>
      'Аккаунт и конфигурация синхронизированы с временным исключением для сертификата. Проверка восстановлена; устраните проблему до следующей синхронизации.';

  @override
  String get cloudCertificateSyncFailed =>
      'Проверка API пройдена, но синхронизация аккаунта или конфигурации узлов не удалась: ';

  @override
  String get cloudConfigSyncIncomplete =>
      'Конфигурация узлов не загружена. Устраните ошибку загрузки и повторите синхронизацию.';

  @override
  String get emailPassword => 'Email и пароль';

  @override
  String get accessToken => 'Access Token';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Введите адрес электронной почты';

  @override
  String get emailValidation => 'Пожалуйста, введите email';

  @override
  String get emailFormatValidation => 'Неверный формат email';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get resetPasswordTitle => 'Сброс пароля';

  @override
  String get sendResetEmail => 'Отправить письмо для сброса';

  @override
  String get resetEmailSent =>
      'Письмо отправлено. Вставьте ссылку или код из письма ниже.';

  @override
  String get resetTokenLabel => 'Ссылка или код сброса';

  @override
  String get resetTokenValidation => 'Введите ссылку или код сброса';

  @override
  String get newPasswordLabel => 'Новый пароль';

  @override
  String get resetPasswordSuccess => 'Пароль сброшен, войдите с новым паролем';

  @override
  String get passwordValidation => 'Пожалуйста, введите пароль';

  @override
  String get tokenLabel => 'Access Token';

  @override
  String get tokenValidation => 'Пожалуйста, введите токен доступа';

  @override
  String expireDate(Object date) {
    return 'Истекает: $date';
  }

  @override
  String get todayUsed => 'Использовано сегодня';

  @override
  String remaining(Object value) {
    return 'Осталось: $value';
  }

  @override
  String get balance => 'Баланс';

  @override
  String get commission => 'Комиссия';

  @override
  String get points => 'Баллы';

  @override
  String get announcement => 'Объявление';

  @override
  String get readFullAnnouncement => 'Читать полностью';

  @override
  String get serviceCheckFailed => 'Проверка сервиса не удалась';

  @override
  String get apiAvailable => 'API-сервис работает нормально';

  @override
  String get checkApi => 'Проверить API';

  @override
  String get refresh => 'Обновить';

  @override
  String get nodeFilter => 'Фильтр узлов';

  @override
  String get nodeFilterSmartSelection => 'Умный выбор';

  @override
  String get nodeFilterCustomized => 'Настроено';

  @override
  String nodeFilterKept(Object kept, Object total) {
    return 'Оставлено $kept из $total узлов';
  }

  @override
  String get nodeFilterLines => 'Линии';

  @override
  String get nodeFilterRegions => 'Регионы';

  @override
  String get nodeFilterNameContains => 'Имя содержит';

  @override
  String get nodeFilterNameExcludes => 'Имя не содержит';

  @override
  String get nodeFilterPreview => 'Предпросмотр';

  @override
  String get nodeFilterSearch => 'Поиск узлов';

  @override
  String get nodeFilterAny => 'Любые';

  @override
  String get nodeFilterOnly => 'Только';

  @override
  String get nodeFilterExclude => 'Исключить';

  @override
  String get nodeFilterKeepOne => 'Оставьте хотя бы один узел';

  @override
  String nodeFilterNodeKept(Object name) {
    return '$name, оставлен';
  }

  @override
  String nodeFilterNodeExcluded(Object name) {
    return '$name, исключён';
  }

  @override
  String get nodeFilterRetry => 'Повторить';

  @override
  String get nodeFilterAccountNote =>
      'Фильтр сохраняется в аккаунте и действует на всех устройствах, где выполнен вход в это приложение.';

  @override
  String get nodeFilterUnavailable =>
      'Фильтр узлов доступен после покупки тарифа';

  @override
  String get minimalConfiguration => 'Минимальная конфигурация';

  @override
  String get minimalConfigurationDesc =>
      'Использовать сокращенный набор правил для меньшего профиля';

  @override
  String get tcpFastOpen => 'TCP Fast Open';

  @override
  String get tcpFastOpenDesc =>
      'Включите эту опцию для ускорения установки TCP-соединения';

  @override
  String get store => 'Магазин';

  @override
  String get recharge => 'Пополнить';

  @override
  String get availablePlans => 'Выберите тариф';

  @override
  String get noAvailablePlans => 'Нет доступных тарифов';

  @override
  String get myOrders => 'Купленные тарифы';

  @override
  String get noPurchaseRecords => 'Купленных тарифов пока нет';

  @override
  String get accountBalance => 'Баланс';

  @override
  String commissionBalance(Object value) {
    return 'Комиссия $value';
  }

  @override
  String get soldOut => 'Распродано';

  @override
  String remainingStock(Object count) {
    return 'Осталось $count';
  }

  @override
  String get mainlandNetworkWarning =>
      'Может не подходить для сетей материкового Китая';

  @override
  String get planInUse => 'Используется';

  @override
  String get planNotActivated => 'Ожидает активации';

  @override
  String get planEnded => 'Завершён';

  @override
  String get planAwaitingAutoRenewal => 'Ожидает автопродления';

  @override
  String get planAwaitingAutoRenewalNote =>
      'Стоит в очереди после остальных тарифов; продлится автоматически, когда они закончатся';

  @override
  String get planAutoRenewalOffNote =>
      'Стоит в очереди после остальных тарифов; завершится, когда они закончатся';

  @override
  String planNumber(Object id) {
    return 'Тариф #$id';
  }

  @override
  String get activate => 'Активировать';

  @override
  String get upgradePlan => 'Улучшить тариф';

  @override
  String get noPaymentMethods => 'Нет доступных способов оплаты';

  @override
  String get activatePlanTitle => 'Активировать тариф';

  @override
  String get activatePlanConfirm =>
      'Активировать этот тариф? Он станет вашим активным тарифом.';

  @override
  String get noUpgradablePlans => 'Нет тарифов для улучшения';

  @override
  String get selectUpgradeTarget => 'Выберите тариф для улучшения';

  @override
  String get refreshAfterPayment =>
      'После оплаты потяните вниз, чтобы обновить и проверить результат';

  @override
  String get discountCodeOptional => 'Промокод (необязательно)';

  @override
  String get bindCoupon => 'Применить купон';

  @override
  String get bindCouponIntro =>
      'Введите официальный код купона. Разница рассчитывается за оставшийся срок, а повторяющийся купон также меняет цену продления.';

  @override
  String get verifyCoupon => 'Проверить';

  @override
  String get discountCode => 'Код купона';

  @override
  String get discountCodeRequired => 'Введите код купона';

  @override
  String get discountedPriceLabel => 'Цена со скидкой';

  @override
  String get amountDueLabel => 'К доплате';

  @override
  String get refundAmountLabel => 'Возврат';

  @override
  String get recurringRenewalHint => 'Скидка сохранится при автопродлении';

  @override
  String get insufficientBalanceHint =>
      'Недостаточно средств. Пополните баланс, чтобы продолжить.';

  @override
  String get amountPayable => 'К оплате';

  @override
  String get renewalPriceLabel => 'Цена продления';

  @override
  String get calculatingQuote => 'Расчёт…';

  @override
  String get paymentMethod => 'Способ оплаты';

  @override
  String get goPay => 'Оплатить';

  @override
  String get confirmPurchase => 'Подтвердить покупку';

  @override
  String get rechargeAmount => 'Сумма пополнения (¥)';

  @override
  String get invalidAmount => 'Введите корректную сумму';

  @override
  String get scanOrTransferPay => 'Оплата сканированием / переводом';

  @override
  String get close => 'Закрыть';

  @override
  String get checkingPayment => 'Проверка...';

  @override
  String get paymentPending =>
      'Платёж ещё не получен. Повторите проверку чуть позже.';

  @override
  String get iHavePaid => 'Я оплатил';

  @override
  String get openInBrowser => 'Открыть в браузере';

  @override
  String get openLinkFailed =>
      'Не удалось открыть ссылку. Убедитесь, что браузер установлен, и повторите попытку.';

  @override
  String get scanToPayNotice => 'Отсканируйте через Alipay / WeChat';

  @override
  String get paymentAmount => 'Сумма платежа';

  @override
  String get receivingAddress => 'Адрес получателя';

  @override
  String get addressCopied => 'Адрес скопирован';

  @override
  String get transferConfirmNotice =>
      'После завершения перевода система подтвердит автоматически, и выбранный тариф будет активирован.';

  @override
  String get operationSuccess => 'Операция выполнена успешно';

  @override
  String get operationFailed => 'Операция не выполнена';

  @override
  String get paymentSuccess => 'Оплата прошла успешно';

  @override
  String get paymentRequestFailed => 'Не удалось выполнить запрос оплаты';

  @override
  String get fetchPlansFailed => 'Не удалось загрузить тарифы';

  @override
  String get storeSubtitle => 'Покупка, продление и улучшение тарифов';

  @override
  String get paymentUnknownResponse =>
      'Платёжный endpoint вернул неизвестный формат';

  @override
  String get buy => 'Купить';

  @override
  String get payWithBalance => 'Оплатить с баланса';

  @override
  String availableBalance(Object value) {
    return 'Доступно $value';
  }

  @override
  String get planUnavailable => 'Недоступно';

  @override
  String get balanceDeductionHint =>
      'Покупки сначала списываются с баланса, а недостающая сумма покрывается комиссией.';

  @override
  String rechargeAllowedRange(Object min, Object max) {
    return 'Допустимый диапазон $min – $max';
  }

  @override
  String get rechargeAmountOutOfRange =>
      'Сумма выходит за пределы диапазона этого способа оплаты';

  @override
  String get insufficientBalanceRecharge =>
      'Пополните баланс и повторите попытку.';

  @override
  String get storeOutcomeUnknown =>
      'Запрос мог быть обработан. Прежде чем повторять, проверьте «Купленные тарифы».';

  @override
  String configParseErrorAtLine(Object line) {
    return 'Неверный формат конфигурации в строке $line.';
  }

  @override
  String configTypeMismatch(Object expected, Object actual) {
    return 'Ожидалось: $expected; получено: $actual.';
  }

  @override
  String get configYamlFormatHint =>
      'Проверьте отступы и маркеры списка \"-\" рядом с этой строкой.';

  @override
  String get configValueTypeList => 'список';

  @override
  String get configValueTypeObject => 'объект';

  @override
  String get configValueTypeText => 'текст';

  @override
  String get configValueTypeBoolean => 'логическое значение';

  @override
  String get configValueTypeInteger => 'целое число';

  @override
  String get configValueTypeNumber => 'число';

  @override
  String get configValueTypeNull => 'пустое значение';

  @override
  String get configRecoveryTitle => 'Восстановление локальных настроек';

  @override
  String get configRecoveryMessage =>
      'Локальные настройки временно недоступны. Ваши данные сохранены. Разблокируйте устройство и повторите попытку или откройте приложение позже.';

  @override
  String get configRecoveryRetry => 'Повторить';

  @override
  String get geoDownloadFailed => 'Не удалось загрузить GEO';

  @override
  String get geoFileMissing => 'Не загружено';

  @override
  String get geoFileReadFailed => 'Не удалось прочитать файл ресурса';

  @override
  String get geoDownloadRecoveryHint =>
      'Загрузка использует текущие правила сети или прямое соединение, если прокси ещё не запущен. Повторите попытку, выберите другой источник или введите URL. После проверки операция продолжится.';

  @override
  String get geoOriginalSource => 'Текущий адрес';

  @override
  String get geoBackupSource => 'Резервный CDN';

  @override
  String get geoDownloadUrl => 'URL загрузки';

  @override
  String get geoInvalidDownloadUrl => 'Введите корректный HTTP или HTTPS URL';

  @override
  String get purchasedAtLabel => 'Время покупки';

  @override
  String get purchasePriceLabel => 'Цена покупки';

  @override
  String get billingPeriodLabel => 'Период оплаты';

  @override
  String get remainingTimeLabel => 'Оставшееся время';

  @override
  String get remainingTrafficLabel => 'Оставшийся трафик';

  @override
  String get expiresAtLabel => 'Истекает';

  @override
  String get usedTrafficLabel => 'Использованный трафик';

  @override
  String get purchaseTotalTrafficLabel => 'Общий трафик';

  @override
  String get purchaseAutoRenewLabel => 'Автопродление';

  @override
  String purchaseDays(Object count) {
    return '$countд';
  }

  @override
  String purchaseHours(Object count) {
    return '$countч';
  }

  @override
  String purchaseMinutes(Object count) {
    return '$countмин';
  }

  @override
  String get purchaseRenewOn => 'Вкл.';

  @override
  String get purchaseRenewOff => 'Выкл.';

  @override
  String get overwriteTypeMerge => 'Дополнение';

  @override
  String get overwriteTypeMergeDesc =>
      'Сохраняет правила и группы подписки и добавляет ваши настройки. Личные правила имеют приоритет над подпиской; существующие дополнительные правила сохраняют свой приоритет.';

  @override
  String get personalRouting => 'Личная маршрутизация';

  @override
  String get overlayHint =>
      'Личные настройки хранятся отдельно и применяются после обновлений. Новые группы блокируют соединения, если нет подходящих участников.';

  @override
  String overlayNameConflict(Object name) {
    return 'Имя «$name» уже используется. Переименуйте личную группу.';
  }

  @override
  String get outboundUnavailable =>
      'Недоступно в этой конфигурации. Удалите или замените.';

  @override
  String get memberOrderHint =>
      'Порядок выбора определяет порядок переключения. Повторный выбор перемещает участника в конец.';

  @override
  String groupCycleError(Object name) {
    return 'Циклическая ссылка группы «$name». Выберите другого участника.';
  }

  @override
  String get rulesRequireRuleMode =>
      'Личные правила действуют в режиме правил.';

  @override
  String get checkRouting => 'Проверить конфигурацию';

  @override
  String get routingChecked =>
      'Конфигурация корректна. Личные настройки сохранены в этом профиле.';

  @override
  String get routingApplied => 'Личные настройки применены.';

  @override
  String get routingApplyFailed =>
      'Изменения сохранены, но не применены. Проверьте конфигурацию и повторите.';

  @override
  String get customRuleForm => 'Форма';

  @override
  String get customRuleRaw => 'Текст правила';

  @override
  String get customRuleRawHint =>
      'Введите одно полное правило. Сложные выражения сохраняются без изменений.';

  @override
  String get customRuleFormUnavailable =>
      'Это правило использует сложный синтаксис. Редактируйте текст, чтобы сохранить все параметры.';

  @override
  String get customRuleInvalidSyntax =>
      'Введите полное правило с допустимыми типом, содержимым и целью.';

  @override
  String customRuleInvalidContent(Object example) {
    return 'Проверьте содержимое для этого типа правила. Пример: $example';
  }

  @override
  String customRuleUnavailableTarget(Object name) {
    return '$name недоступна. Выберите цель из текущей конфигурации.';
  }

  @override
  String customRuleUnavailableProvider(Object name) {
    return '$name недоступен. Выберите существующий источник правил.';
  }

  @override
  String get customRuleChooseTarget => 'Выберите цель';

  @override
  String get customRuleChooseProvider => 'Выберите источник правил';

  @override
  String get customRuleMatchHint =>
      'Совпадает со всем оставшимся трафиком. Правила ниже не будут применяться.';

  @override
  String get customRuleNoResolveHint =>
      'Проверять известные IP-адреса без разрешения доменных имён.';

  @override
  String get saveRoutingDraft => 'Сохранить черновик';

  @override
  String get routingDraftHint =>
      'Сохраните черновик, чтобы исправить другие элементы. Настройки применяются только после проверки всей конфигурации.';

  @override
  String get groupFilterHint =>
      'Фильтрует автоматически добавленные узлы и провайдеры. Участники, выбранные вручную, сохраняются.';

  @override
  String get groupTypeSelect => 'Ручной выбор';

  @override
  String get groupTypeUrlTest => 'Автоматический выбор';

  @override
  String get groupTypeFallback => 'Переключение при сбое';

  @override
  String get groupTypeLoadBalance => 'Балансировка нагрузки';

  @override
  String get groupTypeSelectHint =>
      'Выбирайте активного участника на странице прокси.';

  @override
  String get groupTypeUrlTestHint =>
      'Периодически проверяет участников и выбирает узел с низкой задержкой.';

  @override
  String get groupTypeFallbackHint =>
      'Выбирает участников по порядку и переключается при сбое.';

  @override
  String get groupTypeLoadBalanceHint =>
      'Распределяет соединения между доступными участниками.';

  @override
  String get routingGroupType => 'Тип группы';

  @override
  String get customRuleType => 'Тип правила';

  @override
  String get routingChanged =>
      'Конфигурация изменилась во время редактирования или проверки. Откройте редактор заново или повторите проверку.';

  @override
  String get editCustomRouting => 'Изменить свои настройки';

  @override
  String get customRoutingDraftHint =>
      'Заполните свои настройки маршрутизации, затем выберите режим «Пользовательский». Редактирование черновика не меняет текущий режим.';

  @override
  String coreBlockedByPolicyTip(int code) {
    return 'Windows заблокировала запуск ядра прокси (системная ошибка $code). Проверьте журнал защиты в Безопасности Windows, политику контроля приложений, источник и подпись установщика.';
  }

  @override
  String get startupRecoveryTitle => 'Восстановление запуска';

  @override
  String get startupRecoveryTip =>
      'Предыдущий запуск не завершился. Автоматическое применение конфигурации и запуск VPN приостановлены на этот раз. Выбранный профиль и настройки сохранены. Проверьте конфигурацию и нажмите «Запустить»; уже работающий VPN останется подключённым.';

  @override
  String get initFailed => 'Не удалось запустить';

  @override
  String get initFailedTip =>
      'При запуске приложения произошла критическая ошибка, и работа не может быть продолжена.';

  @override
  String get startupTimeoutTip =>
      'Время ожидания запуска истекло. Закройте и снова откройте приложение. Если проблема повторится, скопируйте диагностические сведения ниже.';

  @override
  String get startupDiagnostics => 'Диагностика запуска';

  @override
  String get errorDetails => 'Подробности ошибки';

  @override
  String get stackTrace => 'Трассировка стека';

  @override
  String get authentication => 'Аутентификация локального прокси';

  @override
  String get authenticationDesc =>
      'Аутентификация локального прокси требует имя пользователя и пароль для HTTP/SOCKS. Пока она включена, системный HTTP-прокси не настраивается; TUN/VPN остаётся доступен';

  @override
  String get authenticationSystemProxyDesc =>
      'Пока включена аутентификация локального прокси, системный прокси не применяется';

  @override
  String get authenticationUsernameInvalid =>
      'От 1 до 255 байт UTF-8, без двоеточий и управляющих символов';

  @override
  String get authenticationPasswordInvalid =>
      'От 1 до 255 байт UTF-8, без управляющих символов';

  @override
  String get authenticationApplyFailed =>
      'Не удалось применить настройки аутентификации';

  @override
  String get installedAppsPermissionRequired =>
      'Нужно разрешение на доступ к списку приложений';

  @override
  String get installedAppsPermissionDesc =>
      'Разрешите доступ к списку установленных приложений, чтобы выбрать приложения для VPN.';

  @override
  String get installedAppsPermissionDeniedMessage =>
      'Разрешение не предоставлено. Его можно включить в системных настройках.';

  @override
  String get installedAppsPermissionGrant => 'Разрешить доступ';

  @override
  String get installedAppsLoadFailed =>
      'Не удалось загрузить список приложений. Повторите попытку.';

  @override
  String get configRecoveryMissingKey =>
      'Ключ шифрования существующих настроек отсутствует или недействителен. Запустите приложение от исходного пользователя на исходном устройстве или восстановите резервную копию. Повторная попытка не воссоздаст утерянный ключ.';

  @override
  String get configRecoveryDatabaseUnavailable =>
      'Локальная база данных временно недоступна. Файлы сохранены. Проверьте права доступа к папке данных приложения и не используется ли база другим процессом, затем повторите попытку.';

  @override
  String get configRecoveryIncompatibleDatabase =>
      'База данных в папке этого приложения несовместима или повреждена. Исходные файлы сохранены. Восстановите совместимую резервную копию или создайте копию и выполните сброс, затем настройте приложение заново. Данные других приложений не используются.';

  @override
  String get configRecoveryUnreadable =>
      'Локальные настройки не удаётся расшифровать, либо файл повреждён. Исходные файлы сохранены. Восстановите подходящие ключ и резервную копию настроек или создайте копию и выполните сброс.';

  @override
  String get configRecoveryStorage =>
      'Не удалось прочитать или сохранить локальные настройки либо ключ шифрования. Проверьте доступ к папке данных приложения и системному защищённому хранилищу, затем повторите попытку.';

  @override
  String get configRecoveryReset => 'Создать копию и сбросить';

  @override
  String get configRecoveryResetConfirm =>
      'Создать зашифрованную резервную копию всех локальных настроек, подписок, правил и данных аккаунта, затем сбросить приложение? Потребуется снова войти и восстановить или импортировать подписки и настройки. Копия защищена текущим пользователем Windows, но не восстановит утерянный ключ шифрования.';

  @override
  String get configRecoveryResetDone =>
      'Зашифрованная резервная копия исходных данных сохранена в указанной ниже папке. Закройте и снова откройте приложение для повторной настройки.';

  @override
  String get configRecoveryResetFailed =>
      'Не удалось завершить зашифрованное резервное копирование и сброс. Оставшиеся исходные данные не будут удалены без проверенной копии. Повторите операцию или закройте и снова откройте приложение для её завершения.';

  @override
  String get configRecoveryKeyring =>
      'Не удалось получить доступ к системной связке ключей (Secret Service). Включите и разблокируйте KWallet или GNOME Keyring в настройках системы, затем повторите попытку.';

  @override
  String get configRecoveryUseLocalStorage => 'Хранить в локальном файле';

  @override
  String get configRecoveryUseLocalStorageConfirm =>
      'Хранить ключи шифрования и учётные данные аккаунта не в системной связке ключей, а в файле в папке данных приложения, доступном только вашему пользователю? Любая программа, запущенная от вашего имени, сможет прочитать их и расшифровать локальные настройки. Этот выбор будет действовать и дальше.';

  @override
  String get excludeSsids => 'Сети Wi-Fi для приостановки прокси';

  @override
  String get excludeSsidsDesc =>
      'Приостанавливать прокси в указанных сетях Wi-Fi; возобновлять после отключения, только если приложение остаётся запущенным.';

  @override
  String get allowBackgroundLocation => 'Разрешить всегда';

  @override
  String get locationPermission => 'Разрешение на геолокацию';

  @override
  String get locationPermissionRequired => 'Требуется разрешение на геолокацию';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. Откройте Системные настройки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте $appName в списке\n\nПосле настройки вернитесь в приложение и продолжайте работу. Спасибо за сотрудничество.';
  }

  @override
  String get ssidPermissionGuide =>
      'Разрешите доступ к геолокации для чтения имён Wi-Fi. На Android разрешите точное местоположение всегда и включите геолокацию.';

  @override
  String get ssidPermissionMacosGuide =>
      'Для чтения имён Wi-Fi разрешите этому приложению использовать службы геолокации в системных настройках.';

  @override
  String get exitDefault => 'По умолчанию';

  @override
  String get customExit => 'Свой выход';

  @override
  String get inputExitName => 'Введите название выхода';

  @override
  String get iconHistory => 'Недавние значки';

  @override
  String get exitFullScreen => 'Выйти из полноэкранного режима';

  @override
  String get unmaximize => 'Свернуть в окно';

  @override
  String get maximize => 'Развернуть';

  @override
  String get unpinWindow => 'Открепить окно';

  @override
  String get pinWindow => 'Закрепить поверх всех окон';

  @override
  String get minimize => 'Свернуть';

  @override
  String get cloudApiDnsFailed => 'Ошибка разрешения DNS';

  @override
  String get cloudApiDnsEmpty =>
      'DNS вернул пустой ответ: возможны помехи или сбой системного DNS';

  @override
  String get cloudApiDnsUnknownHost => 'DNS не нашёл этот домен';

  @override
  String get cloudApiConnectTimeout => 'Время ожидания подключения истекло';

  @override
  String get cloudApiSendTimeout => 'Время отправки запроса истекло';

  @override
  String get cloudApiReceiveTimeout => 'Время ожидания ответа истекло';

  @override
  String get cloudApiTlsFailed => 'Ошибка рукопожатия TLS';

  @override
  String get cloudApiConnectionRefused => 'В подключении отказано';

  @override
  String get cloudApiConnectionReset => 'Соединение сброшено';

  @override
  String get cloudApiNetworkUnreachable => 'Сеть недоступна';

  @override
  String get cloudApiAccessDenied => 'Доступ к сети запрещён';

  @override
  String get cloudApiConnectionFailed => 'Ошибка подключения';

  @override
  String get cloudApiProxyFailed => 'Ошибка подключения к прокси';

  @override
  String get cloudApiProxyAuthFailed =>
      'Ошибка аутентификации прокси (HTTP 407)';

  @override
  String cloudApiHttpError(Object status) {
    return 'Сервер вернул HTTP $status';
  }

  @override
  String get certificateRevoked => 'Сертификат отозван';

  @override
  String get cloudApiBadRequest => 'Сервер отклонил запрос как некорректный';

  @override
  String get cloudApiForbidden => 'Доступ запрещён сервером';

  @override
  String get cloudApiNotFound => 'Запрошенный API или ресурс не найден';

  @override
  String get cloudApiMethodNotAllowed => 'Метод запроса не разрешён';

  @override
  String get cloudApiServerRequestTimeout => 'Сервер не получил запрос вовремя';

  @override
  String get cloudApiRequestTooLarge =>
      'Запрос превышает допустимый для сервера размер';

  @override
  String get cloudApiRateLimited => 'Слишком много запросов; повторите позже';

  @override
  String get cloudApiServerError => 'Внутренняя ошибка сервера';

  @override
  String get cloudApiBadGateway =>
      'Шлюз получил некорректный ответ вышестоящего сервера';

  @override
  String get cloudApiServiceUnavailable => 'Сервис временно недоступен';

  @override
  String get cloudApiGatewayTimeout =>
      'Шлюз не дождался ответа вышестоящего сервера';

  @override
  String get cloudApiNetworkAuthRequired =>
      'Для доступа к этой сети требуется авторизация';

  @override
  String get cloudApiResponseTooLarge =>
      'Ответ сервера превышает допустимый размер';

  @override
  String get cloudApiTlsProtocolFailed =>
      'Несовместимый протокол TLS или некорректный ответ TLS';

  @override
  String get cloudApiTlsAlgorithmFailed =>
      'Не удалось согласовать криптографические алгоритмы TLS';

  @override
  String get cloudApiTlsInterrupted =>
      'Соединение закрыто до завершения рукопожатия TLS';

  @override
  String get cloudApiRedirectLoop => 'Обнаружен цикл перенаправлений сервера';

  @override
  String get cloudApiRedirectLimit => 'Слишком много перенаправлений сервера';

  @override
  String get cloudApiRedirectInvalid => 'Некорректное перенаправление сервера';

  @override
  String get cloudApiResponseInterrupted =>
      'Соединение закрыто до получения полного ответа';

  @override
  String get cloudApiConnectionAborted => 'Соединение прервано';

  @override
  String get cloudApiAddressUnavailable => 'Сетевой адрес недоступен';

  @override
  String get cloudApiAddressInUse => 'Сетевой адрес или порт уже используется';

  @override
  String get cloudApiNetworkResourcesExhausted =>
      'Недостаточно сетевых ресурсов системы';

  @override
  String get cloudApiClockSkew =>
      'Часы устройства слишком расходятся с сервером. Включите автоматическую установку времени и повторите.';

  @override
  String get cloudApiSignatureRejected =>
      'Сервер отклонил подпись приложения. Переустановите последнюю официальную сборку.';

  @override
  String get cloudApiServerUnconfigured =>
      'На сервере не настроен ключ для этого приложения. Обратитесь в поддержку.';

  @override
  String get cloudApiConfigKeyRejected =>
      'Сервер отклонил ключ конфигурации этого устройства. Переустановите последнюю официальную сборку.';

  @override
  String get cloudApiAccountDisabled =>
      'Эта учётная запись отключена. Обратитесь в поддержку.';

  @override
  String get cloudApiAccountAnomaly =>
      'Эта учётная запись требует проверки. Пройдите её на сайте и повторите.';

  @override
  String get cloudApiAccountNotFound =>
      'Эта учётная запись больше не существует. Войдите снова.';

  @override
  String get cloudApiInvalidResponse => 'Неверный формат ответа сервера';

  @override
  String get cloudApiRequestCanceled => 'Запрос отменён';

  @override
  String cloudApiSystemError(Object code) {
    return 'Системная ошибка $code';
  }

  @override
  String get cloudApiTimeout => 'Время ожидания запроса истекло';

  @override
  String cloudApiRouteDirect(Object error) {
    return 'Напрямую: $error';
  }

  @override
  String cloudApiRouteProxy(Object error) {
    return 'Локальный прокси: $error';
  }

  @override
  String get diagTitle => 'Диагностика сети';

  @override
  String get diagEntryHint => 'Проверка ядра, системного прокси, TUN и DNS';

  @override
  String get diagScope =>
      'Проверяется текущая связь на небольшой выборке. Системный путь также может проходить через TUN. Результат не охватывает все приложения и узлы.';

  @override
  String get diagRun => 'Начать проверку';

  @override
  String get diagCopy => 'Копировать отчёт';

  @override
  String get diagCanceled => 'Проверка отменена, результаты неполные';

  @override
  String get diagFixing => 'Применяется исправление, затем проверка повторится';

  @override
  String get diagFixFailed =>
      'Не удалось применить исправление. Следуйте рекомендации выше';

  @override
  String get diagFixApplyProfile => 'Применить конфигурацию';

  @override
  String get diagFixStart => 'Запустить подключение';

  @override
  String get diagFixRestartCore => 'Перезапустить ядро';

  @override
  String get diagFixRestartConnection => 'Переподключиться';

  @override
  String get diagFixSystemProxy => 'Переустановить системный прокси';

  @override
  String get diagFixEnableSystemProxy => 'Включить системный прокси';

  @override
  String get diagFixTun => 'Включить TUN заново';

  @override
  String get diagFixRetest => 'Повторить тест узлов';

  @override
  String get diagPassed => 'Пройдено';

  @override
  String get diagWarning => 'Требует внимания';

  @override
  String get diagFailed => 'Ошибка';

  @override
  String get diagUnknown => 'Не удалось проверить';

  @override
  String get diagSkipped => 'Пропущено';

  @override
  String get diagDisabled => 'Этот параметр выключен';

  @override
  String get diagProfile => 'Применённая конфигурация';

  @override
  String get diagProfileReady => 'Выбранная конфигурация применена';

  @override
  String get diagProfileMissing => 'Выбранная конфигурация ещё не применена';

  @override
  String get diagProfileHint =>
      'Выберите действующую конфигурацию и запустите подключение, затем повторите проверку.';

  @override
  String get diagCore => 'Ответ ядра';

  @override
  String get diagCoreReady => 'Ядро ответило и сообщило об активных слушателях';

  @override
  String get diagCoreUnknown =>
      'Диагностика ядра недоступна или конфигурация изменилась';

  @override
  String get diagCoreStopped =>
      'Ядро сообщает, что передача трафика остановлена';

  @override
  String get diagSuspended =>
      'Передача приостановлена настройкой исключения текущей Wi-Fi сети';

  @override
  String get diagCoreHint =>
      'Проверьте переключатель подключения и исключения Wi-Fi. Если ядро не отвечает, перезапустите его и проверьте совместимость версий клиента и ядра.';

  @override
  String get diagListener => 'Локальный вход прокси';

  @override
  String get diagListenerReady => 'Ожидаемый порт ответил по протоколу прокси';

  @override
  String get diagListenerFailed =>
      'Ожидаемый порт не ответил или отличается от порта ядра';

  @override
  String get diagListenerHint =>
      'Проверьте, не занят ли порт и запущен ли локальный прокси. Переподключитесь; если ошибка остаётся, откройте «Порты и аутентификация» и проверьте или смените смешанный порт.';

  @override
  String get diagSystemProxy => 'Системные настройки прокси';

  @override
  String get diagProxyReady =>
      'HTTP и HTTPS прокси указывают на ожидаемый локальный порт';

  @override
  String get diagProxyDisabled =>
      'Клиент запросил системный прокси, но в ОС он выключен';

  @override
  String get diagProxyDifferent => 'Прокси ОС не совпадает с портом приложения';

  @override
  String get diagProxyAutomatic =>
      'Обнаружена автоматическая настройка прокси; фактический маршрут не проверен';

  @override
  String get diagProxyHint =>
      'Откройте «Диагностика и ручная настройка» и проверьте адрес и порт системного прокси. Если настройки возвращаются, проверьте другие прокси-приложения и политики управления устройством.';

  @override
  String get diagProxyAutomaticHint =>
      'Скрипт PAC или автообнаружение могут выбирать разные прокси для разных сайтов. Это не обязательно означает сбой связи. Перед изменением проверьте источник настроек.';

  @override
  String get diagSystemDnsHint =>
      'Попробуйте другую сеть и проверьте DNS-серверы активного подключения в ОС. Изменение только настроек DNS клиента может не исправить системное разрешение имён.';

  @override
  String get diagProxyRecover => 'Отключить неактивный локальный прокси';

  @override
  String get diagProxyRecoverHint =>
      'Сначала остановите подключение. Ручной прокси на текущем локальном порту отключается только при отсутствии службы на этом порту. Другие адреса, порты и автоматические настройки сохраняются.';

  @override
  String get diagProxyGuide => 'Диагностика и ручная настройка';

  @override
  String get diagRecheck => 'Проверить снова';

  @override
  String get diagOpenPortSettings => 'Порты и аутентификация';

  @override
  String get diagOpenNetworkSettings => 'Настройки сети и TUN';

  @override
  String get diagOpenDnsSettings => 'Переопределение DNS';

  @override
  String get diagOpenSystemSettings => 'Открыть системные настройки';

  @override
  String get diagOpenSettingsFailed =>
      'Не удалось открыть системные настройки. Откройте их вручную по указанному выше пути.';

  @override
  String get diagCopyProxyAddress => 'Копировать адрес прокси';

  @override
  String get diagProxyGuidePrepareTitle => '1. Проверьте локальный прокси';

  @override
  String get diagProxyGuidePrepare =>
      'Выберите действующий профиль, запустите подключение в FlClash и дождитесь успешной проверки локального прокси перед вводом адреса.\nЗакройте другие прокси-приложения, меняющие системные настройки. Если настройки управляются компанией или учебным заведением, заблокированы или восстанавливаются, обратитесь к администратору.';

  @override
  String get diagProxyGuideManualTitle => '2. Проверьте или введите настройки';

  @override
  String get diagProxyGuideWindows =>
      'Параметры → Сеть и Интернет → Прокси-сервер\nЕсли автоматические настройки остались от другого приложения и больше не нужны сети, отключите сценарий настройки и автоматическое определение параметров.\nВ разделе ручной настройки включите прокси-сервер, введите адрес и порт ниже в отдельные поля и сохраните. Не добавляйте http:// к адресу. Сохраните необходимые сети исключения.';

  @override
  String get diagProxyGuideMacos =>
      'Системные настройки → Сеть → активное подключение Wi-Fi или Ethernet → Подробнее → Прокси\nmacOS 12: Системные настройки → Сеть → активное подключение → Дополнительно → Прокси\nЕсли автоматические настройки остались от другого приложения и больше не нужны сети, отключите автообнаружение и автоматическую конфигурацию прокси.\nВключите веб-прокси (HTTP) и защищённый веб-прокси (HTTPS), укажите адрес и порт ниже для обоих и сохраните. Оставьте необходимые сети исключения.';

  @override
  String get diagProxyGuideLinux =>
      'Откройте настройки рабочего стола → Сеть → Сетевой прокси и выберите ручной режим (названия зависят от окружения).\nУкажите адрес и порт ниже для HTTP и HTTPS и примените настройки. Если системной панели прокси нет, настройте нужное приложение.\nПеред заменой автоматической конфигурации проверьте её источник и необходимость для сети.';

  @override
  String get diagProxyGuideApp =>
      'На этом устройстве откройте настройки прокси нужного приложения, выберите HTTP или SOCKS5 и введите адрес и порт ниже.\nAndroid предоставляет системный прокси через службу VPN. Для доступа через VPN проверьте переключатель VPN и контроль доступа приложений в сетевых настройках FlClash.';

  @override
  String get diagProxyGuideAuthenticated =>
      'Включена аутентификация локального прокси, поэтому FlClash не задаёт системный прокси автоматически.\nВ приложении с поддержкой аутентификации прокси выберите HTTP или SOCKS5 и введите адрес и порт ниже. Имя пользователя и пароль доступны в FlClash → Переопределение → Общие → Входящие подключения → Аутентификация.\nНе включайте учётные данные в отчёты диагностики.';

  @override
  String diagProxyGuideValues(Object port) {
    return 'Локальный адрес: 127.0.0.1\nСмешанный порт (текущая конфигурация): $port\nИспользуйте этот порт для HTTP, проксирования сайтов HTTPS и SOCKS5 только на этом устройстве.';
  }

  @override
  String get diagProxyGuideInvalidPort =>
      'Смешанный порт недоступен. Задайте допустимый порт в разделе «Порты и аутентификация» и запустите подключение.';

  @override
  String get diagProxyGuideVerifyTitle => '3. Сохраните и проверьте приложение';

  @override
  String get diagProxyGuideVerify =>
      'Вернитесь и нажмите «Проверить снова», затем повторите попытку в используемом браузере или приложении.\nЕсли локальный прокси проходит проверку, но приложение не работает, проверьте его собственные настройки прокси и расширения. Системный прокси действует не на все приложения.\nПосле остановки FlClash может потребоваться вручную отключить заданный прокси или вернуть прежние настройки, чтобы сохранить доступ к интернету.';

  @override
  String get diagTun => 'Интерфейс TUN и маршрут';

  @override
  String get diagTunMissing =>
      'Активный интерфейс TUN, соответствующий ядру, не найден';

  @override
  String get diagTunReady =>
      'Интерфейс TUN ядра активен, проверенный маршрут IPv4 проходит через него';

  @override
  String get diagTunRouteMismatch =>
      'TUN активен, но проверенный маршрут IPv4 проходит через другой интерфейс';

  @override
  String get diagTunRouteUnknown =>
      'TUN активен, но его маршрут IPv4 не удалось проверить';

  @override
  String get diagTunHint =>
      'Переключите TUN и подтвердите системное разрешение. При несовпадении маршрута проверьте другие VPN. IPv6, UDP и исключения приложений проверяются отдельно.';

  @override
  String get proxyConflictTitle => 'Возможен конфликт прокси';

  @override
  String proxyConflictSystemProxy(Object address) {
    return 'До запуска системный прокси указывал на $address.';
  }

  @override
  String get proxyConflictAutoConfig =>
      'До запуска системный прокси использовал сценарий автоматической настройки.';

  @override
  String proxyConflictVpn(Object name) {
    return 'До запуска трафик шёл через другой VPN или виртуальный адаптер: $name.';
  }

  @override
  String get proxyConflictHint =>
      'Если это другое прокси-приложение или VPN, закройте его: одновременная работа может нарушить подключение.';

  @override
  String get diagTrafficCapture => 'Перехват трафика';

  @override
  String get diagNoCapture => 'Системный прокси и TUN выключены';

  @override
  String get diagCaptureHint =>
      'Включите системный прокси или TUN либо настройте локальный прокси в нужном приложении.';

  @override
  String get diagSystemDns => 'Системный DNS';

  @override
  String get diagCoreDns => 'DNS ядра';

  @override
  String diagProbeSummary(int passed, int total) {
    return 'Успешно проб: $passed из $total';
  }

  @override
  String diagProbeResult(int index, String result, int milliseconds) {
    return 'Проба $index: $result · $milliseconds мс';
  }

  @override
  String get diagDnsServerFailed => 'Вышестоящий DNS вернул ошибку сервера';

  @override
  String get diagDnsReady => 'Проверенные имена успешно разрешены';

  @override
  String get diagDnsPartial => 'Разрешена только часть проверенных имён';

  @override
  String get diagOixDnsNoSample =>
      'Нет управляемого доменного имени узла для проверки';

  @override
  String get diagOixDnsAuthMissing =>
      'Функция подписи управляемого DNS не готова';

  @override
  String get diagDnsNoAnswer =>
      'DNS не вернул подходящий адрес; это само по себе не доказывает ошибку аутентификации';

  @override
  String get diagDnsRefused => 'DNS-запрос отклонён';

  @override
  String get diagDnsHint =>
      'Проверьте переопределения DNS и попробуйте другую сеть. Если системный DNS работает, а DNS ядра нет, проверьте DNS в конфигурации.';

  @override
  String get diagOixDnsHint =>
      'Проверьте версию клиента и системное время, обновите подписку. Если ошибка остаётся, передайте отчёт поддержке.';

  @override
  String get diagSystemPath => 'Системный сетевой путь';

  @override
  String get diagProxyPath => 'Доступ через локальный прокси';

  @override
  String diagWebResult(Object count) {
    return 'Пройдено $count из 2 независимых проверок HTTPS';
  }

  @override
  String get diagSystemPathHint =>
      'Этот путь не использует HTTP-прокси приложения явно, но может идти через TUN. Сбой выборки может быть связан с DNS, фильтрацией или сайтом проверки; сравните с результатом прокси.';

  @override
  String get diagProxyPathHint =>
      'Если системный путь работает, проверьте выбранный узел, правила и DNS ядра. Сбой одного проверочного сайта не означает отказ всех узлов.';

  @override
  String get diagClock => 'Сравнение системного времени';

  @override
  String get diagClockUnknown =>
      'Недостаточно некэшированных HTTPS-ответов для сравнения времени';

  @override
  String get diagClockSkew =>
      'Два независимых ответа указывают на возможное расхождение времени не менее пяти минут';

  @override
  String get diagClockReady =>
      'В выборке не обнаружено устойчивого большого расхождения времени';

  @override
  String get diagClockHint =>
      'Включите автоматическую настройку даты и времени и повторите проверку. Ошибка часов может влиять на сертификаты и подписи DNS oixCloud.';

  @override
  String get diagAllFailed =>
      'Все проверки узлов в этой группе завершились неудачно. Адрес проверки также может быть недоступен. Запустите диагностику сети';

  @override
  String get updateDownloadBackground => 'Скачать в фоне';

  @override
  String get updateReady => 'Обновление готово к установке';

  @override
  String get updateRestart => 'Обновить и перезапустить';

  @override
  String get updateRestartHint =>
      'Приложение закроется, обновится и откроется снова. Ваши настройки сохранятся.';

  @override
  String get updatePreparing => 'Подготовка обновления';

  @override
  String get updateVerifying => 'Проверка пакета обновления';

  @override
  String get updateCheckingInstaller => 'Проверка установщика';

  @override
  String get updateRestarting => 'Завершение работы и перезапуск';

  @override
  String get updateApplyFailed =>
      'Автоматическое обновление не завершено. Повторите попытку или обновите приложение со страницы загрузки.';

  @override
  String get updateReadyHint =>
      'Обновление скачано. Установите его в удобное время.';

  @override
  String get updateInstall => 'Установить обновление';

  @override
  String get updateDownloading => 'Загрузка обновления';

  @override
  String get updateDownloadFailed => 'Не удалось скачать обновление';

  @override
  String get updateDownloadBrowser => 'Скачать в браузере';

  @override
  String get updatePackageFormat => 'Выберите формат пакета';

  @override
  String get updatePackageFormatTip =>
      'Не удалось определить способ установки. Выберите подходящий формат.';

  @override
  String get updateAppImageTip =>
      'AppImage нельзя установить автоматически. Замените текущую программу скачанным файлом; его папка открыта.';

  @override
  String get updatePackageManagerTip =>
      'Эта сборка установлена пакетным менеджером. Обновите её тем же способом, каким устанавливали.';

  @override
  String get tunMtuDesc =>
      'По умолчанию 9000; можно попробовать 1480 или 4064. Перезапустите Android VPN';

  @override
  String get tunMtuInvalid => 'Введите целое число от 1280 до 65535';

  @override
  String get scriptOptions => 'Параметры скрипта';

  @override
  String get scriptOptionsEmpty =>
      'В этом скрипте нет настраиваемых переключателей';

  @override
  String get scriptChanges => 'Изменения скрипта';

  @override
  String get scriptFullConfig => 'Вся конфигурация';

  @override
  String get scriptChangesDescription =>
      'Поля верхнего уровня, добавленные, изменённые или удалённые скриптом. Полная конфигурация также включает настройки приложения.';

  @override
  String get scriptChangesEmpty => 'Скрипт не изменил конфигурацию';

  @override
  String scriptChangesAdded(int count) {
    return 'Добавлено ($count)';
  }

  @override
  String scriptChangesModified(int count) {
    return 'Изменено ($count)';
  }

  @override
  String scriptChangesRemoved(int count) {
    return 'Удалено ($count)';
  }

  @override
  String get excludeNetworks => 'Приостановка прокси по IP или шлюзу';

  @override
  String get excludeNetworksDesc =>
      'Пауза при совпадении IPv4, подсети или шлюза Wi-Fi/Ethernet; возобновление после выхода. Через запятую: 192.168.1.0/24,gateway:192.168.1.1';

  @override
  String get excludeNetworksInvalid =>
      'До 16 правил: допустимые IPv4, CIDR или gateway:адрес';

  @override
  String get delayConcurrency => 'Параллельные проверки в группе';

  @override
  String get delayTestFailed => 'Ошибка проверки';

  @override
  String get updateReleaseNotes => 'Что нового';

  @override
  String get updateDownloadConfirm => 'Скачать обновление';

  @override
  String get updateLater => 'Позже';

  @override
  String get updateCancelDownload => 'Отменить загрузку';

  @override
  String get updateNotice => 'Обнаружена новая версия';

  @override
  String updateVersionNumber(String version) {
    return 'Версия: $version';
  }

  @override
  String updateBuildNumber(String build) {
    return 'Номер сборки: $build';
  }

  @override
  String get updateReleaseNotesFailed =>
      'Не удалось загрузить список изменений. Повторите попытку.';

  @override
  String get tailscaleEntryHint => 'Доступ к устройствам в вашей сети tailnet';

  @override
  String get tailscaleEmptyTitle => 'Доступ к вашей сети tailnet';

  @override
  String get tailscaleEmptyDesc =>
      'Добавьте сеть, войдите на этом устройстве и запустите прокси, чтобы получить доступ к своим устройствам.';

  @override
  String get tailscaleAddNetwork => 'Добавить сеть';

  @override
  String get tailscaleNetworks => 'Сети';

  @override
  String get tailscaleGuide => 'Инструкция';

  @override
  String get tailscaleThisDevice => 'Это устройство';

  @override
  String get tailscaleStatus => 'Состояние';

  @override
  String get tailscaleDeviceName => 'Имя устройства';

  @override
  String tailscaleDevices(Object count) {
    return 'Устройства ($count)';
  }

  @override
  String get tailscaleNetworkName => 'Название сети';

  @override
  String get tailscaleNameInUse => 'Это имя уже используется';

  @override
  String get tailscaleLoginMethod => 'Способ входа';

  @override
  String get tailscaleInteractiveLogin => 'Интерактивный';

  @override
  String get tailscaleAuthKey => 'Ключ авторизации';

  @override
  String get tailscaleAuthKeySaved =>
      'На этом устройстве сохранён ключ авторизации. Введите новый, чтобы заменить его.';

  @override
  String get tailscaleLoginFooter =>
      'Достаточно один раз войти в каждую сеть на этом устройстве.';

  @override
  String get tailscaleAutoRoute => 'Автоматическая маршрутизация';

  @override
  String get tailscaleAutoRouteDesc =>
      'Направлять адреса узлов, имена MagicDNS и одобренные подсети через эту сеть';

  @override
  String get tailscaleExitNode => 'Выходной узел';

  @override
  String get tailscaleExitNodeDesc =>
      'Оставьте пустым, чтобы не использовать, или укажите auto, имя узла либо его IP-адрес.';

  @override
  String get tailscaleAvailableExitNodes => 'Доступные выходные узлы';

  @override
  String get tailscaleExitNodeAllowLan => 'Разрешить доступ к локальной сети';

  @override
  String get tailscaleAdvanced => 'Дополнительно';

  @override
  String get tailscaleControlUrl => 'Адрес сервера управления';

  @override
  String get tailscaleCredentialsFooter =>
      'Данные авторизации и идентификатор устройства хранятся только на этом устройстве.';

  @override
  String get tailscaleAccount => 'Аккаунт';

  @override
  String get tailscaleSaveAndLogin => 'Сохранить и войти';

  @override
  String get tailscaleOpenLoginPage => 'Открыть страницу входа';

  @override
  String get tailscaleLoginWaiting =>
      'Откройте страницу входа или отсканируйте код. Вход завершится автоматически после подтверждения.';

  @override
  String get tailscaleSigningIn => 'Выполняется вход';

  @override
  String get tailscaleSignedIn => 'Вход выполнен';

  @override
  String get tailscaleLogout => 'Выйти';

  @override
  String get tailscaleLoginFailed => 'Не удалось войти в Tailscale';

  @override
  String get tailscaleLoginTimeout =>
      'Вход не был завершён за пять минут. Попробуйте ещё раз.';

  @override
  String get tailscaleLoginHint =>
      'Вход авторизует это устройство. Чтобы пользоваться сетью, запустите прокси.';

  @override
  String get tailscaleEnterAuthKey =>
      'Введите ключ авторизации, чтобы войти на этом устройстве.';

  @override
  String tailscaleCheckSettings(Object fields) {
    return 'Проверьте настройки: $fields';
  }

  @override
  String get tailscaleNotApplied => 'Не применено';

  @override
  String get tailscaleNotAppliedHint =>
      'Сеть не входит в текущую конфигурацию. Выберите профиль и убедитесь, что в нём нет узла с таким же именем.';

  @override
  String get tailscaleNotSignedIn => 'Вход не выполнен';

  @override
  String get tailscaleNeedsLogin => 'Требуется вход';

  @override
  String get tailscaleKeyExpired => 'Срок действия ключа узла истёк';

  @override
  String get tailscaleNeedsApproval => 'Ожидается одобрение устройства';

  @override
  String get tailscaleConnecting => 'Подключение';

  @override
  String get tailscaleConnected => 'Подключено';

  @override
  String get tailscaleStopped => 'Остановлено';

  @override
  String get tailscaleUnavailable => 'Подключение недоступно';

  @override
  String get tailscaleOnline => 'В сети';

  @override
  String get tailscaleOffline => 'Не в сети';

  @override
  String get tailscaleRemoveNetwork => 'Удалить сеть';

  @override
  String tailscaleRemoveConfirm(Object name) {
    return 'Это устройство выйдет из сети $name, а данные входа будут удалены с него. Если сеть сейчас недоступна, удалите устройство в консоли администратора Tailscale.';
  }

  @override
  String tailscaleNetworkInUse(Object name, Object profile) {
    return '$name все еще используется правилом или группой в профиле «$profile»';
  }

  @override
  String get tailscaleGuideGetStarted => 'Начало работы';

  @override
  String get tailscaleGuideGetStartedBody =>
      'Добавьте сеть и выберите «Сохранить и войти». Откройте страницу входа и авторизуйте это устройство — вход завершится сам.\nЧтобы войти по ключу авторизации, выберите «Ключ авторизации» и введите его. Браузер не нужен.\nСеть работает только при запущенном прокси. Сам по себе вход не перенаправляет трафик.';

  @override
  String get tailscaleGuideDevices => 'Устройства и MagicDNS';

  @override
  String get tailscaleGuideDevicesBody =>
      'Автоматическая маршрутизация направляет в эту сеть адреса и имена MagicDNS известных узлов, а также подсети, одобренные в tailnet. Остальной трафик идёт по вашим правилам.\nОна применяется после добавленных и пользовательских правил и до собственных правил профиля.\nС собственным доменом сервера управления маршрутизируются только известные имена устройств, поэтому публичные сайты домена остаются доступны.\nАдреса подсети внутри локальной сети этого устройства остаются локальными. Чтобы попасть в удалённую подсеть с теми же адресами, добавьте правило, указывающее на эту сеть.\nИмя хоста, которое разрешается в одобренную подсеть, тоже идёт через эту сеть. Если профиль сразу отдаёт такое имя прокси, добавьте доменное правило, указывающее на эту сеть.';

  @override
  String get tailscaleGuideExitNodes => 'Выходные узлы';

  @override
  String get tailscaleGuideExitNodesBody =>
      'Если указан выходной узел, сеть появляется в группах выбора профиля. Трафик идёт через него, только когда вы выберете сеть в группе или направите на неё правило.\nОставьте поле пустым, чтобы не использовать выходной узел. auto выбирает доступный выходной узел, имя или адрес устройства — конкретное устройство.';

  @override
  String get tailscaleGuideSignIn => 'Вход и резервное копирование';

  @override
  String get tailscaleGuideSignInBody =>
      'Настройки сети входят в резервную копию. Ключи авторизации и идентификатор устройства остаются только на этом устройстве, поэтому после восстановления на другом устройстве войдите снова.\nКогда истечёт срок ключа узла, снова выберите «Сохранить и войти». Одобрение устройств и доступ настраиваются в вашем tailnet.\nУдаление сети выполняет выход этого устройства и удаляет его идентификатор с этого устройства.';

  @override
  String get tailscaleGuideTroubleshooting => 'Устранение неполадок';

  @override
  String get tailscaleGuideTroubleshootingBody =>
      'Проверьте, что прокси запущен, устройство одобрено, а узел в сети. Для подсетей и интернета также проверьте одобрение маршрутов и выходной узел.\n«Не применено» означает, что текущая конфигурация не содержит сеть: выберите профиль и убедитесь, что в нём нет узла с таким же именем.\nПриложение только подключается к вашему tailnet: оно не принимает входящие соединения и не предлагает это устройство как маршрутизатор подсети или выходной узел.';

  @override
  String get tailscaleNameInvalid => 'Не более 64 символов, без запятых';

  @override
  String get tailscaleHostnameInvalid =>
      'Только строчные буквы, цифры и дефисы, не более 63 символов';

  @override
  String get tailscaleAuthKeyInvalid => 'Это не похоже на ключ авторизации';

  @override
  String get tailscaleDirect => 'Напрямую';

  @override
  String tailscaleRelay(Object region) {
    return 'Ретранслятор $region';
  }

  @override
  String get tailscaleExitNodeActive => 'Используемый выходной узел';

  @override
  String get quickAdd => 'Быстрое добавление';

  @override
  String get rulePresetBlockQuic => 'Блокировать QUIC';

  @override
  String get rulePresetBlockStun => 'Блокировать STUN';

  @override
  String get rulePresetBlockDot => 'Блокировать DNS over TLS';

  @override
  String get rulePresetBlockLoopback => 'Защита от петли прокси';

  @override
  String get rulePresetLanDirect => 'Локальная сеть напрямую';

  @override
  String get rulePresetSystemServicesDirect => 'Apple и Microsoft напрямую';

  @override
  String get rulePresetBittorrentDirect => 'BitTorrent напрямую';

  @override
  String get rulePresetInsertHint =>
      'Выбранные наборы добавляются перед существующими правилами. Одинаковые правила не дублируются.';

  @override
  String get overwriteIssueEmptyName => 'Имя не задано';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name — встроенное имя политики, его нельзя использовать';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return 'Имя $name уже занято другим прокси или группой прокси';
  }

  @override
  String get overwriteIssueNoProxySource =>
      'Не выбраны ни прокси, ни провайдеры прокси, поэтому ядро отклонит эту группу';

  @override
  String overwriteIssueMissingProxies(Object names) {
    return 'Эти прокси или политики не существуют: $names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return 'Эти провайдеры прокси не существуют: $names';
  }

  @override
  String overwriteIssueEmptyFallback(Object name) {
    return 'Резервный выход пустой группы должен быть существующим узлом или встроенным выходом, а не группой прокси: $name';
  }

  @override
  String overwriteIssueGroupLoop(Object path) {
    return 'Группы прокси ссылаются друг на друга по кругу: $path';
  }

  @override
  String invalidPolicy(Object target) {
    return '$target — недопустимая политика';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '$ruleSet — недопустимый набор правил';
  }

  @override
  String invalidSubRule(Object subRule) {
    return '$subRule — недопустимый SUB_RULE';
  }

  @override
  String get safeMode => 'Безопасный режим';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName (Безопасный режим)';
  }

  @override
  String get hideTimeoutProxies => 'Скрывать узлы с ошибкой проверки';

  @override
  String get delayTestQueued => 'В очереди';

  @override
  String get delayTestRunning => 'Проверка';

  @override
  String get dnsQueries => 'DNS-запросы';

  @override
  String get dnsQueriesDesc => 'Последние 500 запросов резолвера';

  @override
  String get dnsQueryCached => 'Из кеша';

  @override
  String get dnsQueryUpstream => 'Вышестоящий сервер';

  @override
  String get dnsQueryAnswers => 'Ответы';

  @override
  String get dnsQueryRcode => 'Код ответа';

  @override
  String get dnsQueryType => 'Тип запроса';

  @override
  String get pauseUpdates => 'Приостановить обновление';

  @override
  String get resumeUpdates => 'Возобновить обновление';

  @override
  String get dnsQueryAll => 'Все запросы';

  @override
  String get dnsQueryFailures => 'Неудачные запросы';

  @override
  String get dnsQueryInitiatorApp => 'Приложение';

  @override
  String get dnsQueryInitiatorRule => 'Подбор правила';

  @override
  String get dnsQueryInitiatorDirect => 'Прямое соединение';

  @override
  String get dnsQueryInitiatorProxy => 'Соединение с прокси';

  @override
  String get dnsQueryInitiatorOther => 'Другое';

  @override
  String get action_ruleMode => 'Режим правил';

  @override
  String get action_globalMode => 'Глобальный режим';

  @override
  String get action_directMode => 'Прямое подключение';

  @override
  String get action_delayTest => 'Проверить задержку узлов';

  @override
  String get action_updateProfiles => 'Обновить профили';

  @override
  String get action_copyEnv => 'Копировать переменные прокси';

  @override
  String get action_exit => 'Выход';

  @override
  String get hotkeyUnavailable => 'Не удалось зарегистрировать сочетание';

  @override
  String get runTime => 'Время работы';

  @override
  String get floatingNavigationBar => 'Плавающая навигация';

  @override
  String get localNetworkTip =>
      'Доступ к локальной сети не разрешён; для этого подключения используется gVisor. Прокси и сервисы в локальной сети могут оставаться недоступны';

  @override
  String get sidebar => 'Боковая панель';

  @override
  String get backgroundBlur => 'Размытие фона';

  @override
  String get sidebarBlurDesc =>
      'Размытие фона показывает рабочий стол за окном сквозь боковую панель.';

  @override
  String get format => 'Формат';

  @override
  String get behavior => 'Поведение';

  @override
  String get appProviderLibrary => 'Библиотека провайдеров';

  @override
  String get providerLocal => 'Локальный файл';

  @override
  String get providerRemote => 'Удалённый URL';

  @override
  String get providerContent => 'Содержимое ресурса';

  @override
  String get providerContentInvalid =>
      'Недопустимое содержимое или формат ресурса';

  @override
  String get providerContentTooLarge => 'Размер ресурса превышает 32 МиБ';

  @override
  String get providerChanged =>
      'Ресурс изменился во время редактирования. Откройте его снова';

  @override
  String get providerNameInvalid =>
      'Введите непустое имя без запятых и переводов строк';

  @override
  String providerInUse(String profiles) {
    return 'Ресурс используется в $profiles';
  }

  @override
  String providerRenameShadowed(String profiles) {
    return 'Переименование изменит ссылки в $profiles';
  }

  @override
  String get providerUrlTip =>
      'Введите HTTP/HTTPS URL без встроенных учётных данных';

  @override
  String providerSourceReference(String profiles) {
    return 'Перед переименованием измените ссылки в исходном профиле: $profiles';
  }

  @override
  String providerSourceUnavailable(String profiles) {
    return 'Не удалось прочитать профили для проверки ссылок: $profiles';
  }

  @override
  String get nodeDefinition => 'Определение узла';

  @override
  String get nodeQuickFields => 'Быстрое редактирование';

  @override
  String get nodeCoreValidationUnavailable =>
      'Запустите Core перед проверкой узла';

  @override
  String get nodeInvalidDefinition =>
      'Введите одно полное определение узла с name и type';

  @override
  String get releaseMemory => 'Освободить память';

  @override
  String get memoryCoreHeapInuse => 'Используемая куча';

  @override
  String get memoryCoreHeapIdle => 'Свободная куча';

  @override
  String get memoryCoreStack => 'Стеки горутин';

  @override
  String get memoryCoreRuntime => 'Накладные расходы среды';

  @override
  String get memoryCoreNotRunning => 'Ядро не запущено';

  @override
  String get memoryAppResident => 'Резидентная память';

  @override
  String get memoryAppShared => 'Приложение и общая';

  @override
  String get memoryEstimateDesc =>
      'Оценка по резидентной памяти процессов; может отличаться от данных системы.';

  @override
  String get memoryEstimateSharedDesc =>
      'Ядро работает в процессе приложения. Его доля оценивается по статистике среды выполнения, остальное относится к приложению и общей памяти.';

  @override
  String get memoryReleased => 'Память освобождена';

  @override
  String memoryReleasedSize(Object size) {
    return 'Освобождено $size';
  }

  @override
  String get releaseMemoryFailed => 'Не удалось освободить память';

  @override
  String get total => 'Всего';

  @override
  String get showNotificationStopAction => 'Кнопка остановки в уведомлении';

  @override
  String get interfaceName => 'Имя интерфейса';

  @override
  String get interfaceNameMode => 'Исходящий интерфейс';

  @override
  String get interfaceNameDesc =>
      'Имя интерфейса задаёт сетевой интерфейс для исходящих соединений';

  @override
  String get interfaceFollowProfile => 'Из профиля';

  @override
  String get interfaceAutomatic => 'Снять привязку (автовыбор интерфейса)';

  @override
  String get hideIp => 'Скрыть IP';

  @override
  String get cameraPermissionRequired => 'Требуется доступ к камере';

  @override
  String get cameraPermissionDesc =>
      'Разрешите доступ к камере в системных настройках, чтобы сканировать QR-коды, или выберите изображение QR-кода из галереи.';

  @override
  String get cameraUnavailable => 'Камера недоступна';

  @override
  String get invalidProfileQrcode =>
      'Этот QR-код не содержит ссылку на профиль';

  @override
  String get pickFromAlbum => 'Выбрать из галереи';

  @override
  String get retry => 'Повторить';

  @override
  String get toggleFlashlight => 'Переключить фонарик';

  @override
  String get networkTimeoutError =>
      'Время ожидания запроса истекло. Проверьте сеть или прокси и повторите попытку';

  @override
  String get networkHostLookupError =>
      'Не удалось определить адрес сервера. Проверьте правильность URL и работу DNS';

  @override
  String get monochromeIcon => 'Монохромный значок';

  @override
  String get networkConnectionError =>
      'Не удалось подключиться к серверу. Проверьте подключение к сети или настройки прокси';

  @override
  String get networkTlsError =>
      'Не удалось установить защищённое соединение. Сертификат сервера может быть недействителен, или соединение перехватывается';

  @override
  String get networkCancelledError => 'Запрос отменён';

  @override
  String networkAccessDeniedError(Object code) {
    return 'Сервер запретил доступ (HTTP $code). Возможно, ссылка устарела или учётные данные неверны';
  }

  @override
  String networkNotFoundError(Object code) {
    return 'По этому адресу ничего не найдено (HTTP $code). Проверьте правильность URL';
  }

  @override
  String get networkRateLimitedError =>
      'Слишком много запросов (HTTP 429). Подождите немного и повторите попытку';

  @override
  String networkServerError(Object code) {
    return 'На сервере произошла ошибка (HTTP $code). Повторите попытку позже';
  }

  @override
  String networkBadResponseError(Object code) {
    return 'Сервер отклонил запрос (HTTP $code)';
  }

  @override
  String get clipboardWriteFailed =>
      'Не удалось скопировать в буфер обмена. Возможно, выделение слишком велико';

  @override
  String get lineWrap => 'Перенос строк';

  @override
  String get previousMatch => 'Предыдущее совпадение';

  @override
  String get nextMatch => 'Следующее совпадение';

  @override
  String get editorUnavailable => 'Редактор недоступен';

  @override
  String get replaceAll => 'Заменить все';

  @override
  String get fontSize => 'Размер';

  @override
  String get replace => 'Заменить';

  @override
  String get locateSelected => 'Перейти к выбранному узлу';

  @override
  String get expandList => 'Развернуть';

  @override
  String get collapseList => 'Свернуть';

  @override
  String get clearSearch => 'Очистить поиск';

  @override
  String get closeAllConnections => 'Закрыть все соединения';

  @override
  String get showMore => 'Развернуть';

  @override
  String get showLess => 'Свернуть';

  @override
  String get showPassword => 'Показать пароль';

  @override
  String get hidePassword => 'Скрыть пароль';

  @override
  String get switchProfile => 'Сменить профиль';

  @override
  String get subscriptionInfo => 'Информация о подписке';

  @override
  String get lastUpdated => 'Последнее обновление';

  @override
  String proxiesCount(num count) {
    return '$count прокси';
  }

  @override
  String rulesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count правила',
      many: '$count правил',
      few: '$count правила',
      one: '$count правило',
    );
    return '$_temp0';
  }

  @override
  String get back => 'Назад';

  @override
  String get noSearchResults => 'Ничего не найдено';

  @override
  String get proxyNode => 'Прокси-узел';

  @override
  String get rules => 'Правила';

  @override
  String get addOverrideEntry => 'Добавить параметр';

  @override
  String get batchAdd => 'Массовое добавление';

  @override
  String get batchListInputTip =>
      'По одному значению на строку или через запятую';

  @override
  String get batchMapInputTip =>
      'По одной записи на строку: ключ, пробел, значение';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return 'Будет добавлено: $count, пропущено (уже есть): $skipped';
  }

  @override
  String get cacheAlgorithm => 'Алгоритм кэша';

  @override
  String get cacheMaxSize => 'Размер кэша';

  @override
  String get dialerProxy => 'Прокси для подключения';

  @override
  String get dialerProxyDesc =>
      'Прокси для подключения — исход, через который идёт обращение к NTP-серверу';

  @override
  String dialerProxyLoopStopped(Object name) {
    return 'Подключение через $name ведёт обратно к прокси, который его использует, поэтому соединение остановлено';
  }

  @override
  String get discardChanges => 'Отменить изменения?';

  @override
  String get fakeipFilterMode => 'Режим фильтра Fake-IP';

  @override
  String get fakeipFilterModeDesc =>
      'В режиме фильтра Fake-IP blacklist исключает совпадения, whitelist применяется только к ним, rule — по правилам';

  @override
  String get fakeipRange6 => 'Диапазон Fake-IP (IPv6)';

  @override
  String get fakeipTtl => 'TTL Fake-IP';

  @override
  String get ipv6Timeout => 'Тайм-аут IPv6 (мс)';

  @override
  String lineIssueTip(Object line, Object message) {
    return 'Строка $line: $message';
  }

  @override
  String get listenRoutingMark => 'Метка маршрутизации';

  @override
  String get listenRoutingMarkDesc =>
      'Метка маршрутизации действует только в Linux';

  @override
  String maxLengthTip(Object label, Object max) {
    return '«$label» — не более $max символов';
  }

  @override
  String get ntpInterval => 'Интервал синхронизации (минуты)';

  @override
  String get ntpStatusDesc =>
      'NTP берёт время с NTP-сервера, а не из системных часов';

  @override
  String get overrideEntries => 'Переопределяемые параметры';

  @override
  String get quickEdit => 'Быстрое редактирование';

  @override
  String get server => 'Сервер';

  @override
  String get singleAdd => 'По одному';

  @override
  String singleValueTip(Object label) {
    return '«$label» — только одно значение';
  }

  @override
  String get writeToSystem => 'Записывать в систему';

  @override
  String get writeToSystemDesc =>
      '«Записывать в систему» также устанавливает системные часы; Android это игнорирует';

  @override
  String get basicInfo => 'Основная информация';

  @override
  String get ruleActionIpSuffixDesc => 'Сопоставить диапазон суффиксов IP';

  @override
  String get ruleActionDomainSuffixDesc => 'Сопоставить суффикс домена';

  @override
  String get ruleActionMatchDesc =>
      'Сопоставляет все запросы, условия не нужны';

  @override
  String get ruleActionSrcGeoipDesc => 'Сопоставить код страны IP источника';

  @override
  String get ruleActionDomainWildcardDesc =>
      'Сопоставление по маске; поддерживаются только * и ?';

  @override
  String get ruleActionAndDesc => 'Логическое правило AND';

  @override
  String get ruleActionIpCidr6Desc =>
      'Сопоставить диапазон IP-адресов; IP-CIDR6 — просто псевдоним';

  @override
  String get ruleActionDomainRegexDesc =>
      'Сопоставить по регулярному выражению домена';

  @override
  String get ruleActionProcessPathRegexDesc =>
      'Сопоставить по регулярному выражению пути процесса';

  @override
  String get ruleActionDstPortDesc => 'Сопоставить диапазон портов назначения';

  @override
  String get ruleActionDscpDesc =>
      'Сопоставить метку DSCP (только для входящих tproxy UDP)';

  @override
  String get ruleActionInPortDesc => 'Сопоставить входящий порт';

  @override
  String get ruleActionUidDesc => 'Сопоставить Linux USER ID';

  @override
  String get ruleActionIpCidrDesc => 'Сопоставить диапазон IP-адресов';

  @override
  String get ruleActionRuleSetDesc =>
      'Ссылка на набор правил; требуется настроить rule-providers';

  @override
  String get ruleActionGeositeDesc => 'Сопоставить домены из Geosite';

  @override
  String get ruleActionNetworkDesc => 'Сопоставить TCP или UDP';

  @override
  String get ruleActionProcessPathDesc =>
      'Сопоставить по полному пути процесса';

  @override
  String get ruleActionProcessPathWildcardDesc =>
      'Сопоставить по маске пути процесса; поддерживаются только * и ?';

  @override
  String get ruleActionRematchNameDesc =>
      'Сопоставить имя повторного сопоставления; несколько имён разделяются /';

  @override
  String get ruleActionSrcIpSuffixDesc =>
      'Сопоставить диапазон суффиксов IP источника';

  @override
  String get ruleActionGeoipDesc => 'Сопоставить код страны IP-адреса';

  @override
  String get ruleActionInUserDesc =>
      'Сопоставить имя пользователя входящего подключения; несколько имён разделяются /';

  @override
  String get invalidNetworkContent => 'Поддерживаются только tcp и udp';

  @override
  String get ruleActionDomainKeywordDesc =>
      'Сопоставить ключевое слово в домене';

  @override
  String get ruleActionNotDesc => 'Логическое правило NOT';

  @override
  String get ruleActionSrcIpAsnDesc => 'Сопоставить ASN IP источника';

  @override
  String get invalidRangeContent =>
      'Введите числа или диапазоны, например 80 или 8000-9000, через /';

  @override
  String get ruleActionProcessNameRegexDesc =>
      'Сопоставить по регулярному выражению имени процесса; на Android соответствует имени пакета';

  @override
  String get ruleActionSrcIpCidrDesc =>
      'Сопоставить диапазон IP-адресов источника';

  @override
  String get ruleActionDomainDesc => 'Сопоставить полный домен';

  @override
  String get ruleActionInNameDesc => 'Сопоставить имя входящего подключения';

  @override
  String get invalidDscpContent => 'Метка DSCP не может превышать 63';

  @override
  String get invalidCidrContent =>
      'Введите диапазон IP в формате CIDR, например 192.168.0.0/16';

  @override
  String get invalidIpv6CidrContent =>
      'Введите диапазон IPv6 в формате CIDR, например fd00::/8';

  @override
  String get invalidHostContent => 'Введите домен или IP-адрес';

  @override
  String get invalidListenContent =>
      'Введите адрес и порт, например 0.0.0.0:1053';

  @override
  String get ruleActionIpAsnDesc => 'Сопоставить ASN, которой принадлежит IP';

  @override
  String get ruleActionSrcPortDesc => 'Сопоставить диапазон портов источника';

  @override
  String get ruleActionInTypeDesc => 'Сопоставить тип входящего подключения';

  @override
  String get ruleActionOrDesc => 'Логическое правило OR';

  @override
  String get ruleActionSubRuleDesc =>
      'Переход к подправилу; обратите внимание на скобки';

  @override
  String get ruleActionProcessNameWildcardDesc =>
      'Сопоставить по маске имени процесса; поддерживаются только * и ?';

  @override
  String get ruleActionProcessNameDesc =>
      'Сопоставить по имени процесса; на Android соответствует имени пакета';

  @override
  String get general => 'Общие';

  @override
  String get startupAndBackground => 'Запуск и фоновая работа';

  @override
  String get inbound => 'Входящие';

  @override
  String get outbound => 'Исходящие';

  @override
  String get logsAndDiagnostics => 'Логи и диагностика';

  @override
  String get onDemand => 'По условию';

  @override
  String get onDemandDesc =>
      '«По условию» приостанавливает и возобновляет прокси в зависимости от Wi-Fi или сетевых условий';

  @override
  String get prerequisites => 'Предварительные условия';

  @override
  String get suspended => 'Приостановлено…';

  @override
  String get enabled => 'Включено';

  @override
  String get enabledOnStart => 'Включится при запуске';

  @override
  String get disabled => 'Выключено';

  @override
  String overwriteIssuesSummary(Object count) {
    return 'Проблем: $count, применение переопределения может завершиться ошибкой';
  }

  @override
  String get ignoreBatteryOptimization => 'Игнорировать оптимизацию батареи';

  @override
  String get batteryOptimizationDesc =>
      'Игнорирование оптимизации батареи позволяет приложению работать в фоне';

  @override
  String get batteryOptimizationStatusTip =>
      'Из-за системных ограничений во время работы невозможно корректно получить статус оптимизации батареи';

  @override
  String get authorized => 'Разрешено';

  @override
  String get tapToAuthorize => 'Нажмите, чтобы разрешить';

  @override
  String get addSsid => 'Добавить SSID';

  @override
  String get editSsid => 'Изменить SSID';

  @override
  String get ssidsEmpty => 'Список SSID пуст';

  @override
  String get hotkeyDesc =>
      'Глобальные горячие клавиши работают, даже когда окно скрыто. Нажмите на действие, чтобы записать сочетание клавиш.';

  @override
  String get hotkeyNotSet => 'Не задано';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return 'Добавьте хотя бы одну из клавиш: $modifiers';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return 'Уже используется для «$action». При сохранении будет перенесено сюда.';
  }

  @override
  String get confirmExitWindow =>
      'Вы уверены, что хотите закрыть текущее окно?';

  @override
  String get dataChangedSave => 'Обнаружены изменения данных. Сохранить их?';

  @override
  String get discard => 'Не сохранять';

  @override
  String get docked => 'Закреплённая';

  @override
  String get fade => 'Растворение';

  @override
  String get floating => 'Плавающая';

  @override
  String get followSystem => 'Как в системе';

  @override
  String get navigationBarStyle => 'Нижняя панель';

  @override
  String get pureBlack => 'Чисто чёрный';

  @override
  String get slide => 'Сдвиг';

  @override
  String get textScalePreview => 'Так будет выглядеть текст в приложении';

  @override
  String get basicStrategy => 'Базовые политики';

  @override
  String get nonTextProviderFile =>
      'Этот внешний ресурс не является текстовым файлом';

  @override
  String get scriptChanged =>
      'Скрипт изменён или удалён. Откройте его заново и повторите попытку.';

  @override
  String get startFromScratch => 'С нуля';

  @override
  String get optional => 'Необязательно';

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Windows заблокировала FlClashCore.exe; Smart App Control включён. Проверьте сведения в разделе «Безопасность Windows → Управление приложениями и браузером» и используйте проверенный выпуск из доверенного источника.';

  @override
  String get helperCorruptTip =>
      'Служба Helper недоступна, поэтому TUN-режим включить нельзя. Переустановите FlClash.';

  @override
  String get changeProxyFailedTip =>
      'Не удалось переключить прокси; восстановлен предыдущий выбор';

  @override
  String get databaseWriteFailedTip =>
      'Не удалось сохранить изменение. Проверьте текущее значение и повторите попытку.';

  @override
  String get proxyType => 'Тип прокси';

  @override
  String get providerSourceSubscription => 'Подписка';

  @override
  String get providerSourceProfile => 'Профиль';

  @override
  String get providerSourceApp => 'Библиотека приложения';

  @override
  String get target => 'Цель';

  @override
  String get outboundExit => 'Выход';

  @override
  String get protocol => 'Протокол';

  @override
  String get traffic => 'Трафик';

  @override
  String get totalDownload => 'Скачано';

  @override
  String get totalUpload => 'Загружено';

  @override
  String get duration => 'Длительность';

  @override
  String get initiatorShort => 'Источник';

  @override
  String get result => 'Результат';

  @override
  String get elapsed => 'Время';

  @override
  String get tunOverrideDesc =>
      'Добавленные здесь параметры заменяют настройки TUN всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет';

  @override
  String get dnsOverrideDesc =>
      'Добавленные здесь параметры заменяют настройки DNS всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет';

  @override
  String get ntpOverrideDesc =>
      'Добавленные здесь параметры заменяют настройки NTP всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет';

  @override
  String get congestionController => 'Управление перегрузкой TCP';

  @override
  String get congestionControllerDesc =>
      'Управление перегрузкой TCP действует только со стеком mips';

  @override
  String get strictRoute => 'Строгая маршрутизация';

  @override
  String get strictRouteDesc =>
      'Строгая маршрутизация не даёт трафику вроде DNS обходить TUN, а при выключенном IPv6 блокирует IPv6-соединения этого устройства';

  @override
  String get routeExcludeAddress => 'Исключённые адреса маршрутов';

  @override
  String get udpTimeout => 'Тайм-аут UDP';

  @override
  String get udpTimeoutDesc =>
      'Тайм-аут UDP задаётся в секундах и действует только со стеками gvisor, system и mixed';

  @override
  String get dnsHijackDesc =>
      'Без этого параметра TUN перехватывает все DNS-запросы на порт 53 (any:53)';

  @override
  String get disableIcmpForwarding => 'Отключить пересылку ICMP';

  @override
  String get disableIcmpForwardingDesc =>
      'При отключённой пересылке ICMP TUN сам отвечает на ping, поэтому ping больше не показывает реальную задержку';

  @override
  String get includeInterface => 'Включённые интерфейсы';

  @override
  String get includeInterfaceDesc =>
      'Через TUN идёт только трафик с включённых интерфейсов, а исключённые интерфейсы больше не действуют';

  @override
  String get excludeInterface => 'Исключённые интерфейсы';

  @override
  String get excludeInterfaceDesc =>
      'Трафик с исключённых интерфейсов, например с docker0, идёт в обход TUN';

  @override
  String get includeUid => 'Включённые ID пользователей';

  @override
  String get includeUidDesc =>
      'Через TUN идёт только трафик процессов включённых ID пользователей';

  @override
  String get excludeUid => 'Исключённые ID пользователей';

  @override
  String get excludeUidDesc =>
      'Трафик процессов исключённых ID пользователей идёт в обход TUN';

  @override
  String get excludeSrcPort => 'Исключённые исходные порты';

  @override
  String get excludeSrcPortDesc =>
      'Трафик с исключённых исходных портов идёт в обход TUN';

  @override
  String get excludeDstPort => 'Исключённые порты назначения';

  @override
  String get excludeDstPortDesc =>
      'Трафик на исключённые порты назначения идёт в обход TUN';

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return 'Значение «$label» должно быть от $min до $max';
  }

  @override
  String get customProfile => 'Пользовательский профиль';

  @override
  String get customProfileDesc =>
      'Группы прокси и правила из своих узлов, библиотеки провайдеров и других профилей';

  @override
  String get emptyCustomProfile =>
      'Сначала добавьте в этот профиль группу прокси или правило';

  @override
  String get nameCustomProfileTip => 'Назовите этот профиль';

  @override
  String profileProviderInUse(Object profiles) {
    return 'Этот профиль — провайдер прокси в $profiles. Сначала удалите его там.';
  }

  @override
  String get healthCheck => 'Проверка состояния';

  @override
  String get additionalPrefix => 'Префикс имени';

  @override
  String get additionalSuffix => 'Суффикс имени';

  @override
  String get ipVersion => 'Версия IP';

  @override
  String get profileSettingsDesc =>
      'Действует только для этого профиля; не добавленные параметры используют значения по умолчанию';

  @override
  String get profileOverrideSettingsDesc =>
      'Действует только для этого профиля и имеет приоритет над переопределяемыми параметрами в настройках DNS и NTP приложения; не добавленные параметры следуют им';

  @override
  String get profileTunSettingsDesc =>
      'Действует только для этого профиля и имеет приоритет над переопределяемыми параметрами TUN в настройках сети';

  @override
  String get settingEntries => 'параметры';

  @override
  String get addSettingEntry => 'Добавить параметр';

  @override
  String settingsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count настройки',
      many: '$count настроек',
      few: '$count настройки',
      one: '$count настройка',
    );
    return '$_temp0';
  }

  @override
  String get sniffer => 'Сниффер';

  @override
  String get snifferStatusDesc =>
      'Сниффер определяет домен по трафику TLS, HTTP и QUIC, чтобы правила могли его сопоставить';

  @override
  String get overrideDestination => 'Подменять адрес назначения';

  @override
  String get overrideDestinationDesc =>
      '«Подменять адрес назначения» подключается к обнаруженному домену вместо исходного адреса';

  @override
  String get forceDnsMapping => 'Принудительно для DNS-сопоставлений';

  @override
  String get forceDnsMappingDesc =>
      '«Принудительно для DNS-сопоставлений» анализирует и соединения, домен которых получен из DNS-сопоставления';

  @override
  String get parsePureIp => 'Разбирать чистые IP';

  @override
  String get parsePureIpDesc =>
      '«Разбирать чистые IP» анализирует соединения, у которых есть только IP-адрес';

  @override
  String get forceDomain => 'Принудительные домены';

  @override
  String get forceDomainDesc =>
      'Принудительные домены тоже анализируются; остальные соединения с доменом не затрагиваются';

  @override
  String get skipDomain => 'Пропускаемые домены';

  @override
  String get skipDomainDesc =>
      'Обнаруженный домен из пропускаемых доменов не используется';

  @override
  String get skipSrcAddress => 'Пропускаемые адреса источника';

  @override
  String get skipDstAddress => 'Пропускаемые адреса назначения';

  @override
  String get sniffProtocols => 'Протоколы';

  @override
  String get ports => 'Порты';

  @override
  String get invalidPortRangeContent =>
      'Введите порт или диапазон, например 443 или 8000-9000';

  @override
  String get importConfig => 'Импорт конфигурации';

  @override
  String get importText => 'Импорт из текста';

  @override
  String get importConfigInvalid =>
      'Это не конфигурация, которую можно импортировать';

  @override
  String get importConfigReplaceTip =>
      'Импорт заменит текущие узлы, группы прокси, правила и настройки этого профиля';

  @override
  String get customImportCloudRefused =>
      'Адреса oixCloud нельзя импортировать в пользовательский профиль';

  @override
  String get customImportNotImported => 'Не импортировано';

  @override
  String customImportDroppedSubRules(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Пользовательские профили не поддерживают подправила, поэтому отброшено $count правила SUB-RULE',
      many:
          'Пользовательские профили не поддерживают подправила, поэтому отброшено $count правил SUB-RULE',
      few:
          'Пользовательские профили не поддерживают подправила, поэтому отброшено $count правила SUB-RULE',
      one:
          'Пользовательские профили не поддерживают подправила, поэтому отброшено $count правило SUB-RULE',
    );
    return '$_temp0';
  }

  @override
  String customImportUnnamedProxies(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count прокси без имени или типа',
      many: '$count прокси без имени или типа',
      few: '$count прокси без имени или типа',
      one: '$count прокси без имени или типа',
    );
    return '$_temp0';
  }

  @override
  String failedItem(Object label, Object message) {
    return '$label: $message';
  }

  @override
  String shareLinkNodesAdded(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Из ссылок добавлено $count узла',
      many: 'Из ссылок добавлено $count узлов',
      few: 'Из ссылок добавлено $count узла',
      one: 'Из ссылок добавлен $count узел',
    );
    return '$_temp0';
  }

  @override
  String shareLinksNotRead(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Не удалось прочитать $count ссылки',
      many: 'Не удалось прочитать $count ссылок',
      few: 'Не удалось прочитать $count ссылки',
      one: 'Не удалось прочитать $count ссылку',
    );
    return '$_temp0';
  }

  @override
  String get connectionStats => 'Статистика подключений';

  @override
  String get connectionStatsDesc => 'Подключения, запросы и DNS-запросы';

  @override
  String get currentOutboundDesc => 'Содержит кнопку запуска, удалить нельзя';

  @override
  String get dashboardAddableSection => 'Можно добавить';

  @override
  String get dashboardReorderHint =>
      'Перетаскивайте карточки для изменения порядка; на сенсорном экране сначала нажмите и удерживайте';

  @override
  String get done => 'Готово';

  @override
  String get editDashboard => 'Изменить панель';

  @override
  String groupCount(num count) {
    return 'Групп: $count';
  }

  @override
  String get groupCountUnit => 'групп';

  @override
  String groupTimeoutCount(Object count) {
    return 'Тайм-аут: $count';
  }

  @override
  String get ipType => 'Тип';

  @override
  String get liveConnections => 'Активные соединения';

  @override
  String get memoryInfoDesc => 'Память приложения и ядра';

  @override
  String get networkTakeover => 'Перехват трафика';

  @override
  String get notRunning => 'Не запущено';

  @override
  String portValue(Object port) {
    return 'Порт $port';
  }

  @override
  String profileDaysLeft(num days) {
    return 'Осталось дней: $days';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    return 'Истекает $date, осталось дней: $days';
  }

  @override
  String profileUpdatedAt(Object time) {
    return 'Обновлено $time';
  }

  @override
  String get proxyGroupsAfterStart =>
      'Группы появятся здесь после запуска ядра';

  @override
  String get running => 'Работает';

  @override
  String get serviceFailed => 'Ошибка проверки';

  @override
  String get tapIconToRetry => 'Нажмите на значок, чтобы повторить';

  @override
  String trafficPeak(Object value) {
    return 'Пик $value';
  }

  @override
  String trafficTotal(Object value) {
    return 'Всего $value';
  }

  @override
  String get usedShort => 'использовано';

  @override
  String get disableKeepAlive => 'Отключить TCP keep-alive';

  @override
  String get keepAliveIdle => 'Простой TCP keep-alive';

  @override
  String get routingMark => 'Метка маршрутизации';

  @override
  String get minutes => 'минут';

  @override
  String yearsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count г. назад',
      many: '$count л. назад',
      few: '$count г. назад',
      one: '$count г. назад',
    );
    return '$_temp0';
  }

  @override
  String monthsAgoShort(num count) {
    return '$count мес. назад';
  }

  @override
  String daysAgoShort(num count) {
    return '$count дн. назад';
  }

  @override
  String hoursAgoShort(num count) {
    return '$count ч назад';
  }

  @override
  String minutesAgoShort(num count) {
    return '$count мин назад';
  }

  @override
  String get expireTime => 'Срок действия';

  @override
  String get runtimeConfig => 'Конфигурация выполнения';

  @override
  String proxyGroupsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count группы прокси',
      many: '$count групп прокси',
      few: '$count группы прокси',
      one: '$count группа прокси',
    );
    return '$_temp0';
  }

  @override
  String get confirmDeleteProxyGroup =>
      'Вы уверены, что хотите удалить эту группу прокси?';

  @override
  String invalidProxyProvider(Object providerName) {
    return '$providerName — недопустимый провайдер прокси';
  }

  @override
  String customIssuesSummary(Object count) {
    return 'Проблем: $count, применение профиля может завершиться ошибкой';
  }

  @override
  String sectionsInEffect(Object count) {
    return 'Действуют: $count';
  }

  @override
  String get emptyFallback => 'Резерв для пустой группы';

  @override
  String get testInterval => 'Интервал тестирования';

  @override
  String get testWhenUsed => 'Тестировать при использовании';

  @override
  String get defaultSelected => 'Выбор по умолчанию';

  @override
  String get hashByInUser => 'Хешировать по пользователю входящего подключения';

  @override
  String get nodes => 'Узлы';

  @override
  String get addNodes => 'Добавить узлы';

  @override
  String get autoInclude => 'Автоматическое включение';

  @override
  String get filters => 'Фильтры';

  @override
  String get inputProxyGroupName => 'Введите название группы прокси';

  @override
  String get definitionNotMap =>
      'Конфигурация должна быть YAML-словарём с полями name и type';

  @override
  String get additionalParameters => 'Дополнительные параметры';

  @override
  String get quickActions => 'Быстрые действия';

  @override
  String get ruleListInvalid =>
      'Правила должны быть YAML-списком, по одному правилу в элементе, например - DOMAIN,example.com,DIRECT';

  @override
  String get goToConfigureAddedRules =>
      'Перейти к настройке добавленных правил';

  @override
  String get large => 'Крупный';

  @override
  String get extraLarge => 'Очень крупный';

  @override
  String get matchCase => 'Учитывать регистр';

  @override
  String get regex => 'Регулярное выражение';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get error => 'Ошибка';

  @override
  String get iconSets => 'Наборы значков';

  @override
  String get localImage => 'Локальное изображение';

  @override
  String get label => 'Метка';

  @override
  String get iconSetsEmptyTip =>
      'Наборов значков пока нет. Добавьте их в разделе «Ресурсы пользовательских профилей → Наборы значков»';

  @override
  String get recommendedIcons => 'Рекомендуемые';

  @override
  String get customProfileResources => 'Ресурсы пользовательских профилей';

  @override
  String get importFromLink => 'Импорт по ссылке';

  @override
  String get sendFromPhone => 'Отправить с телефона';

  @override
  String get sendFromPhoneTip =>
      'Отсканируйте код камерой телефона и вставьте ссылку на открывшейся странице. Оба устройства должны быть в одной сети.';

  @override
  String get sendFromPhoneNoNetwork =>
      'Это устройство не подключено к локальной сети';

  @override
  String get sendFromPhonePermissionDenied =>
      'Чтобы получить ссылку с телефона, FlClash нужно разрешение «Устройства поблизости» для доступа к локальной сети. Включите его в настройках приложения.';

  @override
  String get sendFromPhonePageTitle => 'Отправить ссылку в FlClash';

  @override
  String get sendFromPhonePageHint => 'Ссылка на подписку или ссылка на прокси';

  @override
  String get send => 'Отправить';

  @override
  String get sendFromPhonePageSent =>
      'Отправлено. Подтвердите импорт на другом устройстве.';

  @override
  String get sendFromPhoneConfirmTitle => 'Импортировать ссылку с телефона?';

  @override
  String get shareQrcodeTip =>
      'Отсканируйте в FlClash на другом устройстве, чтобы импортировать этот профиль.';

  @override
  String get qrcodeTooLongTip =>
      'Ссылка слишком длинная для QR-кода. Используйте «Копировать ссылку».';

  @override
  String get invalidLinkTip =>
      'Это не ссылка на подписку и не ссылка на прокси';

  @override
  String get batchLinkInputTip => 'По одной ссылке на строку';

  @override
  String get link => 'Ссылка';

  @override
  String get allowedIps => 'Разрешённые IP';

  @override
  String get cipher => 'Шифр';

  @override
  String get clientFingerprint => 'Отпечаток клиента';

  @override
  String get requestHeaders => 'Заголовки запроса';

  @override
  String transportHeaders(Object transport) {
    return 'Заголовки $transport';
  }

  @override
  String get congestionControl => 'Управление перегрузкой';

  @override
  String get downloadBandwidth => 'Скорость загрузки';

  @override
  String get hopInterval => 'Интервал перескока';

  @override
  String get obfs => 'Обфускация';

  @override
  String get obfsHost => 'Хост обфускации';

  @override
  String get obfsMode => 'Режим обфускации';

  @override
  String get obfsParam => 'Параметр обфускации';

  @override
  String get obfsPassword => 'Пароль обфускации';

  @override
  String get plugin => 'Плагин';

  @override
  String get pluginHost => 'Хост плагина';

  @override
  String get pluginPath => 'Путь плагина';

  @override
  String get pluginUsername => 'Имя пользователя плагина';

  @override
  String get pluginPassword => 'Пароль плагина';

  @override
  String get pluginCipher => 'Шифр плагина';

  @override
  String get pluginMode => 'Режим плагина';

  @override
  String get portHopping => 'Перескок портов';

  @override
  String get preSharedKey => 'Общий ключ';

  @override
  String get privateKey => 'Закрытый ключ';

  @override
  String get privateKeyPassphrase => 'Пароль закрытого ключа';

  @override
  String get protocolParam => 'Параметр протокола';

  @override
  String get protocolVersion => 'Версия протокола';

  @override
  String get publicKey => 'Открытый ключ';

  @override
  String get remoteDnsResolve => 'Удалённое разрешение DNS';

  @override
  String get secretKey => 'Ключ';

  @override
  String get skipCertVerify => 'Пропускать проверку сертификата';

  @override
  String get transport => 'Транспорт';

  @override
  String get udpRelayMode => 'Режим ретрансляции UDP';

  @override
  String get uploadBandwidth => 'Скорость отдачи';

  @override
  String get username => 'Имя пользователя';

  @override
  String get networkName => 'Имя сети';

  @override
  String get networkSecret => 'Секрет сети';

  @override
  String get peers => 'Пиры';

  @override
  String get virtualIpv4 => 'Виртуальный IPv4';

  @override
  String get hostname => 'Имя хоста';

  @override
  String get exitNodes => 'Выходные узлы';

  @override
  String get ageSecretKey => 'Секретный ключ age';

  @override
  String get ageSecretKeyRequiredTip =>
      'Профиль зашифрован с помощью age, для расшифровки нужен секретный ключ age';

  @override
  String get ageDecryptFailedTip =>
      'Не удалось расшифровать профиль. Проверьте секретный ключ age и повторите попытку.';

  @override
  String get resetDns => 'Сбросить DNS';

  @override
  String get resetDnsSuccess => 'Состояние DNS очищено';

  @override
  String get resetDnsFailed =>
      'Не удалось сбросить DNS. Проверьте подключение к ядру и повторите попытку.';

  @override
  String resourceSizeLimitTip(Object limit) {
    return 'Размер ресурса превышает $limit';
  }

  @override
  String get ruleSetDetect => 'Определить формат и тип правил';

  @override
  String get ruleSetConvert => 'Преобразовать в MRS';

  @override
  String get ruleSetConvertRemote => 'Скачать как локальный MRS';

  @override
  String get ruleSetEmptyTip => 'В наборе правил нет пригодных записей';

  @override
  String get ruleSetMixedTip =>
      'В наборе смешаны домены и диапазоны IP. Для их объединения используйте правила classical';

  @override
  String get ruleSetInvalidTip =>
      'Не удалось прочитать набор правил. Проверьте формат и записи';

  @override
  String get ruleSetUnsupportedTip =>
      'Эти правила нельзя преобразовать в MRS без изменения их поведения';

  @override
  String get ruleSetBusyTip =>
      'Выполняется другая операция с набором правил. Повторите попытку позже';

  @override
  String get ruleSetNeedsConversionTip =>
      'Этот удалённый набор правил требует нормализации. Скачайте его как локальный MRS';

  @override
  String get ruleSetSizeTip =>
      'Набор правил превышает лимит обработки. Разделите его на меньшие наборы';

  @override
  String get providerLookupFailed =>
      'Не удалось прочитать активную конфигурацию узла. Обновите ресурс и повторите попытку.';

  @override
  String get lookupProxyConfig => 'Найти конфигурацию узла';

  @override
  String get tunDnsMode => 'Режим системного DNS';

  @override
  String get tunDnsModeDesc =>
      'Пустое значение сохраняет прежнее поведение. disabled не меняет DNS; native использует адрес TUN; hijack также перехватывает DNS других интерфейсов (Windows: strict-route, Linux: auto-redirect). В macOS явный режим имеет приоритет над автоматической настройкой DNS.';

  @override
  String get nodeShareLinkUnavailable =>
      'Этот узел нельзя представить ссылкой. Используйте поля или YAML';

  @override
  String shareLinkNodesPreserved(int count) {
    return 'Узлы, которые нельзя представить ссылкой ($count), останутся без изменений';
  }

  @override
  String get select => 'Выбрать';

  @override
  String get preferred => 'Предпочтительный';

  @override
  String get addToLocalProxies => 'Добавить в пользовательские узлы';

  @override
  String addedToLocalProxies(Object name) {
    return '«$name» добавлен в пользовательские узлы';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '«$name» уже есть в пользовательских узлах';
  }

  @override
  String get generalOverrideDesc =>
      'Добавленные здесь параметры заменяют соответствующие настройки всех профилей; остальные остаются такими, как в профиле, а если профиль их не задаёт, действуют значения ядра по умолчанию.';

  @override
  String get groupBy => 'Группировка';

  @override
  String get copyHost => 'Копировать хост';

  @override
  String get copyDestination => 'Копировать адрес назначения';

  @override
  String get closeConnection => 'Закрыть соединение';

  @override
  String get recentRequests => 'Последние запросы';

  @override
  String get root => 'Root';

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'Расшифровка HTTPS';

  @override
  String get httpCapture => 'Захват HTTP';

  @override
  String get httpCaptureDesc =>
      'Записывает запросы к хостам из списка имён хостов; их можно посмотреть в сведениях о соединении. Записи хранятся только в памяти.';

  @override
  String get httpCaptureNoHosts =>
      'Хосты не указаны, поэтому ничего не записывается. Добавьте их в поле «Имя хоста» на странице MITM или из сведений о соединении.';

  @override
  String get httpCaptureLimit => 'Максимум записей';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return 'Когда записей станет столько или они займут $memory памяти, самые старые удаляются первыми. От каждого тела сохраняются первые $body.';
  }

  @override
  String get httpRequests => 'HTTP-запросы';

  @override
  String get httpRequestsMissing =>
      'Запросы, отправленные до включения захвата или уже удалённые, не показаны.';

  @override
  String get httpRequestCleared => 'Запись этого запроса удалена';

  @override
  String get httpCaptureOff => 'Захват выключен';

  @override
  String get inProgress => 'Выполняется';

  @override
  String get method => 'Метод';

  @override
  String get originalUrl => 'Исходный URL';

  @override
  String get timeToFirstByte => 'Время до первого байта';

  @override
  String get requestBody => 'Тело запроса';

  @override
  String get response => 'Ответ';

  @override
  String get responseBody => 'Тело ответа';

  @override
  String get responseHeaders => 'Заголовки ответа';

  @override
  String get matchedRules => 'Сработавшие правила';

  @override
  String get overview => 'Обзор';

  @override
  String get viewAll => 'Показать всё';

  @override
  String get copyAsBase64 => 'Копировать как Base64';

  @override
  String get copyAsCurl => 'Копировать как cURL';

  @override
  String get copyRequest => 'Копировать запрос';

  @override
  String get copyResponse => 'Копировать ответ';

  @override
  String get copyResponseBody => 'Копировать тело ответа';

  @override
  String get httpBodyProtobufGuess =>
      'Прочитано как Protobuf без схемы: только номера полей, типы предполагаемые.';

  @override
  String get exportHar => 'Экспорт HAR';

  @override
  String get mitmAddRejectRule => 'Добавить правило блокировки';

  @override
  String get mitmAddMapLocalRule => 'Добавить правило локальной подмены';

  @override
  String get httpExportPrivateTitle => 'Содержит личные данные';

  @override
  String get httpExportPrivate =>
      'Запрос может содержать cookie, токены, пароли и данные форм. Проверьте, что и кому вы передаёте.';

  @override
  String get mitmRuleCopiedForStash =>
      'Этот модуль — переопределение Stash, поэтому правило скопировано, добавьте его вручную.';

  @override
  String get binaryData => 'Двоичные данные';

  @override
  String get httpBodyNotKept => 'Не записано: не хватало памяти.';

  @override
  String get httpBodyTruncated => 'Записано только начало тела.';

  @override
  String httpBodyUndecoded(Object encoding) {
    return 'Не удалось декодировать $encoding, показаны данные в том виде, в каком они были переданы.';
  }

  @override
  String get mitmEnableTip =>
      'FlClash сможет читать всё, что отправляется на расшифровываемые узлы, включая cookie и пароли. Включайте только для узлов, которые нужно перезаписывать.';

  @override
  String get generateCertificate => 'Создать сертификат';

  @override
  String get regenerateCertificate => 'Пересоздать сертификат';

  @override
  String get regenerateCertificateTip =>
      'Новый сертификат заменит текущий; FlClash по возможности удалит текущий из доверенных корневых сертификатов этого устройства. На каждое другое устройство, доверяющее текущему, нужно установить новый.';

  @override
  String get exportCertificate => 'Экспортировать сертификат';

  @override
  String get installCertificate => 'Установить в систему';

  @override
  String get installCertificateSuccess => 'Сертификат установлен';

  @override
  String validUntil(Object date) {
    return 'Действителен до $date';
  }

  @override
  String get mitmCertificateExportTip =>
      'Экспортируйте его и добавьте в доверенные на устройствах, трафик которых нужно расшифровывать.';

  @override
  String get mitmTrustReady => 'Доверенный';

  @override
  String get mitmTrustUntrusted => 'Доверие неполное';

  @override
  String get mitmTrustNotInstalled => 'Не установлен';

  @override
  String get mitmTrustChecking => 'Проверка…';

  @override
  String get mitmCertificateAndroidReadyTip =>
      'Расшифровываются только приложения, доверяющие пользовательским сертификатам, в основном браузеры.';

  @override
  String get mitmAndroidRootDesc =>
      'Без root можно расшифровать только приложения, доверяющие пользовательским сертификатам, в основном браузеры. С root — любые приложения.';

  @override
  String get mitmCertificateLinuxTip =>
      'В браузеры из Flatpak экспортированный сертификат нужно импортировать вручную.';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome и Firefox используют собственные хранилища сертификатов, для которых нужен certutil: $command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return 'Ещё не добавлен в: $stores';
  }

  @override
  String get mitmSystemStoreFailed =>
      'Не удалось добавить сертификат в доверенные корневые сертификаты системы';

  @override
  String get mitmRootUntilReboot =>
      'Не найден Magisk, KernelSU или APatch, чтобы сохранить сертификат. После перезагрузки устройства установите его снова.';

  @override
  String get mitmRootPendingReboot =>
      'Сертификат начнёт действовать после перезагрузки устройства.';

  @override
  String get mitmInstallSystemCaTip =>
      'Обнаружен root: сертификат будет добавлен в доверенные сертификаты системы как модуль Magisk, KernelSU или APatch «FlClash MITM CA». После этого ему будут доверять все приложения устройства, а любой, у кого есть его закрытый ключ, сможет расшифровать HTTPS-трафик устройства. Чтобы отменить это, создайте сертификат заново или удалите модуль в root-менеджере и перезагрузите устройство. Если в root отказано, сертификат будет установлен как пользовательский.';

  @override
  String get mitmInstallUserCaTip =>
      'Root не обнаружен: сертификат можно установить только как пользовательский. Расшифровываются только приложения, доверяющие пользовательским сертификатам, в основном браузеры; остальные не смогут подключиться к указанным узлам, поэтому не указывайте их узлы. Начиная с Android 11 установку нужно завершить вручную в настройках системы.';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return 'Файл $fileName сохранён в «Загрузки». Установите его в настройках: Безопасность › Шифрование и учётные данные › Установка сертификата › Сертификат ЦС.';
  }

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return 'Удалите старый сертификат $name в настройках: Безопасность › Шифрование и учётные данные › Надёжные учётные данные › Пользователь, затем установите новый.';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return 'Не удалось удалить старый сертификат $name. Удалите его из доверенных корневых сертификатов вручную.';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return 'Старый сертификат $name всё ещё среди доверенных системных сертификатов. Разрешите FlClash доступ root в менеджере root и создайте сертификат заново или удалите там модуль «FlClash MITM CA» и перезагрузите устройство.';
  }

  @override
  String get removeCertificate => 'Удалить сертификат';

  @override
  String get removeCertificateSuccess => 'Сертификат удалён';

  @override
  String get mitmSystemStoreRemoveFailed =>
      'Не удалось удалить сертификат из доверенных корневых сертификатов системы';

  @override
  String get mitmRemoveInSettings => 'Удалите в настройках';

  @override
  String mitmRemoveUserCertificateTip(Object name) {
    return 'Android не позволяет приложениям удалять пользовательские сертификаты. Удалите $name в настройках: Безопасность › Шифрование и учётные данные › Надёжные учётные данные › Пользователь.';
  }

  @override
  String get mitmCannotRemove => 'Не удалось удалить';

  @override
  String get mitmRemoveSystemCertificateTip =>
      'Сертификат добавлен в систему root-модулем «FlClash MITM CA». Разрешите FlClash доступ root в менеджере root и повторите попытку или удалите там модуль и перезагрузите устройство.';

  @override
  String get mitmDecryptHost => 'Расшифровывать этот хост';

  @override
  String mitmDecryptHostTip(Object host) {
    return 'Добавить $host в список имён хостов? FlClash сможет читать всё, что на него отправляется, включая cookie и пароли.';
  }

  @override
  String get mitmClientRefusedCertificate =>
      'Клиент отклонил сертификат. Установите сертификат или исключите этот хост, если приложение закрепляет свой сертификат.';

  @override
  String get mitmExcludeHost => 'Исключить из расшифровки';

  @override
  String mitmExcludeHostTip(Object host) {
    return 'Добавить -$host в начало списка имён хостов? После этого узел никогда не будет расшифровываться.';
  }

  @override
  String get urlRewrite => 'Перезапись URL';

  @override
  String get headerRewrite => 'Перезапись заголовков';

  @override
  String get bodyRewrite => 'Перезапись тела';

  @override
  String get mapLocal => 'Локальная подмена';

  @override
  String get requestBodyMock => 'Подмена тела запроса';

  @override
  String get clientSourceAddress => 'Адреса клиентов';

  @override
  String get skipVerifyHostname => 'Хосты без проверки сертификата';

  @override
  String get mitmModules => 'Модули';

  @override
  String get mitmModule => 'Модуль';

  @override
  String get mitmModuleInvalid =>
      'Это не модуль Surge, не плагин Loon, не фрагмент Quantumult X и не переопределение Stash';

  @override
  String get arguments => 'Аргументы';

  @override
  String get mitmRoutingRules => 'Правила маршрутизации';

  @override
  String get mitmIgnoredLines => 'Пропущенные строки';

  @override
  String get mitmModuleRulesDesc =>
      'Правила маршрутизации идут перед правилами профиля.';

  @override
  String get mitmRequestRulesDesc =>
      'Правила URL-REGEX и USER-AGENT модуля превращаются в перезаписи URL и проверяются для каждого запроса: для всех запросов по открытому HTTP, а для HTTPS — только для хостов из списка MITM.';

  @override
  String mitmModuleSystemTip(Object system) {
    return 'Написан для $system; некоторые строки могут не подходить к приложениям на этом устройстве.';
  }

  @override
  String mitmModuleRequirementTip(Object requirement) {
    return 'Модуль требует $requirement, а это устройство не удовлетворяет условию; он может работать не так, как задумано.';
  }

  @override
  String mitmExitModules(Object modules) {
    return 'Из модулей: $modules';
  }

  @override
  String get mitmModuleRiskTitle => 'Включить этот модуль?';

  @override
  String get mitmNetworkRisk =>
      'При создании конфигурации он меняет сетевые настройки ниже и имеет приоритет над тем, что вы задали для них в FlClash. Если выключить или удалить модуль, всё вернётся.';

  @override
  String mitmSkipVerifyRisk(Object hosts) {
    return 'После включения сертификаты серверов этих хостов больше не проверяются, и сервер, выдающий себя за них, останется незамеченным: $hosts';
  }

  @override
  String mitmClientSourceRisk(Object addresses) {
    return 'Расшифровывается трафик только этих клиентов: $addresses. При включённом TUN приложения этого устройства подключаются с адреса TUN и могут не попасть в список.';
  }

  @override
  String get mitmClientSourceTunTip =>
      'При включённом TUN приложения этого устройства подключаются с адреса TUN; если его нет в списке, их трафик не расшифровывается.';

  @override
  String get mitmNetworkChanges => 'Сетевые настройки';

  @override
  String mitmChangeReplace(Object values) {
    return 'Заменяется на $values';
  }

  @override
  String mitmChangeInsert(Object values) {
    return 'Добавляет $values в начало';
  }

  @override
  String mitmChangeAppend(Object values) {
    return 'Добавляет $values';
  }

  @override
  String get mitmChangeOverridesYours => 'Перекрывает вашу настройку';

  @override
  String mitmChangeReplacedBy(Object module) {
    return 'Перекрыто модулем $module';
  }

  @override
  String mitmSkipSection(Object section) {
    return 'Раздел [$section] не поддерживается';
  }

  @override
  String get mitmSkipSetting => 'Этот параметр не поддерживается';

  @override
  String get mitmSkipScriptType => 'Этот тип скриптов не поддерживается';

  @override
  String get mitmSkipRule => 'Этот тип правила не поддерживается';

  @override
  String get mitmSkipHttpRulePolicy =>
      'Правила URL-REGEX и USER-AGENT допускают только политику REJECT';

  @override
  String get mitmSkipFinalRule =>
      'Правила модуля идут первыми, поэтому финальное правило скрыло бы все последующие';

  @override
  String get mitmSkipDeviceRule =>
      'Этому правилу нужны сведения об устройстве или сети, которые FlClash не может получить';

  @override
  String get mitmSkipRequirement =>
      'Устройство не удовлетворяет условию этой строки';

  @override
  String get mitmSkipManagedCa =>
      'Сертификатом ЦС управляет FlClash; модуль не может его изменить';

  @override
  String get mitmSkipProxies =>
      'Модуль не может изменять прокси и группы прокси';

  @override
  String get mitmSkipAppOnly =>
      'Это функция исходного приложения, которой нет в FlClash';

  @override
  String get mitmSkipReflect =>
      'FlClash не может отправить пакеты обратно отправителю';

  @override
  String get mitmSkipConditional => 'Условные перезаписи не поддерживаются';

  @override
  String get mitmSkipSkipVerifyAll =>
      'Проверку сертификатов нельзя отключить для всех хостов';

  @override
  String get mitmSkipRelativeData =>
      'Файл из этой строки не прикреплён; укажите URL или прикрепите его';

  @override
  String get mitmSkipNotDownloaded => 'Его файл ещё не загружен';

  @override
  String get mitmSkipUnreadable => 'Эту строку не удалось прочитать';

  @override
  String get mitmAddLocalFile => 'Добавить локальный файл';

  @override
  String get mitmNewModule => 'Новый модуль';

  @override
  String get mitmAttachments => 'Вложения';

  @override
  String get mitmAttachmentsDesc =>
      'Строки ссылаются на вложения по имени файла, например script-path=a.js.';

  @override
  String mitmFileTooLarge(Object size) {
    return 'Файл больше $size МБ';
  }

  @override
  String get mitmSkipDisabled => 'Отключено аргументом';

  @override
  String get mitmSkipEvent => 'Это событие не поддерживается';

  @override
  String get mitmRunScript => 'Запустить сейчас';

  @override
  String get mitmScriptCron => 'По расписанию';

  @override
  String get mitmScriptEvent => 'Событие';

  @override
  String get mitmScriptGeneric => 'Общий';

  @override
  String get mitmExcluded => 'Исключено';

  @override
  String get mitmScriptNoOutput => 'Скрипт завершился без вывода';

  @override
  String get mitmScriptRiskTitle => 'Запускать скрипты этого модуля?';

  @override
  String get mitmModulesTurnedOff => 'Модули отключены';

  @override
  String mitmModuleTurnedOffDesc(Object name) {
    return 'Обновление $name принесло скрипты или сетевые изменения, на которые вы не соглашались';
  }

  @override
  String mitmModulesTurnedOffDesc(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Обновления $count модулей принесли скрипты или сетевые изменения, на которые вы не соглашались',
    );
    return '$_temp0';
  }

  @override
  String get mitmScriptRisk =>
      'Его скрипты читают и меняют трафик подходящих хостов, включая файлы cookie и токены, и могут сами отправлять запросы. Включайте, только если доверяете источнику. После включения его обновления применяются без повторного запроса.';

  @override
  String get mitmModuleUnreadableRisk =>
      'Не удалось прочитать файл модуля, поэтому неизвестно, что он меняет. Включайте, только если доверяете источнику.';

  @override
  String get skipServerCertVerify => 'Пропускать проверку сертификата сервера';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => 'Расшифровывать без локального доверия';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return 'Недействительно: $invalid из $total';
  }

  @override
  String failedCount(Object count) {
    return 'Ошибок: $count. Нажмите, чтобы посмотреть';
  }

  @override
  String get proxyServerNameserverDesc =>
      'Используется только для разрешения имён прокси-серверов.';

  @override
  String get proxyServerNameserverPolicyDesc =>
      'Совпавшие имена прокси-серверов используют указанный здесь DNS-сервер вместо Proxy Server Nameserver.';

  @override
  String get directNameserverDesc => 'Разрешает домены прямых соединений.';

  @override
  String get fakeipFilterDesc =>
      'Эти домены получают реальные IP вместо Fake-IP. В режиме whitelist Fake-IP получают только они.';

  @override
  String get fallbackFilterGeositeDesc =>
      'Домены из этих категорий GeoSite сразу разрешаются через Fallback.';

  @override
  String get fallbackFilterIpcidrDesc =>
      'Если Nameserver возвращает IP из этих диапазонов, используется ответ Fallback.';

  @override
  String get fallbackFilterDomainDesc =>
      'Эти домены сразу разрешаются через Fallback.';

  @override
  String get customResources => 'Пользовательские';

  @override
  String get proxyYieldsToSubscription =>
      'В подписке есть узел с таким именем, в этом профиле используется он';

  @override
  String get delayMeasurementUnknown => 'Время измерения неизвестно';

  @override
  String delayMeasuredAt(String time) {
    return 'Последний тест: $time';
  }

  @override
  String get delayMeasurementStale => 'Результат устарел; повторите тест';

  @override
  String get diagUdp => 'Доступность UDP';

  @override
  String get diagUdpReady => 'Обмен UDP выполнен успешно';

  @override
  String get diagUdpUnknown => 'Не удалось подтвердить доступность UDP';

  @override
  String get diagUdpUnsupported => 'Текущий маршрут не поддерживает UDP';

  @override
  String get diagUdpHint =>
      'Тест следует текущим правилам маршрутизации. Тайм-аут может быть вызван сервером или сетью и не доказывает блокировку всего UDP.';

  @override
  String get diagTimeline => 'Последние операции';

  @override
  String diagTimelineEvent(
    String time,
    String stage,
    String result,
    String code,
  ) {
    return '$time · $stage · $result $code';
  }

  @override
  String get diagStageFetch => 'Получение конфигурации';

  @override
  String get diagStageValidate => 'Проверка конфигурации';

  @override
  String get diagStageApply => 'Применение конфигурации';

  @override
  String get diagStageStart => 'Запуск VPN';

  @override
  String get diagStageStop => 'Остановка VPN';

  @override
  String get diagEventStarted => 'Начато';

  @override
  String get diagEventSucceeded => 'Успешно';

  @override
  String get diagEventFailed => 'Ошибка';

  @override
  String get diagEventUnchanged => 'Содержимое не изменилось';

  @override
  String get diagEventCanceled => 'Отменено';

  @override
  String get diagRecorded => 'История';

  @override
  String mixedPortReset(Object value, Object port) {
    return 'Смешанный порт не может быть $value, поэтому он возвращён на $port';
  }

  @override
  String get coreStoppedDesc => 'Приложение потеряло связь с ядром';

  @override
  String coreStoppedWithReason(Object reason) {
    return 'Приложение потеряло связь с ядром: $reason';
  }

  @override
  String get vpnPermissionNotGranted =>
      'Разрешение на VPN не выдано, поэтому VPN не запущен. Постоянная VPN, заданная для другого приложения, тоже мешает запуску.';

  @override
  String get vpnServiceStartFailed => 'Не удалось запустить службу VPN.';
}
