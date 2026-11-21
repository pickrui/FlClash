// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get applyNow => 'Aplicar ahora';

  @override
  String get rule => 'Regla';

  @override
  String get global => 'Global';

  @override
  String get direct => 'Directo';

  @override
  String get dashboard => 'Panel';

  @override
  String get proxies => 'Proxies';

  @override
  String get profile => 'Perfil';

  @override
  String get profiles => 'Perfiles';

  @override
  String get tools => 'Herramientas';

  @override
  String get logs => 'Registros';

  @override
  String get logsDesc => 'Registro de eventos';

  @override
  String get resources => 'Recursos';

  @override
  String get resourcesDesc => 'Información de recursos externos';

  @override
  String get trafficUsage => 'Uso de tráfico';

  @override
  String get networkSpeed => 'Velocidad de red';

  @override
  String get outboundMode => 'Modo de salida';

  @override
  String get networkDetection => 'Diagnóstico de red';

  @override
  String get upload => 'Subida';

  @override
  String get download => 'Descarga';

  @override
  String get noProxy => 'Sin proxy';

  @override
  String get nullProfileDesc => 'No hay perfiles. Añada uno para empezar';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get defaultText => 'Predeterminado';

  @override
  String get more => 'Más';

  @override
  String get other => 'Otros';

  @override
  String get about => 'Acerca de';

  @override
  String get en => 'Inglés';

  @override
  String get ja => 'Japonés';

  @override
  String get ru => 'Ruso';

  @override
  String get fr => 'Francés';

  @override
  String get es => 'Español';

  @override
  String get ko => 'Coreano';

  @override
  String get zh_CN => 'Chino simplificado';

  @override
  String get theme => 'Tema';

  @override
  String get themeDesc => 'Configurar el modo oscuro y los colores';

  @override
  String get overrideLabel => 'Sobrescritura';

  @override
  String get allowLan => 'Permitir LAN';

  @override
  String get tun => 'TUN';

  @override
  String get tunDesc => 'TUN solo funciona en modo administrador.';

  @override
  String get minimizeOnExit => 'Minimizar al salir';

  @override
  String get autoLaunch => 'Inicio automático';

  @override
  String get silentLaunch => 'Inicio silencioso';

  @override
  String get silentLaunchDesc => 'Iniciar en segundo plano';

  @override
  String get autoRun => 'Ejecución automática';

  @override
  String get autoRunDesc => 'Iniciar automáticamente al abrir la aplicación';

  @override
  String get logcat => 'Logcat';

  @override
  String get logcatDesc =>
      'Desactivar esta opción oculta la entrada de registros';

  @override
  String get accessControl => 'Control de acceso';

  @override
  String get accessControlDesc =>
      'Configurar el acceso de las aplicaciones al proxy';

  @override
  String get application => 'Aplicación';

  @override
  String get edit => 'Editar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get update => 'Actualizar';

  @override
  String get add => 'Añadir';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get hours => 'horas';

  @override
  String get seconds => 'segundos';

  @override
  String get qrcode => 'Código QR';

  @override
  String get qrcodeDesc => 'Escanear un código QR para obtener un perfil';

  @override
  String get url => 'URL';

  @override
  String get file => 'Archivo';

  @override
  String get name => 'Nombre';

  @override
  String get profileNameNullValidationDesc => 'Introduzca el nombre del perfil';

  @override
  String get profileUrlNullValidationDesc => 'Introduzca la URL del perfil';

  @override
  String get profileUrlInvalidValidationDesc =>
      'Introduzca una URL de perfil válida';

  @override
  String get autoUpdate => 'Actualización automática';

  @override
  String get autoUpdateInterval => 'Intervalo de actualización automática';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc =>
      'Introduzca el intervalo de actualización automática';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc =>
      'Introduzca un intervalo válido';

  @override
  String get themeMode => 'Modo del tema';

  @override
  String get themeColor => 'Color del tema';

  @override
  String get preview => 'Vista previa';

  @override
  String get auto => 'Automático';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get submit => 'Enviar';

  @override
  String createProfileFromUrlTip(Object url) {
    return '¿Quieres crear un perfil a partir de $url?';
  }

  @override
  String get create => 'Crear';

  @override
  String get pleaseUploadValidQrcode => 'Sube un código QR válido';

  @override
  String get blacklistMode => 'Modo lista negra';

  @override
  String get whitelistMode => 'Modo lista blanca';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get cancelSelectAll => 'Deseleccionar todo';

  @override
  String get appAccessControl => 'Control de acceso de apps';

  @override
  String get accessControlAllowDesc =>
      'Solo las apps seleccionadas usan la VPN';

  @override
  String get accessControlNotAllowDesc =>
      'Las apps seleccionadas quedan excluidas de la VPN';

  @override
  String get accessControlDisabledDesc =>
      'El control de acceso de apps está desactivado';

  @override
  String accessControlSelectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionadas',
      one: '$count seleccionada',
    );
    return '$_temp0';
  }

  @override
  String get profileParseErrorDesc => 'Error al analizar el perfil';

  @override
  String get proxyPort => 'Puerto del proxy';

  @override
  String get port => 'Puerto';

  @override
  String get logLevel => 'Nivel de registro';

  @override
  String get show => 'Mostrar';

  @override
  String get hide => 'Ocultar';

  @override
  String get exit => 'Salir';

  @override
  String get systemProxy => 'Proxy del sistema';

  @override
  String get custom => 'Personalizado';

  @override
  String get project => 'Proyecto';

  @override
  String get core => 'Núcleo';

  @override
  String get reverseEngineeringNotice =>
      'Se prohíben estrictamente la ingeniería inversa, la descompilación, el desensamblado y el análisis de esta aplicación asistido por IA.';

  @override
  String get tabAnimation => 'Animación de pestañas';

  @override
  String get desc =>
      'Un cliente proxy multiplataforma basado en ClashMeta, sencillo de usar, de código abierto y sin anuncios.';

  @override
  String get startVpn => 'Iniciando VPN…';

  @override
  String get stopVpn => 'Deteniendo VPN…';

  @override
  String get discovery => 'Nueva versión disponible';

  @override
  String get compatible => 'Modo de compatibilidad';

  @override
  String get notSelectedTip =>
      'No se puede seleccionar el grupo de proxies actual';

  @override
  String get tip => 'Consejo';

  @override
  String get account => 'Cuenta';

  @override
  String get backup => 'Copia de seguridad';

  @override
  String get backupSuccess => 'Copia completada';

  @override
  String get noInfo => 'Sin información';

  @override
  String get pleaseBindWebDAV => 'Vincula WebDAV';

  @override
  String get bind => 'Vincular';

  @override
  String get connectivity => 'Conectividad: ';

  @override
  String get webDAVConfiguration => 'Configuración de WebDAV';

  @override
  String get address => 'Dirección';

  @override
  String get addressHelp => 'Dirección del servidor WebDAV';

  @override
  String get addressTip => 'Introduce una dirección WebDAV válida';

  @override
  String get password => 'Contraseña';

  @override
  String get checkUpdate => 'Buscar actualizaciones';

  @override
  String get checkUpdateError => 'La aplicación ya está actualizada';

  @override
  String get checkUpdateFailed =>
      'No se pudieron buscar actualizaciones. Compruebe la conexión y vuelva a intentarlo';

  @override
  String get unknown => 'Desconocido';

  @override
  String get search => 'Buscar';

  @override
  String get allowBypass => 'Permitir que las apps eludan la VPN';

  @override
  String get externalController => 'Controlador externo';

  @override
  String get externalControllerDesc =>
      'El controlador externo permite controlar el núcleo en la dirección configurada';

  @override
  String get openDashboard => 'Abrir el panel';

  @override
  String get ipv6Desc =>
      'El tráfico IPv6 solo se recibe mientras IPv6 esté activado.';

  @override
  String get autoIpv6 => 'IPv6 automático';

  @override
  String get autoIpv6Desc =>
      'Activar o desactivar IPv6 según la compatibilidad de la red local';

  @override
  String get app => 'App';

  @override
  String get unifiedDelay => 'Latencia unificada';

  @override
  String get tcpConcurrent => 'TCP concurrente';

  @override
  String get geodataLoader => 'Modo geo de poca memoria';

  @override
  String get requests => 'Solicitudes';

  @override
  String get requestsDesc => 'Ver solicitudes recientes y conexiones activas';

  @override
  String get findProcessMode => 'Buscar proceso';

  @override
  String get init => 'Inicio';

  @override
  String get infiniteTime => 'Sin caducidad';

  @override
  String get connections => 'Conexiones';

  @override
  String get intranetIP => 'IP de intranet';

  @override
  String get view => 'Ver';

  @override
  String get cut => 'Cortar';

  @override
  String get copy => 'Copiar';

  @override
  String get paste => 'Pegar';

  @override
  String get userAgent => 'User-Agent';

  @override
  String get testUrl => 'URL de prueba';

  @override
  String get delayTestTimeout => 'Tiempo de espera de la prueba de latencia';

  @override
  String get sync => 'Sincronizar';

  @override
  String get exclude => 'Ocultar de aplicaciones recientes';

  @override
  String get compact => 'Compacto';

  @override
  String get filter => 'Filtro';

  @override
  String get tab => 'Pestaña';

  @override
  String get list => 'Lista';

  @override
  String get delay => 'Latencia';

  @override
  String get style => 'Estilo';

  @override
  String get size => 'Tamaño';

  @override
  String get sort => 'Ordenar';

  @override
  String get columns => 'Columnas';

  @override
  String get proxyGroup => 'Grupo de proxies';

  @override
  String get go => 'Ir';

  @override
  String get externalLink => 'Enlace externo';

  @override
  String get autoCloseConnections => 'Cerrar conexiones automáticamente';

  @override
  String get autoCloseConnectionsDesc =>
      'Al cambiar de nodo, cerrar todas las conexiones o solo las que pasan por el grupo de proxies modificado, incluidos los grupos anidados';

  @override
  String get connectionCloseScope => 'Alcance del cierre de conexiones';

  @override
  String get closeCurrentGroupConnections => 'Solo el grupo de proxies actual';

  @override
  String get onlyStatisticsProxy => 'Contar solo el tráfico del proxy';

  @override
  String get pureBlackMode => 'Modo negro puro';

  @override
  String get keepAliveIntervalDesc => 'Intervalo de keep-alive TCP';

  @override
  String get entries => ' entradas';

  @override
  String secondsCount(Object count) {
    return '$count segundos';
  }

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos',
      one: '1 elemento',
    );
    return '$_temp0';
  }

  @override
  String get geoAutoUpdate => 'Actualización automática';

  @override
  String get geoAutoUpdateInterval => 'Intervalo de actualización automática';

  @override
  String get geoAutoUpdateIntervalTip =>
      'El intervalo debe estar entre 1 y 8760 horas';

  @override
  String get geoResources => 'Recursos Geo';

  @override
  String geoUpdating(Object name) {
    return 'Actualizando $name…';
  }

  @override
  String geoSkipped(Object name) {
    return '$name omitido';
  }

  @override
  String geoUpdated(Object name) {
    return '$name actualizado';
  }

  @override
  String get local => 'Local';

  @override
  String get remote => 'Remoto';

  @override
  String get remoteBackupDesc => 'Copiar los datos locales a WebDAV';

  @override
  String get localBackupDesc =>
      'Guardar una copia de los datos en este dispositivo';

  @override
  String get mode => 'Modo';

  @override
  String get time => 'Hora';

  @override
  String get source => 'Origen';

  @override
  String get action => 'Acción';

  @override
  String get intelligentSelected => 'Selección inteligente';

  @override
  String get clipboardNoPackageNames =>
      'No hay nombres de paquete válidos en el portapapeles';

  @override
  String get clipboardImport => 'Importar desde el portapapeles';

  @override
  String get clipboardExport => 'Exportar al portapapeles';

  @override
  String get layout => 'Diseño';

  @override
  String get tight => 'Ajustado';

  @override
  String get standard => 'Estándar';

  @override
  String get loose => 'Amplio';

  @override
  String get profilesSort => 'Orden de perfiles';

  @override
  String get start => 'Iniciar';

  @override
  String get stop => 'Detener';

  @override
  String get key => 'Clave';

  @override
  String get value => 'Valor';

  @override
  String get vpnTip => 'Los cambios se aplican al reiniciar la VPN';

  @override
  String get vpnEnableDesc =>
      'La VPN enruta automáticamente todo el tráfico del sistema a través de VpnService.';

  @override
  String get options => 'Opciones';

  @override
  String get loopback => 'Exención de loopback de UWP';

  @override
  String get providers => 'Proveedores';

  @override
  String get proxyProviders => 'Proveedores de proxies';

  @override
  String get ruleProviders => 'Proveedores de reglas';

  @override
  String get status => 'Estado';

  @override
  String get statusDesc => 'Con DNS desactivado, se usa el DNS del sistema.';

  @override
  String get preferH3Desc => 'Probar HTTP/3 primero para los servidores DoH';

  @override
  String get respectRules => 'Respetar reglas';

  @override
  String get respectRulesDesc =>
      'Encaminar las conexiones DNS según las reglas; requiere un servidor DNS para los nodos proxy';

  @override
  String get dnsMode => 'Modo DNS';

  @override
  String get fakeipRange => 'Rango Fake-IP';

  @override
  String get fakeipFilter => 'Filtro Fake-IP';

  @override
  String get defaultNameserver => 'Servidor DNS predeterminado';

  @override
  String get defaultNameserverDesc =>
      'Resuelve los nombres de los demás servidores DNS. Solo direcciones IP.';

  @override
  String get nameserver => 'Servidor DNS';

  @override
  String get nameserverDesc =>
      'Servidores DNS predeterminados, como 223.5.5.5, tls://1.1.1.1 o https://dns.google/dns-query.';

  @override
  String get useHosts => 'Usar hosts';

  @override
  String get useSystemHosts => 'Usar hosts del sistema';

  @override
  String get nameserverPolicy => 'Política de servidores DNS';

  @override
  String get nameserverPolicyDesc =>
      'Los dominios coincidentes usan el servidor DNS indicado aquí en lugar de Nameserver y Fallback.';

  @override
  String get proxyNameserver => 'DNS de los nodos proxy';

  @override
  String get fallback => 'DNS de respaldo';

  @override
  String get fallbackDesc =>
      'Se usan en lugar de Nameserver cuando el filtro de respaldo considera contaminada su respuesta.';

  @override
  String get preferH3 => 'Preferir HTTP/3';

  @override
  String get fallbackLazyQuery => 'Consulta diferida del DNS de respaldo';

  @override
  String get proxyNameserverPolicy => 'Política DNS de los nodos proxy';

  @override
  String get directNameserver => 'DNS de conexiones directas';

  @override
  String get directNameserverFollowPolicy =>
      'Aplicar la política al DNS directo';

  @override
  String get fallbackFilter => 'Filtro de respaldo';

  @override
  String get geoipCode => 'Código GeoIP';

  @override
  String get ipcidr => 'CIDR IP';

  @override
  String get domain => 'Dominio';

  @override
  String get reset => 'Restablecer';

  @override
  String get action_view => 'Mostrar/Ocultar';

  @override
  String get action_start => 'Iniciar/Detener';

  @override
  String get action_mode => 'Cambiar de modo';

  @override
  String get action_proxy => 'Proxy del sistema';

  @override
  String get action_tun => 'TUN';

  @override
  String get hotkeyManagement => 'Gestión de atajos';

  @override
  String get hotkeyManagementDesc => 'Controlar la aplicación con el teclado';

  @override
  String get pressKeyboard => 'Pulse una tecla.';

  @override
  String get remove => 'Quitar';

  @override
  String get noNetwork => 'Sin red';

  @override
  String get ipv6InboundDesc =>
      'Con IPv6 activado, la VPN permite el tráfico IPv6 entrante.';

  @override
  String get exportLogs => 'Exportar registros';

  @override
  String get exportSuccess => 'Exportación completada';

  @override
  String get iconStyle => 'Estilo de icono';

  @override
  String get iconStyleFilled => 'Relleno';

  @override
  String get iconStylePlain => 'Simple';

  @override
  String get iconStyleHidden => 'Oculto';

  @override
  String get stackMode => 'Modo de pila';

  @override
  String get network => 'Red';

  @override
  String get bypassDomain => 'Dominios excluidos';

  @override
  String get bypassDomainDesc =>
      'Los dominios excluidos solo se aplican mientras el proxy del sistema esté activado.';

  @override
  String get resetTip => 'Confirmar restablecimiento';

  @override
  String get icon => 'Icono';

  @override
  String get noData => 'Sin datos';

  @override
  String get fontFamily => 'Familia de fuente';

  @override
  String get installedFonts => 'Fuentes instaladas';

  @override
  String get toggle => 'Alternar';

  @override
  String get system => 'Sistema';

  @override
  String get bypassPrivateRoute => 'Omitir direcciones privadas';

  @override
  String get bypassPrivateRouteDesc =>
      'Con Omitir direcciones privadas activado, las direcciones de LAN, loopback y multidifusión no pasan por TUN.';

  @override
  String get routeAddress => 'Direcciones de ruta';

  @override
  String get pleaseInputAdminPassword =>
      'Introduzca la contraseña de administrador';

  @override
  String get tunAuthorizationFailed =>
      'No se pudo activar TUN porque se denegó la autorización de administrador. Acepte la solicitud de permiso del sistema y reintente.';

  @override
  String get tunHelperInstallFailed =>
      'No se pudo activar TUN: falló la instalación o el inicio del servicio auxiliar. Compruebe que la aplicación esté instalada por completo y que el servicio del sistema funcione, y vuelva a intentarlo.';

  @override
  String get tunAdminAccountRequired =>
      'TUN requiere una cuenta de administrador en este Mac. Inicie sesión con una para activarlo.';

  @override
  String get copyEnvVar => 'Copiar variables de entorno';

  @override
  String get memoryInfo => 'Información de memoria';

  @override
  String get dialog => 'Diálogo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get fileIsUpdate =>
      'El archivo se ha modificado. ¿Guardar los cambios?';

  @override
  String get profileHasUpdate =>
      'El perfil se ha modificado. ¿Desactivar la actualización automática?';

  @override
  String get copySuccess => 'Copiado';

  @override
  String get copyLink => 'Copiar enlace';

  @override
  String get exportFile => 'Exportar archivo';

  @override
  String get cacheCorrupt => 'La caché está dañada. ¿Borrarla?';

  @override
  String get listen => 'Escucha';

  @override
  String get undo => 'Deshacer';

  @override
  String get redo => 'Rehacer';

  @override
  String get none => 'Ninguno';

  @override
  String get required => 'Obligatorio';

  @override
  String get advancedConfig => 'Configuración avanzada';

  @override
  String get advancedConfigDesc =>
      'Acceder a diversas opciones de configuración';

  @override
  String get addRule => 'Añadir regla';

  @override
  String get ruleName => 'Nombre de la regla';

  @override
  String get content => 'Contenido';

  @override
  String get subRule => 'Subregla';

  @override
  String get ruleTarget => 'Destino de la regla';

  @override
  String get sourceIp => 'IP de origen';

  @override
  String get noResolve => 'No resolver IP';

  @override
  String get saveChanges => '¿Guardar los cambios?';

  @override
  String get findProcessModeAutomaticDesc =>
      'Buscar el proceso solo al comprobar una regla de proceso';

  @override
  String get monochromeScheme => 'Monocromo';

  @override
  String get colorStyle => 'Estilo de color';

  @override
  String get vividStyle => 'Vivo';

  @override
  String get tintedStyle => 'Tintado';

  @override
  String get softStyle => 'Suave';

  @override
  String get customColor => 'Color personalizado';

  @override
  String get grid => 'Cuadrícula';

  @override
  String get spectrum => 'Espectro';

  @override
  String get sliders => 'Reguladores';

  @override
  String get hue => 'Tono';

  @override
  String get saturation => 'Saturación';

  @override
  String get brightness => 'Brillo';

  @override
  String get hex => 'Hex';

  @override
  String get liquidGlass => 'Liquid Glass';

  @override
  String get ultra => 'Ultra';

  @override
  String get developerMode => 'Modo desarrollador';

  @override
  String get developerModeEnableTip => 'El modo desarrollador está activado.';

  @override
  String get messageTest => 'Prueba de mensaje';

  @override
  String get messageTestTip => 'Esto es un mensaje.';

  @override
  String get crashTest => 'Prueba de fallo';

  @override
  String get clearData => 'Borrar datos';

  @override
  String get textScale => 'Escala del texto';

  @override
  String get internet => 'Internet';

  @override
  String get systemApp => 'Aplicaciones del sistema';

  @override
  String get noNetworkApp => 'Aplicaciones sin acceso a la red';

  @override
  String get restoreStrategy => 'Estrategia de restauración';

  @override
  String get restoreStrategy_override => 'Sobrescribir';

  @override
  String get restoreStrategy_compatible => 'Compatible';

  @override
  String get logsTest => 'Prueba de registros';

  @override
  String emptyTip(Object label) {
    return '$label no puede estar vacío';
  }

  @override
  String urlTip(Object label) {
    return '$label debe ser una URL';
  }

  @override
  String numberTip(Object label) {
    return '$label debe ser un número';
  }

  @override
  String get interval => 'Intervalo';

  @override
  String existsTip(Object label) {
    return '$label ya existe';
  }

  @override
  String deleteTip(Object label) {
    return '¿Desea eliminar $label?';
  }

  @override
  String deleteMultipTip(Object label) {
    return '¿Seguro que quieres eliminar los elementos seleccionados ($label)?';
  }

  @override
  String nullTip(Object label) {
    return 'Aún no hay ningún elemento ($label)';
  }

  @override
  String get script => 'Script';

  @override
  String get color => 'Color';

  @override
  String get rename => 'Renombrar';

  @override
  String get unnamed => 'Sin nombre';

  @override
  String get mixedPort => 'Puerto mixto';

  @override
  String get socksPort => 'Puerto SOCKS';

  @override
  String get redirPort => 'Puerto Redir';

  @override
  String get tproxyPort => 'Puerto TProxy';

  @override
  String portTip(Object label) {
    return '$label debe estar entre 1024 y 49151';
  }

  @override
  String get portConflictTip => 'Introduce un puerto diferente';

  @override
  String get portUnavailableTitle => 'Puerto no disponible';

  @override
  String portUnavailableMessage(Object port) {
    return 'No se pudo abrir el puerto mixto $port; otra aplicación podría estar usándolo. Cambie el puerto para volver a intentarlo de inmediato.';
  }

  @override
  String get saveAndRetry => 'Guardar y reintentar';

  @override
  String portSuggestionTip(Object port) {
    return 'Se ha introducido el puerto sugerido $port.';
  }

  @override
  String get portProxyAppTip =>
      'Si hay otra aplicación proxy en ejecución, ciérrela primero.';

  @override
  String get import => 'Importar';

  @override
  String get importFile => 'Importar desde archivo';

  @override
  String get importUrl => 'Importar desde URL';

  @override
  String get autoSetSystemDns => 'Configurar DNS del sistema automáticamente';

  @override
  String get suspendOnIdle => 'Pausar el proxy en reposo';

  @override
  String get suspendOnIdleDesc =>
      'Suspende el reenvío de tráfico y las comprobaciones de disponibilidad cuando la pantalla está apagada y el sistema inactivo. Puede interrumpir llamadas y audio en directo, y retrasar notificaciones';

  @override
  String details(Object label) {
    return 'Detalles de $label';
  }

  @override
  String get creationTime => 'Fecha de creación';

  @override
  String get process => 'Proceso';

  @override
  String get host => 'Host';

  @override
  String get destination => 'Destino';

  @override
  String get destinationGeoIP => 'GeoIP de destino';

  @override
  String get destinationIPASN => 'ASN de la IP de destino';

  @override
  String get specialProxy => 'Proxy especial';

  @override
  String get specialRules => 'Reglas especiales';

  @override
  String get remoteDestination => 'Destino remoto';

  @override
  String get networkType => 'Tipo de red';

  @override
  String get proxyChains => 'Cadenas de proxies';

  @override
  String get proxyChainWarning =>
      'Una cadena de proxies puede reducir considerablemente la velocidad. Déjela desactivada salvo que la necesite.';

  @override
  String get proxyChainInstruction =>
      'Ordene los saltos de entrada a salida. Cada salto puede ser un nodo o un grupo. Los proxies del grupo usan el salto anterior; los grupos anidados y DIRECT/REJECT no cambian. Tras guardar, la cadena aparece con su nombre como grupo de políticas en la lista de proxies y en los destinos de reglas. Las latencias del editor son referencias por salto; pruebe el grupo de la cadena para medir la ruta efectiva.';

  @override
  String get proxyChainMinimumNodes =>
      'Una cadena necesita una entrada y una salida';

  @override
  String get proxyChainMinimumNodesHint => 'Elija un nodo o grupo de salida.';

  @override
  String get proxyChainPolicyGroups => 'Grupos de política';

  @override
  String get proxyChainUnsupportedGroupTip =>
      'Solo se admiten grupos select, url-test, fallback y load-balance en una cadena.';

  @override
  String get proxyChainEntry => 'Entrada';

  @override
  String get proxyChainExit => 'Salida';

  @override
  String get clearProxyChain => 'Borrar la cadena';

  @override
  String get proxyChainCustomNodes => 'Nodos personalizados';

  @override
  String get proxyChainCustomNode => 'Nodo personalizado';

  @override
  String get addProxyChainNode => 'Añadir';

  @override
  String get proxyChainOtherNodes => 'Otros nodos';

  @override
  String get proxyChainSavedAndApplied =>
      'Cadena guardada y aplicada. Selecciónela por su nombre en las reglas o en la lista de proxies.';

  @override
  String proxyChainConflictTip(Object name) {
    return 'El proxy $name entra en conflicto con otra cadena activa o crea un bucle';
  }

  @override
  String proxyChainUnavailableNodeTip(Object name) {
    return 'El proxy $name no está disponible en esta posición';
  }

  @override
  String proxyChainUnavailableReference(Object chainName, Object nodeName) {
    return 'El nodo o grupo de políticas «$nodeName» de la cadena de proxies «$chainName» no está disponible. Vuelva a seleccionarlo en «Cadenas de proxies» o desactive esta cadena.';
  }

  @override
  String get proxyChainRelatedChainsUpdated =>
      'Cadenas relacionadas actualizadas';

  @override
  String get proxyChainSelectedNodes => 'Cadena de proxies';

  @override
  String get proxyChainAvailableNodes => 'Nodos y grupos disponibles';

  @override
  String get proxyChainEmpty => 'No hay nodos en la cadena';

  @override
  String get proxyChainNodeAdded => 'Nodo añadido a la cadena';

  @override
  String get proxyChainUriNodeSupportedFormats =>
      'Formatos compatibles: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://';

  @override
  String get log => 'Registro';

  @override
  String get connection => 'Conexión';

  @override
  String get request => 'Solicitud';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get connecting => 'Conectando…';

  @override
  String get restartCoreTip => '¿Seguro que quieres reiniciar el núcleo?';

  @override
  String get forceRestartCoreTip =>
      '¿Seguro que quieres forzar el reinicio del núcleo?';

  @override
  String get dnsHijacking => 'Secuestro de DNS';

  @override
  String get coreStatus => 'Estado del núcleo';

  @override
  String get liveStatus => 'Estado en vivo';

  @override
  String liveStatusPosition(Object index, Object count) {
    return '$index de $count';
  }

  @override
  String get liveStatusTest => 'Prueba de tarjetas de estado en vivo';

  @override
  String get coreStopped => 'Núcleo detenido';

  @override
  String get restartCore => 'Reiniciar núcleo';

  @override
  String get coreStarting => 'Iniciando núcleo';

  @override
  String get coreStartingDesc => 'Conectando con el núcleo';

  @override
  String get coreRunning => 'Núcleo en ejecución';

  @override
  String get coreRunningDesc => 'La app está conectada al núcleo';

  @override
  String get forceRestartCore => 'Forzar reinicio';

  @override
  String get forceRestartCoreAsk => '¿Forzar el reinicio del núcleo?';

  @override
  String get forceRestartCoreAskDesc => 'Las conexiones en curso se cortarán';

  @override
  String get stopUpdateDownloadTip =>
      '¿Detener la descarga de la actualización?';

  @override
  String get stopUpdateDownloadDesc => 'Se borra lo ya descargado';

  @override
  String get stopDownload => 'Detener';

  @override
  String get coreNotConnected => 'El núcleo no está conectado';

  @override
  String get appendSystemDns => 'Añadir DNS del sistema';

  @override
  String get blockQuic => 'Bloquear QUIC';

  @override
  String get blockQuicDesc =>
      'Rechazar el tráfico UDP del puerto 443 para forzar el uso de TCP';

  @override
  String get blockWebRtc => 'Bloquear WebRTC';

  @override
  String get blockWebRtcDesc =>
      'Rechazar el tráfico STUN para reducir las fugas de IP por WebRTC.';

  @override
  String get editRule => 'Editar regla';

  @override
  String get overrideMode => 'Modo de sobrescritura';

  @override
  String get standardModeDesc =>
      'Modo Estándar: ejecuta opcionalmente un script de sobrescritura y luego añade reglas a la configuración';

  @override
  String get addedRulesAfterScript =>
      'Se insertan tras ejecutar el script, antes de las reglas del perfil';

  @override
  String get addedRules => 'Reglas añadidas';

  @override
  String get controlGlobalAddedRules =>
      'Controlar las reglas añadidas globales';

  @override
  String get overrideScript => 'Script de sobrescritura';

  @override
  String get goToConfigureScript => 'Configurar script';

  @override
  String get editGlobalRules => 'Editar reglas globales';

  @override
  String get confirmForceCrashCore =>
      '¿Seguro que quieres forzar el fallo del núcleo?';

  @override
  String get confirmClearAllData =>
      '¿Seguro que quieres borrar todos los datos?';

  @override
  String get loading => 'Cargando…';

  @override
  String yearsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count años',
      one: 'hace 1 año',
    );
    return '$_temp0';
  }

  @override
  String monthsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count meses',
      one: 'hace 1 mes',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count días',
      one: 'hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count horas',
      one: 'hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count minutos',
      one: 'hace 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Ahora mismo';

  @override
  String get turnOn => 'Activar';

  @override
  String get turnOff => 'Desactivar';

  @override
  String get vpnConfigChangeDetected =>
      'La configuración de la VPN cambió. Toca para reiniciar';

  @override
  String get restart => 'Reiniciar';

  @override
  String get speedStatistics => 'Estadísticas de velocidad';

  @override
  String get resetPageChangesTip =>
      'Esta página tiene cambios. ¿Desea restablecerla?';

  @override
  String get overwriteTypeCustom => 'Personalizado';

  @override
  String get overwriteTypeCustomDesc =>
      'Personalizar por completo los grupos de proxies y las reglas';

  @override
  String get emptyCustomOverwrite =>
      'La sobrescritura personalizada está vacía. Use el relleno rápido o añada reglas y grupos de proxies. Para conservar el contenido de la suscripción, use el modo Superposición.';

  @override
  String get proxyGroupEmpty => 'El grupo de proxies está vacío';

  @override
  String get proxyGroupNameEmpty =>
      'El nombre del grupo de proxies no puede estar vacío';

  @override
  String get ruleEmpty => 'La regla está vacía';

  @override
  String get confirmOverwriteTip =>
      'La confirmación sobrescribirá los datos existentes';

  @override
  String get configDataDetected => 'Se han detectado datos en la configuración';

  @override
  String get quickFill => 'Relleno rápido';

  @override
  String get clearCustomRouting => 'Borrar todo';

  @override
  String get confirmClearCustomRouting =>
      '¿Borrar los grupos de proxies y las reglas personalizados de este perfil? Se conservarán el contenido de la suscripción, las reglas añadidas, las cadenas de proxies y los nodos personalizados.';

  @override
  String get addProxyGroup => 'Añadir grupo de proxies';

  @override
  String get editProxyGroup => 'Editar grupo de proxies';

  @override
  String get lazy => 'Carga diferida';

  @override
  String get proxyFilter => 'Filtro de proxies';

  @override
  String get excludeProxyFilter => 'Filtro de exclusión de proxies';

  @override
  String get excludeType => 'Tipo que excluir';

  @override
  String get expectedStatus => 'Estado esperado';

  @override
  String get maxFailedTimes => 'Máximo de fallos';

  @override
  String get timeout => 'Tiempo agotado';

  @override
  String get strategy => 'Estrategia';

  @override
  String get iconUrl => 'URL del icono';

  @override
  String get disableUDP => 'Desactivar UDP';

  @override
  String get hideFromList => 'Ocultar de la lista';

  @override
  String get includeAll => 'Incluir todos los proxies y proveedores';

  @override
  String get includeAllProxies => 'Incluir todos los proxies';

  @override
  String get includeAllProxyProviders =>
      'Incluir todos los proveedores de proxies';

  @override
  String get proxyGroupMembersEmpty =>
      'Añada un proxy, un proveedor o una opción de inclusión total';

  @override
  String get tolerance => 'Tolerancia';

  @override
  String customOutboundInUse(Object name) {
    return '$name sigue referenciado por un grupo, una regla o una cadena de proxies';
  }

  @override
  String get relayGroupUnsupported =>
      'El núcleo ya no admite grupos Relay. Elija otro tipo.';

  @override
  String rawOutboundInUse(Object name, Object path) {
    return 'La configuración original hace referencia a $name en $path';
  }

  @override
  String get unknownNetworkError => 'Error de red desconocido';

  @override
  String get restoreException => 'Error de restauración';

  @override
  String get networkException =>
      'Error de red. Compruebe la conexión y vuelva a intentarlo';

  @override
  String get invalidBackupFile => 'Archivo de copia de seguridad no válido';

  @override
  String get backupFromNewerVersion =>
      'Esta copia de seguridad procede de una versión más reciente de la app. Actualiza la app antes de restaurarla';

  @override
  String get pruneCache => 'Depurar caché';

  @override
  String get backupAndRestore => 'Copia de seguridad y restauración';

  @override
  String get backupAndRestoreDesc =>
      'Sincronizar datos mediante WebDAV o archivos';

  @override
  String get restore => 'Restaurar';

  @override
  String get restoreDefault => 'Restaurar valores predeterminados';

  @override
  String get restoreSuccess => 'Restauración completada';

  @override
  String get restoreFromWebDAVDesc => 'Restaurar datos desde WebDAV';

  @override
  String get restoreFromFileDesc => 'Restaurar datos desde un archivo';

  @override
  String get restoreOnlyConfig =>
      'Restaurar solo los archivos de configuración';

  @override
  String get restoreAllData => 'Restaurar todos los datos';

  @override
  String get backupRetention => 'Copias que conservar';

  @override
  String get backupRetentionDesc =>
      'Cada copia elimina las copias antiguas de este dispositivo en WebDAV';

  @override
  String get selectBackup => 'Seleccionar una copia';

  @override
  String get noRemoteBackup => 'No hay copias en WebDAV';

  @override
  String get deleteBackupTip => '¿Eliminar esta copia de WebDAV?';

  @override
  String get addProfile => 'Añadir perfil';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get delayTest => 'Prueba de latencia';

  @override
  String get userCenter => 'Centro de usuario';

  @override
  String get userCenterFallback => 'Centro de usuario (alternativo)';

  @override
  String get userGuide => 'Guía de usuario';

  @override
  String get oixCloud => 'oixCloud';

  @override
  String get register => 'Registrarse';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerFailed => 'Error al registrarse';

  @override
  String get registerClosed => 'El registro está cerrado actualmente';

  @override
  String get haveAccountAlready => '¿Ya tiene una cuenta?';

  @override
  String get goLogin => 'Iniciar sesión';

  @override
  String get nicknameLabel => 'Apodo';

  @override
  String get nicknameHint => 'Letras y números, hasta 12 caracteres';

  @override
  String get nicknameValidation => 'Introduzca un apodo';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmPasswordHint => 'Vuelva a introducir su contraseña';

  @override
  String get confirmPasswordValidation => 'Confirme su contraseña';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden';

  @override
  String get passwordRuleHint =>
      'De 10 a 36 caracteres, con mayúscula, minúscula, número y símbolo';

  @override
  String get inviteCodeLabel => 'Código de invitación';

  @override
  String get inviteCodeHint => 'Introduzca el código de invitación';

  @override
  String get inviteCodeValidation => 'Introduzca el código de invitación';

  @override
  String get emailCodeLabel => 'Código por correo';

  @override
  String get emailCodeHint => 'Introduzca el código de 6 dígitos';

  @override
  String get emailCodeValidation => 'Introduzca el código recibido por correo';

  @override
  String get sendCode => 'Enviar código';

  @override
  String resendCodeIn(Object seconds) {
    return 'Reenviar en $seconds s';
  }

  @override
  String get codeSent => 'Código de verificación enviado';

  @override
  String get loggedOutViewTitle => 'oixCloud';

  @override
  String get loggedOutViewDesc =>
      'Inicie sesión para ver su cuenta y gestionar sus suscripciones';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get googleLoginWaiting =>
      'Complete el inicio de sesión con Google en el navegador';

  @override
  String get googleLoginUnavailable =>
      'No se pudo abrir el inicio de sesión con Google. Vuelva a intentarlo.';

  @override
  String get googleLoginTimedOut =>
      'Se agotó el tiempo para iniciar sesión con Google. Vuelva a intentarlo.';

  @override
  String get googleLoginInvalidCallback =>
      'No se pudo verificar el inicio de sesión con Google. Vuelva a intentarlo.';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get startCorePromptTitle => 'Confirmación';

  @override
  String get startCorePromptContent =>
      'Se ha importado el perfil. ¿Desea iniciar el núcleo ahora?';

  @override
  String get logoutTitle => 'Cerrar sesión';

  @override
  String get logoutContent => '¿Cerrar sesión?';

  @override
  String get loginSuccess => 'Sesión iniciada';

  @override
  String get getProfileSuccess => 'Perfil importado';

  @override
  String get startSuccess => 'Iniciado correctamente';

  @override
  String get loginFailed => 'Error al iniciar sesión';

  @override
  String get invalidCertificateTitle => 'Error de verificación del certificado';

  @override
  String get certificateExpired => 'El certificado ha caducado';

  @override
  String get certificateNotYetValid => 'El certificado aún no es válido';

  @override
  String get certificateHostnameMismatch =>
      'El certificado no coincide con el dominio solicitado';

  @override
  String get certificateUntrusted =>
      'La cadena de certificados no es de confianza';

  @override
  String get certificateValidityHint =>
      'Sincronice primero la fecha y la hora del sistema. Si son correctas, debe corregirse el certificado del servidor.';

  @override
  String get invalidCertificateContent =>
      'No se pudo verificar el certificado del servidor. Omitir la verificación puede permitir la suplantación del servidor y el robo o la alteración de las credenciales y los datos de suscripción que se intercambien.\n\nContinúe solo si confía en esta red y este servidor. La excepción se aplica únicamente a este intento, con el mismo servidor y certificado, y termina al finalizar la operación.';

  @override
  String get allowTemporarily => 'Permitir temporalmente';

  @override
  String get retryWithoutCertificateVerification =>
      'Comprobar la API temporalmente';

  @override
  String get apiAvailableWithCertificateException =>
      'La API fue accesible con una excepción temporal de certificado. No se sincronizaron la cuenta ni la configuración de nodos. Resuelva el problema del certificado y vuelva a comprobarlo.';

  @override
  String get certificateUntrustedHint =>
      'Pruebe otra red, como un punto de acceso móvil, y busque actualizaciones del sistema. Si un antivirus o una red de empresa inspecciona HTTPS, consulte a su administrador. Si persiste, pida al proveedor que revise la cadena de certificados.';

  @override
  String get certificateHostnameHint =>
      'Pruebe otra red y complete primero cualquier inicio de sesión Wi-Fi. Si persiste, pida al proveedor que compruebe que el certificado corresponda al dominio del servidor.';

  @override
  String get certificateRevokedHint =>
      'Pida al proveedor que sustituya el certificado revocado. Reintentar o cambiar la hora del sistema no resolverá el problema.';

  @override
  String get certificateUnknownHint =>
      'Compruebe la fecha y la hora del sistema y pruebe otra red. Si la verificación sigue fallando, envíe este error al proveedor para obtener ayuda.';

  @override
  String get certificateCheckOnlyHint =>
      'Esta acción solo comprueba el acceso a la API. No inicia sesión ni descarga la configuración de nodos.';

  @override
  String get certificateSyncRetryDescription =>
      'Tras confirmar, este intento comprueba la conexión, actualiza la cuenta y descarga la configuración de nodos. La excepción de certificado termina al finalizar la sincronización.';

  @override
  String get retryCloudSyncWithCertificateException =>
      'Permitir temporalmente y sincronizar';

  @override
  String get cloudSyncedWithCertificateException =>
      'La cuenta y la configuración se sincronizaron con una excepción temporal de certificado. La verificación se ha restablecido; resuelva el problema antes de la próxima sincronización.';

  @override
  String get cloudCertificateSyncFailed =>
      'La comprobación de la API fue correcta, pero falló la sincronización de la cuenta o los nodos: ';

  @override
  String get cloudConfigSyncIncomplete =>
      'No se descargó la configuración de nodos. Resuelva el error y vuelva a sincronizar.';

  @override
  String get emailPassword => 'Correo y contraseña';

  @override
  String get accessToken => 'Token de acceso';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'Introduzca su dirección de correo';

  @override
  String get emailValidation => 'Introduzca su correo';

  @override
  String get emailFormatValidation => 'Formato de correo no válido';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get forgotPassword => '¿Olvidó su contraseña?';

  @override
  String get resetPasswordTitle => 'Restablecer contraseña';

  @override
  String get sendResetEmail => 'Enviar correo de restablecimiento';

  @override
  String get resetEmailSent =>
      'Correo enviado. Pegue abajo el enlace o el código de restablecimiento recibido.';

  @override
  String get resetTokenLabel => 'Enlace o código de restablecimiento';

  @override
  String get resetTokenValidation =>
      'Introduzca el enlace o el código de restablecimiento';

  @override
  String get newPasswordLabel => 'Nueva contraseña';

  @override
  String get resetPasswordSuccess =>
      'Contraseña restablecida. Inicie sesión con la nueva contraseña';

  @override
  String get passwordValidation => 'Introduzca la contraseña';

  @override
  String get tokenLabel => 'Token de acceso';

  @override
  String get tokenValidation => 'Introduzca el token de acceso';

  @override
  String expireDate(Object date) {
    return 'Caduca: $date';
  }

  @override
  String get todayUsed => 'Uso de hoy';

  @override
  String remaining(Object value) {
    return 'Restante: $value';
  }

  @override
  String get balance => 'Saldo';

  @override
  String get commission => 'Comisión';

  @override
  String get points => 'Puntos';

  @override
  String get announcement => 'Aviso';

  @override
  String get readFullAnnouncement => 'Leer el aviso completo';

  @override
  String get serviceCheckFailed => 'Error al comprobar el servicio';

  @override
  String get apiAvailable => 'El servicio API funciona';

  @override
  String get checkApi => 'Comprobar API';

  @override
  String get refresh => 'Actualizar';

  @override
  String get nodeFilter => 'Filtro de nodos';

  @override
  String get nodeFilterSmartSelection => 'Selección inteligente';

  @override
  String get nodeFilterCustomized => 'Personalizado';

  @override
  String nodeFilterKept(Object kept, Object total) {
    return '$kept de $total nodos conservados';
  }

  @override
  String get nodeFilterLines => 'Líneas';

  @override
  String get nodeFilterRegions => 'Regiones';

  @override
  String get nodeFilterNameContains => 'El nombre contiene';

  @override
  String get nodeFilterNameExcludes => 'El nombre excluye';

  @override
  String get nodeFilterPreview => 'Vista previa';

  @override
  String get nodeFilterSearch => 'Buscar nodos';

  @override
  String get nodeFilterAny => 'Cualquiera';

  @override
  String get nodeFilterOnly => 'Solo';

  @override
  String get nodeFilterExclude => 'Excluir';

  @override
  String get nodeFilterKeepOne => 'Conserve al menos un nodo';

  @override
  String nodeFilterNodeKept(Object name) {
    return '$name, conservado';
  }

  @override
  String nodeFilterNodeExcluded(Object name) {
    return '$name, excluido';
  }

  @override
  String get nodeFilterRetry => 'Reintentar';

  @override
  String get nodeFilterAccountNote =>
      'Se guarda en su cuenta y se aplica a todos los dispositivos con sesión iniciada en esta aplicación.';

  @override
  String get nodeFilterUnavailable =>
      'El filtro de nodos está disponible cuando tiene un plan';

  @override
  String get minimalConfiguration => 'Configuración mínima';

  @override
  String get minimalConfigurationDesc =>
      'Usar reglas simplificadas para generar un perfil más pequeño';

  @override
  String get tcpFastOpen => 'TCP Fast Open';

  @override
  String get tcpFastOpenDesc => 'Acelerar el establecimiento de conexiones TCP';

  @override
  String get store => 'Tienda';

  @override
  String get recharge => 'Recargar';

  @override
  String get availablePlans => 'Elegir un plan';

  @override
  String get noAvailablePlans => 'No hay planes disponibles';

  @override
  String get myOrders => 'Planes comprados';

  @override
  String get noPurchaseRecords => 'No hay planes comprados';

  @override
  String get accountBalance => 'Saldo';

  @override
  String commissionBalance(Object value) {
    return 'Comisión $value';
  }

  @override
  String get soldOut => 'Agotado';

  @override
  String remainingStock(Object count) {
    return 'Solo quedan $count';
  }

  @override
  String get mainlandNetworkWarning =>
      'Puede no ser adecuado para redes de China continental';

  @override
  String get planInUse => 'En uso';

  @override
  String get planNotActivated => 'Pendiente de activación';

  @override
  String get planEnded => 'Finalizado';

  @override
  String get planAwaitingAutoRenewal => 'Pendiente de renovación automática';

  @override
  String get planAwaitingAutoRenewalNote =>
      'En cola tras sus otros planes; se renueva automáticamente cuando se agoten';

  @override
  String get planAutoRenewalOffNote =>
      'En cola tras sus otros planes; finaliza cuando se agoten';

  @override
  String planNumber(Object id) {
    return 'Plan n.º $id';
  }

  @override
  String get activate => 'Activar';

  @override
  String get upgradePlan => 'Mejorar plan';

  @override
  String get noPaymentMethods => 'No hay métodos de pago disponibles';

  @override
  String get activatePlanTitle => 'Activar plan';

  @override
  String get activatePlanConfirm =>
      '¿Activar este plan? Pasará a ser su plan activo.';

  @override
  String get noUpgradablePlans => 'No hay planes disponibles para mejorar';

  @override
  String get selectUpgradeTarget => 'Seleccionar el plan de destino';

  @override
  String get refreshAfterPayment =>
      'Después de pagar, deslice hacia abajo para actualizar y comprobar el resultado';

  @override
  String get discountCodeOptional => 'Código de descuento (opcional)';

  @override
  String get bindCoupon => 'Aplicar cupón';

  @override
  String get bindCouponIntro =>
      'Introduzca un cupón oficial. La diferencia se liquida por el tiempo restante del plan; un cupón recurrente también actualiza el precio de renovación.';

  @override
  String get verifyCoupon => 'Verificar';

  @override
  String get discountCode => 'Código de descuento';

  @override
  String get discountCodeRequired => 'Introduzca un código de descuento';

  @override
  String get discountedPriceLabel => 'Precio con descuento';

  @override
  String get amountDueLabel => 'Importe adeudado';

  @override
  String get refundAmountLabel => 'Reembolso';

  @override
  String get recurringRenewalHint =>
      'Las próximas renovaciones automáticas mantendrán este descuento';

  @override
  String get insufficientBalanceHint =>
      'Saldo insuficiente. Recargue antes de continuar.';

  @override
  String get amountPayable => 'Importe a pagar';

  @override
  String get renewalPriceLabel => 'Precio de renovación';

  @override
  String get calculatingQuote => 'Calculando…';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get goPay => 'Pagar';

  @override
  String get confirmPurchase => 'Confirmar compra';

  @override
  String get rechargeAmount => 'Importe de recarga (¥)';

  @override
  String get invalidAmount => 'Introduzca un importe válido';

  @override
  String get scanOrTransferPay => 'Pago por QR o transferencia';

  @override
  String get close => 'Cerrar';

  @override
  String get checkingPayment => 'Comprobando…';

  @override
  String get paymentPending =>
      'Aún no se ha recibido el pago. Vuelva a comprobarlo en unos instantes.';

  @override
  String get iHavePaid => 'Ya he pagado';

  @override
  String get openInBrowser => 'Abrir en el navegador';

  @override
  String get openLinkFailed =>
      'No se pudo abrir el enlace. Compruebe que haya un navegador instalado y vuelva a intentarlo.';

  @override
  String get scanToPayNotice => 'Escanee con Alipay o WeChat para pagar';

  @override
  String get paymentAmount => 'Importe del pago';

  @override
  String get receivingAddress => 'Dirección de recepción';

  @override
  String get addressCopied => 'Dirección copiada';

  @override
  String get transferConfirmNotice =>
      'La transferencia se confirmará automáticamente y se activará el plan seleccionado.';

  @override
  String get operationSuccess => 'Operación completada';

  @override
  String get operationFailed => 'Error en la operación';

  @override
  String get paymentSuccess => 'Pago completado';

  @override
  String get paymentRequestFailed => 'Error en la solicitud de pago';

  @override
  String get fetchPlansFailed => 'No se pudieron cargar los planes';

  @override
  String get storeSubtitle => 'Comprar, renovar y mejorar planes';

  @override
  String get paymentUnknownResponse =>
      'El servicio de pago devolvió un formato desconocido';

  @override
  String get buy => 'Comprar';

  @override
  String get payWithBalance => 'Pagar con saldo';

  @override
  String availableBalance(Object value) {
    return 'Disponible: $value';
  }

  @override
  String get planUnavailable => 'No disponible';

  @override
  String get balanceDeductionHint =>
      'Las compras usan primero el saldo y después las comisiones para cubrir la diferencia.';

  @override
  String rechargeAllowedRange(Object min, Object max) {
    return 'Intervalo permitido: $min – $max';
  }

  @override
  String get rechargeAmountOutOfRange =>
      'El importe está fuera del intervalo permitido por este método de pago';

  @override
  String get insufficientBalanceRecharge => 'Recargue y vuelva a intentarlo.';

  @override
  String get storeOutcomeUnknown =>
      'La solicitud puede haberse procesado. Revise sus planes comprados antes de reintentarlo.';

  @override
  String configParseErrorAtLine(Object line) {
    return 'El formato de la configuración no es válido en la línea $line.';
  }

  @override
  String configTypeMismatch(Object expected, Object actual) {
    return 'Se esperaba $expected, pero se encontró $actual.';
  }

  @override
  String get configYamlFormatHint =>
      'Compruebe la sangría y los marcadores de lista «-» cerca de esta línea.';

  @override
  String get configValueTypeList => 'una lista';

  @override
  String get configValueTypeObject => 'un objeto';

  @override
  String get configValueTypeText => 'texto';

  @override
  String get configValueTypeBoolean => 'un booleano';

  @override
  String get configValueTypeInteger => 'un entero';

  @override
  String get configValueTypeNumber => 'un número';

  @override
  String get configValueTypeNull => 'un valor vacío';

  @override
  String get configRecoveryTitle => 'Recuperar la configuración local';

  @override
  String get configRecoveryMessage =>
      'La configuración local no está disponible temporalmente. Sus datos se han conservado. Desbloquee el dispositivo y reintente, o vuelva a abrir la aplicación más tarde.';

  @override
  String get configRecoveryRetry => 'Reintentar';

  @override
  String get geoDownloadFailed => 'Error al descargar GEO';

  @override
  String get geoFileMissing => 'Sin descargar';

  @override
  String get geoFileReadFailed => 'No se pudo leer el archivo de recursos';

  @override
  String get geoDownloadRecoveryHint =>
      'La descarga sigue las reglas de red actuales o usa una conexión directa si el proxy no está disponible. Reintente la dirección actual, elija otra fuente o introduzca una URL. La operación continuará automáticamente tras la validación.';

  @override
  String get geoOriginalSource => 'Dirección actual';

  @override
  String get geoBackupSource => 'CDN de respaldo';

  @override
  String get geoDownloadUrl => 'URL de descarga';

  @override
  String get geoInvalidDownloadUrl => 'Introduzca una URL HTTP o HTTPS válida';

  @override
  String get purchasedAtLabel => 'Fecha de compra';

  @override
  String get purchasePriceLabel => 'Precio de compra';

  @override
  String get billingPeriodLabel => 'Periodo de facturación';

  @override
  String get remainingTimeLabel => 'Tiempo restante';

  @override
  String get remainingTrafficLabel => 'Tráfico restante';

  @override
  String get expiresAtLabel => 'Fecha de caducidad';

  @override
  String get usedTrafficLabel => 'Tráfico usado';

  @override
  String get purchaseTotalTrafficLabel => 'Tráfico total';

  @override
  String get purchaseAutoRenewLabel => 'Renovación automática';

  @override
  String purchaseDays(Object count) {
    return '$count d';
  }

  @override
  String purchaseHours(Object count) {
    return '$count h';
  }

  @override
  String purchaseMinutes(Object count) {
    return '$count min';
  }

  @override
  String get purchaseRenewOn => 'Activado';

  @override
  String get purchaseRenewOff => 'Desactivado';

  @override
  String get overwriteTypeMerge => 'Superposición';

  @override
  String get overwriteTypeMergeDesc =>
      'Conservar las reglas y grupos de la suscripción y añadir los propios. Las reglas personales tienen prioridad sobre las de la suscripción; las reglas añadidas existentes mantienen su prioridad.';

  @override
  String get personalRouting => 'Enrutamiento personal';

  @override
  String get overlayHint =>
      'Se guarda por separado de la suscripción y se vuelve a aplicar tras actualizar. Los grupos nuevos bloquean conexiones si ningún miembro coincide.';

  @override
  String overlayNameConflict(Object name) {
    return 'El nombre «$name» ya está en uso. Renombre el grupo personal para conservar ambos.';
  }

  @override
  String get outboundUnavailable =>
      'No está disponible en esta configuración. Elimínelo o sustitúyalo.';

  @override
  String get memberOrderHint =>
      'El orden de selección define el orden de respaldo. Quite y vuelva a seleccionar un miembro para moverlo al final.';

  @override
  String groupCycleError(Object name) {
    return 'Referencia circular de grupo: $name. Elija otro miembro.';
  }

  @override
  String get rulesRequireRuleMode =>
      'Las reglas de enrutamiento personal se aplican en modo Reglas.';

  @override
  String get checkRouting => 'Comprobar configuración';

  @override
  String get routingChecked =>
      'La configuración es válida. Los ajustes personales se han guardado para este perfil.';

  @override
  String get routingApplied => 'Ajustes personales aplicados.';

  @override
  String get routingApplyFailed =>
      'Los cambios se guardaron, pero no pudieron aplicarse. Compruebe la configuración y reintente.';

  @override
  String get customRuleForm => 'Formulario';

  @override
  String get customRuleRaw => 'Texto de la regla';

  @override
  String get customRuleRawHint =>
      'Introduzca una regla completa. Se conservan las expresiones avanzadas.';

  @override
  String get customRuleFormUnavailable =>
      'Esta regla usa sintaxis avanzada. Edite el texto para conservar todas las opciones.';

  @override
  String get customRuleInvalidSyntax =>
      'Introduzca una regla completa con tipo, contenido y destino válidos.';

  @override
  String customRuleInvalidContent(Object example) {
    return 'Compruebe el contenido para este tipo de regla. Ejemplo: $example';
  }

  @override
  String customRuleUnavailableTarget(Object name) {
    return '$name no está disponible. Elija un destino de esta configuración.';
  }

  @override
  String customRuleUnavailableProvider(Object name) {
    return '$name no está disponible. Elija un proveedor de reglas existente.';
  }

  @override
  String get customRuleChooseTarget => 'Elegir destino';

  @override
  String get customRuleChooseProvider => 'Elegir proveedor de reglas';

  @override
  String get customRuleMatchHint =>
      'Coincide con todo el tráfico restante. No se alcanzarán las reglas posteriores.';

  @override
  String get customRuleNoResolveHint =>
      'Usar direcciones IP conocidas sin resolver nombres de dominio.';

  @override
  String get saveRoutingDraft => 'Guardar borrador';

  @override
  String get routingDraftHint =>
      'Guarde un borrador para corregir otros elementos. Los ajustes solo se aplican cuando toda la configuración supera la validación.';

  @override
  String get groupFilterHint =>
      'Filtra los nodos incluidos automáticamente y los de proveedores. Los miembros seleccionados manualmente siempre se conservan.';

  @override
  String get groupTypeSelect => 'Selección manual';

  @override
  String get groupTypeUrlTest => 'Selección automática';

  @override
  String get groupTypeFallback => 'Conmutación por error';

  @override
  String get groupTypeLoadBalance => 'Equilibrio de carga';

  @override
  String get groupTypeSelectHint =>
      'Elija el miembro activo en la página Proxies.';

  @override
  String get groupTypeUrlTestHint =>
      'Probar periódicamente los miembros y elegir un nodo de baja latencia.';

  @override
  String get groupTypeFallbackHint =>
      'Probar los miembros en orden y cambiar si falla el actual.';

  @override
  String get groupTypeLoadBalanceHint =>
      'Distribuir las conexiones entre los miembros disponibles.';

  @override
  String get routingGroupType => 'Tipo de grupo';

  @override
  String get customRuleType => 'Tipo de regla';

  @override
  String get routingChanged =>
      'Esta configuración cambió durante la edición o la comprobación. Vuelva a abrir el editor o compruébela de nuevo.';

  @override
  String get editCustomRouting => 'Editar enrutamiento personalizado';

  @override
  String get customRoutingDraftHint =>
      'Complete su enrutamiento y cambie al modo Personalizado. Editar este borrador no cambia el modo actual.';

  @override
  String coreBlockedByPolicyTip(int code) {
    return 'Windows bloqueó el inicio del núcleo proxy (error del sistema $code). Revise el historial de protección de Seguridad de Windows y la política de control de aplicaciones, y verifique el origen y la firma del instalador.';
  }

  @override
  String get startupRecoveryTitle => 'Recuperación de inicio';

  @override
  String get startupRecoveryTip =>
      'El inicio anterior no terminó. La configuración automática y el inicio de la VPN se suspenden en este arranque. El perfil y los ajustes seleccionados no cambian. Revise la configuración y pulse Iniciar para reintentar; una VPN ya activa seguirá conectada.';

  @override
  String get initFailed => 'Error al iniciar';

  @override
  String get initFailedTip =>
      'La aplicación encontró un error crítico al iniciar y no puede continuar.';

  @override
  String get startupTimeoutTip =>
      'Se agotó el tiempo de inicio. Cierre y vuelva a abrir la aplicación. Si persiste, copie el diagnóstico de abajo.';

  @override
  String get startupDiagnostics => 'Diagnóstico de inicio';

  @override
  String get errorDetails => 'Detalles del error';

  @override
  String get stackTrace => 'Seguimiento de pila';

  @override
  String get authentication => 'Autenticación del proxy local';

  @override
  String get authenticationDesc =>
      'Solicitar usuario y contraseña en los puertos HTTP y SOCKS. Mientras está activo, no se configura el proxy HTTP del sistema; TUN y VPN siguen funcionando';

  @override
  String get authenticationSystemProxyDesc =>
      'El proxy del sistema no se aplica mientras está activa la autenticación del proxy local';

  @override
  String get authenticationUsernameInvalid =>
      'Use de 1 a 255 bytes UTF-8, sin dos puntos ni caracteres de control';

  @override
  String get authenticationPasswordInvalid =>
      'Use de 1 a 255 bytes UTF-8, sin caracteres de control';

  @override
  String get authenticationApplyFailed =>
      'No se pudieron aplicar los ajustes de autenticación';

  @override
  String get installedAppsPermissionRequired =>
      'Se requiere permiso para las aplicaciones instaladas';

  @override
  String get installedAppsPermissionDesc =>
      'Permita el acceso a la lista de aplicaciones instaladas para elegir cuáles usan la VPN.';

  @override
  String get installedAppsPermissionDeniedMessage =>
      'No se concedió el permiso. Puede activarlo en los ajustes del sistema.';

  @override
  String get installedAppsPermissionGrant => 'Permitir acceso';

  @override
  String get installedAppsLoadFailed =>
      'No se pudieron cargar las aplicaciones instaladas. Vuelva a intentarlo.';

  @override
  String get configRecoveryMissingKey =>
      'La clave de cifrado de su configuración falta o no es válida. Pruebe la cuenta y el dispositivo originales, o restaure una copia. Reintentar no recrea una clave perdida.';

  @override
  String get configRecoveryDatabaseUnavailable =>
      'No se puede acceder a la base de datos local en este momento. Se han conservado los archivos. Comprueba los permisos de la carpeta de datos de esta aplicación y si otro proceso está usando la base de datos, y vuelve a intentarlo.';

  @override
  String get configRecoveryIncompatibleDatabase =>
      'La base de datos de esta aplicación es incompatible o está dañada. Se han conservado los archivos. Restaura una copia compatible o crea una copia y restablece la aplicación para configurarla de nuevo. No se accederá a los datos de otras aplicaciones.';

  @override
  String get configRecoveryUnreadable =>
      'La configuración local no se puede descifrar o está dañada. Los archivos existentes se conservan. Restaure la clave y la copia correspondientes, o haga una copia y restablezca.';

  @override
  String get configRecoveryStorage =>
      'No se pudo leer o guardar la configuración local o su clave. Compruebe el acceso a la carpeta de datos y al almacenamiento seguro del sistema, y reintente.';

  @override
  String get configRecoveryReset => 'Copiar y restablecer';

  @override
  String get configRecoveryResetConfirm =>
      '¿Crear una copia cifrada de todos los ajustes, suscripciones, reglas y datos de cuenta y restablecer la aplicación? Tendrá que iniciar sesión e importar o restaurar sus suscripciones y ajustes. La copia está protegida por esta cuenta de Windows y no puede recuperar una clave perdida.';

  @override
  String get configRecoveryResetDone =>
      'Se ha guardado una copia cifrada de los datos originales en la carpeta indicada. Cierre y vuelva a abrir la aplicación para configurarla de nuevo.';

  @override
  String get configRecoveryResetFailed =>
      'No se pudieron completar la copia cifrada y el restablecimiento. Los datos originales restantes no se eliminarán sin una copia verificada. Reintente o cierre y vuelva a abrir la aplicación para finalizar.';

  @override
  String get configRecoveryKeyring =>
      'No se pudo acceder al llavero del sistema (Secret Service). Active y desbloquee KDE Wallet o GNOME Keyring en los ajustes del sistema y reintente.';

  @override
  String get configRecoveryUseLocalStorage => 'Usar un archivo local';

  @override
  String get configRecoveryUseLocalStorageConfirm =>
      '¿Guardar las claves y credenciales en un archivo de la carpeta de la aplicación accesible solo por su cuenta, en lugar del llavero del sistema? Cualquier programa ejecutado con su cuenta podrá leerlas y descifrar la configuración local. Esta elección seguirá vigente.';

  @override
  String get excludeSsids => 'Redes Wi-Fi que pausan el proxy';

  @override
  String get excludeSsidsDesc =>
      'Pausar el proxy en las redes Wi-Fi indicadas; reanudar al salir solo si la aplicación sigue iniciada';

  @override
  String get allowBackgroundLocation => 'Permitir siempre';

  @override
  String get locationPermission => 'Permiso de ubicación';

  @override
  String get locationPermissionRequired => 'Se requiere permiso de ubicación';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. Abre Ajustes del sistema > Privacidad y seguridad\n2. Elige Servicios de localización\n3. Busca $appName en la lista y márcalo\n\nCuando termines, vuelve a la app para continuar. Gracias por tu colaboración.';
  }

  @override
  String get ssidPermissionGuide =>
      'Permita el acceso a la ubicación para leer los nombres Wi-Fi. En Android, permita siempre la ubicación precisa y active los servicios de ubicación del sistema.';

  @override
  String get ssidPermissionMacosGuide =>
      'Permita la ubicación para esta aplicación en Ajustes del Sistema para leer los nombres Wi-Fi.';

  @override
  String get exitDefault => 'Predeterminado';

  @override
  String get customExit => 'Salida personalizada';

  @override
  String get inputExitName => 'Introduce el nombre de la salida';

  @override
  String get iconHistory => 'Iconos recientes';

  @override
  String get exitFullScreen => 'Salir de pantalla completa';

  @override
  String get unmaximize => 'Restaurar tamaño';

  @override
  String get maximize => 'Maximizar';

  @override
  String get unpinWindow => 'Desfijar ventana';

  @override
  String get pinWindow => 'Fijar ventana';

  @override
  String get minimize => 'Minimizar';

  @override
  String get cloudApiDnsFailed => 'Error de resolución DNS';

  @override
  String get cloudApiDnsEmpty =>
      'DNS no devolvió ninguna dirección: posible bloqueo o fallo del resolutor del sistema';

  @override
  String get cloudApiDnsUnknownHost => 'DNS no pudo encontrar este dominio';

  @override
  String get cloudApiConnectTimeout => 'Tiempo de conexión agotado';

  @override
  String get cloudApiSendTimeout => 'Tiempo de envío de la solicitud agotado';

  @override
  String get cloudApiReceiveTimeout => 'Tiempo de espera de respuesta agotado';

  @override
  String get cloudApiTlsFailed => 'Error en la negociación TLS';

  @override
  String get cloudApiConnectionRefused => 'Conexión rechazada';

  @override
  String get cloudApiConnectionReset => 'Conexión restablecida';

  @override
  String get cloudApiNetworkUnreachable => 'Red inaccesible';

  @override
  String get cloudApiAccessDenied => 'Acceso a la red denegado';

  @override
  String get cloudApiConnectionFailed => 'Error de conexión';

  @override
  String get cloudApiProxyFailed => 'Error de conexión al proxy';

  @override
  String get cloudApiProxyAuthFailed =>
      'Error de autenticación del proxy (HTTP 407)';

  @override
  String cloudApiHttpError(Object status) {
    return 'El servidor devolvió HTTP $status';
  }

  @override
  String get certificateRevoked => 'El certificado ha sido revocado';

  @override
  String get cloudApiBadRequest =>
      'El servidor rechazó la solicitud por no ser válida';

  @override
  String get cloudApiForbidden => 'Acceso prohibido';

  @override
  String get cloudApiNotFound =>
      'No se encontró la API o el recurso solicitado';

  @override
  String get cloudApiMethodNotAllowed => 'Método de solicitud no permitido';

  @override
  String get cloudApiServerRequestTimeout =>
      'Se agotó el tiempo del servidor para recibir la solicitud';

  @override
  String get cloudApiRequestTooLarge =>
      'La solicitud supera el límite de tamaño del servidor';

  @override
  String get cloudApiRateLimited =>
      'Demasiadas solicitudes; inténtelo más tarde';

  @override
  String get cloudApiServerError => 'Error interno del servidor';

  @override
  String get cloudApiBadGateway =>
      'La puerta de enlace recibió una respuesta ascendente no válida';

  @override
  String get cloudApiServiceUnavailable =>
      'Servicio no disponible temporalmente';

  @override
  String get cloudApiGatewayTimeout =>
      'La puerta de enlace agotó el tiempo de espera del servidor ascendente';

  @override
  String get cloudApiNetworkAuthRequired =>
      'Esta red requiere iniciar sesión antes de acceder';

  @override
  String get cloudApiResponseTooLarge =>
      'La respuesta del servidor supera el tamaño permitido';

  @override
  String get cloudApiTlsProtocolFailed =>
      'Protocolo TLS incompatible o respuesta TLS no válida';

  @override
  String get cloudApiTlsAlgorithmFailed =>
      'Error al negociar los algoritmos criptográficos TLS';

  @override
  String get cloudApiTlsInterrupted =>
      'Conexión cerrada antes de completar la negociación TLS';

  @override
  String get cloudApiRedirectLoop => 'Bucle de redirecciones del servidor';

  @override
  String get cloudApiRedirectLimit => 'Demasiadas redirecciones del servidor';

  @override
  String get cloudApiRedirectInvalid => 'Redirección del servidor no válida';

  @override
  String get cloudApiResponseInterrupted =>
      'Conexión cerrada antes de recibir toda la respuesta';

  @override
  String get cloudApiConnectionAborted => 'Conexión interrumpida';

  @override
  String get cloudApiAddressUnavailable => 'Dirección de red no disponible';

  @override
  String get cloudApiAddressInUse => 'Dirección de red o puerto ya en uso';

  @override
  String get cloudApiNetworkResourcesExhausted =>
      'Recursos de red del sistema insuficientes';

  @override
  String get cloudApiClockSkew =>
      'El reloj del dispositivo difiere demasiado del servidor. Active la fecha y hora automáticas y reintente.';

  @override
  String get cloudApiSignatureRejected =>
      'El servidor rechazó la firma de esta aplicación. Reinstale la última versión oficial.';

  @override
  String get cloudApiServerUnconfigured =>
      'El servidor no tiene una clave configurada para esta aplicación. Contacte con soporte.';

  @override
  String get cloudApiConfigKeyRejected =>
      'El servidor rechazó la clave de configuración de este dispositivo. Reinstale la última versión oficial.';

  @override
  String get cloudApiAccountDisabled =>
      'Esta cuenta está desactivada. Contacte con soporte.';

  @override
  String get cloudApiAccountAnomaly =>
      'Esta cuenta requiere verificación. Complétela en el sitio web y reintente.';

  @override
  String get cloudApiAccountNotFound =>
      'Esta cuenta ya no existe. Vuelva a iniciar sesión.';

  @override
  String get cloudApiInvalidResponse => 'Respuesta del servidor no válida';

  @override
  String get cloudApiRequestCanceled => 'Solicitud cancelada';

  @override
  String cloudApiSystemError(Object code) {
    return 'Error del sistema $code';
  }

  @override
  String get cloudApiTimeout => 'Tiempo de solicitud agotado';

  @override
  String cloudApiRouteDirect(Object error) {
    return 'Directa: $error';
  }

  @override
  String cloudApiRouteProxy(Object error) {
    return 'Proxy local: $error';
  }

  @override
  String get diagTitle => 'Autodiagnóstico de red';

  @override
  String get diagEntryHint =>
      'Comprobar el núcleo, el proxy del sistema, TUN y DNS';

  @override
  String get diagScope =>
      'Comprueba la conexión actual con una pequeña muestra. La ruta de red del sistema también puede pasar por TUN. Los resultados no abarcan todas las aplicaciones ni todos los nodos.';

  @override
  String get diagRun => 'Iniciar diagnóstico';

  @override
  String get diagCopy => 'Copiar informe de diagnóstico';

  @override
  String get diagCanceled => 'Diagnóstico cancelado; resultados incompletos';

  @override
  String get diagFixing => 'Aplicando la corrección y comprobando de nuevo';

  @override
  String get diagFixFailed =>
      'No se pudo aplicar la corrección. Siga la sugerencia anterior.';

  @override
  String get diagFixApplyProfile => 'Aplicar configuración';

  @override
  String get diagFixStart => 'Iniciar conexión';

  @override
  String get diagFixRestartCore => 'Reiniciar núcleo';

  @override
  String get diagFixRestartConnection => 'Volver a conectar';

  @override
  String get diagFixSystemProxy => 'Volver a aplicar el proxy del sistema';

  @override
  String get diagFixEnableSystemProxy => 'Activar proxy del sistema';

  @override
  String get diagFixTun => 'Volver a activar TUN';

  @override
  String get diagFixRetest => 'Volver a probar los nodos';

  @override
  String get diagPassed => 'Correcto';

  @override
  String get diagWarning => 'Requiere atención';

  @override
  String get diagFailed => 'Error';

  @override
  String get diagUnknown => 'No se pudo confirmar';

  @override
  String get diagSkipped => 'Omitido';

  @override
  String get diagDisabled => 'Esta opción no está activada';

  @override
  String get diagProfile => 'Configuración aplicada';

  @override
  String get diagProfileReady => 'La configuración seleccionada está aplicada';

  @override
  String get diagProfileMissing =>
      'La configuración seleccionada no está aplicada';

  @override
  String get diagProfileHint =>
      'Seleccione una configuración válida e inicie la conexión antes de volver a comprobar.';

  @override
  String get diagCore => 'Respuesta del núcleo';

  @override
  String get diagCoreReady =>
      'El núcleo responde e informa de puertos de escucha activos';

  @override
  String get diagCoreUnknown =>
      'El diagnóstico del núcleo no está disponible o la configuración cambió';

  @override
  String get diagCoreStopped =>
      'El núcleo indica que el reenvío de tráfico está detenido';

  @override
  String get diagSuspended =>
      'El reenvío de tráfico está pausado por la exclusión Wi-Fi actual';

  @override
  String get diagCoreHint =>
      'Compruebe el interruptor de conexión y las exclusiones Wi-Fi. Si el núcleo no responde, reinícielo y use versiones actuales compatibles del cliente y el núcleo.';

  @override
  String get diagListener => 'Entrada del proxy local';

  @override
  String get diagListenerReady =>
      'El puerto esperado respondió al protocolo proxy';

  @override
  String get diagListenerFailed =>
      'El puerto proxy esperado no responde o difiere del puerto del núcleo';

  @override
  String get diagListenerHint =>
      'Compruebe si hay conflictos de puertos o si la escucha está detenida. Reconecte primero; si sigue fallando, abra Puertos y autenticación para revisar o cambiar el puerto mixto.';

  @override
  String get diagSystemProxy => 'Ajustes del proxy del sistema';

  @override
  String get diagProxyReady =>
      'Los proxies HTTP y HTTPS apuntan al puerto local esperado';

  @override
  String get diagProxyDisabled =>
      'La aplicación solicitó un proxy del sistema, pero el sistema lo indica desactivado';

  @override
  String get diagProxyDifferent =>
      'El proxy del sistema no coincide con el puerto de la aplicación';

  @override
  String get diagProxyAutomatic =>
      'Hay una configuración automática del proxy; no se verificó su ruta efectiva';

  @override
  String get diagProxyHint =>
      'Abra Solución de problemas y configuración manual para comparar la dirección y el puerto del proxy del sistema. Si los ajustes se revierten, revise otras aplicaciones proxy o las políticas de gestión del dispositivo.';

  @override
  String get diagProxyAutomaticHint =>
      'Un script PAC o la detección automática puede elegir un proxy distinto para cada sitio. Esto no implica necesariamente un fallo. Compruebe quién proporcionó la configuración antes de modificarla.';

  @override
  String get diagSystemDnsHint =>
      'Pruebe otra red y revise los servidores DNS de la conexión activa en el sistema. Cambiar solo las sobrescrituras DNS del cliente puede no corregir la resolución del sistema.';

  @override
  String get diagProxyRecover => 'Desactivar el proxy local inactivo';

  @override
  String get diagProxyRecoverHint =>
      'Detén primero la conexión. Solo se desactiva el proxy manual del puerto local actual si ningún servicio escucha en él. Se conservan las demás direcciones, puertos y opciones automáticas.';

  @override
  String get diagProxyGuide => 'Solución de problemas y configuración manual';

  @override
  String get diagRecheck => 'Comprobar de nuevo';

  @override
  String get diagOpenPortSettings => 'Puertos y autenticación';

  @override
  String get diagOpenNetworkSettings => 'Ajustes de red y TUN';

  @override
  String get diagOpenDnsSettings => 'Sobrescrituras DNS';

  @override
  String get diagOpenSystemSettings => 'Abrir ajustes del sistema';

  @override
  String get diagOpenSettingsFailed =>
      'No se pudieron abrir los ajustes del sistema. Siga la ruta indicada para abrirlos manualmente.';

  @override
  String get diagCopyProxyAddress => 'Copiar dirección del proxy';

  @override
  String get diagProxyGuidePrepareTitle =>
      '1. Comprobar primero el proxy local';

  @override
  String get diagProxyGuidePrepare =>
      'Seleccione un perfil válido, inicie la conexión en FlClash y compruebe que la prueba del proxy local sea correcta antes de introducir su dirección.\nCierre otras aplicaciones proxy que puedan modificar los ajustes del sistema. Si los gestiona su empresa o centro educativo, están bloqueados o se revierten, consulte al administrador.';

  @override
  String get diagProxyGuideManualTitle =>
      '2. Revisar o introducir los ajustes del proxy';

  @override
  String get diagProxyGuideWindows =>
      'Configuración → Red e Internet → Proxy\nSi los ajustes automáticos proceden de otra aplicación y la red ya no los necesita, desactive Usar script de configuración y Detectar la configuración automáticamente.\nEn Configuración manual del proxy, active Usar un servidor proxy, introduzca la dirección y el puerto indicados en sus campos respectivos y guarde. No anteponga http:// a la dirección. Conserve las excepciones necesarias para su red.';

  @override
  String get diagProxyGuideMacos =>
      'Ajustes del Sistema → Red → conexión Wi-Fi o Ethernet activa → Detalles → Proxies\nmacOS 12: Preferencias del Sistema → Red → conexión activa → Avanzado → Proxies\nSi los ajustes automáticos proceden de otra aplicación y ya no son necesarios, desactive la detección y la configuración automáticas del proxy.\nActive Proxy web (HTTP) y Proxy web seguro (HTTPS). Introduzca la dirección y el puerto indicados para ambos y guarde. Conserve las exclusiones necesarias para su red.';

  @override
  String get diagProxyGuideLinux =>
      'Abra los ajustes del escritorio → Red → Proxy de red y elija Manual (los nombres varían según el escritorio).\nIntroduzca la dirección y el puerto indicados para HTTP y HTTPS y aplique. Si no hay panel de proxy del sistema, configure la aplicación de destino.\nAntes de reemplazar una configuración automática, compruebe su origen y si la red aún la necesita.';

  @override
  String get diagProxyGuideApp =>
      'En este dispositivo, abra los ajustes de proxy de la aplicación, elija HTTP o SOCKS5 e introduzca la dirección y el puerto indicados.\nAndroid proporciona el proxy del sistema mediante el servicio VPN. Para acceder por VPN, revise el interruptor VPN y el control de acceso de aplicaciones en los ajustes de red de FlClash.';

  @override
  String get diagProxyGuideAuthenticated =>
      'La autenticación del proxy local está activada, por lo que FlClash no aplica un proxy del sistema automáticamente.\nEn una aplicación compatible, elija HTTP o SOCKS5 e introduzca la dirección y el puerto indicados. Use el usuario y la contraseña de FlClash → Sobrescritura → General → Entradas → Autenticación.\nNo incluya credenciales en los informes de diagnóstico.';

  @override
  String diagProxyGuideValues(Object port) {
    return 'Dirección local: 127.0.0.1\nPuerto mixto (configuración actual): $port\nUse este puerto mixto para HTTP, sitios HTTPS o SOCKS5, solo en este dispositivo.';
  }

  @override
  String get diagProxyGuideInvalidPort =>
      'El puerto mixto no está disponible. Defina un puerto válido en Puertos y autenticación e inicie la conexión.';

  @override
  String get diagProxyGuideVerifyTitle =>
      '3. Guardar y verificar en la aplicación';

  @override
  String get diagProxyGuideVerify =>
      'Vuelva y elija Comprobar de nuevo; después reintente en su navegador o aplicación.\nSi el proxy local supera la prueba pero una aplicación falla, revise sus ajustes de proxy del sistema, personalizado o de extensiones. El proxy del sistema no abarca todas las aplicaciones.\nAl detener FlClash, quizá deba desactivar el proxy manual o restaurar sus ajustes anteriores para mantener el acceso a Internet.';

  @override
  String get diagTun => 'Interfaz y ruta TUN';

  @override
  String get diagTunMissing =>
      'No se encontró una interfaz TUN activa del núcleo';

  @override
  String get diagTunReady =>
      'La interfaz TUN del núcleo está activa y la ruta IPv4 probada la utiliza';

  @override
  String get diagTunRouteMismatch =>
      'TUN está activo, pero la ruta IPv4 probada usa otra interfaz';

  @override
  String get diagTunRouteUnknown =>
      'TUN está activo; no se pudo verificar su ruta IPv4';

  @override
  String get diagTunHint =>
      'Desactive y active TUN y complete la autorización del sistema. Si la ruta difiere, revise otras VPN. IPv6, UDP y las exclusiones por aplicación requieren comprobaciones aparte.';

  @override
  String get proxyConflictTitle => 'Posible conflicto de proxy';

  @override
  String proxyConflictSystemProxy(Object address) {
    return 'Antes del inicio, el proxy del sistema apuntaba a $address.';
  }

  @override
  String get proxyConflictAutoConfig =>
      'Antes del inicio, el proxy del sistema usaba un script de configuración automática.';

  @override
  String proxyConflictVpn(Object name) {
    return 'Antes del inicio, el tráfico pasaba por otra VPN o adaptador virtual: $name.';
  }

  @override
  String get proxyConflictHint =>
      'Si pertenece a otra aplicación proxy o VPN, ciérrela; ejecutar ambas puede interrumpir la conexión.';

  @override
  String get diagTrafficCapture => 'Captura de tráfico';

  @override
  String get diagNoCapture => 'Ni el proxy del sistema ni TUN están activados';

  @override
  String get diagCaptureHint =>
      'Active el proxy del sistema o TUN, o configure la aplicación afectada para usar el proxy local.';

  @override
  String get diagSystemDns => 'DNS del sistema';

  @override
  String get diagCoreDns => 'DNS del núcleo';

  @override
  String diagProbeSummary(int passed, int total) {
    return '$passed/$total muestras correctas';
  }

  @override
  String diagProbeResult(int index, String result, int milliseconds) {
    return 'Prueba $index: $result · $milliseconds ms';
  }

  @override
  String get diagDnsServerFailed =>
      'El DNS de origen devolvió un error del servidor';

  @override
  String get diagDnsReady => 'Los nombres probados se resolvieron';

  @override
  String get diagDnsPartial => 'Solo se resolvieron algunos nombres probados';

  @override
  String get diagOixDnsNoSample =>
      'No había ningún nombre de host de nodo gestionado disponible para esta prueba';

  @override
  String get diagOixDnsAuthMissing =>
      'La función de firma DNS gestionada no está lista';

  @override
  String get diagDnsNoAnswer =>
      'DNS no devolvió ninguna dirección utilizable; esto por sí solo no demuestra un fallo de autenticación';

  @override
  String get diagDnsRefused => 'La solicitud DNS fue rechazada';

  @override
  String get diagDnsHint =>
      'Revise las sobrescrituras DNS y pruebe otra red. Si el DNS del sistema funciona pero el del núcleo falla, examine los ajustes DNS de la configuración.';

  @override
  String get diagOixDnsHint =>
      'Compruebe la versión del cliente y la hora del sistema y actualice la suscripción. Si la resolución sigue fallando, comparta este informe con soporte.';

  @override
  String get diagSystemPath => 'Ruta de red del sistema';

  @override
  String get diagProxyPath => 'A través del proxy local';

  @override
  String diagWebResult(Object count) {
    return '$count de 2 pruebas HTTPS independientes correctas';
  }

  @override
  String get diagSystemPathHint =>
      'Esta ruta no usa explícitamente el proxy HTTP de la aplicación, pero puede pasar por TUN. Un fallo puede deberse a DNS, filtros o al sitio probado; compare el resultado del proxy local.';

  @override
  String get diagProxyPathHint =>
      'Si la ruta del sistema funciona, revise el nodo seleccionado, las reglas y el DNS del núcleo. El fallo de un sitio de prueba no significa que todos los nodos sean inutilizables.';

  @override
  String get diagClock => 'Comparación de la hora del sistema';

  @override
  String get diagClockUnknown =>
      'No hay suficientes respuestas HTTPS sin caché para comparar la hora';

  @override
  String get diagClockSkew =>
      'Dos respuestas independientes indican una posible diferencia de al menos cinco minutos';

  @override
  String get diagClockReady =>
      'No se detectó una diferencia grande y consistente en esta muestra';

  @override
  String get diagClockHint =>
      'Active la fecha y hora automáticas y reintente. Un reloj incorrecto puede afectar a los certificados y las firmas DNS de oixCloud.';

  @override
  String get diagAllFailed =>
      'Todos los nodos probados de este grupo fallaron. La URL de prueba también podría ser inaccesible. ¿Ejecutar el autodiagnóstico de red?';

  @override
  String get updateDownloadBackground => 'Descargar en segundo plano';

  @override
  String get updateReady => 'Actualización lista para instalar';

  @override
  String get updateRestart => 'Actualizar y volver a abrir';

  @override
  String get updateRestartHint =>
      'La aplicación se cerrará, se actualizará en su ubicación actual y se abrirá de nuevo. Sus ajustes se conservarán.';

  @override
  String get updatePreparing => 'Preparando la actualización';

  @override
  String get updateVerifying => 'Verificando el paquete de actualización';

  @override
  String get updateCheckingInstaller => 'Comprobando el instalador';

  @override
  String get updateRestarting => 'Cerrando y reiniciando';

  @override
  String get updateApplyFailed =>
      'La actualización automática no se completó. Reintente o actualice desde la página de descarga.';

  @override
  String get updateReadyHint =>
      'La actualización está descargada. Instálela cuando le convenga.';

  @override
  String get updateInstall => 'Instalar actualización';

  @override
  String get updateDownloading => 'Descargando actualización';

  @override
  String get updateDownloadFailed => 'Error al descargar la actualización';

  @override
  String get updateDownloadBrowser => 'Descargar en el navegador';

  @override
  String get updatePackageFormat => 'Elegir formato del paquete';

  @override
  String get updatePackageFormatTip =>
      'No se pudo determinar cómo se instaló esta versión. Elija el formato correspondiente.';

  @override
  String get updateAppImageTip =>
      'Una AppImage no puede instalarse automáticamente. Sustituya el programa actual por el archivo descargado; se ha abierto su carpeta.';

  @override
  String get updatePackageManagerTip =>
      'Esta versión se instaló con un gestor de paquetes; actualícela del mismo modo.';

  @override
  String get tunMtuDesc =>
      'Valor predeterminado: 9000; alternativas: 1480 o 4064. Reinicie la VPN de Android para aplicar';

  @override
  String get tunMtuInvalid => 'Introduzca un entero entre 1280 y 65535';

  @override
  String get scriptOptions => 'Opciones del script';

  @override
  String get scriptOptionsEmpty =>
      'Este script no ofrece interruptores configurables';

  @override
  String get scriptChanges => 'Cambios del script';

  @override
  String get scriptFullConfig => 'Configuración completa';

  @override
  String get scriptChangesDescription =>
      'Campos de nivel superior añadidos, modificados o eliminados por el script. La configuración completa también incluye los ajustes de la aplicación.';

  @override
  String get scriptChangesEmpty => 'El script no modificó la configuración';

  @override
  String scriptChangesAdded(int count) {
    return 'Añadidos ($count)';
  }

  @override
  String scriptChangesModified(int count) {
    return 'Modificados ($count)';
  }

  @override
  String scriptChangesRemoved(int count) {
    return 'Eliminados ($count)';
  }

  @override
  String get excludeNetworks => 'Pausar según IP o puerta de enlace';

  @override
  String get excludeNetworksDesc =>
      'Pausar al coincidir con direcciones IPv4 Wi-Fi/Ethernet, subredes o puertas de enlace; reanudar al salir. Separe por comas, p. ej. 192.168.1.0/24,gateway:192.168.1.1';

  @override
  String get excludeNetworksInvalid =>
      'Hasta 16 reglas; introduzca IPv4, CIDR o gateway:dirección válidos';

  @override
  String get delayConcurrency => 'Pruebas de latencia simultáneas';

  @override
  String get delayTestFailed => 'Error';

  @override
  String get updateReleaseNotes => 'Notas de la versión';

  @override
  String get updateDownloadConfirm => 'Descargar actualización';

  @override
  String get updateLater => 'Más tarde';

  @override
  String get updateCancelDownload => 'Cancelar descarga';

  @override
  String get updateNotice => 'Nueva versión detectada';

  @override
  String updateVersionNumber(String version) {
    return 'Versión: $version';
  }

  @override
  String updateBuildNumber(String build) {
    return 'Compilación: $build';
  }

  @override
  String get updateReleaseNotesFailed =>
      'No se pudieron cargar las notas de la versión. Reintente.';

  @override
  String get tailscaleEntryHint => 'Acceder a los dispositivos de su tailnet';

  @override
  String get tailscaleEmptyTitle => 'Acceder a su tailnet';

  @override
  String get tailscaleEmptyDesc =>
      'Añada una red, inicie sesión en este dispositivo e inicie el proxy para acceder a sus dispositivos.';

  @override
  String get tailscaleAddNetwork => 'Añadir red';

  @override
  String get tailscaleNetworks => 'Redes';

  @override
  String get tailscaleGuide => 'Guía';

  @override
  String get tailscaleThisDevice => 'Este dispositivo';

  @override
  String get tailscaleStatus => 'Estado';

  @override
  String get tailscaleDeviceName => 'Nombre del dispositivo';

  @override
  String tailscaleDevices(Object count) {
    return 'Dispositivos ($count)';
  }

  @override
  String get tailscaleNetworkName => 'Nombre de la red';

  @override
  String get tailscaleNameInUse => 'Este nombre ya está en uso';

  @override
  String get tailscaleLoginMethod => 'Método de inicio de sesión';

  @override
  String get tailscaleInteractiveLogin => 'Interactivo';

  @override
  String get tailscaleAuthKey => 'Clave de autenticación';

  @override
  String get tailscaleAuthKeySaved =>
      'Hay una clave de autenticación guardada en este dispositivo. Introduzca otra para sustituirla.';

  @override
  String get tailscaleLoginFooter =>
      'Inicie sesión una vez por red en este dispositivo.';

  @override
  String get tailscaleAutoRoute => 'Enrutamiento automático';

  @override
  String get tailscaleAutoRouteDesc =>
      'Encaminar las direcciones de pares, los nombres MagicDNS y las subredes aprobadas por esta red';

  @override
  String get tailscaleExitNode => 'Nodo de salida';

  @override
  String get tailscaleExitNodeDesc =>
      'Déjelo vacío para ninguno, o use auto, un nombre de par o su IP.';

  @override
  String get tailscaleAvailableExitNodes => 'Nodos de salida disponibles';

  @override
  String get tailscaleExitNodeAllowLan => 'Permitir acceso a la red local';

  @override
  String get tailscaleAdvanced => 'Avanzado';

  @override
  String get tailscaleControlUrl => 'URL de control';

  @override
  String get tailscaleCredentialsFooter =>
      'La autenticación y la identidad del dispositivo permanecen en este dispositivo.';

  @override
  String get tailscaleAccount => 'Cuenta';

  @override
  String get tailscaleSaveAndLogin => 'Guardar e iniciar sesión';

  @override
  String get tailscaleOpenLoginPage => 'Abrir página de inicio de sesión';

  @override
  String get tailscaleLoginWaiting =>
      'Abra la página de inicio de sesión o escanee el código. La sesión se completa automáticamente tras la autorización.';

  @override
  String get tailscaleSigningIn => 'Iniciando sesión';

  @override
  String get tailscaleSignedIn => 'Sesión iniciada';

  @override
  String get tailscaleLogout => 'Cerrar sesión';

  @override
  String get tailscaleLoginFailed => 'Error al iniciar sesión en Tailscale';

  @override
  String get tailscaleLoginTimeout =>
      'No se completó el inicio de sesión en cinco minutos. Reintente.';

  @override
  String get tailscaleLoginHint =>
      'Iniciar sesión autoriza este dispositivo. Inicie el proxy para usar la red.';

  @override
  String get tailscaleEnterAuthKey =>
      'Introduzca la clave de autenticación para iniciar sesión en este dispositivo.';

  @override
  String tailscaleCheckSettings(Object fields) {
    return 'Revise estos ajustes: $fields';
  }

  @override
  String get tailscaleNotApplied => 'Sin aplicar';

  @override
  String get tailscaleNotAppliedHint =>
      'La red no forma parte de la configuración activa. Seleccione un perfil y asegúrese de que ningún nodo tenga el mismo nombre.';

  @override
  String get tailscaleNotSignedIn => 'Sin sesión';

  @override
  String get tailscaleNeedsLogin => 'Inicio de sesión necesario';

  @override
  String get tailscaleKeyExpired => 'La clave del nodo ha caducado';

  @override
  String get tailscaleNeedsApproval => 'Dispositivo pendiente de aprobación';

  @override
  String get tailscaleConnecting => 'Conectando';

  @override
  String get tailscaleConnected => 'Conectado';

  @override
  String get tailscaleStopped => 'Detenido';

  @override
  String get tailscaleUnavailable => 'Conexión no disponible';

  @override
  String get tailscaleOnline => 'En línea';

  @override
  String get tailscaleOffline => 'Sin conexión';

  @override
  String get tailscaleRemoveNetwork => 'Eliminar red';

  @override
  String tailscaleRemoveConfirm(Object name) {
    return 'Este dispositivo saldrá de $name y se borrarán sus datos de inicio de sesión de este dispositivo. Si la red es inaccesible, elimine el dispositivo en la consola de administración de Tailscale.';
  }

  @override
  String tailscaleNetworkInUse(Object name, Object profile) {
    return '$name sigue en uso por una regla o grupo del perfil $profile';
  }

  @override
  String get tailscaleGuideGetStarted => 'Primeros pasos';

  @override
  String get tailscaleGuideGetStartedBody =>
      'Añada una red y elija «Guardar e iniciar sesión». Abra la página de inicio de sesión y autorice este dispositivo; la sesión se completa automáticamente.\nPara usar una clave, elija «Clave de autenticación» e introdúzcala. No se necesita navegador.\nLa red solo transporta tráfico mientras el proxy está activo. Iniciar sesión por sí solo no encamina tráfico.';

  @override
  String get tailscaleGuideDevices => 'Dispositivos y MagicDNS';

  @override
  String get tailscaleGuideDevicesBody =>
      'El enrutamiento automático envía las direcciones y nombres MagicDNS de pares conocidos, y las subredes aprobadas del tailnet, a esta red. El resto del tráfico sigue sus reglas.\nSe aplica después de las reglas añadidas y personalizadas y antes de las propias del perfil.\nCon un dominio de servidor de control personalizado, solo se encaminan nombres de dispositivos conocidos, por lo que los sitios públicos del dominio siguen accesibles.\nLas direcciones de subred dentro de la red local actual permanecen locales. Para alcanzar una subred remota con las mismas direcciones, añada una regla dirigida a esta red.\nUn nombre de host que se resuelva a una subred aprobada también pasa por esta red. Si el perfil envía ese nombre directamente a un proxy, añada una regla de dominio dirigida a esta red.';

  @override
  String get tailscaleGuideExitNodes => 'Nodos de salida';

  @override
  String get tailscaleGuideExitNodesBody =>
      'Con un nodo de salida, la red aparece en los grupos de selección del perfil. El tráfico solo usa el nodo de salida tras seleccionar la red allí o dirigir una regla a ella.\nDeje el campo vacío para no usar nodo de salida. auto elige uno disponible; un nombre o dirección selecciona ese dispositivo.';

  @override
  String get tailscaleGuideSignIn => 'Inicio de sesión y copias';

  @override
  String get tailscaleGuideSignInBody =>
      'Los ajustes de red se incluyen en las copias. Las claves de autenticación y la identidad permanecen en este dispositivo; inicie sesión de nuevo al restaurar en otro.\nCuando caduque la clave del nodo, elija de nuevo «Guardar e iniciar sesión». La aprobación de dispositivos y el acceso se gestionan en su tailnet.\nEliminar una red cierra la sesión y borra la identidad de este dispositivo.';

  @override
  String get tailscaleGuideTroubleshooting => 'Solución de problemas';

  @override
  String get tailscaleGuideTroubleshootingBody =>
      'Compruebe que el proxy esté activo, este dispositivo esté aprobado y el par esté en línea. Para subredes o Internet, revise también la aprobación de rutas y el nodo de salida.\n«Sin aplicar» indica que la configuración activa no incluye la red: seleccione un perfil y compruebe que ningún nodo tenga el mismo nombre.\nEsta aplicación solo establece conexiones salientes al tailnet. No acepta conexiones entrantes ni ofrece este dispositivo como router de subred o nodo de salida.';

  @override
  String get tailscaleNameInvalid => 'Use hasta 64 caracteres, sin comas';

  @override
  String get tailscaleHostnameInvalid =>
      'Use minúsculas, números y guiones, hasta 63 caracteres';

  @override
  String get tailscaleAuthKeyInvalid =>
      'Esto no parece una clave de autenticación';

  @override
  String get tailscaleDirect => 'Directa';

  @override
  String tailscaleRelay(Object region) {
    return 'Relé $region';
  }

  @override
  String get tailscaleExitNodeActive => 'Nodo de salida en uso';

  @override
  String get quickAdd => 'Adición rápida';

  @override
  String get rulePresetBlockQuic => 'Bloquear QUIC';

  @override
  String get rulePresetBlockStun => 'Bloquear STUN';

  @override
  String get rulePresetBlockDot => 'Bloquear DNS sobre TLS';

  @override
  String get rulePresetBlockLoopback => 'Bloquear bucle del proxy';

  @override
  String get rulePresetLanDirect => 'LAN directa';

  @override
  String get rulePresetSystemServicesDirect => 'Apple y Microsoft directos';

  @override
  String get rulePresetBittorrentDirect => 'BitTorrent directo';

  @override
  String get rulePresetInsertHint =>
      'Añadir los preajustes seleccionados antes de las reglas existentes. No se vuelven a añadir reglas idénticas.';

  @override
  String get overwriteIssueEmptyName => 'El nombre está vacío';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name es un nombre de política integrado y no se puede usar aquí';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return 'El nombre $name ya está en uso por otro proxy o grupo';
  }

  @override
  String get overwriteIssueNoProxySource =>
      'No hay proxies ni proveedores seleccionados, por lo que el núcleo rechaza este grupo';

  @override
  String overwriteIssueMissingProxies(Object names) {
    return 'Estos proxies o políticas no existen: $names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return 'Estos proveedores de proxies no existen: $names';
  }

  @override
  String overwriteIssueEmptyFallback(Object name) {
    return 'El respaldo de un grupo vacío debe ser un nodo existente o una salida integrada, no un grupo: $name';
  }

  @override
  String overwriteIssueGroupLoop(Object path) {
    return 'Referencia circular entre grupos de proxies: $path';
  }

  @override
  String invalidPolicy(Object target) {
    return '$target no es una política válida';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '$ruleSet no es un conjunto de reglas válido';
  }

  @override
  String invalidSubRule(Object subRule) {
    return '$subRule no es una SUB_RULE válida';
  }

  @override
  String get safeMode => 'Modo seguro';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName (Modo seguro)';
  }

  @override
  String get hideTimeoutProxies => 'Ocultar nodos fallidos';

  @override
  String get delayTestQueued => 'En cola';

  @override
  String get delayTestRunning => 'Probando';

  @override
  String get dnsQueries => 'Consultas DNS';

  @override
  String get dnsQueriesDesc => 'Ver las últimas 500 consultas del resolutor';

  @override
  String get dnsQueryCached => 'En caché';

  @override
  String get dnsQueryUpstream => 'Ascendente';

  @override
  String get dnsQueryAnswers => 'Respuestas';

  @override
  String get dnsQueryRcode => 'Código de respuesta';

  @override
  String get dnsQueryType => 'Tipo de consulta';

  @override
  String get pauseUpdates => 'Pausar actualizaciones';

  @override
  String get resumeUpdates => 'Reanudar actualizaciones';

  @override
  String get dnsQueryAll => 'Todas las consultas';

  @override
  String get dnsQueryFailures => 'Consultas fallidas';

  @override
  String get dnsQueryInitiatorApp => 'Aplicación';

  @override
  String get dnsQueryInitiatorRule => 'Coincidencia de reglas';

  @override
  String get dnsQueryInitiatorDirect => 'Conexión directa';

  @override
  String get dnsQueryInitiatorProxy => 'Conexión proxy';

  @override
  String get dnsQueryInitiatorOther => 'Otro';

  @override
  String get action_ruleMode => 'Modo Reglas';

  @override
  String get action_globalMode => 'Modo Global';

  @override
  String get action_directMode => 'Modo Directo';

  @override
  String get action_delayTest => 'Probar latencia de nodos';

  @override
  String get action_updateProfiles => 'Actualizar perfiles';

  @override
  String get action_copyEnv => 'Copiar variables de entorno del proxy';

  @override
  String get action_exit => 'Salir';

  @override
  String get hotkeyUnavailable => 'Atajo no disponible';

  @override
  String get runTime => 'Tiempo de actividad';

  @override
  String get floatingNavigationBar => 'Navegación flotante';

  @override
  String get localNetworkTip =>
      'Acceso a la red local denegado; se usará gVisor en esta conexión. Los proxies y servicios locales pueden seguir inaccesibles';

  @override
  String get sidebar => 'Barra lateral';

  @override
  String get backgroundBlur => 'Desenfoque de fondo';

  @override
  String get sidebarBlurDesc =>
      'El desenfoque de fondo deja ver el escritorio detrás de la ventana a través de la barra lateral.';

  @override
  String get format => 'Formato';

  @override
  String get behavior => 'Comportamiento';

  @override
  String get appProviderLibrary => 'Biblioteca de proveedores';

  @override
  String get providerLocal => 'Archivo local';

  @override
  String get providerRemote => 'URL remota';

  @override
  String get providerContent => 'Contenido del recurso';

  @override
  String get providerContentInvalid =>
      'El contenido o el formato del recurso no es válido';

  @override
  String get providerContentTooLarge => 'El recurso supera los 32 MiB';

  @override
  String get providerChanged =>
      'El recurso cambió durante la edición; vuelva a abrirlo y reintente';

  @override
  String get providerNameInvalid =>
      'Introduzca un nombre sin comas ni saltos de línea';

  @override
  String providerInUse(String profiles) {
    return 'Este recurso sigue en uso por $profiles';
  }

  @override
  String providerRenameShadowed(String profiles) {
    return 'El cambio de nombre alteraría las referencias a recursos de suscripción en $profiles';
  }

  @override
  String get providerUrlTip =>
      'Introduzca una URL HTTP o HTTPS sin credenciales integradas';

  @override
  String providerSourceReference(String profiles) {
    return 'Edite primero las referencias en los perfiles de origen: $profiles';
  }

  @override
  String providerSourceUnavailable(String profiles) {
    return 'No se pueden leer estos perfiles para comprobar referencias: $profiles';
  }

  @override
  String get nodeDefinition => 'Definición del nodo';

  @override
  String get nodeQuickFields => 'Edición rápida';

  @override
  String get nodeCoreValidationUnavailable =>
      'Inicie el núcleo antes de validar este nodo';

  @override
  String get nodeInvalidDefinition =>
      'Introduzca una definición completa del proxy, con nombre y tipo';

  @override
  String get releaseMemory => 'Liberar memoria';

  @override
  String get memoryCoreHeapInuse => 'Heap en uso';

  @override
  String get memoryCoreHeapIdle => 'Heap inactivo';

  @override
  String get memoryCoreStack => 'Pilas de goroutines';

  @override
  String get memoryCoreRuntime => 'Sobrecarga del runtime';

  @override
  String get memoryCoreNotRunning => 'El núcleo no se está ejecutando';

  @override
  String get memoryAppResident => 'Memoria residente';

  @override
  String get memoryAppShared => 'App y compartida';

  @override
  String get memoryEstimateDesc =>
      'Estimado a partir de la memoria residente del proceso; puede diferir de lo que indica el sistema.';

  @override
  String get memoryEstimateSharedDesc =>
      'El núcleo se ejecuta dentro del proceso de la app. Su parte se estima a partir de las estadísticas del runtime, y el resto cuenta como memoria de la app y compartida.';

  @override
  String get memoryReleased => 'Memoria liberada';

  @override
  String memoryReleasedSize(Object size) {
    return 'Liberado: $size';
  }

  @override
  String get releaseMemoryFailed => 'No se pudo liberar la memoria';

  @override
  String get total => 'Total';

  @override
  String get showNotificationStopAction =>
      'Botón de detener en la notificación';

  @override
  String get interfaceName => 'Nombre de interfaz';

  @override
  String get interfaceNameMode => 'Interfaz de salida';

  @override
  String get interfaceNameDesc =>
      'El nombre de interfaz es la interfaz de red que usan las conexiones salientes.';

  @override
  String get interfaceFollowProfile => 'Seguir el perfil';

  @override
  String get interfaceAutomatic => 'Quitar sobrescritura (interfaz automática)';

  @override
  String get hideIp => 'Ocultar IP';

  @override
  String get cameraPermissionRequired => 'Se requiere permiso de cámara';

  @override
  String get cameraPermissionDesc =>
      'Permite el acceso a la cámara en los ajustes del sistema para escanear códigos QR, o elige una imagen de código QR del álbum.';

  @override
  String get cameraUnavailable => 'Cámara no disponible';

  @override
  String get invalidProfileQrcode =>
      'Este código QR no contiene un enlace de perfil';

  @override
  String get pickFromAlbum => 'Elegir del álbum';

  @override
  String get retry => 'Reintentar';

  @override
  String get toggleFlashlight => 'Activar/Desactivar linterna';

  @override
  String get networkTimeoutError =>
      'Se agotó el tiempo de espera de la solicitud. Comprueba tu red o el proxy e inténtalo de nuevo';

  @override
  String get networkHostLookupError =>
      'No se pudo resolver la dirección del servidor. Comprueba que la URL sea correcta y que el DNS funcione';

  @override
  String get monochromeIcon => 'Icono monocromo';

  @override
  String get networkConnectionError =>
      'No se pudo conectar con el servidor. Comprueba tu conexión de red o los ajustes del proxy';

  @override
  String get networkTlsError =>
      'Falló la conexión segura. Puede que el certificado del servidor no sea válido o que la conexión esté siendo interceptada';

  @override
  String get networkCancelledError => 'Se canceló la solicitud';

  @override
  String networkAccessDeniedError(Object code) {
    return 'El servidor denegó el acceso (HTTP $code). Puede que el enlace haya caducado o que las credenciales sean incorrectas';
  }

  @override
  String networkNotFoundError(Object code) {
    return 'No se encontró nada en esta dirección (HTTP $code). Comprueba que la URL sea correcta';
  }

  @override
  String get networkRateLimitedError =>
      'Demasiadas solicitudes (HTTP 429). Espera un momento e inténtalo de nuevo';

  @override
  String networkServerError(Object code) {
    return 'El servidor tuvo un problema (HTTP $code). Inténtalo de nuevo más tarde';
  }

  @override
  String networkBadResponseError(Object code) {
    return 'El servidor rechazó la solicitud (HTTP $code)';
  }

  @override
  String get clipboardWriteFailed =>
      'No se pudo copiar al portapapeles. Puede que la selección sea demasiado grande';

  @override
  String get lineWrap => 'Ajuste de línea';

  @override
  String get previousMatch => 'Coincidencia anterior';

  @override
  String get nextMatch => 'Coincidencia siguiente';

  @override
  String get editorUnavailable => 'Editor no disponible';

  @override
  String get replaceAll => 'Reemplazar todo';

  @override
  String get fontSize => 'Tamaño';

  @override
  String get replace => 'Reemplazar';

  @override
  String get locateSelected => 'Localizar nodo seleccionado';

  @override
  String get expandList => 'Expandir';

  @override
  String get collapseList => 'Contraer';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get closeAllConnections => 'Cerrar todas las conexiones';

  @override
  String get showMore => 'Expandir';

  @override
  String get showLess => 'Contraer';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get switchProfile => 'Cambiar de perfil';

  @override
  String get subscriptionInfo => 'Información de la suscripción';

  @override
  String get lastUpdated => 'Última actualización';

  @override
  String proxiesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proxies',
      one: '1 proxy',
    );
    return '$_temp0';
  }

  @override
  String rulesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reglas',
      one: '1 regla',
    );
    return '$_temp0';
  }

  @override
  String get back => 'Atrás';

  @override
  String get noSearchResults => 'No hay resultados';

  @override
  String get proxyNode => 'Nodo proxy';

  @override
  String get rules => 'Reglas';

  @override
  String get addOverrideEntry => 'Añadir entrada de sobrescritura';

  @override
  String get batchAdd => 'Añadir en lote';

  @override
  String get batchListInputTip =>
      'Un elemento por línea, o separados por comas';

  @override
  String get batchMapInputTip =>
      'Una entrada por línea: clave, un espacio y el valor';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return '$count por añadir, $skipped omitidos por ya existir';
  }

  @override
  String get cacheAlgorithm => 'Algoritmo de caché';

  @override
  String get cacheMaxSize => 'Tamaño de caché';

  @override
  String get dialerProxy => 'Proxy de marcación';

  @override
  String get dialerProxyDesc =>
      'El proxy de marcación es la salida que se usa para llegar al servidor NTP.';

  @override
  String dialerProxyLoopStopped(Object name) {
    return 'La marcación a través de $name lleva de vuelta al proxy que lo usa, por lo que se detuvo la conexión';
  }

  @override
  String get discardChanges => '¿Descartar los cambios?';

  @override
  String get fakeipFilterMode => 'Modo de filtro Fake-IP';

  @override
  String get fakeipFilterModeDesc =>
      'En el modo de filtro Fake-IP, la lista negra excluye las coincidencias, la lista blanca aplica Fake-IP solo a las coincidencias y rule coincide según las reglas.';

  @override
  String get fakeipRange6 => 'Rango Fake-IP (IPv6)';

  @override
  String get fakeipTtl => 'TTL de Fake-IP';

  @override
  String get ipv6Timeout => 'Tiempo de espera IPv6 (ms)';

  @override
  String lineIssueTip(Object line, Object message) {
    return 'Línea $line: $message';
  }

  @override
  String get listenRoutingMark => 'Marca de enrutamiento de escucha';

  @override
  String get listenRoutingMarkDesc =>
      'La marca de enrutamiento de escucha solo funciona en Linux.';

  @override
  String maxLengthTip(Object label, Object max) {
    return '$label debe tener como máximo $max caracteres';
  }

  @override
  String get ntpInterval => 'Intervalo de sincronización (minutos)';

  @override
  String get ntpStatusDesc =>
      'NTP obtiene la hora de un servidor NTP en lugar del reloj del sistema.';

  @override
  String get overrideEntries => 'Entradas de sobrescritura';

  @override
  String get quickEdit => 'Edición rápida';

  @override
  String get server => 'Servidor';

  @override
  String get singleAdd => 'Añadir uno';

  @override
  String singleValueTip(Object label) {
    return '$label debe ser un solo elemento';
  }

  @override
  String get writeToSystem => 'Escribir en el sistema';

  @override
  String get writeToSystemDesc =>
      'Escribir en el sistema también ajusta el reloj del sistema; Android lo ignora.';

  @override
  String get basicInfo => 'Información básica';

  @override
  String get ruleActionIpSuffixDesc => 'Coincide con un rango de sufijo de IP';

  @override
  String get ruleActionDomainSuffixDesc => 'Coincide con un sufijo de dominio';

  @override
  String get ruleActionMatchDesc =>
      'Coincide con todas las solicitudes, sin necesidad de condiciones';

  @override
  String get ruleActionSrcGeoipDesc =>
      'Coincide con el código de país de la IP de origen';

  @override
  String get ruleActionDomainWildcardDesc =>
      'Coincidencia con comodines; solo se admiten * y ?';

  @override
  String get ruleActionAndDesc => 'Regla lógica AND';

  @override
  String get ruleActionIpCidr6Desc =>
      'Coincide con un rango de direcciones IP; IP-CIDR6 es solo un alias';

  @override
  String get ruleActionDomainRegexDesc =>
      'Coincide con una expresión regular de dominio';

  @override
  String get ruleActionProcessPathRegexDesc =>
      'Coincide con una expresión regular de la ruta del proceso';

  @override
  String get ruleActionDstPortDesc =>
      'Coincide con el rango de puertos de destino';

  @override
  String get ruleActionDscpDesc =>
      'Coincide con la marca DSCP (solo entrada UDP de tproxy)';

  @override
  String get ruleActionInPortDesc => 'Coincide con el puerto de entrada';

  @override
  String get ruleActionUidDesc => 'Coincide con el ID de usuario de Linux';

  @override
  String get ruleActionIpCidrDesc => 'Coincide con un rango de direcciones IP';

  @override
  String get ruleActionRuleSetDesc =>
      'Hace referencia a un conjunto de reglas; requiere rule-providers';

  @override
  String get ruleActionGeositeDesc => 'Coincide con los dominios de Geosite';

  @override
  String get ruleActionNetworkDesc => 'Coincide con TCP o UDP';

  @override
  String get ruleActionProcessPathDesc =>
      'Coincide con la ruta completa del proceso';

  @override
  String get ruleActionProcessPathWildcardDesc =>
      'Coincide con comodines en la ruta del proceso; solo se admiten * y ?';

  @override
  String get ruleActionRematchNameDesc =>
      'Coincide con el nombre de rematch; separa varios nombres con /';

  @override
  String get ruleActionSrcIpSuffixDesc =>
      'Coincide con un rango de sufijo de IP de origen';

  @override
  String get ruleActionGeoipDesc => 'Coincide con el código de país de la IP';

  @override
  String get ruleActionInUserDesc =>
      'Coincide con el nombre de usuario de entrada; separa varios usuarios con /';

  @override
  String get invalidNetworkContent => 'Solo se admite tcp o udp';

  @override
  String get ruleActionDomainKeywordDesc =>
      'Coincide con una palabra clave del dominio';

  @override
  String get ruleActionNotDesc => 'Regla lógica NOT';

  @override
  String get ruleActionSrcIpAsnDesc => 'Coincide con el ASN de la IP de origen';

  @override
  String get invalidRangeContent =>
      'Introduce números o rangos como 80 u 8000-9000, separados por /';

  @override
  String get ruleActionProcessNameRegexDesc =>
      'Coincide con una expresión regular del nombre del proceso; en Android coincide con el nombre del paquete';

  @override
  String get ruleActionSrcIpCidrDesc =>
      'Coincide con un rango de direcciones IP de origen';

  @override
  String get ruleActionDomainDesc => 'Coincide con el dominio completo';

  @override
  String get ruleActionInNameDesc => 'Coincide con el nombre de la entrada';

  @override
  String get invalidDscpContent => 'Una marca DSCP no puede superar 63';

  @override
  String get invalidCidrContent =>
      'Introduce un rango de IP en formato CIDR, como 192.168.0.0/16';

  @override
  String get invalidIpv6CidrContent =>
      'Introduzca un rango IPv6 en formato CIDR, como fd00::/8';

  @override
  String get invalidHostContent => 'Introduce un dominio o una dirección IP';

  @override
  String get invalidListenContent =>
      'Introduce una dirección y un puerto, como 0.0.0.0:1053';

  @override
  String get ruleActionIpAsnDesc => 'Coincide con el ASN de la IP';

  @override
  String get ruleActionSrcPortDesc =>
      'Coincide con el rango de puertos de origen';

  @override
  String get ruleActionInTypeDesc => 'Coincide con el tipo de entrada';

  @override
  String get ruleActionOrDesc => 'Regla lógica OR';

  @override
  String get ruleActionSubRuleDesc =>
      'Coincide con una subregla; cuidado con los paréntesis';

  @override
  String get ruleActionProcessNameWildcardDesc =>
      'Coincide con comodines en el nombre del proceso; solo se admiten * y ?';

  @override
  String get ruleActionProcessNameDesc =>
      'Coincide con el nombre del proceso; en Android coincide con el nombre del paquete';

  @override
  String get general => 'General';

  @override
  String get startupAndBackground => 'Inicio y segundo plano';

  @override
  String get inbound => 'Entrada';

  @override
  String get outbound => 'Salida';

  @override
  String get logsAndDiagnostics => 'Registros y diagnóstico';

  @override
  String get onDemand => 'Bajo demanda';

  @override
  String get onDemandDesc =>
      'Pausar y reanudar el proxy según el Wi-Fi o las condiciones de red';

  @override
  String get prerequisites => 'Requisitos previos';

  @override
  String get suspended => 'Suspendido…';

  @override
  String get enabled => 'Activado';

  @override
  String get enabledOnStart => 'Activar al iniciar';

  @override
  String get disabled => 'Desactivado';

  @override
  String overwriteIssuesSummary(Object count) {
    return '$count elementos tienen problemas; la aplicación de esta sobrescritura puede fallar';
  }

  @override
  String get ignoreBatteryOptimization => 'Ignorar optimización de batería';

  @override
  String get batteryOptimizationDesc =>
      'Ignorar la optimización de batería mantiene la app en ejecución en segundo plano.';

  @override
  String get batteryOptimizationStatusTip =>
      'Las limitaciones del sistema impiden leer correctamente el estado de optimización de batería durante la ejecución';

  @override
  String get authorized => 'Autorizado';

  @override
  String get tapToAuthorize => 'Toca para autorizar';

  @override
  String get addSsid => 'Añadir SSID';

  @override
  String get editSsid => 'Editar SSID';

  @override
  String get ssidsEmpty => 'No hay SSID';

  @override
  String get hotkeyDesc =>
      'Los atajos globales funcionan incluso con la ventana oculta. Toca una acción para grabar su combinación de teclas.';

  @override
  String get hotkeyNotSet => 'Sin asignar';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return 'Incluye al menos una de estas teclas: $modifiers';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return 'Ya lo usa “$action”. Al guardar, pasará a este.';
  }

  @override
  String get confirmExitWindow =>
      '¿Seguro que quieres salir de la ventana actual?';

  @override
  String get dataChangedSave => 'Se detectaron cambios. ¿Guardarlos?';

  @override
  String get discard => 'Descartar';

  @override
  String get docked => 'Fija';

  @override
  String get fade => 'Fundido';

  @override
  String get floating => 'Flotante';

  @override
  String get followSystem => 'Seguir el sistema';

  @override
  String get navigationBarStyle => 'Barra inferior';

  @override
  String get pureBlack => 'Negro puro';

  @override
  String get slide => 'Deslizar';

  @override
  String get textScalePreview => 'Así se verá el texto en la app';

  @override
  String get basicStrategy => 'Estrategias básicas';

  @override
  String get nonTextProviderFile =>
      'Este recurso externo no es un archivo de texto';

  @override
  String get scriptChanged =>
      'El script se modificó o eliminó. Vuelva a abrirlo y reintente.';

  @override
  String get startFromScratch => 'Empezar desde cero';

  @override
  String get optional => 'Opcional';

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Windows bloqueó FlClashCore.exe y Smart App Control está activado. Revise los detalles en Seguridad de Windows → Control de aplicaciones y explorador y use una versión fiable y verificada.';

  @override
  String get helperCorruptTip =>
      'El servicio auxiliar (Helper) no está disponible; no se puede activar el modo TUN. Reinstala FlClash para restaurarlo.';

  @override
  String get changeProxyFailedTip =>
      'No se pudo cambiar de proxy; se ha restaurado la selección anterior';

  @override
  String get databaseWriteFailedTip =>
      'No se pudo guardar el cambio. Compruebe el valor actual y reintente.';

  @override
  String get proxyType => 'Tipo de proxy';

  @override
  String get providerSourceSubscription => 'Suscripción';

  @override
  String get providerSourceProfile => 'Perfil';

  @override
  String get providerSourceApp => 'Biblioteca de la aplicación';

  @override
  String get target => 'Destino';

  @override
  String get outboundExit => 'Salida';

  @override
  String get protocol => 'Protocolo';

  @override
  String get traffic => 'Tráfico';

  @override
  String get totalDownload => 'Descargado';

  @override
  String get totalUpload => 'Subido';

  @override
  String get duration => 'Duración';

  @override
  String get initiatorShort => 'De';

  @override
  String get result => 'Resultado';

  @override
  String get elapsed => 'Tardó';

  @override
  String get tunOverrideDesc =>
      'Las entradas añadidas aquí sustituyen los ajustes de TUN de todos los perfiles; lo que no añadas conserva el ajuste del propio perfil. Las entradas que añade un perfil personalizado tienen prioridad.';

  @override
  String get dnsOverrideDesc =>
      'Las entradas añadidas aquí reemplazan los ajustes DNS de cada perfil; lo que no se añada conserva el ajuste del perfil. Las entradas propias de un perfil personalizado tienen prioridad';

  @override
  String get ntpOverrideDesc =>
      'Las entradas añadidas aquí reemplazan los ajustes NTP de cada perfil; lo que no se añada conserva el ajuste del perfil. Las entradas propias de un perfil personalizado tienen prioridad';

  @override
  String get congestionController => 'Control de congestión TCP';

  @override
  String get congestionControllerDesc =>
      'El control de congestión TCP solo funciona con la pila mips.';

  @override
  String get strictRoute => 'Ruta estricta';

  @override
  String get strictRouteDesc =>
      'La ruta estricta evita que el tráfico, como el DNS, eluda TUN y, con IPv6 desactivado, bloquea las conexiones IPv6 de este dispositivo.';

  @override
  String get routeExcludeAddress => 'Direcciones excluidas de la ruta';

  @override
  String get udpTimeout => 'Tiempo de espera UDP';

  @override
  String get udpTimeoutDesc =>
      'El tiempo de espera UDP se indica en segundos y solo funciona con las pilas gvisor, system y mixed.';

  @override
  String get dnsHijackDesc =>
      'Sin esta entrada, TUN secuestra todas las consultas DNS al puerto 53 (any:53).';

  @override
  String get disableIcmpForwarding => 'Desactivar reenvío ICMP';

  @override
  String get disableIcmpForwardingDesc =>
      'Con el reenvío ICMP desactivado, TUN responde él mismo al ping, por lo que ping ya no muestra la latencia real.';

  @override
  String get includeInterface => 'Interfaces incluidas';

  @override
  String get includeInterfaceDesc =>
      'Solo el tráfico que llega por las interfaces incluidas pasa por TUN, y las interfaces excluidas dejan de aplicarse.';

  @override
  String get excludeInterface => 'Interfaces excluidas';

  @override
  String get excludeInterfaceDesc =>
      'El tráfico que llega por las interfaces excluidas, como docker0, no pasa por TUN.';

  @override
  String get includeUid => 'ID de usuario incluidos';

  @override
  String get includeUidDesc =>
      'Solo el tráfico de los procesos de los ID de usuario incluidos pasa por TUN.';

  @override
  String get excludeUid => 'ID de usuario excluidos';

  @override
  String get excludeUidDesc =>
      'El tráfico de los procesos de los ID de usuario excluidos no pasa por TUN.';

  @override
  String get excludeSrcPort => 'Puertos de origen excluidos';

  @override
  String get excludeSrcPortDesc =>
      'El tráfico desde los puertos de origen excluidos no pasa por TUN.';

  @override
  String get excludeDstPort => 'Puertos de destino excluidos';

  @override
  String get excludeDstPortDesc =>
      'El tráfico hacia los puertos de destino excluidos no pasa por TUN.';

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return '$label debe estar entre $min y $max';
  }

  @override
  String get customProfile => 'Perfil personalizado';

  @override
  String get customProfileDesc =>
      'Crear grupos de proxies y reglas con sus nodos, la biblioteca de proveedores y otros perfiles';

  @override
  String get emptyCustomProfile =>
      'Añada primero un grupo de proxies o una regla a este perfil personalizado';

  @override
  String get nameCustomProfileTip =>
      'Asigne un nombre a este perfil personalizado';

  @override
  String profileProviderInUse(Object profiles) {
    return 'Este perfil proporciona proxies a $profiles. Quítelo primero de esos perfiles.';
  }

  @override
  String get healthCheck => 'Comprobación de estado';

  @override
  String get additionalPrefix => 'Prefijo del nombre';

  @override
  String get additionalSuffix => 'Sufijo del nombre';

  @override
  String get ipVersion => 'Versión de IP';

  @override
  String get profileSettingsDesc =>
      'Se aplica solo a este perfil; lo que no añadas usa su valor predeterminado.';

  @override
  String get profileOverrideSettingsDesc =>
      'Solo se aplica a este perfil y tiene prioridad sobre las sobrescrituras DNS y NTP de la aplicación; las entradas no añadidas siguen dichas sobrescrituras';

  @override
  String get profileTunSettingsDesc =>
      'Se aplica solo a este perfil y tiene prioridad sobre las entradas de sobrescritura de TUN de los ajustes de red.';

  @override
  String get settingEntries => 'ajustes';

  @override
  String get addSettingEntry => 'Añadir ajuste';

  @override
  String settingsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ajustes',
      one: '1 ajuste',
    );
    return '$_temp0';
  }

  @override
  String get sniffer => 'Sniffer';

  @override
  String get snifferStatusDesc =>
      'El sniffer lee el dominio del tráfico TLS, HTTP y QUIC para que las reglas puedan aplicarse.';

  @override
  String get overrideDestination => 'Sobrescribir destino';

  @override
  String get overrideDestinationDesc =>
      'Sobrescribir destino se conecta al dominio detectado en lugar de a la dirección original.';

  @override
  String get forceDnsMapping => 'Forzar mapeo DNS';

  @override
  String get forceDnsMappingDesc =>
      'Forzar mapeo DNS también analiza las conexiones cuyo dominio provino de un mapeo DNS.';

  @override
  String get parsePureIp => 'Analizar IP pura';

  @override
  String get parsePureIpDesc =>
      'Analizar IP pura analiza las conexiones que solo llevan una dirección IP.';

  @override
  String get forceDomain => 'Forzar dominios';

  @override
  String get forceDomainDesc =>
      'Los dominios forzados también se analizan; las demás conexiones que ya tienen dominio se dejan como están.';

  @override
  String get skipDomain => 'Omitir dominios';

  @override
  String get skipDomainDesc =>
      'Un dominio detectado que esté en la lista de dominios omitidos no se usa.';

  @override
  String get skipSrcAddress => 'Omitir direcciones de origen';

  @override
  String get skipDstAddress => 'Omitir direcciones de destino';

  @override
  String get sniffProtocols => 'Protocolos';

  @override
  String get ports => 'Puertos';

  @override
  String get invalidPortRangeContent =>
      'Introduce un puerto o un rango como 443 u 8000-9000';

  @override
  String get importConfig => 'Importar configuración';

  @override
  String get importText => 'Importar desde texto';

  @override
  String get importConfigInvalid => 'Esta configuración no se puede importar';

  @override
  String get importConfigReplaceTip =>
      'La importación reemplaza los nodos, grupos de proxies, reglas y ajustes actuales del perfil';

  @override
  String get customImportCloudRefused =>
      'Las direcciones oixCloud no se pueden importar a un perfil personalizado';

  @override
  String get customImportNotImported => 'Sin importar';

  @override
  String customImportDroppedSubRules(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Se omitieron $count reglas SUB-RULE porque los perfiles personalizados no admiten subreglas',
      one: 'Se omitió 1 regla SUB-RULE porque los perfiles personalizados no admiten subreglas',
    );
    return '$_temp0';
  }

  @override
  String customImportUnnamedProxies(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proxies sin nombre o tipo',
      one: '1 proxy sin nombre o tipo',
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
      other: '$count nodos añadidos desde los enlaces compartidos',
      one: '1 nodo añadido desde los enlaces compartidos',
    );
    return '$_temp0';
  }

  @override
  String shareLinksNotRead(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'No se pudieron leer $count enlaces',
      one: 'No se pudo leer 1 enlace',
    );
    return '$_temp0';
  }

  @override
  String get connectionStats => 'Estadísticas de conexión';

  @override
  String get connectionStatsDesc =>
      'Conexiones activas, solicitudes recientes y consultas DNS';

  @override
  String get currentOutboundDesc =>
      'Contiene el botón de inicio y no se puede quitar';

  @override
  String get dashboardAddableSection => 'Disponibles para añadir';

  @override
  String get dashboardReorderHint =>
      'Arrastra las tarjetas para reordenarlas; en pantallas táctiles, mantén pulsado primero';

  @override
  String get done => 'Hecho';

  @override
  String get editDashboard => 'Editar panel';

  @override
  String groupCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupos',
      one: '1 grupo',
    );
    return '$_temp0';
  }

  @override
  String get groupCountUnit => 'grupos';

  @override
  String groupTimeoutCount(Object count) {
    return '$count sin respuesta';
  }

  @override
  String get ipType => 'Tipo';

  @override
  String get liveConnections => 'Conexiones activas';

  @override
  String get memoryInfoDesc => 'Memoria que usan la app y el núcleo';

  @override
  String get networkTakeover => 'Control del tráfico';

  @override
  String get notRunning => 'Detenido';

  @override
  String portValue(Object port) {
    return 'Puerto $port';
  }

  @override
  String profileDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Quedan $days días',
      one: 'Queda 1 día',
    );
    return '$_temp0';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'quedan $days días',
      one: 'queda 1 día',
    );
    return 'Vence el $date, $_temp0';
  }

  @override
  String profileUpdatedAt(Object time) {
    return 'Actualizado $time';
  }

  @override
  String get proxyGroupsAfterStart =>
      'Los grupos aparecen aquí cuando se inicia el núcleo';

  @override
  String get running => 'En ejecución';

  @override
  String get serviceFailed => 'Error en la comprobación';

  @override
  String get tapIconToRetry => 'Toca el icono para reintentar';

  @override
  String trafficPeak(Object value) {
    return 'Pico: $value';
  }

  @override
  String trafficTotal(Object value) {
    return 'Total: $value';
  }

  @override
  String get usedShort => 'usado';

  @override
  String get disableKeepAlive => 'Desactivar keep-alive TCP';

  @override
  String get keepAliveIdle => 'Inactividad de keep-alive TCP';

  @override
  String get routingMark => 'Marca de enrutamiento';

  @override
  String get minutes => 'minutos';

  @override
  String yearsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count a',
    );
    return '$_temp0';
  }

  @override
  String monthsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count m',
    );
    return '$_temp0';
  }

  @override
  String daysAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count d',
    );
    return '$_temp0';
  }

  @override
  String hoursAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count h',
    );
    return '$_temp0';
  }

  @override
  String minutesAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count min',
    );
    return '$_temp0';
  }

  @override
  String get expireTime => 'Fecha de vencimiento';

  @override
  String get runtimeConfig => 'Configuración de ejecución';

  @override
  String proxyGroupsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupos de proxies',
      one: '1 grupo de proxies',
    );
    return '$_temp0';
  }

  @override
  String get confirmDeleteProxyGroup =>
      '¿Seguro que quieres eliminar este grupo de proxies?';

  @override
  String invalidProxyProvider(Object providerName) {
    return '$providerName no es un proveedor de proxies válido';
  }

  @override
  String customIssuesSummary(Object count) {
    return '$count elementos tienen problemas, y aplicar este perfil puede fallar';
  }

  @override
  String sectionsInEffect(Object count) {
    return '$count en vigor';
  }

  @override
  String get emptyFallback => 'Respaldo si está vacío';

  @override
  String get testInterval => 'Intervalo de prueba';

  @override
  String get testWhenUsed => 'Probar al usarse';

  @override
  String get defaultSelected => 'Selección predeterminada';

  @override
  String get hashByInUser => 'Hash por usuario de entrada';

  @override
  String get nodes => 'Nodos';

  @override
  String get addNodes => 'Añadir nodos';

  @override
  String get autoInclude => 'Incluir automáticamente';

  @override
  String get filters => 'Filtros';

  @override
  String get inputProxyGroupName => 'Introduce el nombre del grupo de proxies';

  @override
  String get definitionNotMap =>
      'La configuración debe ser un mapa YAML con un nombre y un tipo';

  @override
  String get additionalParameters => 'Parámetros adicionales';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get ruleListInvalid =>
      'Las reglas deben ser una lista YAML con una regla por elemento, por ejemplo - DOMAIN,example.com,DIRECT';

  @override
  String get goToConfigureAddedRules =>
      'Ir a la configuración de las reglas añadidas';

  @override
  String get large => 'Grande';

  @override
  String get extraLarge => 'Muy grande';

  @override
  String get matchCase => 'Coincidir mayúsculas y minúsculas';

  @override
  String get regex => 'Expresión regular';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get error => 'Error';

  @override
  String get iconSets => 'Conjuntos de iconos';

  @override
  String get localImage => 'Imagen local';

  @override
  String get label => 'Etiqueta';

  @override
  String get iconSetsEmptyTip =>
      'Aún no hay conjuntos de iconos. Añádelos en Recursos de perfil personalizado → Conjuntos de iconos';

  @override
  String get recommendedIcons => 'Sugeridos';

  @override
  String get customProfileResources => 'Recursos de perfil personalizado';

  @override
  String get importFromLink => 'Importar desde enlace';

  @override
  String get sendFromPhone => 'Enviar desde el teléfono';

  @override
  String get sendFromPhoneTip =>
      'Escanea el código con la cámara del teléfono y pega el enlace en la página que se abre. Ambos dispositivos deben estar en la misma red.';

  @override
  String get sendFromPhoneNoNetwork =>
      'Este dispositivo no está conectado a una red local';

  @override
  String get sendFromPhonePermissionDenied =>
      'Para recibir un enlace desde el teléfono, FlClash necesita el permiso Dispositivos cercanos, que le da acceso a la red local. Actívalo en los ajustes de la aplicación.';

  @override
  String get sendFromPhonePageTitle => 'Enviar un enlace a FlClash';

  @override
  String get sendFromPhonePageHint =>
      'Enlace de suscripción o enlace para compartir un proxy';

  @override
  String get send => 'Enviar';

  @override
  String get sendFromPhonePageSent =>
      'Enviado. Confirma la importación en el otro dispositivo.';

  @override
  String get sendFromPhoneConfirmTitle =>
      '¿Importar el enlace enviado desde el teléfono?';

  @override
  String get shareQrcodeTip =>
      'Escanea con FlClash en otro dispositivo para importar este perfil.';

  @override
  String get qrcodeTooLongTip =>
      'Este enlace es demasiado largo para un código QR. Usa Copiar enlace.';

  @override
  String get invalidLinkTip =>
      'No es un enlace de suscripción ni un enlace para compartir proxies';

  @override
  String get batchLinkInputTip => 'Un enlace por línea';

  @override
  String get link => 'Enlace';

  @override
  String get allowedIps => 'IP permitidas';

  @override
  String get cipher => 'Cifrado';

  @override
  String get clientFingerprint => 'Huella del cliente';

  @override
  String get requestHeaders => 'Encabezados de solicitud';

  @override
  String transportHeaders(Object transport) {
    return 'Encabezados $transport';
  }

  @override
  String get congestionControl => 'Control de congestión';

  @override
  String get downloadBandwidth => 'Ancho de banda de descarga';

  @override
  String get hopInterval => 'Intervalo de salto';

  @override
  String get obfs => 'Ofuscación';

  @override
  String get obfsHost => 'Host de ofuscación';

  @override
  String get obfsMode => 'Modo de ofuscación';

  @override
  String get obfsParam => 'Parámetro de ofuscación';

  @override
  String get obfsPassword => 'Contraseña de ofuscación';

  @override
  String get plugin => 'Complemento';

  @override
  String get pluginHost => 'Host del complemento';

  @override
  String get pluginPath => 'Ruta del complemento';

  @override
  String get pluginUsername => 'Usuario del complemento';

  @override
  String get pluginPassword => 'Contraseña del complemento';

  @override
  String get pluginCipher => 'Cifrado del complemento';

  @override
  String get pluginMode => 'Modo del complemento';

  @override
  String get portHopping => 'Salto de puertos';

  @override
  String get preSharedKey => 'Clave precompartida';

  @override
  String get privateKey => 'Clave privada';

  @override
  String get privateKeyPassphrase => 'Frase de contraseña de la clave privada';

  @override
  String get protocolParam => 'Parámetro del protocolo';

  @override
  String get protocolVersion => 'Versión del protocolo';

  @override
  String get publicKey => 'Clave pública';

  @override
  String get remoteDnsResolve => 'Resolución DNS remota';

  @override
  String get secretKey => 'Clave';

  @override
  String get skipCertVerify => 'Omitir verificación de certificado';

  @override
  String get transport => 'Transporte';

  @override
  String get udpRelayMode => 'Modo de retransmisión UDP';

  @override
  String get uploadBandwidth => 'Ancho de banda de subida';

  @override
  String get username => 'Usuario';

  @override
  String get networkName => 'Nombre de la red';

  @override
  String get networkSecret => 'Clave de la red';

  @override
  String get peers => 'Pares';

  @override
  String get virtualIpv4 => 'IPv4 virtual';

  @override
  String get hostname => 'Nombre de host';

  @override
  String get exitNodes => 'Nodos de salida';

  @override
  String get ageSecretKey => 'Clave secreta de age';

  @override
  String get ageSecretKeyRequiredTip =>
      'Este perfil está cifrado con age y necesita una clave secreta de age para descifrarse';

  @override
  String get ageDecryptFailedTip =>
      'No se pudo descifrar el perfil. Compruebe la clave secreta age y reintente.';

  @override
  String get resetDns => 'Restablecer DNS';

  @override
  String get resetDnsSuccess => 'Estado de DNS borrado';

  @override
  String get resetDnsFailed =>
      'No se pudo restablecer el DNS. Comprueba la conexión con el núcleo e inténtalo de nuevo.';

  @override
  String resourceSizeLimitTip(Object limit) {
    return 'El recurso supera $limit';
  }

  @override
  String get ruleSetDetect => 'Detectar formato y tipo de reglas';

  @override
  String get ruleSetConvert => 'Convertir a MRS';

  @override
  String get ruleSetConvertRemote => 'Descargar como MRS local';

  @override
  String get ruleSetEmptyTip =>
      'El conjunto de reglas no contiene entradas utilizables';

  @override
  String get ruleSetMixedTip =>
      'El conjunto mezcla dominios y rangos IP. Use reglas classical para combinarlos';

  @override
  String get ruleSetInvalidTip =>
      'No se puede leer este conjunto de reglas. Compruebe su formato y sus entradas';

  @override
  String get ruleSetUnsupportedTip =>
      'Estas reglas no se pueden convertir a MRS sin cambiar su comportamiento';

  @override
  String get ruleSetBusyTip =>
      'Hay otra operación de reglas en curso. Vuelva a intentarlo en unos instantes';

  @override
  String get ruleSetNeedsConversionTip =>
      'Este conjunto remoto necesita normalización. Descárguelo como MRS local para usarlo';

  @override
  String get ruleSetSizeTip =>
      'El conjunto de reglas supera el límite de procesamiento. Divídalo en conjuntos más pequeños';

  @override
  String get providerLookupFailed =>
      'No se puede leer la configuración activa del nodo. Actualiza el recurso e inténtalo de nuevo.';

  @override
  String get lookupProxyConfig => 'Buscar la configuración del nodo';

  @override
  String get tunDnsMode => 'Modo DNS del sistema';

  @override
  String get tunDnsModeDesc =>
      'Vacío conserva el comportamiento anterior. disabled no modifica el DNS; native usa la dirección TUN; hijack también intercepta el DNS de otras interfaces (Windows requiere strict-route; Linux, auto-redirect). En macOS, un modo explícito tiene prioridad sobre el DNS automático.';

  @override
  String get nodeShareLinkUnavailable =>
      'Este nodo no se puede convertir en un enlace. Use los campos o YAML';

  @override
  String shareLinkNodesPreserved(int count) {
    return 'Se conservarán sin cambios $count nodos que no se pueden convertir en enlaces';
  }

  @override
  String get select => 'Seleccionar';

  @override
  String get preferred => 'Preferido';

  @override
  String get addToLocalProxies => 'Añadir a nodos personalizados';

  @override
  String addedToLocalProxies(Object name) {
    return '$name añadido a nodos personalizados';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '$name ya está en nodos personalizados';
  }

  @override
  String get generalOverrideDesc =>
      'Las entradas añadidas aquí sustituyen el ajuste correspondiente de todos los perfiles; lo que no añadas conserva el ajuste del propio perfil, o el valor predeterminado del núcleo si el perfil no lo define.';

  @override
  String get groupBy => 'Agrupar por';

  @override
  String get copyHost => 'Copiar host';

  @override
  String get copyDestination => 'Copiar destino';

  @override
  String get closeConnection => 'Cerrar conexión';

  @override
  String get recentRequests => 'Solicitudes recientes';

  @override
  String get root => 'Root';

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'Descifrado HTTPS';

  @override
  String get httpCapture => 'Captura HTTP';

  @override
  String get httpCaptureDesc =>
      'Registra las solicitudes a los hosts indicados en Nombre de host, para verlas en los detalles de la conexión. Los registros solo se guardan en memoria.';

  @override
  String get httpCaptureNoHosts =>
      'No hay ningún host indicado, así que no se registra nada. Añade hosts en Nombre de host, en la página MITM, o desde los detalles de una conexión.';

  @override
  String get httpCaptureLimit => 'Máximo de registros';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return 'Los registros más antiguos se eliminan primero al alcanzar este número u ocupar $memory de memoria. De cada cuerpo se conservan solo los primeros $body.';
  }

  @override
  String get httpRequests => 'Solicitudes HTTP';

  @override
  String get httpRequestsMissing =>
      'Las solicitudes enviadas antes de activar la captura, o ya borradas, no aparecen.';

  @override
  String get httpRequestCleared =>
      'El registro de esta solicitud se ha borrado';

  @override
  String get httpCaptureOff => 'La captura está desactivada';

  @override
  String get inProgress => 'En curso';

  @override
  String get method => 'Método';

  @override
  String get originalUrl => 'URL original';

  @override
  String get timeToFirstByte => 'Tiempo hasta el primer byte';

  @override
  String get requestBody => 'Cuerpo de la solicitud';

  @override
  String get response => 'Respuesta';

  @override
  String get responseBody => 'Cuerpo de la respuesta';

  @override
  String get responseHeaders => 'Encabezados de respuesta';

  @override
  String get matchedRules => 'Reglas aplicadas';

  @override
  String get overview => 'Resumen';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get copyAsBase64 => 'Copiar como Base64';

  @override
  String get copyAsCurl => 'Copiar como cURL';

  @override
  String get copyRequest => 'Copiar solicitud';

  @override
  String get copyResponse => 'Copiar respuesta';

  @override
  String get copyResponseBody => 'Copiar cuerpo de la respuesta';

  @override
  String get httpBodyProtobufGuess =>
      'Leído como Protobuf sin esquema: solo números de campo, y los tipos son supuestos.';

  @override
  String get exportHar => 'Exportar HAR';

  @override
  String get mitmAddRejectRule => 'Añadir una regla de rechazo';

  @override
  String get mitmAddMapLocalRule => 'Añadir una regla de mapeo local';

  @override
  String get httpExportPrivateTitle => 'Contiene datos privados';

  @override
  String get httpExportPrivate =>
      'Una solicitud puede llevar cookies, tokens, contraseñas y contenido de formularios. Revisa qué compartes y con quién.';

  @override
  String get mitmRuleCopiedForStash =>
      'Este módulo es una sobrescritura de Stash, así que la regla se copió para que la añadas a mano.';

  @override
  String get binaryData => 'Datos binarios';

  @override
  String get httpBodyNotKept => 'No se registró por falta de memoria.';

  @override
  String get httpBodyTruncated =>
      'Solo se registró el comienzo de este cuerpo.';

  @override
  String httpBodyUndecoded(Object encoding) {
    return 'No se pudo decodificar $encoding, así que se muestran los datos tal como se enviaron.';
  }

  @override
  String get mitmEnableTip =>
      'FlClash podrá leer todo lo que se envíe a los hosts descifrados, incluidas cookies y contraseñas. Actívalo solo para los hosts que quieras reescribir.';

  @override
  String get certificate => 'Certificado';

  @override
  String get generateCertificate => 'Generar certificado';

  @override
  String get regenerateCertificate => 'Regenerar certificado';

  @override
  String get regenerateCertificateTip =>
      'El nuevo certificado sustituye al actual, que FlClash quita de las raíces de confianza de este dispositivo cuando puede. Cada otro dispositivo que confía en el actual tiene que instalar el nuevo.';

  @override
  String get exportCertificate => 'Exportar certificado';

  @override
  String get installCertificate => 'Instalar en el sistema';

  @override
  String get installCertificateSuccess => 'Certificado instalado';

  @override
  String validUntil(Object date) {
    return 'Válido hasta el $date';
  }

  @override
  String get mitmCertificateExportTip =>
      'Expórtalo y confía en él en los dispositivos que quieras descifrar.';

  @override
  String get mitmTrustReady => 'De confianza';

  @override
  String get mitmTrustUntrusted => 'Sin confianza completa';

  @override
  String get mitmTrustNotInstalled => 'No instalado';

  @override
  String get mitmTrustChecking => 'Comprobando…';

  @override
  String get trustCertificate => 'Confiar en el certificado';

  @override
  String get mitmCertificateAndroidReadyTip =>
      'Solo se descifran las apps que confían en certificados de usuario, sobre todo los navegadores.';

  @override
  String get mitmCertificateLinuxTip =>
      'Los navegadores Flatpak necesitan que importes el certificado exportado a mano.';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome y Firefox tienen sus propios almacenes de certificados, que necesitan certutil: $command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return 'Aún no está en: $stores';
  }

  @override
  String get mitmSystemStoreFailed =>
      'No se pudo añadir el certificado a las raíces de confianza del sistema';

  @override
  String get mitmRootUntilReboot =>
      'No se encontró Magisk, KernelSU ni APatch para conservar el certificado. Vuelve a instalarlo después de reiniciar el dispositivo.';

  @override
  String get mitmRootPendingReboot =>
      'El certificado se aplicará después de reiniciar el dispositivo.';

  @override
  String get mitmInstallSystemCaTip =>
      'Se detectó root: el certificado se añadirá a los certificados de confianza del sistema como el módulo de Magisk, KernelSU o APatch «FlClash MITM CA». Todas las apps del dispositivo confiarán en él, y quien tenga su clave privada podrá descifrar el tráfico HTTPS del dispositivo. Para deshacerlo, regenera el certificado o quita el módulo en el gestor de root y reinicia. Si se deniega root, se instalará como certificado de usuario.';

  @override
  String get mitmInstallUserCaTip =>
      'No se detectó root: el certificado solo puede instalarse como certificado de usuario. Solo se descifran las apps que confían en certificados de usuario, sobre todo los navegadores; las demás fallan en los hosts que indiques, así que no indiques sus hosts. Desde Android 11 terminas la instalación tú mismo en los ajustes del sistema.';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return 'Se guardó $fileName en Descargas. Instálalo en Ajustes › Seguridad › Cifrado y credenciales › Instalar un certificado › Certificado de CA.';
  }

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return 'Quita el certificado antiguo, $name, en Ajustes › Seguridad › Cifrado y credenciales › Credenciales de confianza › Usuario, y después instala el nuevo.';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return 'No se pudo quitar el certificado antiguo, $name. Quítalo tú de las raíces de confianza.';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return 'El certificado antiguo, $name, sigue entre los certificados de confianza del sistema. Permite el acceso root a FlClash en tu gestor de root y vuelve a generarlo, o elimina allí el módulo «FlClash MITM CA» y reinicia.';
  }

  @override
  String get mitmDecryptHost => 'Descifrar este host';

  @override
  String mitmDecryptHostTip(Object host) {
    return '¿Añadir $host a la lista de nombres de host? FlClash podrá leer lo que se le envíe, incluidas cookies y contraseñas.';
  }

  @override
  String get mitmClientRefusedCertificate =>
      'El cliente rechazó el certificado. Instala la CA o excluye este host si la app fija su certificado.';

  @override
  String get mitmExcludeHost => 'Excluir del descifrado';

  @override
  String mitmExcludeHostTip(Object host) {
    return '¿Añadir -$host al principio de la lista de nombres de host? El host ya no se descifrará nunca.';
  }

  @override
  String get urlRewrite => 'Reescritura de URL';

  @override
  String get headerRewrite => 'Reescritura de cabeceras';

  @override
  String get bodyRewrite => 'Reescritura del cuerpo';

  @override
  String get mapLocal => 'Mapeo local';

  @override
  String get mitmHostnameDesc =>
      'Un - al principio excluye un host, y decide la primera coincidencia.';

  @override
  String get mitmModules => 'Módulos';

  @override
  String get mitmModule => 'Módulo';

  @override
  String get mitmModuleInvalid =>
      'No es un módulo de Surge, un plugin de Loon, un fragmento de Quantumult X ni una sobrescritura de Stash';

  @override
  String get arguments => 'Argumentos';

  @override
  String get mitmRoutingRules => 'Reglas de enrutamiento';

  @override
  String get mitmIgnoredLines => 'Líneas ignoradas';

  @override
  String get mitmModuleRulesDesc =>
      'Las reglas de enrutamiento van antes que las del perfil.';

  @override
  String mitmModuleSystemTip(Object system) {
    return 'Escrito para $system; algunas líneas pueden no coincidir con las apps de este dispositivo.';
  }

  @override
  String mitmSkipSection(Object section) {
    return 'La sección [$section] no es compatible';
  }

  @override
  String get mitmSkipSetting => 'Este ajuste no es compatible';

  @override
  String get mitmSkipScriptType => 'Este tipo de script no es compatible';

  @override
  String get mitmSkipRule => 'Este tipo de regla no es compatible';

  @override
  String get mitmSkipPolicy => 'Solo se admiten las políticas DIRECT y REJECT';

  @override
  String get mitmSkipJq => 'Las reescrituras jq no son compatibles';

  @override
  String get mitmSkipJsonBody =>
      'Las reescrituras del cuerpo JSON no son compatibles';

  @override
  String get mitmSkipRawHeader =>
      'No se admite reescribir todos los encabezados como un solo texto';

  @override
  String get mitmSkipConditional =>
      'Las reescrituras condicionales no son compatibles';

  @override
  String get mitmSkipRelativeData =>
      'El archivo que nombra esta línea no está adjunto; usa una URL o adjúntalo';

  @override
  String get mitmSkipNotDownloaded => 'Su archivo aún no se ha descargado';

  @override
  String get mitmSkipUnreadable => 'No se puede leer esta línea';

  @override
  String get mitmAddLocalFile => 'Añadir un archivo local';

  @override
  String get mitmNewModule => 'Nuevo módulo';

  @override
  String get mitmAttachments => 'Adjuntos';

  @override
  String get mitmAttachmentsDesc =>
      'Las líneas hacen referencia a los adjuntos por nombre de archivo, como script-path=a.js.';

  @override
  String mitmFileTooLarge(Object size) {
    return 'El archivo supera los $size MB';
  }

  @override
  String get mitmSkipDisabled => 'Desactivado por un argumento';

  @override
  String get mitmSkipEvent => 'Este evento no es compatible';

  @override
  String get mitmRunScript => 'Ejecutar ahora';

  @override
  String get mitmScriptNoOutput => 'El script terminó sin salida';

  @override
  String get mitmScriptRiskTitle => '¿Ejecutar los scripts de este módulo?';

  @override
  String get mitmScriptRisk =>
      'Sus scripts leen y modifican el tráfico de los hosts que coinciden, incluidas las cookies y los tokens, y pueden enviar sus propias solicitudes. Actívalo solo si confías en su origen.';

  @override
  String get skipServerCertVerify =>
      'Omitir la verificación del certificado del servidor';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => 'Descifrar sin confianza local';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return '$invalid de $total no válidos';
  }

  @override
  String mitmModuleScriptsChanged(Object name) {
    return 'Los scripts de $name han cambiado y se ha desactivado';
  }

  @override
  String failedCount(Object count) {
    return '$count elementos fallaron. Toca para ver';
  }

  @override
  String get proxyServerNameserverDesc =>
      'Solo resuelve los nombres de los servidores proxy.';

  @override
  String get proxyServerNameserverPolicyDesc =>
      'Los nombres de servidores proxy coincidentes usan el servidor DNS indicado aquí en lugar de Proxy Server Nameserver.';

  @override
  String get directNameserverDesc =>
      'Resuelve los dominios de las conexiones directas.';

  @override
  String get fakeipFilterDesc =>
      'Estos dominios reciben su IP real en lugar de una Fake-IP. En modo whitelist, solo ellos reciben Fake-IP.';

  @override
  String get fallbackFilterGeositeDesc =>
      'Los dominios de estas categorías GeoSite se resuelven directamente con Fallback.';

  @override
  String get fallbackFilterIpcidrDesc =>
      'Si Nameserver devuelve una IP de estos rangos, se usa la respuesta de Fallback.';

  @override
  String get fallbackFilterDomainDesc =>
      'Estos dominios se resuelven directamente con Fallback.';

  @override
  String get customResources => 'Personalizado';

  @override
  String get proxyYieldsToSubscription =>
      'La suscripción tiene un nodo con este nombre y este perfil usa ese';

  @override
  String get delayMeasurementUnknown => 'Hora de medición desconocida';

  @override
  String delayMeasuredAt(String time) {
    return 'Última prueba: $time';
  }

  @override
  String get delayMeasurementStale => 'Resultado antiguo; repite la prueba';

  @override
  String get diagUdp => 'Conectividad UDP';

  @override
  String get diagUdpReady => 'Prueba de ida y vuelta UDP correcta';

  @override
  String get diagUdpUnknown => 'No se pudo confirmar la conectividad UDP';

  @override
  String get diagUdpUnsupported => 'Esta ruta no admite UDP';

  @override
  String get diagUdpHint =>
      'La prueba sigue las reglas de enrutamiento actuales. Un tiempo de espera puede deberse al servidor o a la red y no demuestra que todo UDP esté bloqueado.';

  @override
  String get diagTimeline => 'Operaciones recientes';

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
  String get diagStageFetch => 'Obtener configuración';

  @override
  String get diagStageValidate => 'Validar configuración';

  @override
  String get diagStageApply => 'Aplicar configuración';

  @override
  String get diagStageStart => 'Iniciar VPN';

  @override
  String get diagStageStop => 'Detener VPN';

  @override
  String get diagEventStarted => 'Iniciado';

  @override
  String get diagEventSucceeded => 'Correcto';

  @override
  String get diagEventFailed => 'Error';

  @override
  String get diagEventUnchanged => 'Sin cambios de contenido';

  @override
  String get diagEventCanceled => 'Cancelado';

  @override
  String get diagRecorded => 'Historial';

  @override
  String mixedPortReset(Object value, Object port) {
    return 'El puerto mixto no puede ser $value, así que se restableció a $port';
  }

  @override
  String get coreStoppedDesc => 'La app perdió la conexión con el núcleo';

  @override
  String coreStoppedWithReason(Object reason) {
    return 'La app perdió la conexión con el núcleo: $reason';
  }
}
