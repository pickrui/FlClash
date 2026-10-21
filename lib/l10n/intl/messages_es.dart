// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(value) => "Disponible: ${value}";

  static String m1(count, skipped) =>
      "${count} por añadir, ${skipped} omitidos por ya existir";

  static String m2(status) => "El servidor devolvió HTTP ${status}";

  static String m3(error) => "Directa: ${error}";

  static String m4(error) => "Proxy local: ${error}";

  static String m5(code) => "Error del sistema ${code}";

  static String m6(value) => "Comisión ${value}";

  static String m7(line) =>
      "El formato de la configuración no es válido en la línea ${line}.";

  static String m8(expected, actual) =>
      "Se esperaba ${expected}, pero se encontró ${actual}.";

  static String m9(code) =>
      "Windows bloqueó el inicio del núcleo proxy (error del sistema ${code}). Revise el historial de protección de Seguridad de Windows y la política de control de aplicaciones, y verifique el origen y la firma del instalador.";

  static String m10(url) => "¿Quieres crear un perfil a partir de ${url}?";

  static String m11(count) =>
      "${Intl.plural(count, one: 'Se omitió 1 regla SUB-RULE porque los perfiles personalizados no admiten subreglas', other: 'Se omitieron ${count} reglas SUB-RULE porque los perfiles personalizados no admiten subreglas')}";

  static String m12(count) =>
      "${Intl.plural(count, one: '1 proxy sin nombre o tipo', other: '${count} proxies sin nombre o tipo')}";

  static String m13(count) =>
      "${count} elementos tienen problemas, y aplicar este perfil puede fallar";

  static String m14(name) =>
      "${name} sigue referenciado por un grupo, una regla o una cadena de proxies";

  static String m15(example) =>
      "Compruebe el contenido para este tipo de regla. Ejemplo: ${example}";

  static String m16(name) =>
      "${name} no está disponible. Elija un proveedor de reglas existente.";

  static String m17(name) =>
      "${name} no está disponible. Elija un destino de esta configuración.";

  static String m18(count) =>
      "${Intl.plural(count, one: 'hace 1 día', other: 'hace ${count} días')}";

  static String m19(count) => "${Intl.plural(count, other: 'hace ${count} d')}";

  static String m20(label) =>
      "¿Seguro que quieres eliminar los elementos seleccionados (${label})?";

  static String m21(label) => "¿Desea eliminar ${label}?";

  static String m22(label) => "Detalles de ${label}";

  static String m23(port) =>
      "Dirección local: 127.0.0.1\nPuerto mixto (configuración actual): ${port}\nUse este puerto mixto para HTTP, sitios HTTPS o SOCKS5, solo en este dispositivo.";

  static String m24(count) =>
      "${count} de 2 pruebas HTTPS independientes correctas";

  static String m25(name) =>
      "La marcación a través de ${name} lleva de vuelta al proxy que lo usa, por lo que se detuvo la conexión";

  static String m26(label) => "${label} no puede estar vacío";

  static String m27(label) => "${label} ya existe";

  static String m28(date) => "Caduca: ${date}";

  static String m29(label, message) => "${label}: ${message}";

  static String m30(name) => "${name} omitido";

  static String m31(name) => "${name} actualizado";

  static String m32(name) => "Actualizando ${name}…";

  static String m33(count) =>
      "${Intl.plural(count, one: '1 grupo', other: '${count} grupos')}";

  static String m34(name) =>
      "Referencia circular de grupo: ${name}. Elija otro miembro.";

  static String m35(count) => "${count} sin respuesta";

  static String m36(action) =>
      "Ya lo usa “${action}”. Al guardar, pasará a este.";

  static String m37(modifiers) =>
      "Incluye al menos una de estas teclas: ${modifiers}";

  static String m38(count) =>
      "${Intl.plural(count, one: 'hace 1 hora', other: 'hace ${count} horas')}";

  static String m39(count) => "${Intl.plural(count, other: 'hace ${count} h')}";

  static String m40(count) => "${count} horas";

  static String m41(target) => "${target} no es una política válida";

  static String m42(providerName) =>
      "${providerName} no es un proveedor de proxies válido";

  static String m43(ruleSet) => "${ruleSet} no es un conjunto de reglas válido";

  static String m44(subRule) => "${subRule} no es una SUB_RULE válida";

  static String m45(count) =>
      "${Intl.plural(count, one: '1 elemento', other: '${count} elementos')}";

  static String m46(line, message) => "Línea ${line}: ${message}";

  static String m47(appName) =>
      "1. Abre Ajustes del sistema > Privacidad y seguridad\n2. Elige Servicios de localización\n3. Busca ${appName} en la lista y márcalo\n\nCuando termines, vuelve a la app para continuar. Gracias por tu colaboración.";

  static String m48(label, max) =>
      "${label} debe tener como máximo ${max} caracteres";

  static String m49(size) => "Liberado: ${size}";

  static String m50(count) =>
      "${Intl.plural(count, one: 'hace 1 minuto', other: 'hace ${count} minutos')}";

  static String m51(count) =>
      "${Intl.plural(count, other: 'hace ${count} min')}";

  static String m52(count) =>
      "${Intl.plural(count, one: 'hace 1 mes', other: 'hace ${count} meses')}";

  static String m53(count) => "${Intl.plural(count, other: 'hace ${count} m')}";

  static String m54(code) =>
      "El servidor denegó el acceso (HTTP ${code}). Puede que el enlace haya caducado o que las credenciales sean incorrectas";

  static String m55(code) => "El servidor rechazó la solicitud (HTTP ${code})";

  static String m56(code) =>
      "No se encontró nada en esta dirección (HTTP ${code}). Comprueba que la URL sea correcta";

  static String m57(code) =>
      "El servidor tuvo un problema (HTTP ${code}). Inténtalo de nuevo más tarde";

  static String m58(kept, total) => "${kept} de ${total} nodos conservados";

  static String m59(name) => "${name}, excluido";

  static String m60(name) => "${name}, conservado";

  static String m61(label) => "Aún no hay ningún elemento (${label})";

  static String m62(label, min, max) =>
      "${label} debe estar entre ${min} y ${max}";

  static String m63(label) => "${label} debe ser un número";

  static String m64(name) =>
      "El nombre «${name}» ya está en uso. Renombre el grupo personal para conservar ambos.";

  static String m65(name) =>
      "El nombre ${name} ya está en uso por otro proxy o grupo";

  static String m66(name) =>
      "El respaldo de un grupo vacío debe ser un nodo existente o una salida integrada, no un grupo: ${name}";

  static String m67(path) =>
      "Referencia circular entre grupos de proxies: ${path}";

  static String m68(names) =>
      "Estos proveedores de proxies no existen: ${names}";

  static String m69(names) => "Estos proxies o políticas no existen: ${names}";

  static String m70(name) =>
      "${name} es un nombre de política integrado y no se puede usar aquí";

  static String m71(count) =>
      "${count} elementos tienen problemas; la aplicación de esta sobrescritura puede fallar";

  static String m72(id) => "Plan n.º ${id}";

  static String m73(port) => "Se ha introducido el puerto sugerido ${port}.";

  static String m74(label) => "${label} debe estar entre 1024 y 49151";

  static String m75(port) =>
      "No se pudo abrir el puerto mixto ${port}; otra aplicación podría estar usándolo. Cambie el puerto para volver a intentarlo de inmediato.";

  static String m76(port) => "Puerto ${port}";

  static String m77(days) =>
      "${Intl.plural(days, one: 'Queda 1 día', other: 'Quedan ${days} días')}";

  static String m78(date, days) =>
      "Vence el ${date}, ${Intl.plural(days, one: 'queda 1 día', other: 'quedan ${days} días')}";

  static String m79(profiles) =>
      "Este perfil proporciona proxies a ${profiles}. Quítelo primero de esos perfiles.";

  static String m80(time) => "Actualizado ${time}";

  static String m81(profiles) => "Este recurso sigue en uso por ${profiles}";

  static String m82(profiles) =>
      "El cambio de nombre alteraría las referencias a recursos de suscripción en ${profiles}";

  static String m83(profiles) =>
      "Edite primero las referencias en los perfiles de origen: ${profiles}";

  static String m84(profiles) =>
      "No se pueden leer estos perfiles para comprobar referencias: ${profiles}";

  static String m85(count) =>
      "${Intl.plural(count, one: '1 proxy', other: '${count} proxies')}";

  static String m86(name) =>
      "El nodo ${name} ya pertenece a otra cadena activa o tiene un conflicto de encadenamiento";

  static String m87(name) =>
      "El nodo ${name} no está disponible en esta posición";

  static String m88(address) =>
      "Antes del inicio, el proxy del sistema apuntaba a ${address}.";

  static String m89(name) =>
      "Antes del inicio, el tráfico pasaba por otra VPN o adaptador virtual: ${name}.";

  static String m90(count) =>
      "${Intl.plural(count, one: '1 grupo de proxies', other: '${count} grupos de proxies')}";

  static String m91(count) => "${count} d";

  static String m92(count) => "${count} h";

  static String m93(count) => "${count} min";

  static String m94(name, path) =>
      "La configuración original hace referencia a ${name} en ${path}";

  static String m95(min, max) => "Intervalo permitido: ${min} – ${max}";

  static String m96(value) => "Restante: ${value}";

  static String m97(count) => "Solo quedan ${count}";

  static String m98(seconds) => "Reenviar en ${seconds} s";

  static String m99(limit) => "El recurso supera ${limit}";

  static String m100(count) =>
      "${Intl.plural(count, one: '1 regla', other: '${count} reglas')}";

  static String m101(appName) => "${appName} (Modo seguro)";

  static String m102(count) => "Añadidos (${count})";

  static String m103(count) => "Modificados (${count})";

  static String m104(count) => "Eliminados (${count})";

  static String m105(count) => "${count} segundos";

  static String m106(count) => "${count} en vigor";

  static String m107(count) =>
      "${Intl.plural(count, one: '1 ajuste', other: '${count} ajustes')}";

  static String m108(count) =>
      "${Intl.plural(count, one: '1 nodo añadido desde los enlaces compartidos', other: '${count} nodos añadidos desde los enlaces compartidos')}";

  static String m109(count) =>
      "${Intl.plural(count, one: 'No se pudo leer 1 enlace', other: 'No se pudieron leer ${count} enlaces')}";

  static String m110(label) => "${label} debe ser un solo elemento";

  static String m111(fields) => "Revise estos ajustes: ${fields}";

  static String m112(count) => "Dispositivos (${count})";

  static String m113(name, profile) =>
      "${name} sigue en uso por una regla o grupo del perfil ${profile}";

  static String m114(region) => "Relé ${region}";

  static String m115(name) =>
      "Este dispositivo saldrá de ${name} y se borrarán sus datos de inicio de sesión de este dispositivo. Si la red es inaccesible, elimine el dispositivo en la consola de administración de Tailscale.";

  static String m116(value) => "Pico: ${value}";

  static String m117(value) => "Total: ${value}";

  static String m118(build) => "Compilación: ${build}";

  static String m119(version) => "Versión: ${version}";

  static String m120(label) => "${label} debe ser una URL";

  static String m121(count) =>
      "${Intl.plural(count, one: 'hace 1 año', other: 'hace ${count} años')}";

  static String m122(count) =>
      "${Intl.plural(count, other: 'hace ${count} a')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
    "accessControl": MessageLookupByLibrary.simpleMessage("Control de acceso"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Solo las aplicaciones seleccionadas usan la VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Configurar el acceso de las aplicaciones al proxy",
    ),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "El control de acceso de apps está desactivado",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Las aplicaciones seleccionadas se excluyen de la VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Ajustes de control de acceso",
    ),
    "accessToken": MessageLookupByLibrary.simpleMessage("Token de acceso"),
    "account": MessageLookupByLibrary.simpleMessage("Cuenta"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("Saldo"),
    "action": MessageLookupByLibrary.simpleMessage("Acción"),
    "action_copyEnv": MessageLookupByLibrary.simpleMessage(
      "Copiar variables de entorno del proxy",
    ),
    "action_delayTest": MessageLookupByLibrary.simpleMessage(
      "Probar latencia de nodos",
    ),
    "action_directMode": MessageLookupByLibrary.simpleMessage("Modo Directo"),
    "action_exit": MessageLookupByLibrary.simpleMessage("Salir"),
    "action_globalMode": MessageLookupByLibrary.simpleMessage("Modo Global"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Cambiar de modo"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("Proxy del sistema"),
    "action_ruleMode": MessageLookupByLibrary.simpleMessage("Modo Reglas"),
    "action_start": MessageLookupByLibrary.simpleMessage("Iniciar/Detener"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_updateProfiles": MessageLookupByLibrary.simpleMessage(
      "Actualizar perfiles",
    ),
    "action_view": MessageLookupByLibrary.simpleMessage("Mostrar/Ocultar"),
    "activate": MessageLookupByLibrary.simpleMessage("Activar"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Activar este plan? Pasará a ser su plan activo.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage("Activar plan"),
    "add": MessageLookupByLibrary.simpleMessage("Añadir"),
    "addNodes": MessageLookupByLibrary.simpleMessage("Añadir nodos"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Añadir entrada de sobrescritura",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Añadir perfil"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("Añadir"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Añadir grupo de proxies",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Añadir regla"),
    "addSettingEntry": MessageLookupByLibrary.simpleMessage("Añadir ajuste"),
    "addSsid": MessageLookupByLibrary.simpleMessage("Añadir SSID"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Reglas añadidas"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Parámetros adicionales",
    ),
    "additionalPrefix": MessageLookupByLibrary.simpleMessage(
      "Prefijo del nombre",
    ),
    "additionalSuffix": MessageLookupByLibrary.simpleMessage(
      "Sufijo del nombre",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Dirección"),
    "addressCopied": MessageLookupByLibrary.simpleMessage("Dirección copiada"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "Dirección del servidor WebDAV",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Introduce una dirección WebDAV válida",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Configuración avanzada",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Acceder a diversas opciones de configuración",
    ),
    "ageDecryptFailedTip": MessageLookupByLibrary.simpleMessage(
      "No se pudo descifrar el perfil. Compruebe la clave secreta age y reintente.",
    ),
    "ageSecretKey": MessageLookupByLibrary.simpleMessage(
      "Clave secreta de age",
    ),
    "ageSecretKeyRequiredTip": MessageLookupByLibrary.simpleMessage(
      "Este perfil está cifrado con age y necesita una clave secreta de age para descifrarse",
    ),
    "allowBackgroundLocation": MessageLookupByLibrary.simpleMessage(
      "Permitir siempre",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Permitir que las apps eludan la VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Permitir que algunas aplicaciones omitan la VPN",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Permitir LAN"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Permitir el acceso al proxy desde la red local",
    ),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage(
      "Permitir temporalmente",
    ),
    "allowedIps": MessageLookupByLibrary.simpleMessage("IP permitidas"),
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("Importe adeudado"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("Importe a pagar"),
    "announcement": MessageLookupByLibrary.simpleMessage("Aviso"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "El servicio API funciona",
    ),
    "apiAvailableWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "La API fue accesible con una excepción temporal de certificado. No se sincronizaron la cuenta ni la configuración de nodos. Resuelva el problema del certificado y vuelva a comprobarlo.",
        ),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Control de acceso de apps",
    ),
    "appProviderLibrary": MessageLookupByLibrary.simpleMessage(
      "Biblioteca de proveedores",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Añadir DNS del sistema",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Añadir siempre el DNS del sistema a la configuración",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Aplicación"),
    "authentication": MessageLookupByLibrary.simpleMessage(
      "Autenticación del proxy local",
    ),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron aplicar los ajustes de autenticación",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Solicitar usuario y contraseña en los puertos HTTP y SOCKS. Mientras está activo, no se configura el proxy HTTP del sistema; TUN y VPN siguen funcionando",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "Use de 1 a 255 bytes UTF-8, sin caracteres de control",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "El proxy del sistema no se aplica mientras está activa la autenticación del proxy local",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use de 1 a 255 bytes UTF-8, sin dos puntos ni caracteres de control",
    ),
    "authorized": MessageLookupByLibrary.simpleMessage("Autorizado"),
    "auto": MessageLookupByLibrary.simpleMessage("Automático"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Cerrar conexiones automáticamente",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Cerrar las conexiones automáticamente al cambiar de nodo",
    ),
    "autoInclude": MessageLookupByLibrary.simpleMessage(
      "Incluir automáticamente",
    ),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("IPv6 automático"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "Activar o desactivar IPv6 según la compatibilidad de la red local",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Inicio automático"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Iniciar con el sistema",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Ejecución automática"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Iniciar automáticamente al abrir la aplicación",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Configurar DNS del sistema automáticamente",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage(
      "Actualización automática",
    ),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Intervalo de actualización automática",
    ),
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("Elegir un plan"),
    "back": MessageLookupByLibrary.simpleMessage("Atrás"),
    "backup": MessageLookupByLibrary.simpleMessage("Copia de seguridad"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridad y restauración",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Sincronizar datos mediante WebDAV o archivos",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "Esta copia de seguridad procede de una versión más reciente de la app. Actualiza la app antes de restaurarla",
    ),
    "backupRetention": MessageLookupByLibrary.simpleMessage(
      "Copias que conservar",
    ),
    "backupRetentionDesc": MessageLookupByLibrary.simpleMessage(
      "Cada copia elimina las copias antiguas de este dispositivo en WebDAV",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Copia completada"),
    "balance": MessageLookupByLibrary.simpleMessage("Saldo"),
    "balanceDeductionHint": MessageLookupByLibrary.simpleMessage(
      "Las compras usan primero el saldo y después las comisiones para cubrir la diferencia.",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Información básica"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage(
      "Estrategias básicas",
    ),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Añadir en lote"),
    "batchLinkInputTip": MessageLookupByLibrary.simpleMessage(
      "Un enlace por línea",
    ),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "Un elemento por línea, o separados por comas",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "Una entrada por línea: clave, un espacio y el valor",
    ),
    "batchPreviewTip": m1,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Ignorar la optimización de batería mantiene la app en ejecución en segundo plano.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Las limitaciones del sistema impiden leer correctamente el estado de optimización de batería durante la ejecución",
    ),
    "behavior": MessageLookupByLibrary.simpleMessage("Comportamiento"),
    "billingPeriodLabel": MessageLookupByLibrary.simpleMessage(
      "Periodo de facturación",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Vincular"),
    "bindCoupon": MessageLookupByLibrary.simpleMessage("Aplicar cupón"),
    "bindCouponIntro": MessageLookupByLibrary.simpleMessage(
      "Introduzca un cupón oficial. La diferencia se liquida por el tiempo restante del plan; un cupón recurrente también actualiza el precio de renovación.",
    ),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Modo lista negra"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("Bloquear QUIC"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "Rechazar el tráfico UDP del puerto 443 para forzar el uso de TCP",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("Bloquear WebRTC"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "Rechazar el tráfico STUN para reducir las fugas de IP por WebRTC.",
    ),
    "brightness": MessageLookupByLibrary.simpleMessage("Brillo"),
    "buy": MessageLookupByLibrary.simpleMessage("Comprar"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Dominios excluidos"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Los dominios excluidos solo se aplican mientras el proxy del sistema esté activado.",
    ),
    "bypassPrivateRoute": MessageLookupByLibrary.simpleMessage(
      "Omitir direcciones privadas",
    ),
    "bypassPrivateRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Con Omitir direcciones privadas activado, las direcciones de LAN, loopback y multidifusión no pasan por TUN.",
    ),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage(
      "Algoritmo de caché",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "La caché está dañada. ¿Borrarla?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Tamaño de caché"),
    "calculatingQuote": MessageLookupByLibrary.simpleMessage("Calculando…"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Permite el acceso a la cámara en los ajustes del sistema para escanear códigos QR, o elige una imagen de código QR del álbum.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Se requiere permiso de cámara",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Cámara no disponible",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Deseleccionar todo",
    ),
    "certificateCheckOnlyHint": MessageLookupByLibrary.simpleMessage(
      "Esta acción solo comprueba el acceso a la API. No inicia sesión ni descarga la configuración de nodos.",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage(
      "El certificado ha caducado",
    ),
    "certificateHostnameHint": MessageLookupByLibrary.simpleMessage(
      "Pruebe otra red y complete primero cualquier inicio de sesión Wi-Fi. Si persiste, pida al proveedor que compruebe que el certificado corresponda al dominio del servidor.",
    ),
    "certificateHostnameMismatch": MessageLookupByLibrary.simpleMessage(
      "El certificado no coincide con el dominio solicitado",
    ),
    "certificateNotYetValid": MessageLookupByLibrary.simpleMessage(
      "El certificado aún no es válido",
    ),
    "certificateRevoked": MessageLookupByLibrary.simpleMessage(
      "El certificado ha sido revocado",
    ),
    "certificateRevokedHint": MessageLookupByLibrary.simpleMessage(
      "Pida al proveedor que sustituya el certificado revocado. Reintentar o cambiar la hora del sistema no resolverá el problema.",
    ),
    "certificateSyncRetryDescription": MessageLookupByLibrary.simpleMessage(
      "Tras confirmar, este intento comprueba la conexión, actualiza la cuenta y descarga la configuración de nodos. La excepción de certificado termina al finalizar la sincronización.",
    ),
    "certificateUnknownHint": MessageLookupByLibrary.simpleMessage(
      "Compruebe la fecha y la hora del sistema y pruebe otra red. Si la verificación sigue fallando, envíe este error al proveedor para obtener ayuda.",
    ),
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "La cadena de certificados no es de confianza",
    ),
    "certificateUntrustedHint": MessageLookupByLibrary.simpleMessage(
      "Pruebe otra red, como un punto de acceso móvil, y busque actualizaciones del sistema. Si un antivirus o una red de empresa inspecciona HTTPS, consulte a su administrador. Si persiste, pida al proveedor que revise la cadena de certificados.",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "Sincronice primero la fecha y la hora del sistema. Si son correctas, debe corregirse el certificado del servidor.",
    ),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "No se pudo cambiar de proxy; se ha restaurado la selección anterior",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Cambios incompatibles",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Novedades"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Correcciones"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage("Rendimiento"),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Reversiones"),
    "checkApi": MessageLookupByLibrary.simpleMessage("Comprobar API"),
    "checkRouting": MessageLookupByLibrary.simpleMessage(
      "Comprobar configuración",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage(
      "Buscar actualizaciones",
    ),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "La aplicación ya está actualizada",
    ),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron buscar actualizaciones. Compruebe la conexión y vuelva a intentarlo",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("Comprobando…"),
    "chooseMembers": MessageLookupByLibrary.simpleMessage("Elegir miembros"),
    "cipher": MessageLookupByLibrary.simpleMessage("Cifrado"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("Borrar todo"),
    "clearData": MessageLookupByLibrary.simpleMessage("Borrar datos"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage("Borrar la cadena"),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Borrar búsqueda"),
    "clientFingerprint": MessageLookupByLibrary.simpleMessage(
      "Huella del cliente",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Exportar al portapapeles",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Importar desde el portapapeles",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo copiar al portapapeles. Puede que la selección sea demasiado grande",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "closeAllConnections": MessageLookupByLibrary.simpleMessage(
      "Cerrar todas las conexiones",
    ),
    "cloudApiAccessDenied": MessageLookupByLibrary.simpleMessage(
      "Acceso a la red denegado",
    ),
    "cloudApiAddressInUse": MessageLookupByLibrary.simpleMessage(
      "Dirección de red o puerto ya en uso",
    ),
    "cloudApiAddressUnavailable": MessageLookupByLibrary.simpleMessage(
      "Dirección de red no disponible",
    ),
    "cloudApiBadGateway": MessageLookupByLibrary.simpleMessage(
      "La puerta de enlace recibió una respuesta ascendente no válida",
    ),
    "cloudApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "El servidor rechazó la solicitud por no ser válida",
    ),
    "cloudApiClockSkew": MessageLookupByLibrary.simpleMessage(
      "El reloj del dispositivo difiere demasiado del servidor. Active la fecha y hora automáticas y reintente.",
    ),
    "cloudApiConnectTimeout": MessageLookupByLibrary.simpleMessage(
      "Tiempo de conexión agotado",
    ),
    "cloudApiConnectionAborted": MessageLookupByLibrary.simpleMessage(
      "Conexión interrumpida",
    ),
    "cloudApiConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Error de conexión",
    ),
    "cloudApiConnectionRefused": MessageLookupByLibrary.simpleMessage(
      "Conexión rechazada",
    ),
    "cloudApiConnectionReset": MessageLookupByLibrary.simpleMessage(
      "Conexión restablecida",
    ),
    "cloudApiDnsEmpty": MessageLookupByLibrary.simpleMessage(
      "DNS no devolvió ninguna dirección: posible bloqueo o fallo del resolutor del sistema",
    ),
    "cloudApiDnsFailed": MessageLookupByLibrary.simpleMessage(
      "Error de resolución DNS",
    ),
    "cloudApiDnsUnknownHost": MessageLookupByLibrary.simpleMessage(
      "DNS no pudo encontrar este dominio",
    ),
    "cloudApiForbidden": MessageLookupByLibrary.simpleMessage(
      "Acceso prohibido",
    ),
    "cloudApiGatewayTimeout": MessageLookupByLibrary.simpleMessage(
      "La puerta de enlace agotó el tiempo de espera del servidor ascendente",
    ),
    "cloudApiHttpError": m2,
    "cloudApiInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Respuesta del servidor no válida",
    ),
    "cloudApiMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Método de solicitud no permitido",
    ),
    "cloudApiNetworkAuthRequired": MessageLookupByLibrary.simpleMessage(
      "Esta red requiere iniciar sesión antes de acceder",
    ),
    "cloudApiNetworkResourcesExhausted": MessageLookupByLibrary.simpleMessage(
      "Recursos de red del sistema insuficientes",
    ),
    "cloudApiNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "Red inaccesible",
    ),
    "cloudApiNotFound": MessageLookupByLibrary.simpleMessage(
      "No se encontró la API o el recurso solicitado",
    ),
    "cloudApiProxyAuthFailed": MessageLookupByLibrary.simpleMessage(
      "Error de autenticación del proxy (HTTP 407)",
    ),
    "cloudApiProxyFailed": MessageLookupByLibrary.simpleMessage(
      "Error de conexión al proxy",
    ),
    "cloudApiRateLimited": MessageLookupByLibrary.simpleMessage(
      "Demasiadas solicitudes; inténtelo más tarde",
    ),
    "cloudApiReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Tiempo de espera de respuesta agotado",
    ),
    "cloudApiRedirectInvalid": MessageLookupByLibrary.simpleMessage(
      "Redirección del servidor no válida",
    ),
    "cloudApiRedirectLimit": MessageLookupByLibrary.simpleMessage(
      "Demasiadas redirecciones del servidor",
    ),
    "cloudApiRedirectLoop": MessageLookupByLibrary.simpleMessage(
      "Bucle de redirecciones del servidor",
    ),
    "cloudApiRequestCanceled": MessageLookupByLibrary.simpleMessage(
      "Solicitud cancelada",
    ),
    "cloudApiRequestTooLarge": MessageLookupByLibrary.simpleMessage(
      "La solicitud supera el límite de tamaño del servidor",
    ),
    "cloudApiResponseInterrupted": MessageLookupByLibrary.simpleMessage(
      "Conexión cerrada antes de recibir toda la respuesta",
    ),
    "cloudApiResponseTooLarge": MessageLookupByLibrary.simpleMessage(
      "La respuesta del servidor supera el tamaño permitido",
    ),
    "cloudApiRouteDirect": m3,
    "cloudApiRouteProxy": m4,
    "cloudApiSendTimeout": MessageLookupByLibrary.simpleMessage(
      "Tiempo de envío de la solicitud agotado",
    ),
    "cloudApiServerError": MessageLookupByLibrary.simpleMessage(
      "Error interno del servidor",
    ),
    "cloudApiServerRequestTimeout": MessageLookupByLibrary.simpleMessage(
      "Se agotó el tiempo del servidor para recibir la solicitud",
    ),
    "cloudApiServerUnconfigured": MessageLookupByLibrary.simpleMessage(
      "El servidor no tiene una clave configurada para esta aplicación. Contacte con soporte.",
    ),
    "cloudApiServiceUnavailable": MessageLookupByLibrary.simpleMessage(
      "Servicio no disponible temporalmente",
    ),
    "cloudApiSignatureRejected": MessageLookupByLibrary.simpleMessage(
      "El servidor rechazó la firma de esta aplicación. Reinstale la última versión oficial.",
    ),
    "cloudApiSystemError": m5,
    "cloudApiTimeout": MessageLookupByLibrary.simpleMessage(
      "Tiempo de solicitud agotado",
    ),
    "cloudApiTlsAlgorithmFailed": MessageLookupByLibrary.simpleMessage(
      "Error al negociar los algoritmos criptográficos TLS",
    ),
    "cloudApiTlsFailed": MessageLookupByLibrary.simpleMessage(
      "Error en la negociación TLS",
    ),
    "cloudApiTlsInterrupted": MessageLookupByLibrary.simpleMessage(
      "Conexión cerrada antes de completar la negociación TLS",
    ),
    "cloudApiTlsProtocolFailed": MessageLookupByLibrary.simpleMessage(
      "Protocolo TLS incompatible o respuesta TLS no válida",
    ),
    "cloudCertificateSyncFailed": MessageLookupByLibrary.simpleMessage(
      "La comprobación de la API fue correcta, pero falló la sincronización de la cuenta o los nodos: ",
    ),
    "cloudConfigSyncIncomplete": MessageLookupByLibrary.simpleMessage(
      "No se descargó la configuración de nodos. Resuelva el error y vuelva a sincronizar.",
    ),
    "cloudSyncedWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "La cuenta y la configuración se sincronizaron con una excepción temporal de certificado. La verificación se ha restablecido; resuelva el problema antes de la próxima sincronización.",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Código de verificación enviado",
    ),
    "collapseList": MessageLookupByLibrary.simpleMessage("Contraer"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorStyle": MessageLookupByLibrary.simpleMessage("Estilo de color"),
    "columns": MessageLookupByLibrary.simpleMessage("Columnas"),
    "commission": MessageLookupByLibrary.simpleMessage("Comisión"),
    "commissionBalance": m6,
    "compact": MessageLookupByLibrary.simpleMessage("Compacto"),
    "compatible": MessageLookupByLibrary.simpleMessage(
      "Modo de compatibilidad",
    ),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Se han detectado datos en la configuración",
    ),
    "configParseErrorAtLine": m7,
    "configRecoveryKeyring": MessageLookupByLibrary.simpleMessage(
      "No se pudo acceder al llavero del sistema (Secret Service). Active y desbloquee KDE Wallet o GNOME Keyring en los ajustes del sistema y reintente.",
    ),
    "configRecoveryMessage": MessageLookupByLibrary.simpleMessage(
      "La configuración local no está disponible temporalmente. Sus datos se han conservado. Desbloquee el dispositivo y reintente, o vuelva a abrir la aplicación más tarde.",
    ),
    "configRecoveryMissingKey": MessageLookupByLibrary.simpleMessage(
      "La clave de cifrado de su configuración falta o no es válida. Pruebe la cuenta y el dispositivo originales, o restaure una copia. Reintentar no recrea una clave perdida.",
    ),
    "configRecoveryReset": MessageLookupByLibrary.simpleMessage(
      "Copiar y restablecer",
    ),
    "configRecoveryResetConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Crear una copia cifrada de todos los ajustes, suscripciones, reglas y datos de cuenta y restablecer la aplicación? Tendrá que iniciar sesión e importar o restaurar sus suscripciones y ajustes. La copia está protegida por esta cuenta de Windows y no puede recuperar una clave perdida.",
    ),
    "configRecoveryResetDone": MessageLookupByLibrary.simpleMessage(
      "Se ha guardado una copia cifrada de los datos originales en la carpeta indicada. Cierre y vuelva a abrir la aplicación para configurarla de nuevo.",
    ),
    "configRecoveryResetFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron completar la copia cifrada y el restablecimiento. Los datos originales restantes no se eliminarán sin una copia verificada. Reintente o cierre y vuelva a abrir la aplicación para finalizar.",
    ),
    "configRecoveryRetry": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "configRecoveryStorage": MessageLookupByLibrary.simpleMessage(
      "No se pudo leer o guardar la configuración local o su clave. Compruebe el acceso a la carpeta de datos y al almacenamiento seguro del sistema, y reintente.",
    ),
    "configRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Recuperar la configuración local",
    ),
    "configRecoveryUnreadable": MessageLookupByLibrary.simpleMessage(
      "La configuración local no se puede descifrar o está dañada. Los archivos existentes se conservan. Restaure la clave y la copia correspondientes, o haga una copia y restablezca.",
    ),
    "configRecoveryUseLocalStorage": MessageLookupByLibrary.simpleMessage(
      "Usar un archivo local",
    ),
    "configRecoveryUseLocalStorageConfirm":
        MessageLookupByLibrary.simpleMessage(
          "¿Guardar las claves y credenciales en un archivo de la carpeta de la aplicación accesible solo por su cuenta, en lugar del llavero del sistema? Cualquier programa ejecutado con su cuenta podrá leerlas y descifrar la configuración local. Esta elección seguirá vigente.",
        ),
    "configTypeMismatch": m8,
    "configValueTypeBoolean": MessageLookupByLibrary.simpleMessage(
      "un booleano",
    ),
    "configValueTypeInteger": MessageLookupByLibrary.simpleMessage("un entero"),
    "configValueTypeList": MessageLookupByLibrary.simpleMessage("una lista"),
    "configValueTypeNull": MessageLookupByLibrary.simpleMessage(
      "un valor vacío",
    ),
    "configValueTypeNumber": MessageLookupByLibrary.simpleMessage("un número"),
    "configValueTypeObject": MessageLookupByLibrary.simpleMessage("un objeto"),
    "configValueTypeText": MessageLookupByLibrary.simpleMessage("texto"),
    "configYamlFormatHint": MessageLookupByLibrary.simpleMessage(
      "Compruebe la sangría y los marcadores de lista «-» cerca de esta línea.",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres borrar todos los datos?",
    ),
    "confirmClearCustomRouting": MessageLookupByLibrary.simpleMessage(
      "¿Borrar los grupos de proxies y las reglas personalizados de este perfil? Se conservarán el contenido de la suscripción, las reglas añadidas, las cadenas de proxies y los nodos personalizados.",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres eliminar este grupo de proxies?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres salir de la ventana actual?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres forzar el fallo del núcleo?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "La confirmación sobrescribirá los datos existentes",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Vuelva a introducir su contraseña",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "confirmPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "Confirme su contraseña",
    ),
    "confirmPurchase": MessageLookupByLibrary.simpleMessage("Confirmar compra"),
    "congestionControl": MessageLookupByLibrary.simpleMessage(
      "Control de congestión",
    ),
    "congestionController": MessageLookupByLibrary.simpleMessage(
      "Control de congestión TCP",
    ),
    "congestionControllerDesc": MessageLookupByLibrary.simpleMessage(
      "El control de congestión TCP solo funciona con la pila mips.",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Conectado"),
    "connecting": MessageLookupByLibrary.simpleMessage("Conectando…"),
    "connection": MessageLookupByLibrary.simpleMessage("Conexión"),
    "connectionStats": MessageLookupByLibrary.simpleMessage(
      "Estadísticas de conexión",
    ),
    "connectionStatsDesc": MessageLookupByLibrary.simpleMessage(
      "Conexiones activas, solicitudes recientes y consultas DNS",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("Conexiones"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Ver conexiones actuales",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Conectividad: "),
    "content": MessageLookupByLibrary.simpleMessage("Contenido"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Controlar las reglas añadidas globales",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Copiar variables de entorno",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Copiar enlace"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copiado"),
    "core": MessageLookupByLibrary.simpleMessage("Núcleo"),
    "coreBlockedByPolicyTip": m9,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Windows bloqueó FlClashCore.exe y Smart App Control está activado. Revise los detalles en Seguridad de Windows → Control de aplicaciones y explorador y use una versión fiable y verificada.",
    ),
    "coreNotConnected": MessageLookupByLibrary.simpleMessage(
      "El núcleo no está conectado",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Estado del núcleo"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Prueba de fallo"),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createProfileFromUrlTip": m10,
    "creationTime": MessageLookupByLibrary.simpleMessage("Fecha de creación"),
    "currentOutboundDesc": MessageLookupByLibrary.simpleMessage(
      "Contiene el botón de inicio y no se puede quitar",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Personalizado"),
    "customColor": MessageLookupByLibrary.simpleMessage("Color personalizado"),
    "customImportCloudRefused": MessageLookupByLibrary.simpleMessage(
      "Las direcciones oixCloud no se pueden importar a un perfil personalizado",
    ),
    "customImportDroppedSubRules": m11,
    "customImportNotImported": MessageLookupByLibrary.simpleMessage(
      "Sin importar",
    ),
    "customImportUnnamedProxies": m12,
    "customIssuesSummary": m13,
    "customOutboundInUse": m14,
    "customProfile": MessageLookupByLibrary.simpleMessage(
      "Perfil personalizado",
    ),
    "customProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Crear grupos de proxies y reglas con sus nodos, la biblioteca de proveedores y otros perfiles",
    ),
    "customProfileResources": MessageLookupByLibrary.simpleMessage(
      "Recursos de perfil personalizado",
    ),
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Complete su enrutamiento y cambie al modo Personalizado. Editar este borrador no cambia el modo actual.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "Elegir proveedor de reglas",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage(
      "Elegir destino",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("Formulario"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "Esta regla usa sintaxis avanzada. Edite el texto para conservar todas las opciones.",
    ),
    "customRuleInvalidContent": m15,
    "customRuleInvalidSyntax": MessageLookupByLibrary.simpleMessage(
      "Introduzca una regla completa con tipo, contenido y destino válidos.",
    ),
    "customRuleMatchHint": MessageLookupByLibrary.simpleMessage(
      "Coincide con todo el tráfico restante. No se alcanzarán las reglas posteriores.",
    ),
    "customRuleNoResolveHint": MessageLookupByLibrary.simpleMessage(
      "Usar direcciones IP conocidas sin resolver nombres de dominio.",
    ),
    "customRuleRaw": MessageLookupByLibrary.simpleMessage("Texto de la regla"),
    "customRuleRawHint": MessageLookupByLibrary.simpleMessage(
      "Introduzca una regla completa. Se conservan las expresiones avanzadas.",
    ),
    "customRuleTargetHint": MessageLookupByLibrary.simpleMessage(
      "Elija un grupo de políticas, un proxy o una acción integrada.",
    ),
    "customRuleType": MessageLookupByLibrary.simpleMessage("Tipo de regla"),
    "customRuleUnavailableProvider": m16,
    "customRuleUnavailableTarget": m17,
    "cut": MessageLookupByLibrary.simpleMessage("Cortar"),
    "dark": MessageLookupByLibrary.simpleMessage("Oscuro"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Panel"),
    "dashboardAddableSection": MessageLookupByLibrary.simpleMessage(
      "Disponibles para añadir",
    ),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Se detectaron cambios. ¿Guardarlos?",
    ),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "No se pudo guardar el cambio. Compruebe el valor actual y reintente.",
    ),
    "daysAgo": m18,
    "daysAgoShort": m19,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Servidor DNS predeterminado",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Resuelve los dominios de los servidores DNS",
    ),
    "defaultSelected": MessageLookupByLibrary.simpleMessage(
      "Selección predeterminada",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Predeterminado"),
    "definitionNotMap": MessageLookupByLibrary.simpleMessage(
      "La configuración debe ser un mapa YAML con un nombre y un tipo",
    ),
    "delay": MessageLookupByLibrary.simpleMessage("Latencia"),
    "delayConcurrency": MessageLookupByLibrary.simpleMessage(
      "Pruebas de latencia simultáneas",
    ),
    "delayConcurrencyAndroidDesc": MessageLookupByLibrary.simpleMessage(
      "Valor predeterminado en Android: 16. Reduzca en redes congestionadas; se aplica al siguiente lote",
    ),
    "delayConcurrencyDesc": MessageLookupByLibrary.simpleMessage(
      "Valor predeterminado: 50. Reduzca en redes congestionadas; se aplica al siguiente lote",
    ),
    "delayTest": MessageLookupByLibrary.simpleMessage("Prueba de latencia"),
    "delayTestFailed": MessageLookupByLibrary.simpleMessage("Error"),
    "delayTestQueued": MessageLookupByLibrary.simpleMessage("En cola"),
    "delayTestRunning": MessageLookupByLibrary.simpleMessage("Probando"),
    "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "¿Eliminar esta copia de WebDAV?",
    ),
    "deleteMultipTip": m20,
    "deleteTip": m21,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Un cliente proxy multiplataforma basado en ClashMeta, sencillo de usar, de código abierto y sin anuncios.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destino"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "GeoIP de destino",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "ASN de la IP de destino",
    ),
    "details": m22,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Usa una API de terceros; resultados solo como referencia",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Modo desarrollador"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "El modo desarrollador está activado.",
    ),
    "diagAllFailed": MessageLookupByLibrary.simpleMessage(
      "Todos los nodos probados de este grupo fallaron. La URL de prueba también podría ser inaccesible. ¿Ejecutar el autodiagnóstico de red?",
    ),
    "diagCanceled": MessageLookupByLibrary.simpleMessage(
      "Diagnóstico cancelado; resultados incompletos",
    ),
    "diagCaptureHint": MessageLookupByLibrary.simpleMessage(
      "Active el proxy del sistema o TUN, o configure la aplicación afectada para usar el proxy local.",
    ),
    "diagClock": MessageLookupByLibrary.simpleMessage(
      "Comparación de la hora del sistema",
    ),
    "diagClockHint": MessageLookupByLibrary.simpleMessage(
      "Active la fecha y hora automáticas y reintente. Un reloj incorrecto puede afectar a los certificados y las firmas DNS de oixCloud.",
    ),
    "diagClockReady": MessageLookupByLibrary.simpleMessage(
      "No se detectó una diferencia grande y consistente en esta muestra",
    ),
    "diagClockSkew": MessageLookupByLibrary.simpleMessage(
      "Dos respuestas independientes indican una posible diferencia de al menos cinco minutos",
    ),
    "diagClockUnknown": MessageLookupByLibrary.simpleMessage(
      "No hay suficientes respuestas HTTPS sin caché para comparar la hora",
    ),
    "diagCopy": MessageLookupByLibrary.simpleMessage(
      "Copiar informe de diagnóstico",
    ),
    "diagCopyProxyAddress": MessageLookupByLibrary.simpleMessage(
      "Copiar dirección del proxy",
    ),
    "diagCore": MessageLookupByLibrary.simpleMessage("Respuesta del núcleo"),
    "diagCoreDns": MessageLookupByLibrary.simpleMessage("DNS del núcleo"),
    "diagCoreHint": MessageLookupByLibrary.simpleMessage(
      "Compruebe el interruptor de conexión y las exclusiones Wi-Fi. Si el núcleo no responde, reinícielo y use versiones actuales compatibles del cliente y el núcleo.",
    ),
    "diagCoreReady": MessageLookupByLibrary.simpleMessage(
      "El núcleo responde e informa de puertos de escucha activos",
    ),
    "diagCoreStopped": MessageLookupByLibrary.simpleMessage(
      "El núcleo indica que el reenvío de tráfico está detenido",
    ),
    "diagCoreUnknown": MessageLookupByLibrary.simpleMessage(
      "El diagnóstico del núcleo no está disponible o la configuración cambió",
    ),
    "diagDisabled": MessageLookupByLibrary.simpleMessage(
      "Esta opción no está activada",
    ),
    "diagDnsHint": MessageLookupByLibrary.simpleMessage(
      "Revise las sobrescrituras DNS y pruebe otra red. Si el DNS del sistema funciona pero el del núcleo falla, examine los ajustes DNS de la configuración.",
    ),
    "diagDnsNoAnswer": MessageLookupByLibrary.simpleMessage(
      "DNS no devolvió ninguna dirección utilizable; esto por sí solo no demuestra un fallo de autenticación",
    ),
    "diagDnsPartial": MessageLookupByLibrary.simpleMessage(
      "Solo se resolvieron algunos nombres probados",
    ),
    "diagDnsReady": MessageLookupByLibrary.simpleMessage(
      "Los nombres probados se resolvieron",
    ),
    "diagDnsRefused": MessageLookupByLibrary.simpleMessage(
      "La solicitud DNS fue rechazada",
    ),
    "diagEntryHint": MessageLookupByLibrary.simpleMessage(
      "Comprobar el núcleo, el proxy del sistema, TUN y DNS",
    ),
    "diagFailed": MessageLookupByLibrary.simpleMessage("Error"),
    "diagFixApplyProfile": MessageLookupByLibrary.simpleMessage(
      "Aplicar configuración",
    ),
    "diagFixEnableSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Activar proxy del sistema",
    ),
    "diagFixFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo aplicar la corrección. Siga la sugerencia anterior.",
    ),
    "diagFixRestartConnection": MessageLookupByLibrary.simpleMessage(
      "Volver a conectar",
    ),
    "diagFixRestartCore": MessageLookupByLibrary.simpleMessage(
      "Reiniciar núcleo",
    ),
    "diagFixRetest": MessageLookupByLibrary.simpleMessage(
      "Volver a probar los nodos",
    ),
    "diagFixStart": MessageLookupByLibrary.simpleMessage("Iniciar conexión"),
    "diagFixSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Volver a aplicar el proxy del sistema",
    ),
    "diagFixTun": MessageLookupByLibrary.simpleMessage("Volver a activar TUN"),
    "diagFixing": MessageLookupByLibrary.simpleMessage(
      "Aplicando la corrección y comprobando de nuevo",
    ),
    "diagListener": MessageLookupByLibrary.simpleMessage(
      "Entrada del proxy local",
    ),
    "diagListenerFailed": MessageLookupByLibrary.simpleMessage(
      "El puerto proxy esperado no responde o difiere del puerto del núcleo",
    ),
    "diagListenerHint": MessageLookupByLibrary.simpleMessage(
      "Compruebe si hay conflictos de puertos o si la escucha está detenida. Reconecte primero; si sigue fallando, abra Puertos y autenticación para revisar o cambiar el puerto mixto.",
    ),
    "diagListenerReady": MessageLookupByLibrary.simpleMessage(
      "El puerto esperado respondió al protocolo proxy",
    ),
    "diagNoCapture": MessageLookupByLibrary.simpleMessage(
      "Ni el proxy del sistema ni TUN están activados",
    ),
    "diagOixDns": MessageLookupByLibrary.simpleMessage(
      "DNS firmado de oixCloud",
    ),
    "diagOixDnsAuthMissing": MessageLookupByLibrary.simpleMessage(
      "La función de firma DNS gestionada no está lista",
    ),
    "diagOixDnsHint": MessageLookupByLibrary.simpleMessage(
      "Compruebe la versión del cliente y la hora del sistema y actualice la suscripción. Si la resolución sigue fallando, comparta este informe con soporte.",
    ),
    "diagOixDnsNoSample": MessageLookupByLibrary.simpleMessage(
      "No había ningún nombre de host de nodo gestionado disponible para esta prueba",
    ),
    "diagOpenDnsSettings": MessageLookupByLibrary.simpleMessage(
      "Sobrescrituras DNS",
    ),
    "diagOpenNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Ajustes de red y TUN",
    ),
    "diagOpenPortSettings": MessageLookupByLibrary.simpleMessage(
      "Puertos y autenticación",
    ),
    "diagOpenSettingsFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron abrir los ajustes del sistema. Siga la ruta indicada para abrirlos manualmente.",
    ),
    "diagOpenSystemSettings": MessageLookupByLibrary.simpleMessage(
      "Abrir ajustes del sistema",
    ),
    "diagPassed": MessageLookupByLibrary.simpleMessage("Correcto"),
    "diagProfile": MessageLookupByLibrary.simpleMessage(
      "Configuración aplicada",
    ),
    "diagProfileHint": MessageLookupByLibrary.simpleMessage(
      "Seleccione una configuración válida e inicie la conexión antes de volver a comprobar.",
    ),
    "diagProfileMissing": MessageLookupByLibrary.simpleMessage(
      "La configuración seleccionada no está aplicada",
    ),
    "diagProfileReady": MessageLookupByLibrary.simpleMessage(
      "La configuración seleccionada está aplicada",
    ),
    "diagProxyAutomatic": MessageLookupByLibrary.simpleMessage(
      "Hay una configuración automática del proxy; no se verificó su ruta efectiva",
    ),
    "diagProxyAutomaticHint": MessageLookupByLibrary.simpleMessage(
      "Un script PAC o la detección automática puede elegir un proxy distinto para cada sitio. Esto no implica necesariamente un fallo. Compruebe quién proporcionó la configuración antes de modificarla.",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "El proxy del sistema no coincide con el puerto de la aplicación",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "La aplicación solicitó un proxy del sistema, pero el sistema lo indica desactivado",
    ),
    "diagProxyGuide": MessageLookupByLibrary.simpleMessage(
      "Solución de problemas y configuración manual",
    ),
    "diagProxyGuideApp": MessageLookupByLibrary.simpleMessage(
      "En este dispositivo, abra los ajustes de proxy de la aplicación, elija HTTP o SOCKS5 e introduzca la dirección y el puerto indicados.\nAndroid proporciona el proxy del sistema mediante el servicio VPN. Para acceder por VPN, revise el interruptor VPN y el control de acceso de aplicaciones en los ajustes de red de FlClash.",
    ),
    "diagProxyGuideAuthenticated": MessageLookupByLibrary.simpleMessage(
      "La autenticación del proxy local está activada, por lo que FlClash no aplica un proxy del sistema automáticamente.\nEn una aplicación compatible, elija HTTP o SOCKS5 e introduzca la dirección y el puerto indicados. Use el usuario y la contraseña de FlClash → Sobrescritura → General → Entradas → Autenticación.\nNo incluya credenciales en los informes de diagnóstico.",
    ),
    "diagProxyGuideInvalidPort": MessageLookupByLibrary.simpleMessage(
      "El puerto mixto no está disponible. Defina un puerto válido en Puertos y autenticación e inicie la conexión.",
    ),
    "diagProxyGuideLinux": MessageLookupByLibrary.simpleMessage(
      "Abra los ajustes del escritorio → Red → Proxy de red y elija Manual (los nombres varían según el escritorio).\nIntroduzca la dirección y el puerto indicados para HTTP y HTTPS y aplique. Si no hay panel de proxy del sistema, configure la aplicación de destino.\nAntes de reemplazar una configuración automática, compruebe su origen y si la red aún la necesita.",
    ),
    "diagProxyGuideMacos": MessageLookupByLibrary.simpleMessage(
      "Ajustes del Sistema → Red → conexión Wi-Fi o Ethernet activa → Detalles → Proxies\nmacOS 12: Preferencias del Sistema → Red → conexión activa → Avanzado → Proxies\nSi los ajustes automáticos proceden de otra aplicación y ya no son necesarios, desactive la detección y la configuración automáticas del proxy.\nActive Proxy web (HTTP) y Proxy web seguro (HTTPS). Introduzca la dirección y el puerto indicados para ambos y guarde. Conserve las exclusiones necesarias para su red.",
    ),
    "diagProxyGuideManualTitle": MessageLookupByLibrary.simpleMessage(
      "2. Revisar o introducir los ajustes del proxy",
    ),
    "diagProxyGuidePrepare": MessageLookupByLibrary.simpleMessage(
      "Seleccione un perfil válido, inicie la conexión en FlClash y compruebe que la prueba del proxy local sea correcta antes de introducir su dirección.\nCierre otras aplicaciones proxy que puedan modificar los ajustes del sistema. Si los gestiona su empresa o centro educativo, están bloqueados o se revierten, consulte al administrador.",
    ),
    "diagProxyGuidePrepareTitle": MessageLookupByLibrary.simpleMessage(
      "1. Comprobar primero el proxy local",
    ),
    "diagProxyGuideValues": m23,
    "diagProxyGuideVerify": MessageLookupByLibrary.simpleMessage(
      "Vuelva y elija Comprobar de nuevo; después reintente en su navegador o aplicación.\nSi el proxy local supera la prueba pero una aplicación falla, revise sus ajustes de proxy del sistema, personalizado o de extensiones. El proxy del sistema no abarca todas las aplicaciones.\nAl detener FlClash, quizá deba desactivar el proxy manual o restaurar sus ajustes anteriores para mantener el acceso a Internet.",
    ),
    "diagProxyGuideVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "3. Guardar y verificar en la aplicación",
    ),
    "diagProxyGuideWindows": MessageLookupByLibrary.simpleMessage(
      "Configuración → Red e Internet → Proxy\nSi los ajustes automáticos proceden de otra aplicación y la red ya no los necesita, desactive Usar script de configuración y Detectar la configuración automáticamente.\nEn Configuración manual del proxy, active Usar un servidor proxy, introduzca la dirección y el puerto indicados en sus campos respectivos y guarde. No anteponga http:// a la dirección. Conserve las excepciones necesarias para su red.",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "Abra Solución de problemas y configuración manual para comparar la dirección y el puerto del proxy del sistema. Si los ajustes se revierten, revise otras aplicaciones proxy o las políticas de gestión del dispositivo.",
    ),
    "diagProxyPath": MessageLookupByLibrary.simpleMessage(
      "A través del proxy local",
    ),
    "diagProxyPathHint": MessageLookupByLibrary.simpleMessage(
      "Si la ruta del sistema funciona, revise el nodo seleccionado, las reglas y el DNS del núcleo. El fallo de un sitio de prueba no significa que todos los nodos sean inutilizables.",
    ),
    "diagProxyReady": MessageLookupByLibrary.simpleMessage(
      "Los proxies HTTP y HTTPS apuntan al puerto local esperado",
    ),
    "diagRecheck": MessageLookupByLibrary.simpleMessage("Comprobar de nuevo"),
    "diagRun": MessageLookupByLibrary.simpleMessage("Iniciar diagnóstico"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "Comprueba la conexión actual con una pequeña muestra. La ruta de red del sistema también puede pasar por TUN. Los resultados no abarcan todas las aplicaciones ni todos los nodos.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("Omitido"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "El reenvío de tráfico está pausado por la exclusión Wi-Fi actual",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("DNS del sistema"),
    "diagSystemDnsHint": MessageLookupByLibrary.simpleMessage(
      "Pruebe otra red y revise los servidores DNS de la conexión activa en el sistema. Cambiar solo las sobrescrituras DNS del cliente puede no corregir la resolución del sistema.",
    ),
    "diagSystemPath": MessageLookupByLibrary.simpleMessage(
      "Ruta de red del sistema",
    ),
    "diagSystemPathHint": MessageLookupByLibrary.simpleMessage(
      "Esta ruta no usa explícitamente el proxy HTTP de la aplicación, pero puede pasar por TUN. Un fallo puede deberse a DNS, filtros o al sitio probado; compare el resultado del proxy local.",
    ),
    "diagSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Ajustes del proxy del sistema",
    ),
    "diagTitle": MessageLookupByLibrary.simpleMessage("Autodiagnóstico de red"),
    "diagTrafficCapture": MessageLookupByLibrary.simpleMessage(
      "Captura de tráfico",
    ),
    "diagTun": MessageLookupByLibrary.simpleMessage("Interfaz y ruta TUN"),
    "diagTunHint": MessageLookupByLibrary.simpleMessage(
      "Desactive y active TUN y complete la autorización del sistema. Si la ruta difiere, revise otras VPN. IPv6, UDP y las exclusiones por aplicación requieren comprobaciones aparte.",
    ),
    "diagTunMissing": MessageLookupByLibrary.simpleMessage(
      "No se encontró una interfaz TUN activa del núcleo",
    ),
    "diagTunReady": MessageLookupByLibrary.simpleMessage(
      "La interfaz TUN del núcleo está activa y la ruta IPv4 probada la utiliza",
    ),
    "diagTunRouteMismatch": MessageLookupByLibrary.simpleMessage(
      "TUN está activo, pero la ruta IPv4 probada usa otra interfaz",
    ),
    "diagTunRouteUnknown": MessageLookupByLibrary.simpleMessage(
      "TUN está activo; no se pudo verificar su ruta IPv4",
    ),
    "diagUnknown": MessageLookupByLibrary.simpleMessage("No se pudo confirmar"),
    "diagWarning": MessageLookupByLibrary.simpleMessage("Requiere atención"),
    "diagWebResult": m24,
    "dialerProxy": MessageLookupByLibrary.simpleMessage("Proxy de marcación"),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "El proxy de marcación es la salida que se usa para llegar al servidor NTP.",
    ),
    "dialerProxyLoopStopped": m25,
    "direct": MessageLookupByLibrary.simpleMessage("Directo"),
    "directNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS de conexiones directas",
    ),
    "directNameserverFollowPolicy": MessageLookupByLibrary.simpleMessage(
      "Aplicar la política al DNS directo",
    ),
    "disableIcmpForwarding": MessageLookupByLibrary.simpleMessage(
      "Desactivar reenvío ICMP",
    ),
    "disableIcmpForwardingDesc": MessageLookupByLibrary.simpleMessage(
      "Con el reenvío ICMP desactivado, TUN responde él mismo al ping, por lo que ping ya no muestra la latencia real.",
    ),
    "disableKeepAlive": MessageLookupByLibrary.simpleMessage(
      "Desactivar keep-alive TCP",
    ),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Desactivar UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Desactivado"),
    "discard": MessageLookupByLibrary.simpleMessage("Descartar"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "¿Descartar los cambios?",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Desconectado"),
    "discountCode": MessageLookupByLibrary.simpleMessage("Código de descuento"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Código de descuento (opcional)",
    ),
    "discountCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Introduzca un código de descuento",
    ),
    "discountedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Precio con descuento",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Nueva versión disponible",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Modificar los ajustes de DNS",
    ),
    "dnsHijackDesc": MessageLookupByLibrary.simpleMessage(
      "Sin esta entrada, TUN secuestra todas las consultas DNS al puerto 53 (any:53).",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("Secuestro de DNS"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Modo DNS"),
    "dnsOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Las entradas añadidas aquí reemplazan los ajustes DNS de cada perfil; lo que no se añada conserva el ajuste del perfil. Las entradas propias de un perfil personalizado tienen prioridad",
    ),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("Consultas DNS"),
    "dnsQueriesDesc": MessageLookupByLibrary.simpleMessage(
      "Ver las últimas 500 consultas del resolutor",
    ),
    "dnsQueryAll": MessageLookupByLibrary.simpleMessage("Todas las consultas"),
    "dnsQueryAnswers": MessageLookupByLibrary.simpleMessage("Respuestas"),
    "dnsQueryCached": MessageLookupByLibrary.simpleMessage("En caché"),
    "dnsQueryFailures": MessageLookupByLibrary.simpleMessage(
      "Consultas fallidas",
    ),
    "dnsQueryInitiatorApp": MessageLookupByLibrary.simpleMessage("Aplicación"),
    "dnsQueryInitiatorDirect": MessageLookupByLibrary.simpleMessage(
      "Conexión directa",
    ),
    "dnsQueryInitiatorOther": MessageLookupByLibrary.simpleMessage("Otro"),
    "dnsQueryInitiatorProxy": MessageLookupByLibrary.simpleMessage(
      "Conexión proxy",
    ),
    "dnsQueryInitiatorRule": MessageLookupByLibrary.simpleMessage(
      "Coincidencia de reglas",
    ),
    "dnsQueryRcode": MessageLookupByLibrary.simpleMessage(
      "Código de respuesta",
    ),
    "dnsQueryType": MessageLookupByLibrary.simpleMessage("Tipo de consulta"),
    "dnsQueryUpstream": MessageLookupByLibrary.simpleMessage("Ascendente"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "¿Desea continuar?",
    ),
    "docked": MessageLookupByLibrary.simpleMessage("Fija"),
    "domain": MessageLookupByLibrary.simpleMessage("Dominio"),
    "done": MessageLookupByLibrary.simpleMessage("Hecho"),
    "download": MessageLookupByLibrary.simpleMessage("Descarga"),
    "downloadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Ancho de banda de descarga",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Duración"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "Incluir automáticamente nodos de esta configuración al actualizar la suscripción. Use un filtro de nombre, como Japan|JP.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Editar"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Editar enrutamiento personalizado",
    ),
    "editDashboard": MessageLookupByLibrary.simpleMessage("Editar panel"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Editar reglas globales",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Editar grupo de proxies",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Editar regla"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Editar SSID"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Editor no disponible",
    ),
    "elapsed": MessageLookupByLibrary.simpleMessage("Tardó"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage(
      "Introduzca el código de 6 dígitos",
    ),
    "emailCodeLabel": MessageLookupByLibrary.simpleMessage("Código por correo"),
    "emailCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca el código recibido por correo",
    ),
    "emailFormatValidation": MessageLookupByLibrary.simpleMessage(
      "Formato de correo no válido",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage(
      "Introduzca su dirección de correo",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "emailPassword": MessageLookupByLibrary.simpleMessage(
      "Correo y contraseña",
    ),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca su correo",
    ),
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "La sobrescritura personalizada está vacía. Use el relleno rápido o añada reglas y grupos de proxies. Para conservar el contenido de la suscripción, use el modo Superposición.",
    ),
    "emptyCustomProfile": MessageLookupByLibrary.simpleMessage(
      "Añada primero un grupo de proxies o una regla a este perfil personalizado",
    ),
    "emptyFallback": MessageLookupByLibrary.simpleMessage(
      "Respaldo si está vacío",
    ),
    "emptyTip": m26,
    "en": MessageLookupByLibrary.simpleMessage("Inglés"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Activar renovación automática",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Activado"),
    "enabledOnStart": MessageLookupByLibrary.simpleMessage(
      "Activar al iniciar",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" entradas"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Detalles del error"),
    "es": MessageLookupByLibrary.simpleMessage("Español"),
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Ocultar de aplicaciones recientes",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Ocultar la aplicación de las tareas recientes cuando esté en segundo plano",
    ),
    "excludeDstPort": MessageLookupByLibrary.simpleMessage(
      "Puertos de destino excluidos",
    ),
    "excludeDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "El tráfico hacia los puertos de destino excluidos no pasa por TUN.",
    ),
    "excludeInterface": MessageLookupByLibrary.simpleMessage(
      "Interfaces excluidas",
    ),
    "excludeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "El tráfico que llega por las interfaces excluidas, como docker0, no pasa por TUN.",
    ),
    "excludeNetworks": MessageLookupByLibrary.simpleMessage(
      "Pausar según IP o puerta de enlace",
    ),
    "excludeNetworksDesc": MessageLookupByLibrary.simpleMessage(
      "Pausar al coincidir con direcciones IPv4 Wi-Fi/Ethernet, subredes o puertas de enlace; reanudar al salir. Separe por comas, p. ej. 192.168.1.0/24,gateway:192.168.1.1",
    ),
    "excludeNetworksInvalid": MessageLookupByLibrary.simpleMessage(
      "Hasta 16 reglas; introduzca IPv4, CIDR o gateway:dirección válidos",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Filtro de exclusión de proxies",
    ),
    "excludeSrcPort": MessageLookupByLibrary.simpleMessage(
      "Puertos de origen excluidos",
    ),
    "excludeSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "El tráfico desde los puertos de origen excluidos no pasa por TUN.",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage(
      "Redes Wi-Fi que pausan el proxy",
    ),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Pausar el proxy en las redes Wi-Fi indicadas; reanudar al salir solo si la aplicación sigue iniciada",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Tipo que excluir"),
    "excludeUid": MessageLookupByLibrary.simpleMessage(
      "ID de usuario excluidos",
    ),
    "excludeUidDesc": MessageLookupByLibrary.simpleMessage(
      "El tráfico de los procesos de los ID de usuario excluidos no pasa por TUN.",
    ),
    "existsTip": m27,
    "exit": MessageLookupByLibrary.simpleMessage("Salir"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Salir de pantalla completa",
    ),
    "exitNodes": MessageLookupByLibrary.simpleMessage("Nodos de salida"),
    "expandList": MessageLookupByLibrary.simpleMessage("Expandir"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Estado esperado"),
    "expireDate": m28,
    "expireTime": MessageLookupByLibrary.simpleMessage("Fecha de vencimiento"),
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage(
      "Fecha de caducidad",
    ),
    "exportFile": MessageLookupByLibrary.simpleMessage("Exportar archivo"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Exportar registros"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage(
      "Exportación completada",
    ),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Controlador externo",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "El controlador externo permite controlar el núcleo en la dirección configurada",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("Enlace externo"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Muy grande"),
    "fade": MessageLookupByLibrary.simpleMessage("Fundido"),
    "failedItem": m29,
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Filtro Fake-IP"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Modo de filtro Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "En el modo de filtro Fake-IP, la lista negra excluye las coincidencias, la lista blanca aplica Fake-IP solo a las coincidencias y rule coincide según las reglas.",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Rango Fake-IP"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Rango Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL de Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("DNS de respaldo"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Normalmente incluye servidores DNS del extranjero",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage(
      "Filtro de respaldo",
    ),
    "fallbackLazyQuery": MessageLookupByLibrary.simpleMessage(
      "Consulta diferida del DNS de respaldo",
    ),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el historial de compras",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los planes",
    ),
    "file": MessageLookupByLibrary.simpleMessage("Archivo"),
    "fileDesc": MessageLookupByLibrary.simpleMessage(
      "Importar directamente un archivo de perfil",
    ),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "El archivo se ha modificado. ¿Guardar los cambios?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
    "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Buscar proceso"),
    "findProcessModeAutomaticDesc": MessageLookupByLibrary.simpleMessage(
      "Buscar el proceso solo al comprobar una regla de proceso",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "La activación puede reducir el rendimiento",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("Flotante"),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "Navegación flotante",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Seguir perfil"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Seguir el sistema"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Familia de fuente"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Tamaño"),
    "forceDnsMapping": MessageLookupByLibrary.simpleMessage("Forzar mapeo DNS"),
    "forceDnsMappingDesc": MessageLookupByLibrary.simpleMessage(
      "Forzar mapeo DNS también analiza las conexiones cuyo dominio provino de un mapeo DNS.",
    ),
    "forceDomain": MessageLookupByLibrary.simpleMessage("Forzar dominios"),
    "forceDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Los dominios forzados también se analizan; las demás conexiones que ya tienen dominio se dejan como están.",
    ),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres forzar el reinicio del núcleo?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "¿Olvidó su contraseña?",
    ),
    "format": MessageLookupByLibrary.simpleMessage("Formato"),
    "fr": MessageLookupByLibrary.simpleMessage("Francés"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage(
      "Actualización automática",
    ),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Intervalo de actualización automática",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "El intervalo debe estar entre 1 y 8760 horas",
    ),
    "geoBackupSource": MessageLookupByLibrary.simpleMessage("CDN de respaldo"),
    "geoDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Error al descargar GEO",
    ),
    "geoDownloadRecoveryHint": MessageLookupByLibrary.simpleMessage(
      "La descarga sigue las reglas de red actuales o usa una conexión directa si el proxy no está disponible. Reintente la dirección actual, elija otra fuente o introduzca una URL. La operación continuará automáticamente tras la validación.",
    ),
    "geoDownloadUrl": MessageLookupByLibrary.simpleMessage("URL de descarga"),
    "geoFileMissing": MessageLookupByLibrary.simpleMessage("Sin descargar"),
    "geoFileReadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo leer el archivo de recursos",
    ),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "Introduzca una URL HTTP o HTTPS válida",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Opciones Geo"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage(
      "Dirección actual",
    ),
    "geoResources": MessageLookupByLibrary.simpleMessage("Recursos Geo"),
    "geoSkipped": m30,
    "geoUpdated": m31,
    "geoUpdating": m32,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Modo geo de poca memoria",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Usar el cargador Geo de bajo consumo de memoria",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Código GeoIP"),
    "getProfileSuccess": MessageLookupByLibrary.simpleMessage(
      "Perfil importado",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Global"),
    "go": MessageLookupByLibrary.simpleMessage("Ir"),
    "goLogin": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "goPay": MessageLookupByLibrary.simpleMessage("Pagar"),
    "goToConfigureAddedRules": MessageLookupByLibrary.simpleMessage(
      "Ir a la configuración de las reglas añadidas",
    ),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Configurar script",
    ),
    "googleLoginInvalidCallback": MessageLookupByLibrary.simpleMessage(
      "No se pudo verificar el inicio de sesión con Google. Vuelva a intentarlo.",
    ),
    "googleLoginTimedOut": MessageLookupByLibrary.simpleMessage(
      "Se agotó el tiempo para iniciar sesión con Google. Vuelva a intentarlo.",
    ),
    "googleLoginUnavailable": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el inicio de sesión con Google. Vuelva a intentarlo.",
    ),
    "googleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Complete el inicio de sesión con Google en el navegador",
    ),
    "grid": MessageLookupByLibrary.simpleMessage("Cuadrícula"),
    "groupCount": m33,
    "groupCountUnit": MessageLookupByLibrary.simpleMessage("grupos"),
    "groupCycleError": m34,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "Filtra los nodos incluidos automáticamente y los de proveedores. Los miembros seleccionados manualmente siempre se conservan.",
    ),
    "groupTimeoutCount": m35,
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage(
      "Conmutación por error",
    ),
    "groupTypeFallbackHint": MessageLookupByLibrary.simpleMessage(
      "Probar los miembros en orden y cambiar si falla el actual.",
    ),
    "groupTypeLoadBalance": MessageLookupByLibrary.simpleMessage(
      "Equilibrio de carga",
    ),
    "groupTypeLoadBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Distribuir las conexiones entre los miembros disponibles.",
    ),
    "groupTypeSelect": MessageLookupByLibrary.simpleMessage("Selección manual"),
    "groupTypeSelectHint": MessageLookupByLibrary.simpleMessage(
      "Elija el miembro activo en la página Proxies.",
    ),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage(
      "Selección automática",
    ),
    "groupTypeUrlTestHint": MessageLookupByLibrary.simpleMessage(
      "Probar periódicamente los miembros y elegir un nodo de baja latencia.",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "¿Guardar los cambios en caché?",
    ),
    "hashByInUser": MessageLookupByLibrary.simpleMessage(
      "Hash por usuario de entrada",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "¿Ya tiene una cuenta?",
    ),
    "healthCheck": MessageLookupByLibrary.simpleMessage(
      "Comprobación de estado",
    ),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "El servicio auxiliar (Helper) no está disponible; no se puede activar el modo TUN. Reinstala FlClash para restaurarlo.",
    ),
    "hex": MessageLookupByLibrary.simpleMessage("Hex"),
    "hide": MessageLookupByLibrary.simpleMessage("Ocultar"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Ocultar de la lista"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Ocultar IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Ocultar contraseña"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Ocultar nodos fallidos",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Conservar el nodo seleccionado y aquellos cuya prueba no haya terminado",
    ),
    "hopInterval": MessageLookupByLibrary.simpleMessage("Intervalo de salto"),
    "host": MessageLookupByLibrary.simpleMessage("Host"),
    "hostname": MessageLookupByLibrary.simpleMessage("Nombre de host"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Añadir entradas Hosts"),
    "hotkeyConflictWith": m36,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Los atajos globales funcionan incluso con la ventana oculta. Toca una acción para grabar su combinación de teclas.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Gestión de atajos",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Controlar la aplicación con el teclado",
    ),
    "hotkeyNeedsModifier": m37,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Sin asignar"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Atajo no disponible",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("horas"),
    "hoursAgo": m38,
    "hoursAgoShort": m39,
    "hoursCount": m40,
    "hue": MessageLookupByLibrary.simpleMessage("Tono"),
    "iHavePaid": MessageLookupByLibrary.simpleMessage("Ya he pagado"),
    "icon": MessageLookupByLibrary.simpleMessage("Icono"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("Iconos recientes"),
    "iconSets": MessageLookupByLibrary.simpleMessage("Conjuntos de iconos"),
    "iconSetsEmptyTip": MessageLookupByLibrary.simpleMessage(
      "Aún no hay conjuntos de iconos. Añádelos en Recursos de perfil personalizado → Conjuntos de iconos",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Estilo de icono"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("Relleno"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Oculto"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Simple"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL del icono"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Ignorar optimización de batería",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Importar"),
    "importConfig": MessageLookupByLibrary.simpleMessage(
      "Importar configuración",
    ),
    "importConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Crear un perfil personalizado con los proxies, grupos, reglas y ajustes de una configuración",
    ),
    "importConfigInvalid": MessageLookupByLibrary.simpleMessage(
      "Esta configuración no se puede importar",
    ),
    "importConfigReplaceTip": MessageLookupByLibrary.simpleMessage(
      "La importación reemplaza los nodos, grupos de proxies, reglas y ajustes actuales del perfil",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage(
      "Importar desde archivo",
    ),
    "importFromLink": MessageLookupByLibrary.simpleMessage(
      "Importar desde enlace",
    ),
    "importFromURL": MessageLookupByLibrary.simpleMessage(
      "Importar desde una URL",
    ),
    "importText": MessageLookupByLibrary.simpleMessage("Importar desde texto"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Importar desde URL"),
    "inbound": MessageLookupByLibrary.simpleMessage("Entrada"),
    "includeAll": MessageLookupByLibrary.simpleMessage(
      "Incluir todos los proxies y proveedores",
    ),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Incluir todos los proxies",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Incluir todos los proveedores de proxies",
    ),
    "includeInterface": MessageLookupByLibrary.simpleMessage(
      "Interfaces incluidas",
    ),
    "includeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Solo el tráfico que llega por las interfaces incluidas pasa por TUN, y las interfaces excluidas dejan de aplicarse.",
    ),
    "includeUid": MessageLookupByLibrary.simpleMessage(
      "ID de usuario incluidos",
    ),
    "includeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Solo el tráfico de los procesos de los ID de usuario incluidos pasa por TUN.",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Sin caducidad"),
    "init": MessageLookupByLibrary.simpleMessage("Inicio"),
    "initFailed": MessageLookupByLibrary.simpleMessage("Error al iniciar"),
    "initFailedTip": MessageLookupByLibrary.simpleMessage(
      "La aplicación encontró un error crítico al iniciar y no puede continuar.",
    ),
    "initiatorShort": MessageLookupByLibrary.simpleMessage("De"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Introduce el nombre del grupo de proxies",
    ),
    "installedAppsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las aplicaciones instaladas. Vuelva a intentarlo.",
    ),
    "installedAppsPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "No se concedió el permiso. Puede activarlo en los ajustes del sistema.",
    ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Permita el acceso a la lista de aplicaciones instaladas para elegir cuáles usan la VPN.",
    ),
    "installedAppsPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Permitir acceso",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Se requiere permiso para las aplicaciones instaladas",
    ),
    "installedFonts": MessageLookupByLibrary.simpleMessage(
      "Fuentes instaladas",
    ),
    "insufficientBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Saldo insuficiente. Recargue antes de continuar.",
    ),
    "insufficientBalanceRecharge": MessageLookupByLibrary.simpleMessage(
      "Recargue y vuelva a intentarlo.",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Selección inteligente",
    ),
    "interfaceAutomatic": MessageLookupByLibrary.simpleMessage(
      "Quitar sobrescritura (interfaz automática)",
    ),
    "interfaceFollowProfile": MessageLookupByLibrary.simpleMessage(
      "Seguir el perfil",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Nombre de interfaz"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "El nombre de interfaz es la interfaz de red que usan las conexiones salientes.",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Interfaz de salida",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "interval": MessageLookupByLibrary.simpleMessage("Intervalo"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("IP de intranet"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage(
      "Introduzca un importe válido",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Archivo de copia de seguridad no válido",
    ),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "No se pudo verificar el certificado del servidor. Omitir la verificación puede permitir la suplantación del servidor y el robo o la alteración de las credenciales y los datos de suscripción que se intercambien.\n\nContinúe solo si confía en esta red y este servidor. La excepción se aplica únicamente a este intento, con el mismo servidor y certificado, y termina al finalizar la operación.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "Error de verificación del certificado",
    ),
    "invalidCidrContent": MessageLookupByLibrary.simpleMessage(
      "Introduce un rango de IP en formato CIDR, como 192.168.0.0/16",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Una marca DSCP no puede superar 63",
    ),
    "invalidHostContent": MessageLookupByLibrary.simpleMessage(
      "Introduce un dominio o una dirección IP",
    ),
    "invalidIpv6CidrContent": MessageLookupByLibrary.simpleMessage(
      "Introduzca un rango IPv6 en formato CIDR, como fd00::/8",
    ),
    "invalidLinkTip": MessageLookupByLibrary.simpleMessage(
      "No es un enlace de suscripción ni un enlace para compartir proxies",
    ),
    "invalidListenContent": MessageLookupByLibrary.simpleMessage(
      "Introduce una dirección y un puerto, como 0.0.0.0:1053",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Solo se admite tcp o udp",
    ),
    "invalidPolicy": m41,
    "invalidPortRangeContent": MessageLookupByLibrary.simpleMessage(
      "Introduce un puerto o un rango como 443 u 8000-9000",
    ),
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Este código QR no contiene un enlace de perfil",
    ),
    "invalidProxyProvider": m42,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Introduce números o rangos como 80 u 8000-9000, separados por /",
    ),
    "invalidRuleSet": m43,
    "invalidSubRule": m44,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Introduzca el código de invitación",
    ),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Código de invitación",
    ),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca el código de invitación",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Tipo"),
    "ipVersion": MessageLookupByLibrary.simpleMessage("Versión de IP"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("CIDR IP"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "El tráfico IPv6 solo se recibe mientras IPv6 esté activado.",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Con IPv6 activado, la VPN permite el tráfico IPv6 entrante.",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage(
      "Tiempo de espera IPv6 (ms)",
    ),
    "itemsCount": m45,
    "ja": MessageLookupByLibrary.simpleMessage("Japonés"),
    "justNow": MessageLookupByLibrary.simpleMessage("Ahora mismo"),
    "keepAliveIdle": MessageLookupByLibrary.simpleMessage(
      "Inactividad de keep-alive TCP",
    ),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Intervalo de keep-alive TCP",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Clave"),
    "ko": MessageLookupByLibrary.simpleMessage("Coreano"),
    "label": MessageLookupByLibrary.simpleMessage("Etiqueta"),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "large": MessageLookupByLibrary.simpleMessage("Grande"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Última actualización"),
    "layout": MessageLookupByLibrary.simpleMessage("Diseño"),
    "lazy": MessageLookupByLibrary.simpleMessage("Carga diferida"),
    "light": MessageLookupByLibrary.simpleMessage("Claro"),
    "lineIssueTip": m46,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Ajuste de línea"),
    "link": MessageLookupByLibrary.simpleMessage("Enlace"),
    "linkDesc": MessageLookupByLibrary.simpleMessage(
      "Obtén un perfil desde un enlace de suscripción o un enlace para compartir proxies",
    ),
    "liquidGlass": MessageLookupByLibrary.simpleMessage("Liquid Glass"),
    "list": MessageLookupByLibrary.simpleMessage("Lista"),
    "listen": MessageLookupByLibrary.simpleMessage("Escucha"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Marca de enrutamiento de escucha",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "La marca de enrutamiento de escucha solo funciona en Linux.",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage(
      "Conexiones activas",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Cargando…"),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Guardar una copia de los datos en este dispositivo",
    ),
    "localImage": MessageLookupByLibrary.simpleMessage("Imagen local"),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "Acceso a la red local denegado; se usará gVisor en esta conexión. Los proxies y servicios locales pueden seguir inaccesibles",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage(
      "Localizar nodo seleccionado",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Permiso de ubicación",
    ),
    "locationPermissionGuide": m47,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Se requiere permiso de ubicación",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Registro"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Nivel de registro"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Desactivar esta opción oculta la entrada de registros",
    ),
    "loggedOutViewDesc": MessageLookupByLibrary.simpleMessage(
      "Inicie sesión para ver su cuenta y gestionar sus suscripciones",
    ),
    "loggedOutViewTitle": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Error al iniciar sesión",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Sesión iniciada"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "logoutContent": MessageLookupByLibrary.simpleMessage("¿Cerrar sesión?"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "logs": MessageLookupByLibrary.simpleMessage("Registros"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Registros y diagnóstico",
    ),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Registro de eventos"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Prueba de registros"),
    "lookupProxyConfig": MessageLookupByLibrary.simpleMessage(
      "Buscar la configuración del nodo",
    ),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Exención de loopback de UWP",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Permitir el bucle local de las aplicaciones UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Amplio"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "Puede no ser adecuado para redes de China continental",
    ),
    "matchCase": MessageLookupByLibrary.simpleMessage(
      "Coincidir mayúsculas y minúsculas",
    ),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage(
      "Destino de coincidencia",
    ),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("Máximo de fallos"),
    "maxLengthTip": m48,
    "maximize": MessageLookupByLibrary.simpleMessage("Maximizar"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "El orden de selección define el orden de respaldo. Quite y vuelva a seleccionar un miembro para moverlo al final.",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Memoria residente",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage("App y compartida"),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage("Heap inactivo"),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage("Heap en uso"),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "El núcleo no se está ejecutando",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage(
      "Sobrecarga del runtime",
    ),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage(
      "Pilas de goroutines",
    ),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "Estimado a partir de la memoria residente del proceso; puede diferir de lo que indica el sistema.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "El núcleo se ejecuta dentro del proceso de la app. Su parte se estima a partir de las estadísticas del runtime, y el resto cuenta como memoria de la app y compartida.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage(
      "Información de memoria",
    ),
    "memoryInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Memoria que usan la app y el núcleo",
    ),
    "memoryReleased": MessageLookupByLibrary.simpleMessage("Memoria liberada"),
    "memoryReleasedSize": m49,
    "messageTest": MessageLookupByLibrary.simpleMessage("Prueba de mensaje"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "Esto es un mensaje.",
    ),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage(
      "Configuración mínima",
    ),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "Usar reglas simplificadas para generar un perfil más pequeño",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("Minimizar"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Minimizar al salir",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Cambiar el comportamiento al cerrar",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("minutos"),
    "minutesAgo": m50,
    "minutesAgoShort": m51,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Puerto mixto"),
    "mode": MessageLookupByLibrary.simpleMessage("Modo"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monocromo"),
    "monthsAgo": m52,
    "monthsAgoShort": m53,
    "more": MessageLookupByLibrary.simpleMessage("Más"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Planes comprados"),
    "name": MessageLookupByLibrary.simpleMessage("Nombre"),
    "nameCustomProfileTip": MessageLookupByLibrary.simpleMessage(
      "Asigne un nombre a este perfil personalizado",
    ),
    "nameserver": MessageLookupByLibrary.simpleMessage("Servidor DNS"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Resuelve nombres de dominio",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de servidores DNS",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Seleccionar el servidor DNS según el dominio coincidente",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage(
      "Barra inferior",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Red"),
    "networkAccessDeniedError": m54,
    "networkBadResponseError": m55,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "Se canceló la solicitud",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "No se pudo conectar con el servidor. Comprueba tu conexión de red o los ajustes del proxy",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modificar los ajustes de red",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Diagnóstico de red",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Error de red. Compruebe la conexión y vuelva a intentarlo",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "No se pudo resolver la dirección del servidor. Comprueba que la URL sea correcta y que el DNS funcione",
    ),
    "networkName": MessageLookupByLibrary.simpleMessage("Nombre de la red"),
    "networkNotFoundError": m56,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Demasiadas solicitudes (HTTP 429). Espera un momento e inténtalo de nuevo",
    ),
    "networkSecret": MessageLookupByLibrary.simpleMessage("Clave de la red"),
    "networkServerError": m57,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Velocidad de red"),
    "networkTakeover": MessageLookupByLibrary.simpleMessage(
      "Control del tráfico",
    ),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "Se agotó el tiempo de espera de la solicitud. Comprueba tu red o el proxy e inténtalo de nuevo",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Falló la conexión segura. Puede que el certificado del servidor no sea válido o que la conexión esté siendo interceptada",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Tipo de red"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Nueva contraseña",
    ),
    "nextMatch": MessageLookupByLibrary.simpleMessage("Coincidencia siguiente"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage(
      "Letras y números, hasta 12 caracteres",
    ),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("Apodo"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca un apodo",
    ),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "No hay planes disponibles",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Sin datos"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Sin información"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Sin red"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage(
      "Aplicaciones sin acceso a la red",
    ),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "No hay métodos de pago disponibles",
    ),
    "noProxy": MessageLookupByLibrary.simpleMessage("Sin proxy"),
    "noPurchaseRecords": MessageLookupByLibrary.simpleMessage(
      "No hay planes comprados",
    ),
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage(
      "No hay copias en WebDAV",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolver IP"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage(
      "No hay resultados coincidentes",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No hay resultados",
    ),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "No hay planes disponibles para mejorar",
    ),
    "nodeCoreValidationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Inicie el núcleo antes de validar este nodo",
    ),
    "nodeDefinition": MessageLookupByLibrary.simpleMessage(
      "Definición del nodo",
    ),
    "nodeFilter": MessageLookupByLibrary.simpleMessage("Filtro de nodos"),
    "nodeFilterAccountNote": MessageLookupByLibrary.simpleMessage(
      "Se guarda en su cuenta y se aplica a todos los dispositivos con sesión iniciada en esta aplicación.",
    ),
    "nodeFilterAny": MessageLookupByLibrary.simpleMessage("Cualquiera"),
    "nodeFilterCustomized": MessageLookupByLibrary.simpleMessage(
      "Personalizado",
    ),
    "nodeFilterExclude": MessageLookupByLibrary.simpleMessage("Excluir"),
    "nodeFilterKeepOne": MessageLookupByLibrary.simpleMessage(
      "Conserve al menos un nodo",
    ),
    "nodeFilterKept": m58,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("Líneas"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage(
      "El nombre contiene",
    ),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage(
      "El nombre excluye",
    ),
    "nodeFilterNodeExcluded": m59,
    "nodeFilterNodeKept": m60,
    "nodeFilterOnly": MessageLookupByLibrary.simpleMessage("Solo"),
    "nodeFilterPreview": MessageLookupByLibrary.simpleMessage("Vista previa"),
    "nodeFilterRegions": MessageLookupByLibrary.simpleMessage("Regiones"),
    "nodeFilterRetry": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "nodeFilterSearch": MessageLookupByLibrary.simpleMessage("Buscar nodos"),
    "nodeFilterSmartSelection": MessageLookupByLibrary.simpleMessage(
      "Selección inteligente",
    ),
    "nodeInvalidDefinition": MessageLookupByLibrary.simpleMessage(
      "Introduzca una definición completa del proxy, con nombre y tipo",
    ),
    "nodeQuickFields": MessageLookupByLibrary.simpleMessage("Edición rápida"),
    "nodes": MessageLookupByLibrary.simpleMessage("Nodos"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "Este recurso externo no es un archivo de texto",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Ninguno"),
    "notRunning": MessageLookupByLibrary.simpleMessage("Detenido"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "No se puede seleccionar el grupo de proxies actual",
    ),
    "ntpDesc": MessageLookupByLibrary.simpleMessage(
      "Modificar los ajustes de NTP",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Intervalo de sincronización (minutos)",
    ),
    "ntpOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Las entradas añadidas aquí reemplazan los ajustes NTP de cada perfil; lo que no se añada conserva el ajuste del perfil. Las entradas propias de un perfil personalizado tienen prioridad",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "NTP obtiene la hora de un servidor NTP en lugar del reloj del sistema.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No hay perfiles. Añada uno para empezar",
    ),
    "nullTip": m61,
    "numberRangeTip": m62,
    "numberTip": m63,
    "obfs": MessageLookupByLibrary.simpleMessage("Ofuscación"),
    "obfsHost": MessageLookupByLibrary.simpleMessage("Host de ofuscación"),
    "obfsMode": MessageLookupByLibrary.simpleMessage("Modo de ofuscación"),
    "obfsParam": MessageLookupByLibrary.simpleMessage(
      "Parámetro de ofuscación",
    ),
    "obfsPassword": MessageLookupByLibrary.simpleMessage(
      "Contraseña de ofuscación",
    ),
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onDemand": MessageLookupByLibrary.simpleMessage("Bajo demanda"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Pausar y reanudar el proxy según el Wi-Fi o las condiciones de red",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Contar solo el tráfico del proxy",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Contabilizar solo el tráfico del proxy",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("Abrir el panel"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage(
      "Abrir en el navegador",
    ),
    "openLinkFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el enlace. Compruebe que haya un navegador instalado y vuelva a intentarlo.",
    ),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Error en la operación",
    ),
    "operationSuccess": MessageLookupByLibrary.simpleMessage(
      "Operación completada",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Opcional"),
    "options": MessageLookupByLibrary.simpleMessage("Opciones"),
    "other": MessageLookupByLibrary.simpleMessage("Otros"),
    "outbound": MessageLookupByLibrary.simpleMessage("Salida"),
    "outboundExit": MessageLookupByLibrary.simpleMessage("Salida"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Modo de salida"),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "No está disponible en esta configuración. Elimínelo o sustitúyalo.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Se guarda por separado de la suscripción y se vuelve a aplicar tras actualizar. Los grupos nuevos bloquean conexiones si ningún miembro coincide.",
    ),
    "overlayNameConflict": m64,
    "override": MessageLookupByLibrary.simpleMessage("Sobrescritura"),
    "overrideDestination": MessageLookupByLibrary.simpleMessage(
      "Sobrescribir destino",
    ),
    "overrideDestinationDesc": MessageLookupByLibrary.simpleMessage(
      "Sobrescribir destino se conecta al dominio detectado en lugar de a la dirección original.",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Entradas de sobrescritura",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Modo de sobrescritura",
    ),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Script de sobrescritura",
    ),
    "overwriteIssueDuplicateName": m65,
    "overwriteIssueEmptyFallback": m66,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "El nombre está vacío",
    ),
    "overwriteIssueGroupLoop": m67,
    "overwriteIssueMissingProviders": m68,
    "overwriteIssueMissingProxies": m69,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "No hay proxies ni proveedores seleccionados, por lo que el núcleo rechaza este grupo",
    ),
    "overwriteIssueReservedName": m70,
    "overwriteIssuesSummary": m71,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Personalizado",
    ),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Personalizar por completo los grupos de proxies y las reglas",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("Superposición"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "Conservar las reglas y grupos de la suscripción y añadir los propios. Las reglas personales tienen prioridad sobre las de la suscripción; las reglas añadidas existentes mantienen su prioridad.",
    ),
    "parsePureIp": MessageLookupByLibrary.simpleMessage("Analizar IP pura"),
    "parsePureIpDesc": MessageLookupByLibrary.simpleMessage(
      "Analizar IP pura analiza las conexiones que solo llevan una dirección IP.",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden",
    ),
    "passwordRuleHint": MessageLookupByLibrary.simpleMessage(
      "De 10 a 36 caracteres, con mayúscula, minúscula, número y símbolo",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca la contraseña",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Pegar"),
    "pauseUpdates": MessageLookupByLibrary.simpleMessage(
      "Pausar actualizaciones",
    ),
    "payWithBalance": MessageLookupByLibrary.simpleMessage("Pagar con saldo"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("Importe del pago"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Método de pago"),
    "paymentPending": MessageLookupByLibrary.simpleMessage(
      "Aún no se ha recibido el pago. Vuelva a comprobarlo en unos instantes.",
    ),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Error en la solicitud de pago",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage("Pago completado"),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "El servicio de pago devolvió un formato desconocido",
    ),
    "peers": MessageLookupByLibrary.simpleMessage("Pares"),
    "personalRouting": MessageLookupByLibrary.simpleMessage(
      "Enrutamiento personal",
    ),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Elegir del álbum"),
    "pinWindow": MessageLookupByLibrary.simpleMessage("Fijar ventana"),
    "planEnded": MessageLookupByLibrary.simpleMessage("Finalizado"),
    "planInUse": MessageLookupByLibrary.simpleMessage("En uso"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Pendiente de activación",
    ),
    "planNumber": m72,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("No disponible"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage("Vincula WebDAV"),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Introduzca la contraseña de administrador",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Sube un código QR válido",
    ),
    "plugin": MessageLookupByLibrary.simpleMessage("Complemento"),
    "pluginHost": MessageLookupByLibrary.simpleMessage("Host del complemento"),
    "pluginMode": MessageLookupByLibrary.simpleMessage("Modo del complemento"),
    "points": MessageLookupByLibrary.simpleMessage("Puntos"),
    "port": MessageLookupByLibrary.simpleMessage("Puerto"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Introduce un puerto diferente",
    ),
    "portHopping": MessageLookupByLibrary.simpleMessage("Salto de puertos"),
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "Si hay otra aplicación proxy en ejecución, ciérrela primero.",
    ),
    "portSuggestionTip": m73,
    "portTip": m74,
    "portUnavailableMessage": m75,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Puerto no disponible",
    ),
    "portValue": m76,
    "ports": MessageLookupByLibrary.simpleMessage("Puertos"),
    "preSharedKey": MessageLookupByLibrary.simpleMessage("Clave precompartida"),
    "preferH3": MessageLookupByLibrary.simpleMessage("Preferir HTTP/3"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Probar HTTP/3 primero para los servidores DoH",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage("Requisitos previos"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("Pulse una tecla."),
    "preview": MessageLookupByLibrary.simpleMessage("Vista previa"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Coincidencia anterior",
    ),
    "privateKey": MessageLookupByLibrary.simpleMessage("Clave privada"),
    "privateKeyPassphrase": MessageLookupByLibrary.simpleMessage(
      "Frase de contraseña de la clave privada",
    ),
    "process": MessageLookupByLibrary.simpleMessage("Proceso"),
    "profile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("Introduzca un intervalo válido"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Introduzca el intervalo de actualización automática",
        ),
    "profileDaysLeft": m77,
    "profileExpiresIn": m78,
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "El perfil se ha modificado. ¿Desactivar la actualización automática?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Introduzca el nombre del perfil",
    ),
    "profileOverrideSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Solo se aplica a este perfil y tiene prioridad sobre las sobrescrituras DNS y NTP de la aplicación; las entradas no añadidas siguen dichas sobrescrituras",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "Error al analizar el perfil",
    ),
    "profileProviderInUse": m79,
    "profileSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Se aplica solo a este perfil; lo que no añadas usa su valor predeterminado.",
    ),
    "profileTunSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Se aplica solo a este perfil y tiene prioridad sobre las entradas de sobrescritura de TUN de los ajustes de red.",
    ),
    "profileUpdatedAt": m80,
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Introduzca una URL de perfil válida",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Introduzca la URL del perfil",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Perfiles"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Orden de perfiles"),
    "project": MessageLookupByLibrary.simpleMessage("Proyecto"),
    "protocol": MessageLookupByLibrary.simpleMessage("Protocolo"),
    "protocolParam": MessageLookupByLibrary.simpleMessage(
      "Parámetro del protocolo",
    ),
    "protocolVersion": MessageLookupByLibrary.simpleMessage(
      "Versión del protocolo",
    ),
    "providerChanged": MessageLookupByLibrary.simpleMessage(
      "El recurso cambió durante la edición; vuelva a abrirlo y reintente",
    ),
    "providerContent": MessageLookupByLibrary.simpleMessage(
      "Contenido del recurso",
    ),
    "providerContentInvalid": MessageLookupByLibrary.simpleMessage(
      "El contenido o el formato del recurso no es válido",
    ),
    "providerContentTooLarge": MessageLookupByLibrary.simpleMessage(
      "El recurso supera los 32 MiB",
    ),
    "providerInUse": m81,
    "providerLocal": MessageLookupByLibrary.simpleMessage("Archivo local"),
    "providerLookupFailed": MessageLookupByLibrary.simpleMessage(
      "No se puede leer la configuración activa del nodo. Actualiza el recurso e inténtalo de nuevo.",
    ),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Introduzca un nombre sin comas ni saltos de línea",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("URL remota"),
    "providerRenameShadowed": m82,
    "providerSourceApp": MessageLookupByLibrary.simpleMessage(
      "Biblioteca de la aplicación",
    ),
    "providerSourceProfile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "providerSourceReference": m83,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage(
      "Suscripción",
    ),
    "providerSourceUnavailable": m84,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Introduzca una URL HTTP o HTTPS sin credenciales integradas",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Proveedores"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxiesCount": m85,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Nodos disponibles",
    ),
    "proxyChainConflictTip": m86,
    "proxyChainCustomNode": MessageLookupByLibrary.simpleMessage(
      "Nodo personalizado",
    ),
    "proxyChainCustomNodes": MessageLookupByLibrary.simpleMessage(
      "Nodos personalizados",
    ),
    "proxyChainEmpty": MessageLookupByLibrary.simpleMessage(
      "No hay nodos en la cadena",
    ),
    "proxyChainEntry": MessageLookupByLibrary.simpleMessage("Entrada"),
    "proxyChainExit": MessageLookupByLibrary.simpleMessage("Salida"),
    "proxyChainInstruction": MessageLookupByLibrary.simpleMessage(
      "Seleccione los nodos en orden: el primero es la entrada y el último la salida. Seleccione el nodo de salida para usar la cadena.",
    ),
    "proxyChainMinimumNodes": MessageLookupByLibrary.simpleMessage(
      "Una cadena requiere al menos 2 nodos",
    ),
    "proxyChainMinimumNodesHint": MessageLookupByLibrary.simpleMessage(
      "Una cadena requiere al menos 2 nodos. Añada un nodo de salida.",
    ),
    "proxyChainNodeAdded": MessageLookupByLibrary.simpleMessage(
      "Nodo añadido a la cadena",
    ),
    "proxyChainOtherNodes": MessageLookupByLibrary.simpleMessage("Otros nodos"),
    "proxyChainRelatedChainsUpdated": MessageLookupByLibrary.simpleMessage(
      "Cadenas relacionadas actualizadas",
    ),
    "proxyChainSavedAndApplied": MessageLookupByLibrary.simpleMessage(
      "Cadena guardada y aplicada. Seleccione el nodo de salida para usarla",
    ),
    "proxyChainSelectedNodes": MessageLookupByLibrary.simpleMessage(
      "Cadena de proxies",
    ),
    "proxyChainUnavailableNodeTip": m87,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Formatos compatibles: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "Una cadena de proxies puede reducir considerablemente la velocidad. Déjela desactivada salvo que la necesite.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Cadenas de proxies"),
    "proxyConflictAutoConfig": MessageLookupByLibrary.simpleMessage(
      "Antes del inicio, el proxy del sistema usaba un script de configuración automática.",
    ),
    "proxyConflictHint": MessageLookupByLibrary.simpleMessage(
      "Si pertenece a otra aplicación proxy o VPN, ciérrela; ejecutar ambas puede interrumpir la conexión.",
    ),
    "proxyConflictSystemProxy": m88,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "Posible conflicto de proxy",
    ),
    "proxyConflictVpn": m89,
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Filtro de proxies"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Grupo de proxies"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "El grupo de proxies está vacío",
    ),
    "proxyGroupMembersEmpty": MessageLookupByLibrary.simpleMessage(
      "Añada un proxy, un proveedor o una opción de inclusión total",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "El nombre del grupo de proxies no puede estar vacío",
    ),
    "proxyGroupsAfterStart": MessageLookupByLibrary.simpleMessage(
      "Los grupos aparecen aquí cuando se inicia el núcleo",
    ),
    "proxyGroupsCount": m90,
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS de los nodos proxy",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Resuelve los dominios de los nodos proxy",
    ),
    "proxyNameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Política DNS de los nodos proxy",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Nodo proxy"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("Puerto del proxy"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage(
      "Proveedores de proxies",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("Tipo de proxy"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Depurar caché"),
    "publicKey": MessageLookupByLibrary.simpleMessage("Clave pública"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Renovación automática",
    ),
    "purchaseDays": m91,
    "purchaseHours": m92,
    "purchaseMinutes": m93,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "Precio de compra",
    ),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Desactivado"),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("Activado"),
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Tráfico total",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Fecha de compra"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("Negro puro"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Modo negro puro"),
    "qrcode": MessageLookupByLibrary.simpleMessage("Código QR"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Escanear un código QR para obtener un perfil",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Acciones rápidas"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Adición rápida"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Edición rápida"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Relleno rápido"),
    "rawOutboundInUse": m94,
    "readFullAnnouncement": MessageLookupByLibrary.simpleMessage(
      "Leer el aviso completo",
    ),
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Dirección de recepción",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Recargar"),
    "rechargeAllowedRange": m95,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Importe de recarga (¥)",
    ),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "El importe está fuera del intervalo permitido por este método de pago",
    ),
    "recommendedIcons": MessageLookupByLibrary.simpleMessage("Sugeridos"),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "Las próximas renovaciones automáticas mantendrán este descuento",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Puerto Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Rehacer"),
    "refresh": MessageLookupByLibrary.simpleMessage("Actualizar"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "Después de pagar, deslice hacia abajo para actualizar y comprobar el resultado",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("Reembolso"),
    "regex": MessageLookupByLibrary.simpleMessage("Expresión regular"),
    "register": MessageLookupByLibrary.simpleMessage("Registrarse"),
    "registerClosed": MessageLookupByLibrary.simpleMessage(
      "El registro está cerrado actualmente",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Error al registrarse",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "El núcleo ya no admite grupos Relay. Elija otro tipo.",
    ),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Liberar memoria"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo liberar la memoria",
    ),
    "remaining": m96,
    "remainingStock": m97,
    "remainingTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Tiempo restante",
    ),
    "remainingTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Tráfico restante",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Remoto"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Copiar los datos locales a WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage("Destino remoto"),
    "remoteDnsResolve": MessageLookupByLibrary.simpleMessage(
      "Resolución DNS remota",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Quitar"),
    "rename": MessageLookupByLibrary.simpleMessage("Renombrar"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Precio de renovación",
    ),
    "replace": MessageLookupByLibrary.simpleMessage("Reemplazar"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Reemplazar todo"),
    "request": MessageLookupByLibrary.simpleMessage("Solicitud"),
    "requests": MessageLookupByLibrary.simpleMessage("Solicitudes"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Ver solicitudes recientes",
    ),
    "required": MessageLookupByLibrary.simpleMessage("Obligatorio"),
    "resendCodeIn": m98,
    "reset": MessageLookupByLibrary.simpleMessage("Restablecer"),
    "resetDns": MessageLookupByLibrary.simpleMessage("Restablecer DNS"),
    "resetDnsFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo restablecer el DNS. Comprueba la conexión con el núcleo e inténtalo de nuevo.",
    ),
    "resetDnsSuccess": MessageLookupByLibrary.simpleMessage(
      "Estado de DNS borrado",
    ),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Correo enviado. Pegue abajo el enlace o el código de restablecimiento recibido.",
    ),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "Esta página tiene cambios. ¿Desea restablecerla?",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Contraseña restablecida. Inicie sesión con la nueva contraseña",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Restablecer contraseña",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Confirmar restablecimiento",
    ),
    "resetTokenLabel": MessageLookupByLibrary.simpleMessage(
      "Enlace o código de restablecimiento",
    ),
    "resetTokenValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca el enlace o el código de restablecimiento",
    ),
    "resourceSizeLimitTip": m99,
    "resources": MessageLookupByLibrary.simpleMessage("Recursos"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Información de recursos externos",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Respetar reglas"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Encaminar las conexiones DNS según las reglas; requiere un servidor DNS para los nodos proxy",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("Reiniciar"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres reiniciar el núcleo?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Restaurar todos los datos",
    ),
    "restoreDefault": MessageLookupByLibrary.simpleMessage(
      "Restaurar valores predeterminados",
    ),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Error de restauración",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Restaurar datos desde un archivo",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Restaurar datos desde WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Restaurar solo los archivos de configuración",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Estrategia de restauración",
    ),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Compatible",
    ),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Sobrescribir",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Restauración completada",
    ),
    "result": MessageLookupByLibrary.simpleMessage("Resultado"),
    "resumeUpdates": MessageLookupByLibrary.simpleMessage(
      "Reanudar actualizaciones",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "retryCloudSyncWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "Permitir temporalmente y sincronizar",
        ),
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "Comprobar la API temporalmente",
    ),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "Se prohíben estrictamente la ingeniería inversa, la descompilación, el desensamblado y el análisis de esta aplicación asistido por IA.",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Direcciones de ruta"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Configurar las direcciones de rutas de escucha",
    ),
    "routeExcludeAddress": MessageLookupByLibrary.simpleMessage(
      "Direcciones excluidas de la ruta",
    ),
    "routingApplied": MessageLookupByLibrary.simpleMessage(
      "Ajustes personales aplicados.",
    ),
    "routingApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Los cambios se guardaron, pero no pudieron aplicarse. Compruebe la configuración y reintente.",
    ),
    "routingChanged": MessageLookupByLibrary.simpleMessage(
      "Esta configuración cambió durante la edición o la comprobación. Vuelva a abrir el editor o compruébela de nuevo.",
    ),
    "routingChecked": MessageLookupByLibrary.simpleMessage(
      "La configuración es válida. Los ajustes personales se han guardado para este perfil.",
    ),
    "routingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Guarde un borrador para corregir otros elementos. Los ajustes solo se aplican cuando toda la configuración supera la validación.",
    ),
    "routingGroupType": MessageLookupByLibrary.simpleMessage("Tipo de grupo"),
    "routingMark": MessageLookupByLibrary.simpleMessage(
      "Marca de enrutamiento",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("Ruso"),
    "rule": MessageLookupByLibrary.simpleMessage("Regla"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Regla lógica AND",
    ),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el dominio completo",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con una palabra clave del dominio",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con una expresión regular de dominio",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con un sufijo de dominio",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Coincidencia con comodines; solo se admiten * y ?",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con la marca DSCP (solo entrada UDP de tproxy)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el rango de puertos de destino",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el código de país de la IP",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con los dominios de Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el nombre de la entrada",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el puerto de entrada",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el tipo de entrada",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el nombre de usuario de entrada; separa varios usuarios con /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el ASN de la IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Coincide con un rango de direcciones IP; IP-CIDR6 es solo un alias",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con un rango de direcciones IP",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con un rango de sufijo de IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con todas las solicitudes, sin necesidad de condiciones",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con TCP o UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Regla lógica NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage("Regla lógica OR"),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el nombre del proceso; en Android coincide con el nombre del paquete",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con una expresión regular del nombre del proceso; en Android coincide con el nombre del paquete",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con comodines en el nombre del proceso; solo se admiten * y ?",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con la ruta completa del proceso",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con una expresión regular de la ruta del proceso",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con comodines en la ruta del proceso; solo se admiten * y ?",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el nombre de rematch; separa varios nombres con /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Hace referencia a un conjunto de reglas; requiere rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el código de país de la IP de origen",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el ASN de la IP de origen",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con un rango de direcciones IP de origen",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con un rango de sufijo de IP de origen",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el rango de puertos de origen",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con una subregla; cuidado con los paréntesis",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Coincide con el ID de usuario de Linux",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("La regla está vacía"),
    "ruleListInvalid": MessageLookupByLibrary.simpleMessage(
      "Las reglas deben ser una lista YAML con una regla por elemento, por ejemplo - DOMAIN,example.com,DIRECT",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Nombre de la regla"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent directo",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Bloquear DNS sobre TLS",
    ),
    "rulePresetBlockLoopback": MessageLookupByLibrary.simpleMessage(
      "Bloquear bucle del proxy",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage(
      "Bloquear QUIC",
    ),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage(
      "Bloquear STUN",
    ),
    "rulePresetInsertHint": MessageLookupByLibrary.simpleMessage(
      "Añadir los preajustes seleccionados antes de las reglas existentes. No se vuelven a añadir reglas idénticas.",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage("LAN directa"),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple y Microsoft directos",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage(
      "Proveedores de reglas",
    ),
    "ruleSetBusyTip": MessageLookupByLibrary.simpleMessage(
      "Hay otra operación de reglas en curso. Vuelva a intentarlo en unos instantes",
    ),
    "ruleSetConvert": MessageLookupByLibrary.simpleMessage("Convertir a MRS"),
    "ruleSetConvertRemote": MessageLookupByLibrary.simpleMessage(
      "Descargar como MRS local",
    ),
    "ruleSetDetect": MessageLookupByLibrary.simpleMessage(
      "Detectar formato y tipo de reglas",
    ),
    "ruleSetEmptyTip": MessageLookupByLibrary.simpleMessage(
      "El conjunto de reglas no contiene entradas utilizables",
    ),
    "ruleSetInvalidTip": MessageLookupByLibrary.simpleMessage(
      "No se puede leer este conjunto de reglas. Compruebe su formato y sus entradas",
    ),
    "ruleSetMixedTip": MessageLookupByLibrary.simpleMessage(
      "El conjunto mezcla dominios y rangos IP. Use reglas classical para combinarlos",
    ),
    "ruleSetNeedsConversionTip": MessageLookupByLibrary.simpleMessage(
      "Este conjunto remoto necesita normalización. Descárguelo como MRS local para usarlo",
    ),
    "ruleSetSizeTip": MessageLookupByLibrary.simpleMessage(
      "El conjunto de reglas supera el límite de procesamiento. Divídalo en conjuntos más pequeños",
    ),
    "ruleSetUnsupportedTip": MessageLookupByLibrary.simpleMessage(
      "Estas reglas no se pueden convertir a MRS sin cambiar su comportamiento",
    ),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Destino de la regla"),
    "rules": MessageLookupByLibrary.simpleMessage("Reglas"),
    "rulesCount": m100,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Las reglas de enrutamiento personal se aplican en modo Reglas.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("Tiempo de actividad"),
    "running": MessageLookupByLibrary.simpleMessage("En ejecución"),
    "runtimeConfig": MessageLookupByLibrary.simpleMessage(
      "Configuración de ejecución",
    ),
    "safeMode": MessageLookupByLibrary.simpleMessage("Modo seguro"),
    "safeModeAppTitle": m101,
    "saturation": MessageLookupByLibrary.simpleMessage("Saturación"),
    "save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage(
      "Guardar y reintentar",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "¿Guardar los cambios?",
    ),
    "saveRoutingDraft": MessageLookupByLibrary.simpleMessage(
      "Guardar borrador",
    ),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage(
      "Pago por QR o transferencia",
    ),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Escanee con Alipay o WeChat para pagar",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "scriptChanged": MessageLookupByLibrary.simpleMessage(
      "El script se modificó o eliminó. Vuelva a abrirlo y reintente.",
    ),
    "scriptChanges": MessageLookupByLibrary.simpleMessage("Cambios del script"),
    "scriptChangesAdded": m102,
    "scriptChangesDescription": MessageLookupByLibrary.simpleMessage(
      "Campos de nivel superior añadidos, modificados o eliminados por el script. La configuración completa también incluye los ajustes de la aplicación.",
    ),
    "scriptChangesEmpty": MessageLookupByLibrary.simpleMessage(
      "El script no modificó la configuración",
    ),
    "scriptChangesModified": m103,
    "scriptChangesRemoved": m104,
    "scriptFullConfig": MessageLookupByLibrary.simpleMessage(
      "Configuración completa",
    ),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Modo Script: usa un script de extensión para sobrescribir la configuración en una sola acción",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage(
      "Opciones del script",
    ),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "Este script no ofrece interruptores configurables",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Buscar"),
    "seconds": MessageLookupByLibrary.simpleMessage("segundos"),
    "secondsCount": m105,
    "secretKey": MessageLookupByLibrary.simpleMessage("Clave"),
    "sectionsInEffect": m106,
    "selectAll": MessageLookupByLibrary.simpleMessage("Seleccionar todo"),
    "selectBackup": MessageLookupByLibrary.simpleMessage(
      "Seleccionar una copia",
    ),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Seleccionar el plan de destino",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Seleccionado"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Enviar código"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage(
      "Enviar correo de restablecimiento",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Servidor"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Error al comprobar el servicio",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage(
      "Error en la comprobación",
    ),
    "settingEntries": MessageLookupByLibrary.simpleMessage("ajustes"),
    "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "settingsCount": m107,
    "shareLinkNodesAdded": m108,
    "shareLinksNotRead": m109,
    "show": MessageLookupByLibrary.simpleMessage("Mostrar"),
    "showLess": MessageLookupByLibrary.simpleMessage("Contraer"),
    "showMore": MessageLookupByLibrary.simpleMessage("Expandir"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Botón de detener en la notificación",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Mostrar contraseña"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Difuminar barra lateral",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Mostrar un fondo translúcido del sistema tras la barra lateral",
    ),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Iniciar sesión con Google",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Inicio silencioso"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Iniciar en segundo plano",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("Añadir uno"),
    "singleValueTip": m110,
    "size": MessageLookupByLibrary.simpleMessage("Tamaño"),
    "skipCertVerify": MessageLookupByLibrary.simpleMessage(
      "Omitir verificación de certificado",
    ),
    "skipDomain": MessageLookupByLibrary.simpleMessage("Omitir dominios"),
    "skipDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Un dominio detectado que esté en la lista de dominios omitidos no se usa.",
    ),
    "skipDstAddress": MessageLookupByLibrary.simpleMessage(
      "Omitir direcciones de destino",
    ),
    "skipSrcAddress": MessageLookupByLibrary.simpleMessage(
      "Omitir direcciones de origen",
    ),
    "slide": MessageLookupByLibrary.simpleMessage("Deslizar"),
    "sliders": MessageLookupByLibrary.simpleMessage("Reguladores"),
    "sniffProtocols": MessageLookupByLibrary.simpleMessage("Protocolos"),
    "sniffer": MessageLookupByLibrary.simpleMessage("Sniffer"),
    "snifferStatusDesc": MessageLookupByLibrary.simpleMessage(
      "El sniffer lee el dominio del tráfico TLS, HTTP y QUIC para que las reglas puedan aplicarse.",
    ),
    "socksPort": MessageLookupByLibrary.simpleMessage("Puerto SOCKS"),
    "softStyle": MessageLookupByLibrary.simpleMessage("Suave"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Agotado"),
    "sort": MessageLookupByLibrary.simpleMessage("Ordenar"),
    "source": MessageLookupByLibrary.simpleMessage("Origen"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("IP de origen"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Proxy especial"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Reglas especiales"),
    "spectrum": MessageLookupByLibrary.simpleMessage("Espectro"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Estadísticas de velocidad",
    ),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Permita el acceso a la ubicación para leer los nombres Wi-Fi. En Android, permita siempre la ubicación precisa y active los servicios de ubicación del sistema.",
    ),
    "ssidPermissionMacosGuide": MessageLookupByLibrary.simpleMessage(
      "Permita la ubicación para esta aplicación en Ajustes del Sistema para leer los nombres Wi-Fi.",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("No hay SSID"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Modo de pila"),
    "stackTrace": MessageLookupByLibrary.simpleMessage("Seguimiento de pila"),
    "standard": MessageLookupByLibrary.simpleMessage("Estándar"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Modo Estándar: reemplaza los ajustes básicos y permite añadir reglas fácilmente",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Iniciar"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "Se ha importado el perfil. ¿Desea iniciar el núcleo ahora?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage(
      "Confirmación",
    ),
    "startFromScratch": MessageLookupByLibrary.simpleMessage(
      "Empezar desde cero",
    ),
    "startSuccess": MessageLookupByLibrary.simpleMessage(
      "Iniciado correctamente",
    ),
    "startVpn": MessageLookupByLibrary.simpleMessage("Iniciando VPN…"),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Inicio y segundo plano",
    ),
    "startupDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Diagnóstico de inicio",
    ),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "El inicio anterior no terminó. La configuración automática y el inicio de la VPN se suspenden en este arranque. El perfil y los ajustes seleccionados no cambian. Revise la configuración y pulse Iniciar para reintentar; una VPN ya activa seguirá conectada.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Recuperación de inicio",
    ),
    "startupTimeoutTip": MessageLookupByLibrary.simpleMessage(
      "Se agotó el tiempo de inicio. Cierre y vuelva a abrir la aplicación. Si persiste, copie el diagnóstico de abajo.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Estado"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Con DNS desactivado, se usa el DNS del sistema.",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Detener"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Deteniendo VPN…"),
    "store": MessageLookupByLibrary.simpleMessage("Tienda"),
    "storeOutcomeUnknown": MessageLookupByLibrary.simpleMessage(
      "La solicitud puede haberse procesado. Revise sus planes comprados antes de reintentarlo.",
    ),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Comprar, renovar y mejorar planes",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Estrategia"),
    "strictRoute": MessageLookupByLibrary.simpleMessage("Ruta estricta"),
    "strictRouteDesc": MessageLookupByLibrary.simpleMessage(
      "La ruta estricta evita que el tráfico, como el DNS, eluda TUN y, con IPv6 desactivado, bloquea las conexiones IPv6 de este dispositivo.",
    ),
    "style": MessageLookupByLibrary.simpleMessage("Estilo"),
    "subRule": MessageLookupByLibrary.simpleMessage("Subregla"),
    "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Información de la suscripción",
    ),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage(
      "Pausar el proxy en reposo",
    ),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "Suspende el reenvío de tráfico y las comprobaciones de disponibilidad cuando la pantalla está apagada y el sistema inactivo. Puede interrumpir llamadas y audio en directo, y retrasar notificaciones",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("Suspendido…"),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Cambiar de perfil"),
    "sync": MessageLookupByLibrary.simpleMessage("Sincronizar"),
    "system": MessageLookupByLibrary.simpleMessage("Sistema"),
    "systemApp": MessageLookupByLibrary.simpleMessage(
      "Aplicaciones del sistema",
    ),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Proxy del sistema"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Asociar el proxy HTTP a VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Pestaña"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage(
      "Animación de pestañas",
    ),
    "tailscaleAccount": MessageLookupByLibrary.simpleMessage("Cuenta"),
    "tailscaleAddNetwork": MessageLookupByLibrary.simpleMessage("Añadir red"),
    "tailscaleAdvanced": MessageLookupByLibrary.simpleMessage("Avanzado"),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage(
      "Clave de autenticación",
    ),
    "tailscaleAuthKeyInvalid": MessageLookupByLibrary.simpleMessage(
      "Esto no parece una clave de autenticación",
    ),
    "tailscaleAuthKeySaved": MessageLookupByLibrary.simpleMessage(
      "Hay una clave de autenticación guardada en este dispositivo. Introduzca otra para sustituirla.",
    ),
    "tailscaleAutoRoute": MessageLookupByLibrary.simpleMessage(
      "Enrutamiento automático",
    ),
    "tailscaleAutoRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Encaminar las direcciones de pares, los nombres MagicDNS y las subredes aprobadas por esta red",
    ),
    "tailscaleAvailableExitNodes": MessageLookupByLibrary.simpleMessage(
      "Nodos de salida disponibles",
    ),
    "tailscaleCheckSettings": m111,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("Conectado"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage("Conectando"),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage(
      "URL de control",
    ),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "La autenticación y la identidad del dispositivo permanecen en este dispositivo.",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage(
      "Nombre del dispositivo",
    ),
    "tailscaleDevices": m112,
    "tailscaleDirect": MessageLookupByLibrary.simpleMessage("Directa"),
    "tailscaleEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Añada una red, inicie sesión en este dispositivo e inicie el proxy para acceder a sus dispositivos.",
    ),
    "tailscaleEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Acceder a su tailnet",
    ),
    "tailscaleEnterAuthKey": MessageLookupByLibrary.simpleMessage(
      "Introduzca la clave de autenticación para iniciar sesión en este dispositivo.",
    ),
    "tailscaleEntryHint": MessageLookupByLibrary.simpleMessage(
      "Acceder a los dispositivos de su tailnet",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("Nodo de salida"),
    "tailscaleExitNodeActive": MessageLookupByLibrary.simpleMessage(
      "Nodo de salida en uso",
    ),
    "tailscaleExitNodeAllowLan": MessageLookupByLibrary.simpleMessage(
      "Permitir acceso a la red local",
    ),
    "tailscaleExitNodeDesc": MessageLookupByLibrary.simpleMessage(
      "Déjelo vacío para ninguno, o use auto, un nombre de par o su IP.",
    ),
    "tailscaleGuide": MessageLookupByLibrary.simpleMessage("Guía"),
    "tailscaleGuideDevices": MessageLookupByLibrary.simpleMessage(
      "Dispositivos y MagicDNS",
    ),
    "tailscaleGuideDevicesBody": MessageLookupByLibrary.simpleMessage(
      "El enrutamiento automático envía las direcciones y nombres MagicDNS de pares conocidos, y las subredes aprobadas del tailnet, a esta red. El resto del tráfico sigue sus reglas.\nSe aplica después de las reglas añadidas y personalizadas y antes de las propias del perfil.\nCon un dominio de servidor de control personalizado, solo se encaminan nombres de dispositivos conocidos, por lo que los sitios públicos del dominio siguen accesibles.\nLas direcciones de subred dentro de la red local actual permanecen locales. Para alcanzar una subred remota con las mismas direcciones, añada una regla dirigida a esta red.\nUn nombre de host que se resuelva a una subred aprobada también pasa por esta red. Si el perfil envía ese nombre directamente a un proxy, añada una regla de dominio dirigida a esta red.",
    ),
    "tailscaleGuideExitNodes": MessageLookupByLibrary.simpleMessage(
      "Nodos de salida",
    ),
    "tailscaleGuideExitNodesBody": MessageLookupByLibrary.simpleMessage(
      "Con un nodo de salida, la red aparece en los grupos de selección del perfil. El tráfico solo usa el nodo de salida tras seleccionar la red allí o dirigir una regla a ella.\nDeje el campo vacío para no usar nodo de salida. auto elige uno disponible; un nombre o dirección selecciona ese dispositivo.",
    ),
    "tailscaleGuideGetStarted": MessageLookupByLibrary.simpleMessage(
      "Primeros pasos",
    ),
    "tailscaleGuideGetStartedBody": MessageLookupByLibrary.simpleMessage(
      "Añada una red y elija «Guardar e iniciar sesión». Abra la página de inicio de sesión y autorice este dispositivo; la sesión se completa automáticamente.\nPara usar una clave, elija «Clave de autenticación» e introdúzcala. No se necesita navegador.\nLa red solo transporta tráfico mientras el proxy está activo. Iniciar sesión por sí solo no encamina tráfico.",
    ),
    "tailscaleGuideSignIn": MessageLookupByLibrary.simpleMessage(
      "Inicio de sesión y copias",
    ),
    "tailscaleGuideSignInBody": MessageLookupByLibrary.simpleMessage(
      "Los ajustes de red se incluyen en las copias. Las claves de autenticación y la identidad permanecen en este dispositivo; inicie sesión de nuevo al restaurar en otro.\nCuando caduque la clave del nodo, elija de nuevo «Guardar e iniciar sesión». La aprobación de dispositivos y el acceso se gestionan en su tailnet.\nEliminar una red cierra la sesión y borra la identidad de este dispositivo.",
    ),
    "tailscaleGuideTroubleshooting": MessageLookupByLibrary.simpleMessage(
      "Solución de problemas",
    ),
    "tailscaleGuideTroubleshootingBody": MessageLookupByLibrary.simpleMessage(
      "Compruebe que el proxy esté activo, este dispositivo esté aprobado y el par esté en línea. Para subredes o Internet, revise también la aprobación de rutas y el nodo de salida.\n«Sin aplicar» indica que la configuración activa no incluye la red: seleccione un perfil y compruebe que ningún nodo tenga el mismo nombre.\nEsta aplicación solo establece conexiones salientes al tailnet. No acepta conexiones entrantes ni ofrece este dispositivo como router de subred o nodo de salida.",
    ),
    "tailscaleHostnameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use minúsculas, números y guiones, hasta 63 caracteres",
    ),
    "tailscaleInteractiveLogin": MessageLookupByLibrary.simpleMessage(
      "Interactivo",
    ),
    "tailscaleKeyExpired": MessageLookupByLibrary.simpleMessage(
      "La clave del nodo ha caducado",
    ),
    "tailscaleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Error al iniciar sesión en Tailscale",
    ),
    "tailscaleLoginFooter": MessageLookupByLibrary.simpleMessage(
      "Inicie sesión una vez por red en este dispositivo.",
    ),
    "tailscaleLoginHint": MessageLookupByLibrary.simpleMessage(
      "Iniciar sesión autoriza este dispositivo. Inicie el proxy para usar la red.",
    ),
    "tailscaleLoginMethod": MessageLookupByLibrary.simpleMessage(
      "Método de inicio de sesión",
    ),
    "tailscaleLoginTimeout": MessageLookupByLibrary.simpleMessage(
      "No se completó el inicio de sesión en cinco minutos. Reintente.",
    ),
    "tailscaleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Abra la página de inicio de sesión o escanee el código. La sesión se completa automáticamente tras la autorización.",
    ),
    "tailscaleLogout": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "tailscaleNameInUse": MessageLookupByLibrary.simpleMessage(
      "Este nombre ya está en uso",
    ),
    "tailscaleNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use hasta 64 caracteres, sin comas",
    ),
    "tailscaleNeedsApproval": MessageLookupByLibrary.simpleMessage(
      "Dispositivo pendiente de aprobación",
    ),
    "tailscaleNeedsLogin": MessageLookupByLibrary.simpleMessage(
      "Inicio de sesión necesario",
    ),
    "tailscaleNetworkInUse": m113,
    "tailscaleNetworkName": MessageLookupByLibrary.simpleMessage(
      "Nombre de la red",
    ),
    "tailscaleNetworks": MessageLookupByLibrary.simpleMessage("Redes"),
    "tailscaleNotApplied": MessageLookupByLibrary.simpleMessage("Sin aplicar"),
    "tailscaleNotAppliedHint": MessageLookupByLibrary.simpleMessage(
      "La red no forma parte de la configuración activa. Seleccione un perfil y asegúrese de que ningún nodo tenga el mismo nombre.",
    ),
    "tailscaleNotSignedIn": MessageLookupByLibrary.simpleMessage("Sin sesión"),
    "tailscaleOffline": MessageLookupByLibrary.simpleMessage("Sin conexión"),
    "tailscaleOnline": MessageLookupByLibrary.simpleMessage("En línea"),
    "tailscaleOpenLoginPage": MessageLookupByLibrary.simpleMessage(
      "Abrir página de inicio de sesión",
    ),
    "tailscaleRelay": m114,
    "tailscaleRemoveConfirm": m115,
    "tailscaleRemoveNetwork": MessageLookupByLibrary.simpleMessage(
      "Eliminar red",
    ),
    "tailscaleSaveAndLogin": MessageLookupByLibrary.simpleMessage(
      "Guardar e iniciar sesión",
    ),
    "tailscaleSignedIn": MessageLookupByLibrary.simpleMessage(
      "Sesión iniciada",
    ),
    "tailscaleSigningIn": MessageLookupByLibrary.simpleMessage(
      "Iniciando sesión",
    ),
    "tailscaleStatus": MessageLookupByLibrary.simpleMessage("Estado"),
    "tailscaleStopped": MessageLookupByLibrary.simpleMessage("Detenido"),
    "tailscaleThisDevice": MessageLookupByLibrary.simpleMessage(
      "Este dispositivo",
    ),
    "tailscaleUnavailable": MessageLookupByLibrary.simpleMessage(
      "Conexión no disponible",
    ),
    "tapIconToRetry": MessageLookupByLibrary.simpleMessage(
      "Toca el icono para reintentar",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Toca para autorizar",
    ),
    "target": MessageLookupByLibrary.simpleMessage("Destino"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP concurrente"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Permitir conexiones TCP simultáneas",
    ),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "Acelerar el establecimiento de conexiones TCP",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage("Intervalo de prueba"),
    "testUrl": MessageLookupByLibrary.simpleMessage("URL de prueba"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage("Probar al usarse"),
    "textScale": MessageLookupByLibrary.simpleMessage("Escala del texto"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Así se verá el texto en la app",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Color del tema"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Configurar el modo oscuro y los colores",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Modo del tema"),
    "tight": MessageLookupByLibrary.simpleMessage("Ajustado"),
    "time": MessageLookupByLibrary.simpleMessage("Hora"),
    "timeout": MessageLookupByLibrary.simpleMessage("Tiempo agotado"),
    "tintedStyle": MessageLookupByLibrary.simpleMessage("Tintado"),
    "tip": MessageLookupByLibrary.simpleMessage("Consejo"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Uso de hoy"),
    "toggle": MessageLookupByLibrary.simpleMessage("Alternar"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage(
      "Activar/Desactivar linterna",
    ),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Token de acceso"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Introduzca el token de acceso",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Tolerancia"),
    "tools": MessageLookupByLibrary.simpleMessage("Herramientas"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalDownload": MessageLookupByLibrary.simpleMessage("Descargado"),
    "totalUpload": MessageLookupByLibrary.simpleMessage("Subido"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Puerto TProxy"),
    "traffic": MessageLookupByLibrary.simpleMessage("Tráfico"),
    "trafficPeak": m116,
    "trafficTotal": m117,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Uso de tráfico"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "La transferencia se confirmará automáticamente y se activará el plan seleccionado.",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("Transporte"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAdminAccountRequired": MessageLookupByLibrary.simpleMessage(
      "TUN requiere una cuenta de administrador en este Mac. Inicie sesión con una para activarlo.",
    ),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo activar TUN porque se denegó la autorización de administrador. Acepte la solicitud de permiso del sistema y reintente.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "TUN solo funciona en modo administrador.",
    ),
    "tunHelperInstallFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo activar TUN: falló la instalación o el inicio del servicio auxiliar. Compruebe que la aplicación esté instalada por completo y que el servicio del sistema funcione, y vuelva a intentarlo.",
    ),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "Valor predeterminado: 9000; alternativas: 1480 o 4064. Reinicie la VPN de Android para aplicar",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "Introduzca un entero entre 1280 y 65535",
    ),
    "tunOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Las entradas añadidas aquí sustituyen los ajustes de TUN de todos los perfiles; lo que no añadas conserva el ajuste del propio perfil. Las entradas que añade un perfil personalizado tienen prioridad.",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Desactivar"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Activar"),
    "udpRelayMode": MessageLookupByLibrary.simpleMessage(
      "Modo de retransmisión UDP",
    ),
    "udpTimeout": MessageLookupByLibrary.simpleMessage("Tiempo de espera UDP"),
    "udpTimeoutDesc": MessageLookupByLibrary.simpleMessage(
      "El tiempo de espera UDP se indica en segundos y solo funciona con las pilas gvisor, system y mixed.",
    ),
    "ultra": MessageLookupByLibrary.simpleMessage("Ultra"),
    "undo": MessageLookupByLibrary.simpleMessage("Deshacer"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Latencia unificada"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Excluir retrasos adicionales, como la negociación",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Desconocido"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Error de red desconocido",
    ),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Restaurar tamaño"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Sin nombre"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Desfijar ventana"),
    "update": MessageLookupByLibrary.simpleMessage("Actualizar"),
    "updateAppImageTip": MessageLookupByLibrary.simpleMessage(
      "Una AppImage no puede instalarse automáticamente. Sustituya el programa actual por el archivo descargado; se ha abierto su carpeta.",
    ),
    "updateApplyFailed": MessageLookupByLibrary.simpleMessage(
      "La actualización automática no se completó. Reintente o actualice desde la página de descarga.",
    ),
    "updateBuildNumber": m118,
    "updateCancelDownload": MessageLookupByLibrary.simpleMessage(
      "Cancelar descarga",
    ),
    "updateDownloadBackground": MessageLookupByLibrary.simpleMessage(
      "Descargar en segundo plano",
    ),
    "updateDownloadBrowser": MessageLookupByLibrary.simpleMessage(
      "Descargar en el navegador",
    ),
    "updateDownloadConfirm": MessageLookupByLibrary.simpleMessage(
      "Descargar actualización",
    ),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Error al descargar la actualización",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage(
      "Descargando actualización",
    ),
    "updateInstall": MessageLookupByLibrary.simpleMessage(
      "Instalar actualización",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Más tarde"),
    "updateNotice": MessageLookupByLibrary.simpleMessage(
      "Nueva versión detectada",
    ),
    "updatePackageFormat": MessageLookupByLibrary.simpleMessage(
      "Elegir formato del paquete",
    ),
    "updatePackageFormatTip": MessageLookupByLibrary.simpleMessage(
      "No se pudo determinar cómo se instaló esta versión. Elija el formato correspondiente.",
    ),
    "updatePackageManagerTip": MessageLookupByLibrary.simpleMessage(
      "Esta versión se instaló con un gestor de paquetes; actualícela del mismo modo.",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage(
      "Actualización lista para instalar",
    ),
    "updateReadyHint": MessageLookupByLibrary.simpleMessage(
      "La actualización está descargada. Instálela cuando le convenga.",
    ),
    "updateReleaseNotes": MessageLookupByLibrary.simpleMessage(
      "Notas de la versión",
    ),
    "updateReleaseNotesFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las notas de la versión. Reintente.",
    ),
    "updateRestart": MessageLookupByLibrary.simpleMessage(
      "Actualizar y reiniciar",
    ),
    "updateRestartHint": MessageLookupByLibrary.simpleMessage(
      "La aplicación se cerrará, se actualizará en su ubicación actual y se abrirá de nuevo. Sus ajustes se conservarán.",
    ),
    "updateVersionNumber": m119,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Mejorar plan"),
    "upload": MessageLookupByLibrary.simpleMessage("Subida"),
    "uploadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Ancho de banda de subida",
    ),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtener un perfil mediante una URL",
    ),
    "urlTip": m120,
    "useHosts": MessageLookupByLibrary.simpleMessage("Usar hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Usar hosts del sistema",
    ),
    "usedShort": MessageLookupByLibrary.simpleMessage("usado"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage("Tráfico usado"),
    "userCenter": MessageLookupByLibrary.simpleMessage("Centro de usuario"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "Centro de usuario (alternativo)",
    ),
    "userGuide": MessageLookupByLibrary.simpleMessage("Guía de usuario"),
    "username": MessageLookupByLibrary.simpleMessage("Usuario"),
    "value": MessageLookupByLibrary.simpleMessage("Valor"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("Verificar"),
    "view": MessageLookupByLibrary.simpleMessage("Ver"),
    "virtualIpv4": MessageLookupByLibrary.simpleMessage("IPv4 virtual"),
    "vividStyle": MessageLookupByLibrary.simpleMessage("Vivo"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Cambio de configuración VPN detectado",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "La VPN enruta automáticamente todo el tráfico del sistema a través de VpnService.",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Los cambios se aplican al reiniciar la VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Configuración de WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Modo lista blanca"),
    "writeToSystem": MessageLookupByLibrary.simpleMessage(
      "Escribir en el sistema",
    ),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "Escribir en el sistema también ajusta el reloj del sistema; Android lo ignora.",
    ),
    "yearsAgo": m121,
    "yearsAgoShort": m122,
    "yes": MessageLookupByLibrary.simpleMessage("Sí"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Chino simplificado"),
  };
}
