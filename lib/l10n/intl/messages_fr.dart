// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(value) => "Disponible : ${value}";

  static String m1(count, skipped) =>
      "${count} à ajouter, ${skipped} ignorés car déjà présents";

  static String m2(status) => "Le serveur a renvoyé HTTP ${status}";

  static String m3(error) => "Direct : ${error}";

  static String m4(error) => "Proxy local : ${error}";

  static String m5(code) => "Erreur système ${code}";

  static String m6(value) => "Commission ${value}";

  static String m7(line) =>
      "Le format de la configuration est invalide à la ligne ${line}.";

  static String m8(expected, actual) =>
      "Type attendu : ${expected} ; type trouvé : ${actual}.";

  static String m9(code) =>
      "Windows a bloqué le démarrage du cœur proxy (erreur système ${code}). Consultez l’historique de protection de Sécurité Windows et la politique de contrôle des applications, puis vérifiez la source et la signature de l’installateur.";

  static String m10(url) => "Créer un profil à partir de ${url} ?";

  static String m11(count) =>
      "${Intl.plural(count, one: '${count} règle SUB-RULE ignorée, car les profils personnalisés ne prennent pas en charge les sous-règles', other: '${count} règles SUB-RULE ignorées, car les profils personnalisés ne prennent pas en charge les sous-règles')}";

  static String m12(count) =>
      "${Intl.plural(count, one: '${count} proxy sans nom ou type', other: '${count} proxies sans nom ou type')}";

  static String m13(count) =>
      "${count} éléments posent problème, et l’application de ce profil peut échouer";

  static String m14(name) =>
      "${name} est encore référencé par un groupe, une règle ou une chaîne de proxies";

  static String m15(example) =>
      "Vérifiez le contenu pour ce type de règle. Exemple : ${example}";

  static String m16(name) =>
      "${name} est indisponible. Choisissez un fournisseur de règles existant.";

  static String m17(name) =>
      "${name} est indisponible. Choisissez une cible de cette configuration.";

  static String m18(count) =>
      "${Intl.plural(count, one: 'il y a ${count} jour', other: 'il y a ${count} jours')}";

  static String m19(count) =>
      "${Intl.plural(count, other: 'il y a ${count} j')}";

  static String m20(label) =>
      "Voulez-vous vraiment supprimer les éléments sélectionnés (${label}) ?";

  static String m21(label) => "Voulez-vous supprimer ${label} ?";

  static String m22(label) => "Détails de ${label}";

  static String m23(port) =>
      "Adresse locale : 127.0.0.1\nPort mixte (configuration actuelle) : ${port}\nUtilisez ce port mixte pour HTTP, les sites HTTPS ou SOCKS5, uniquement sur cet appareil.";

  static String m24(count) => "${count} tests HTTPS indépendants réussis sur 2";

  static String m25(name) =>
      "La connexion via ${name} renvoie au proxy qui l’utilise ; la connexion a donc été arrêtée";

  static String m26(label) => "${label} ne peut pas être vide";

  static String m27(label) => "${label} existe déjà";

  static String m28(date) => "Expiration : ${date}";

  static String m29(label, message) => "${label} : ${message}";

  static String m30(name) => "${name} ignoré";

  static String m31(name) => "${name} mis à jour";

  static String m32(name) => "Mise à jour de ${name}…";

  static String m33(count) =>
      "${Intl.plural(count, one: '${count} groupe', other: '${count} groupes')}";

  static String m34(name) =>
      "Référence circulaire de groupe : ${name}. Choisissez un autre membre.";

  static String m35(count) => "${count} expirés";

  static String m36(action) =>
      "Déjà utilisé par « ${action} ». L’enregistrer le déplace ici.";

  static String m37(modifiers) =>
      "Incluez au moins l’une de ces touches : ${modifiers}";

  static String m38(count) =>
      "${Intl.plural(count, one: 'il y a ${count} heure', other: 'il y a ${count} heures')}";

  static String m39(count) =>
      "${Intl.plural(count, other: 'il y a ${count} h')}";

  static String m40(count) => "${count} heures";

  static String m41(target) => "${target} n’est pas une stratégie valide";

  static String m42(providerName) =>
      "${providerName} n’est pas un fournisseur de proxys valide";

  static String m43(ruleSet) => "${ruleSet} n’est pas un jeu de règles valide";

  static String m44(subRule) => "${subRule} n’est pas un SUB_RULE valide";

  static String m45(count) =>
      "${Intl.plural(count, one: '${count} élément', other: '${count} éléments')}";

  static String m46(line, message) => "Ligne ${line} : ${message}";

  static String m47(appName) =>
      "1. Ouvrez Réglages système > Confidentialité et sécurité\n2. Choisissez Service de localisation\n3. Trouvez ${appName} dans la liste et cochez-le\n\nUne fois terminé, revenez dans l’app pour continuer. Merci de votre coopération.";

  static String m48(label, max) =>
      "${label} ne doit pas dépasser ${max} caractères";

  static String m49(size) => "${size} libérés";

  static String m50(count) =>
      "${Intl.plural(count, one: 'il y a ${count} minute', other: 'il y a ${count} minutes')}";

  static String m51(count) =>
      "${Intl.plural(count, other: 'il y a ${count} min')}";

  static String m52(count) =>
      "${Intl.plural(count, one: 'il y a ${count} mois', other: 'il y a ${count} mois')}";

  static String m53(count) =>
      "${Intl.plural(count, other: 'il y a ${count} m')}";

  static String m54(code) =>
      "Le serveur a refusé l’accès (HTTP ${code}). Le lien a peut-être expiré, ou les identifiants sont incorrects";

  static String m55(code) => "Le serveur a rejeté la requête (HTTP ${code})";

  static String m56(code) =>
      "Rien n’a été trouvé à cette adresse (HTTP ${code}). Vérifiez que l’URL est correcte";

  static String m57(code) =>
      "Le serveur a rencontré un problème (HTTP ${code}). Réessayez plus tard";

  static String m58(kept, total) => "${kept} nœuds conservés sur ${total}";

  static String m59(name) => "${name}, exclu";

  static String m60(name) => "${name}, conservé";

  static String m61(label) => "Aucun élément (${label}) pour le moment";

  static String m62(label, min, max) =>
      "${label} doit être compris entre ${min} et ${max}";

  static String m63(label) => "${label} doit être un nombre";

  static String m64(name) =>
      "Le nom « ${name} » est déjà utilisé. Renommez le groupe personnel pour conserver les deux.";

  static String m65(name) =>
      "Le nom ${name} est déjà utilisé par un autre proxy ou groupe";

  static String m66(name) =>
      "La solution de secours d’un groupe vide doit être un nœud existant ou une sortie intégrée, pas un groupe : ${name}";

  static String m67(path) =>
      "Référence circulaire entre groupes de proxies : ${path}";

  static String m68(names) =>
      "Ces fournisseurs de proxies n’existent pas : ${names}";

  static String m69(names) =>
      "Ces proxies ou politiques n’existent pas : ${names}";

  static String m70(name) =>
      "${name} est un nom de politique intégré et ne peut pas être utilisé ici";

  static String m71(count) =>
      "${count} éléments présentent des problèmes ; l’application de ce remplacement peut échouer";

  static String m72(id) => "Offre n° ${id}";

  static String m73(port) => "Le port suggéré ${port} a été renseigné.";

  static String m74(label) => "${label} doit être compris entre 1024 et 49151";

  static String m75(port) =>
      "Le port mixte ${port} n’a pas pu être ouvert et peut être utilisé par une autre application. Changez de port pour réessayer immédiatement.";

  static String m76(port) => "Port ${port}";

  static String m77(days) =>
      "${Intl.plural(days, one: '${days} jour restant', other: '${days} jours restants')}";

  static String m78(date, days) =>
      "Expire le ${date}, ${Intl.plural(days, one: '${days} jour restant', other: '${days} jours restants')}";

  static String m79(profiles) =>
      "Ce profil fournit des proxies à ${profiles}. Retirez-le d’abord de ces profils.";

  static String m80(time) => "Mis à jour ${time}";

  static String m81(profiles) =>
      "Cette ressource est encore utilisée par ${profiles}";

  static String m82(profiles) =>
      "Le renommage modifierait les références aux ressources d’abonnement dans ${profiles}";

  static String m83(profiles) =>
      "Modifiez d’abord les références dans les profils source : ${profiles}";

  static String m84(profiles) =>
      "Impossible de lire ces profils pour vérifier les références : ${profiles}";

  static String m85(count) =>
      "${Intl.plural(count, one: '${count} proxy', other: '${count} proxies')}";

  static String m86(name) =>
      "Le nœud ${name} appartient déjà à une autre chaîne active ou présente un conflit de chaînage";

  static String m87(name) =>
      "Le nœud ${name} n’est pas disponible à cette position";

  static String m88(address) =>
      "Avant le démarrage, le proxy système pointait vers ${address}.";

  static String m89(name) =>
      "Avant le démarrage, le trafic passait par un autre VPN ou adaptateur virtuel : ${name}.";

  static String m90(count) =>
      "${Intl.plural(count, one: '${count} groupe de proxies', other: '${count} groupes de proxies')}";

  static String m91(count) => "${count} j";

  static String m92(count) => "${count} h";

  static String m93(count) => "${count} min";

  static String m94(name, path) =>
      "La configuration d’origine référence ${name} à l’emplacement ${path}";

  static String m95(min, max) => "Plage autorisée : ${min} – ${max}";

  static String m96(value) => "Restant : ${value}";

  static String m97(count) => "Plus que ${count}";

  static String m98(seconds) => "Renvoyer dans ${seconds} s";

  static String m99(limit) => "La ressource dépasse ${limit}";

  static String m100(count) =>
      "${Intl.plural(count, one: '${count} règle', other: '${count} règles')}";

  static String m101(appName) => "${appName} (mode sans échec)";

  static String m102(count) => "Ajoutés (${count})";

  static String m103(count) => "Modifiés (${count})";

  static String m104(count) => "Supprimés (${count})";

  static String m105(count) => "${count} secondes";

  static String m106(count) => "${count} actifs";

  static String m107(count) =>
      "${Intl.plural(count, one: '${count} réglage', other: '${count} réglages')}";

  static String m108(count) =>
      "${Intl.plural(count, one: '${count} nœud ajouté depuis les liens de partage', other: '${count} nœuds ajoutés depuis les liens de partage')}";

  static String m109(count) =>
      "${Intl.plural(count, one: '${count} lien n’a pas pu être lu', other: '${count} liens n’ont pas pu être lus')}";

  static String m110(label) => "${label} doit être un seul élément";

  static String m111(fields) => "Vérifiez ces paramètres : ${fields}";

  static String m112(count) => "Appareils (${count})";

  static String m113(name, profile) =>
      "${name} est encore utilisé par une règle ou un groupe du profil ${profile}";

  static String m114(region) => "Relais ${region}";

  static String m115(name) =>
      "Cet appareil quittera ${name} et ses informations de connexion seront supprimées de cet appareil. Si le réseau est inaccessible, supprimez aussi l’appareil dans la console d’administration Tailscale.";

  static String m116(value) => "Pic ${value}";

  static String m117(value) => "Total ${value}";

  static String m118(build) => "Compilation : ${build}";

  static String m119(version) => "Version : ${version}";

  static String m120(label) => "${label} doit être une URL";

  static String m121(count) =>
      "${Intl.plural(count, one: 'il y a ${count} an', other: 'il y a ${count} ans')}";

  static String m122(count) =>
      "${Intl.plural(count, other: 'il y a ${count} a')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("À propos"),
    "accessControl": MessageLookupByLibrary.simpleMessage("Contrôle d’accès"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Seules les applications sélectionnées utilisent le VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Configurer l’accès des applications au proxy",
    ),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "Le contrôle d’accès des apps est désactivé",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Les applications sélectionnées sont exclues du VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Réglages du contrôle d’accès",
    ),
    "accessToken": MessageLookupByLibrary.simpleMessage("Jeton d’accès"),
    "account": MessageLookupByLibrary.simpleMessage("Compte"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("Solde"),
    "action": MessageLookupByLibrary.simpleMessage("Action"),
    "action_copyEnv": MessageLookupByLibrary.simpleMessage(
      "Copier les variables d’environnement du proxy",
    ),
    "action_delayTest": MessageLookupByLibrary.simpleMessage(
      "Tester la latence des nœuds",
    ),
    "action_directMode": MessageLookupByLibrary.simpleMessage("Mode Direct"),
    "action_exit": MessageLookupByLibrary.simpleMessage("Quitter"),
    "action_globalMode": MessageLookupByLibrary.simpleMessage("Mode Global"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Changer de mode"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("Proxy système"),
    "action_ruleMode": MessageLookupByLibrary.simpleMessage("Mode Règles"),
    "action_start": MessageLookupByLibrary.simpleMessage("Démarrer/Arrêter"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_updateProfiles": MessageLookupByLibrary.simpleMessage(
      "Mettre à jour les profils",
    ),
    "action_view": MessageLookupByLibrary.simpleMessage("Afficher/Masquer"),
    "activate": MessageLookupByLibrary.simpleMessage("Activer"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "Activer cette offre ? Elle deviendra votre offre active.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage(
      "Activer l’offre",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Ajouter"),
    "addNodes": MessageLookupByLibrary.simpleMessage("Ajouter des nœuds"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Ajouter une entrée de remplacement",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Ajouter un profil"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("Ajouter"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Ajouter un groupe de proxys",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Ajouter une règle"),
    "addSettingEntry": MessageLookupByLibrary.simpleMessage(
      "Ajouter un réglage",
    ),
    "addSsid": MessageLookupByLibrary.simpleMessage("Ajouter un SSID"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Règles ajoutées"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Paramètres supplémentaires",
    ),
    "additionalPrefix": MessageLookupByLibrary.simpleMessage("Préfixe du nom"),
    "additionalSuffix": MessageLookupByLibrary.simpleMessage("Suffixe du nom"),
    "address": MessageLookupByLibrary.simpleMessage("Adresse"),
    "addressCopied": MessageLookupByLibrary.simpleMessage("Adresse copiée"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "Adresse du serveur WebDAV",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Veuillez saisir une adresse WebDAV valide",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Configuration avancée",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Accéder aux différentes options de configuration",
    ),
    "ageDecryptFailedTip": MessageLookupByLibrary.simpleMessage(
      "Impossible de déchiffrer le profil. Vérifiez la clé secrète age et réessayez.",
    ),
    "ageSecretKey": MessageLookupByLibrary.simpleMessage("Clé secrète age"),
    "ageSecretKeyRequiredTip": MessageLookupByLibrary.simpleMessage(
      "Ce profil est chiffré avec age et nécessite une clé secrète age pour être déchiffré",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Autoriser les apps à contourner le VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Autoriser certaines applications à contourner le VPN",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Autoriser le LAN"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Autoriser l’accès au proxy depuis le réseau local",
    ),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage(
      "Autoriser temporairement",
    ),
    "allowedIps": MessageLookupByLibrary.simpleMessage("IP autorisées"),
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("Montant dû"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("Montant à payer"),
    "announcement": MessageLookupByLibrary.simpleMessage("Annonce"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "Le service API fonctionne",
    ),
    "apiAvailableWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "L’API était accessible avec une exception temporaire de certificat. Aucun compte ni aucune configuration de nœuds n’a été synchronisé. Corrigez le certificat, puis vérifiez à nouveau.",
        ),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Contrôle d’accès des apps",
    ),
    "appProviderLibrary": MessageLookupByLibrary.simpleMessage(
      "Bibliothèque de fournisseurs",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Ajouter le DNS du système",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Ajouter systématiquement le DNS du système à la configuration",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "authentication": MessageLookupByLibrary.simpleMessage(
      "Authentification du proxy local",
    ),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible d’appliquer les paramètres d’authentification",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Demander un nom d’utilisateur et un mot de passe sur les ports HTTP et SOCKS. Le proxy HTTP système n’est pas configuré lorsque cette option est active ; TUN et VPN restent fonctionnels",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "Utilisez 1 à 255 octets UTF-8, sans caractères de contrôle",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Le proxy système n’est pas appliqué lorsque l’authentification du proxy local est active",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "Utilisez 1 à 255 octets UTF-8, sans deux-points ni caractères de contrôle",
    ),
    "authorized": MessageLookupByLibrary.simpleMessage("Autorisé"),
    "auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Fermer les connexions automatiquement",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Fermer automatiquement les connexions après un changement de nœud",
    ),
    "autoInclude": MessageLookupByLibrary.simpleMessage(
      "Inclure automatiquement",
    ),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("IPv6 automatique"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "Activer ou désactiver IPv6 selon sa prise en charge par le réseau local",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Lancement automatique"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Démarrer avec le système",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Démarrage automatique"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Démarrer automatiquement à l’ouverture de l’application",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Définir automatiquement le DNS du système",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage(
      "Mise à jour automatique",
    ),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Intervalle de mise à jour automatique",
    ),
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("Choisir une offre"),
    "back": MessageLookupByLibrary.simpleMessage("Retour"),
    "backup": MessageLookupByLibrary.simpleMessage("Sauvegarde"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde et restauration",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Synchroniser les données via WebDAV ou des fichiers",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "Cette sauvegarde provient d’une version plus récente de l’app. Mettez l’app à jour avant de la restaurer",
    ),
    "backupRetention": MessageLookupByLibrary.simpleMessage(
      "Sauvegardes à conserver",
    ),
    "backupRetentionDesc": MessageLookupByLibrary.simpleMessage(
      "Chaque sauvegarde supprime les anciennes sauvegardes WebDAV de cet appareil",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Sauvegarde réussie"),
    "balance": MessageLookupByLibrary.simpleMessage("Solde"),
    "balanceDeductionHint": MessageLookupByLibrary.simpleMessage(
      "Les achats utilisent d’abord votre solde, puis les commissions pour couvrir le reste.",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Infos de base"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Stratégies de base"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Ajout groupé"),
    "batchLinkInputTip": MessageLookupByLibrary.simpleMessage(
      "Un lien par ligne",
    ),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "Un élément par ligne, ou séparés par des virgules",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "Une entrée par ligne : la clé, un espace, puis la valeur",
    ),
    "batchPreviewTip": m1,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Ignorer l’optimisation de la batterie maintient l’app active en arrière-plan.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Les limitations du système empêchent de lire correctement l’état de l’optimisation de la batterie pendant l’exécution",
    ),
    "behavior": MessageLookupByLibrary.simpleMessage("Comportement"),
    "billingPeriodLabel": MessageLookupByLibrary.simpleMessage(
      "Période de facturation",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Lier"),
    "bindCoupon": MessageLookupByLibrary.simpleMessage("Appliquer un coupon"),
    "bindCouponIntro": MessageLookupByLibrary.simpleMessage(
      "Saisissez un code de coupon officiel. La différence est calculée sur la durée restante de l’offre ; un coupon récurrent modifie aussi le prix du renouvellement.",
    ),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Mode liste noire"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("Bloquer QUIC"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "Refuser le trafic UDP sur le port 443 pour forcer le retour à TCP",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("Bloquer WebRTC"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "Refuser le trafic STUN pour limiter les fuites d’adresse IP via WebRTC.",
    ),
    "brightness": MessageLookupByLibrary.simpleMessage("Luminosité"),
    "buy": MessageLookupByLibrary.simpleMessage("Acheter"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Domaines contournés"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Les domaines contournés ne s’appliquent que si le proxy système est activé.",
    ),
    "bypassPrivateRoute": MessageLookupByLibrary.simpleMessage(
      "Contourner les adresses privées",
    ),
    "bypassPrivateRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Avec « Contourner les adresses privées » activé, les adresses LAN, de bouclage et multicast ne passent pas par TUN.",
    ),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage(
      "Algorithme de cache",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Le cache est endommagé. L’effacer ?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Taille du cache"),
    "calculatingQuote": MessageLookupByLibrary.simpleMessage(
      "Calcul en cours…",
    ),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Autorisez l’accès à l’appareil photo dans les réglages du système pour scanner des codes QR, ou choisissez une image de code QR dans l’album.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Autorisation de l’appareil photo requise",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Appareil photo indisponible",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Tout désélectionner",
    ),
    "certificateCheckOnlyHint": MessageLookupByLibrary.simpleMessage(
      "Cette action vérifie uniquement l’accès à l’API, sans connexion au compte ni téléchargement de configuration des nœuds.",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage(
      "Le certificat a expiré",
    ),
    "certificateHostnameHint": MessageLookupByLibrary.simpleMessage(
      "Essayez un autre réseau et terminez d’abord toute connexion Wi-Fi requise. Si le problème persiste, demandez au fournisseur de vérifier que le certificat correspond au domaine du serveur.",
    ),
    "certificateHostnameMismatch": MessageLookupByLibrary.simpleMessage(
      "Le certificat ne correspond pas au domaine demandé",
    ),
    "certificateNotYetValid": MessageLookupByLibrary.simpleMessage(
      "Le certificat n’est pas encore valide",
    ),
    "certificateRevoked": MessageLookupByLibrary.simpleMessage(
      "Le certificat a été révoqué",
    ),
    "certificateRevokedHint": MessageLookupByLibrary.simpleMessage(
      "Demandez au fournisseur de remplacer le certificat révoqué. Réessayer ou modifier l’heure système ne résoudra pas ce problème.",
    ),
    "certificateSyncRetryDescription": MessageLookupByLibrary.simpleMessage(
      "Après confirmation, cette tentative vérifie la connexion, actualise votre compte et télécharge la configuration des nœuds. L’exception de certificat prend fin avec la synchronisation.",
    ),
    "certificateUnknownHint": MessageLookupByLibrary.simpleMessage(
      "Vérifiez la date et l’heure du système, puis essayez un autre réseau. Si la vérification échoue toujours, transmettez cette erreur au fournisseur pour obtenir de l’aide.",
    ),
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "La chaîne de certificats n’est pas fiable",
    ),
    "certificateUntrustedHint": MessageLookupByLibrary.simpleMessage(
      "Essayez un autre réseau, par exemple un partage de connexion, et recherchez les mises à jour système. Si un antivirus ou un réseau d’entreprise inspecte HTTPS, contactez son administrateur. Si le problème persiste, demandez au fournisseur de vérifier la chaîne de certificats.",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "Synchronisez d’abord la date et l’heure du système. Si elles sont correctes, le certificat du serveur doit être corrigé.",
    ),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Échec du changement de proxy ; la sélection précédente a été rétablie",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Changements majeurs",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Nouveautés"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage(
      "Corrections de bugs",
    ),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage(
      "Performances",
    ),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Annulations"),
    "checkApi": MessageLookupByLibrary.simpleMessage("Vérifier l’API"),
    "checkRouting": MessageLookupByLibrary.simpleMessage(
      "Vérifier la configuration",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage(
      "Rechercher des mises à jour",
    ),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "L’application est déjà à jour",
    ),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de rechercher les mises à jour. Vérifiez votre connexion et réessayez",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("Vérification…"),
    "chooseMembers": MessageLookupByLibrary.simpleMessage(
      "Choisir les membres",
    ),
    "cipher": MessageLookupByLibrary.simpleMessage("Chiffrement"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("Tout effacer"),
    "clearData": MessageLookupByLibrary.simpleMessage("Effacer les données"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Effacer la chaîne",
    ),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Effacer la recherche"),
    "clientFingerprint": MessageLookupByLibrary.simpleMessage(
      "Empreinte client",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Exporter vers le presse-papiers",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Importer depuis le presse-papiers",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de copier dans le presse-papiers. La sélection est peut-être trop volumineuse",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Fermer"),
    "closeAllConnections": MessageLookupByLibrary.simpleMessage(
      "Fermer toutes les connexions",
    ),
    "cloudApiAccessDenied": MessageLookupByLibrary.simpleMessage(
      "Accès réseau refusé",
    ),
    "cloudApiAddressInUse": MessageLookupByLibrary.simpleMessage(
      "Adresse réseau ou port déjà utilisé",
    ),
    "cloudApiAddressUnavailable": MessageLookupByLibrary.simpleMessage(
      "Adresse réseau indisponible",
    ),
    "cloudApiBadGateway": MessageLookupByLibrary.simpleMessage(
      "La passerelle a reçu une réponse amont invalide",
    ),
    "cloudApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "Le serveur a rejeté la requête comme invalide",
    ),
    "cloudApiClockSkew": MessageLookupByLibrary.simpleMessage(
      "L’horloge de l’appareil diffère trop de celle du serveur. Activez la date et l’heure automatiques, puis réessayez.",
    ),
    "cloudApiConnectTimeout": MessageLookupByLibrary.simpleMessage(
      "Délai de connexion dépassé",
    ),
    "cloudApiConnectionAborted": MessageLookupByLibrary.simpleMessage(
      "Connexion interrompue",
    ),
    "cloudApiConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la connexion",
    ),
    "cloudApiConnectionRefused": MessageLookupByLibrary.simpleMessage(
      "Connexion refusée",
    ),
    "cloudApiConnectionReset": MessageLookupByLibrary.simpleMessage(
      "Connexion réinitialisée",
    ),
    "cloudApiDnsEmpty": MessageLookupByLibrary.simpleMessage(
      "Le DNS n’a renvoyé aucune adresse : blocage possible ou résolveur système défaillant",
    ),
    "cloudApiDnsFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la résolution DNS",
    ),
    "cloudApiDnsUnknownHost": MessageLookupByLibrary.simpleMessage(
      "Le DNS ne trouve pas ce domaine",
    ),
    "cloudApiForbidden": MessageLookupByLibrary.simpleMessage("Accès interdit"),
    "cloudApiGatewayTimeout": MessageLookupByLibrary.simpleMessage(
      "La passerelle a dépassé le délai d’attente du serveur amont",
    ),
    "cloudApiHttpError": m2,
    "cloudApiInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Réponse du serveur invalide",
    ),
    "cloudApiMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Méthode de requête non autorisée",
    ),
    "cloudApiNetworkAuthRequired": MessageLookupByLibrary.simpleMessage(
      "Ce réseau exige une connexion avant de donner accès",
    ),
    "cloudApiNetworkResourcesExhausted": MessageLookupByLibrary.simpleMessage(
      "Ressources réseau du système insuffisantes",
    ),
    "cloudApiNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "Réseau inaccessible",
    ),
    "cloudApiNotFound": MessageLookupByLibrary.simpleMessage(
      "API ou ressource demandée introuvable",
    ),
    "cloudApiProxyAuthFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de l’authentification du proxy (HTTP 407)",
    ),
    "cloudApiProxyFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la connexion au proxy",
    ),
    "cloudApiRateLimited": MessageLookupByLibrary.simpleMessage(
      "Trop de requêtes ; réessayez plus tard",
    ),
    "cloudApiReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Délai d’attente de la réponse dépassé",
    ),
    "cloudApiRedirectInvalid": MessageLookupByLibrary.simpleMessage(
      "Redirection du serveur invalide",
    ),
    "cloudApiRedirectLimit": MessageLookupByLibrary.simpleMessage(
      "Trop de redirections du serveur",
    ),
    "cloudApiRedirectLoop": MessageLookupByLibrary.simpleMessage(
      "Boucle de redirection du serveur",
    ),
    "cloudApiRequestCanceled": MessageLookupByLibrary.simpleMessage(
      "Requête annulée",
    ),
    "cloudApiRequestTooLarge": MessageLookupByLibrary.simpleMessage(
      "La requête dépasse la taille autorisée par le serveur",
    ),
    "cloudApiResponseInterrupted": MessageLookupByLibrary.simpleMessage(
      "Connexion fermée avant la réception de la réponse complète",
    ),
    "cloudApiResponseTooLarge": MessageLookupByLibrary.simpleMessage(
      "La réponse du serveur dépasse la taille autorisée",
    ),
    "cloudApiRouteDirect": m3,
    "cloudApiRouteProxy": m4,
    "cloudApiSendTimeout": MessageLookupByLibrary.simpleMessage(
      "Délai d’envoi de la requête dépassé",
    ),
    "cloudApiServerError": MessageLookupByLibrary.simpleMessage(
      "Erreur interne du serveur",
    ),
    "cloudApiServerRequestTimeout": MessageLookupByLibrary.simpleMessage(
      "Le serveur a dépassé le délai de réception de la requête",
    ),
    "cloudApiServerUnconfigured": MessageLookupByLibrary.simpleMessage(
      "Le serveur n’a pas de clé configurée pour cette application. Contactez l’assistance.",
    ),
    "cloudApiServiceUnavailable": MessageLookupByLibrary.simpleMessage(
      "Service temporairement indisponible",
    ),
    "cloudApiSignatureRejected": MessageLookupByLibrary.simpleMessage(
      "Le serveur a rejeté la signature de cette application. Réinstallez la dernière version officielle.",
    ),
    "cloudApiSystemError": m5,
    "cloudApiTimeout": MessageLookupByLibrary.simpleMessage(
      "Délai de la requête dépassé",
    ),
    "cloudApiTlsAlgorithmFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la négociation des algorithmes cryptographiques TLS",
    ),
    "cloudApiTlsFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la négociation TLS",
    ),
    "cloudApiTlsInterrupted": MessageLookupByLibrary.simpleMessage(
      "Connexion fermée avant la fin de la négociation TLS",
    ),
    "cloudApiTlsProtocolFailed": MessageLookupByLibrary.simpleMessage(
      "Protocole TLS incompatible ou réponse TLS invalide",
    ),
    "cloudCertificateSyncFailed": MessageLookupByLibrary.simpleMessage(
      "La vérification de l’API a réussi, mais la synchronisation du compte ou des nœuds a échoué : ",
    ),
    "cloudConfigSyncIncomplete": MessageLookupByLibrary.simpleMessage(
      "La configuration des nœuds n’a pas été téléchargée. Résolvez l’erreur et relancez la synchronisation.",
    ),
    "cloudSyncedWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "Le compte et la configuration ont été synchronisés avec une exception temporaire de certificat. La vérification est rétablie ; résolvez le problème avant la prochaine synchronisation.",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Code de vérification envoyé",
    ),
    "collapseList": MessageLookupByLibrary.simpleMessage("Réduire"),
    "color": MessageLookupByLibrary.simpleMessage("Couleur"),
    "colorStyle": MessageLookupByLibrary.simpleMessage("Style de couleur"),
    "columns": MessageLookupByLibrary.simpleMessage("Colonnes"),
    "commission": MessageLookupByLibrary.simpleMessage("Commission"),
    "commissionBalance": m6,
    "compact": MessageLookupByLibrary.simpleMessage("Compact"),
    "compatible": MessageLookupByLibrary.simpleMessage("Mode de compatibilité"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Données détectées dans la configuration",
    ),
    "configParseErrorAtLine": m7,
    "configRecoveryKeyring": MessageLookupByLibrary.simpleMessage(
      "Impossible d’accéder au trousseau système (Secret Service). Activez et déverrouillez KDE Wallet ou GNOME Keyring dans les paramètres système, puis réessayez.",
    ),
    "configRecoveryMessage": MessageLookupByLibrary.simpleMessage(
      "La configuration locale est temporairement indisponible. Vos données ont été conservées. Déverrouillez l’appareil et réessayez, ou rouvrez l’application plus tard.",
    ),
    "configRecoveryMissingKey": MessageLookupByLibrary.simpleMessage(
      "La clé de chiffrement de votre configuration est absente ou invalide. Essayez le compte système et l’appareil d’origine, ou restaurez une sauvegarde. Réessayer ne recrée pas une clé perdue.",
    ),
    "configRecoveryReset": MessageLookupByLibrary.simpleMessage(
      "Sauvegarder et réinitialiser",
    ),
    "configRecoveryResetConfirm": MessageLookupByLibrary.simpleMessage(
      "Créer une sauvegarde chiffrée de tous les paramètres, abonnements, règles et données de compte, puis réinitialiser l’application ? Vous devrez vous reconnecter et restaurer ou importer vos abonnements et paramètres. La sauvegarde est protégée par ce compte Windows ; elle ne permet pas de récupérer une clé perdue.",
    ),
    "configRecoveryResetDone": MessageLookupByLibrary.simpleMessage(
      "Une sauvegarde chiffrée des données d’origine a été enregistrée dans le dossier ci-dessous. Quittez puis rouvrez l’application pour la configurer à nouveau.",
    ),
    "configRecoveryResetFailed": MessageLookupByLibrary.simpleMessage(
      "La sauvegarde chiffrée et la réinitialisation ont échoué. Aucune donnée d’origine restante ne sera supprimée sans sauvegarde vérifiée. Réessayez, ou quittez puis rouvrez l’application pour terminer.",
    ),
    "configRecoveryRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "configRecoveryStorage": MessageLookupByLibrary.simpleMessage(
      "Impossible de lire ou d’enregistrer la configuration locale ou sa clé. Vérifiez l’accès au dossier de données de l’application et au stockage sécurisé du système, puis réessayez.",
    ),
    "configRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Récupérer la configuration locale",
    ),
    "configRecoveryUnreadable": MessageLookupByLibrary.simpleMessage(
      "La configuration locale est indéchiffrable ou endommagée. Les fichiers existants sont conservés. Restaurez la clé et la sauvegarde correspondantes, ou sauvegardez puis réinitialisez.",
    ),
    "configRecoveryUseLocalStorage": MessageLookupByLibrary.simpleMessage(
      "Utiliser un fichier local",
    ),
    "configRecoveryUseLocalStorageConfirm":
        MessageLookupByLibrary.simpleMessage(
          "Enregistrer les clés de chiffrement et les identifiants dans un fichier du dossier de l’application, accessible uniquement à votre compte, plutôt que dans le trousseau système ? Tout programme exécuté avec votre compte pourra les lire et déchiffrer la configuration locale. Ce choix restera actif.",
        ),
    "configTypeMismatch": m8,
    "configValueTypeBoolean": MessageLookupByLibrary.simpleMessage(
      "un booléen",
    ),
    "configValueTypeInteger": MessageLookupByLibrary.simpleMessage("un entier"),
    "configValueTypeList": MessageLookupByLibrary.simpleMessage("une liste"),
    "configValueTypeNull": MessageLookupByLibrary.simpleMessage(
      "une valeur vide",
    ),
    "configValueTypeNumber": MessageLookupByLibrary.simpleMessage("un nombre"),
    "configValueTypeObject": MessageLookupByLibrary.simpleMessage("un objet"),
    "configValueTypeText": MessageLookupByLibrary.simpleMessage("du texte"),
    "configYamlFormatHint": MessageLookupByLibrary.simpleMessage(
      "Vérifiez l’indentation et les marqueurs de liste « - » autour de cette ligne.",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmer"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment effacer toutes les données ?",
    ),
    "confirmClearCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Effacer les groupes de proxies et les règles personnalisés de ce profil ? Le contenu de l’abonnement, les règles ajoutées, les chaînes de proxies et les nœuds personnalisés seront conservés.",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment supprimer ce groupe de proxys ?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment quitter la fenêtre actuelle ?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment forcer le plantage du cœur ?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "La confirmation remplacera les données existantes",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Saisissez à nouveau votre mot de passe",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "confirmPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre mot de passe",
    ),
    "confirmPurchase": MessageLookupByLibrary.simpleMessage(
      "Confirmer l’achat",
    ),
    "congestionControl": MessageLookupByLibrary.simpleMessage(
      "Contrôle de congestion",
    ),
    "congestionController": MessageLookupByLibrary.simpleMessage(
      "Contrôle de congestion TCP",
    ),
    "congestionControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Le contrôle de congestion TCP ne fonctionne qu’avec la pile mips.",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Connecté"),
    "connecting": MessageLookupByLibrary.simpleMessage("Connexion…"),
    "connection": MessageLookupByLibrary.simpleMessage("Connexion"),
    "connectionStats": MessageLookupByLibrary.simpleMessage(
      "Statistiques de connexion",
    ),
    "connectionStatsDesc": MessageLookupByLibrary.simpleMessage(
      "Connexions en direct, requêtes récentes et requêtes DNS",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("Connexions"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Consulter les connexions en cours",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Connectivité : "),
    "content": MessageLookupByLibrary.simpleMessage("Contenu"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Gérer les règles ajoutées globales",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copier"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Copier les variables d’environnement",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Copier le lien"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copie réussie"),
    "core": MessageLookupByLibrary.simpleMessage("Cœur"),
    "coreBlockedByPolicyTip": m9,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Windows a bloqué FlClashCore.exe et Smart App Control est activé. Consultez les détails dans Sécurité Windows → Contrôle des applications et du navigateur, puis utilisez une version fiable et vérifiée.",
    ),
    "coreNotConnected": MessageLookupByLibrary.simpleMessage(
      "Le cœur n’est pas connecté",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("État du cœur"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Test de plantage"),
    "create": MessageLookupByLibrary.simpleMessage("Créer"),
    "createProfileFromUrlTip": m10,
    "creationTime": MessageLookupByLibrary.simpleMessage("Date de création"),
    "currentOutboundDesc": MessageLookupByLibrary.simpleMessage(
      "Contient le bouton de démarrage et ne peut pas être retiré",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Personnalisé"),
    "customColor": MessageLookupByLibrary.simpleMessage(
      "Couleur personnalisée",
    ),
    "customImportCloudRefused": MessageLookupByLibrary.simpleMessage(
      "Les adresses oixCloud ne peuvent pas être importées dans un profil personnalisé",
    ),
    "customImportDroppedSubRules": m11,
    "customImportNotImported": MessageLookupByLibrary.simpleMessage(
      "Non importé",
    ),
    "customImportUnnamedProxies": m12,
    "customIssuesSummary": m13,
    "customOutboundInUse": m14,
    "customProfile": MessageLookupByLibrary.simpleMessage(
      "Profil personnalisé",
    ),
    "customProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Assembler des groupes de proxies et des règles à partir de vos nœuds, de la bibliothèque de fournisseurs et d’autres profils",
    ),
    "customProfileResources": MessageLookupByLibrary.simpleMessage(
      "Ressources des profils personnalisés",
    ),
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Complétez votre routage, puis passez en mode Personnalisé. Modifier ce brouillon ne change pas le mode actuel.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "Choisir un fournisseur de règles",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage(
      "Choisir une cible",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("Formulaire"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "Cette règle utilise une syntaxe avancée. Modifiez son texte pour conserver toutes les options.",
    ),
    "customRuleInvalidContent": m15,
    "customRuleInvalidSyntax": MessageLookupByLibrary.simpleMessage(
      "Saisissez une règle complète avec un type, un contenu et une cible valides.",
    ),
    "customRuleMatchHint": MessageLookupByLibrary.simpleMessage(
      "Correspond à tout le trafic restant. Les règles suivantes ne seront pas atteintes.",
    ),
    "customRuleNoResolveHint": MessageLookupByLibrary.simpleMessage(
      "Utiliser les adresses IP connues sans résoudre les noms de domaine.",
    ),
    "customRuleRaw": MessageLookupByLibrary.simpleMessage("Texte de la règle"),
    "customRuleRawHint": MessageLookupByLibrary.simpleMessage(
      "Saisissez une règle complète. Les expressions avancées sont conservées.",
    ),
    "customRuleTargetHint": MessageLookupByLibrary.simpleMessage(
      "Choisissez un groupe de politiques, un proxy ou une action intégrée.",
    ),
    "customRuleType": MessageLookupByLibrary.simpleMessage("Type de règle"),
    "customRuleUnavailableProvider": m16,
    "customRuleUnavailableTarget": m17,
    "cut": MessageLookupByLibrary.simpleMessage("Couper"),
    "dark": MessageLookupByLibrary.simpleMessage("Sombre"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Tableau de bord"),
    "dashboardAddableSection": MessageLookupByLibrary.simpleMessage(
      "Disponibles à l’ajout",
    ),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Des modifications ont été détectées. Les enregistrer ?",
    ),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Impossible d’enregistrer la modification. Vérifiez la valeur actuelle et réessayez.",
    ),
    "daysAgo": m18,
    "daysAgoShort": m19,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Serveur DNS par défaut",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Résout les noms de domaine des serveurs DNS",
    ),
    "defaultSelected": MessageLookupByLibrary.simpleMessage(
      "Sélection par défaut",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Par défaut"),
    "definitionNotMap": MessageLookupByLibrary.simpleMessage(
      "La configuration doit être un mappage YAML avec un nom et un type",
    ),
    "delay": MessageLookupByLibrary.simpleMessage("Délai"),
    "delayConcurrency": MessageLookupByLibrary.simpleMessage(
      "Tests de latence simultanés",
    ),
    "delayConcurrencyAndroidDesc": MessageLookupByLibrary.simpleMessage(
      "Par défaut sur Android : 16. Réduisez sur les réseaux encombrés ; s’applique au prochain lot",
    ),
    "delayConcurrencyDesc": MessageLookupByLibrary.simpleMessage(
      "Par défaut : 50. Réduisez sur les réseaux encombrés ; s’applique au prochain lot",
    ),
    "delayTest": MessageLookupByLibrary.simpleMessage("Test de délai"),
    "delayTestFailed": MessageLookupByLibrary.simpleMessage("Échec"),
    "delayTestQueued": MessageLookupByLibrary.simpleMessage("En attente"),
    "delayTestRunning": MessageLookupByLibrary.simpleMessage("Test en cours"),
    "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "Supprimer cette sauvegarde de WebDAV ?",
    ),
    "deleteMultipTip": m20,
    "deleteTip": m21,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Un client proxy multiplateforme basé sur ClashMeta, simple d’utilisation, open source et sans publicité.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destination"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "GeoIP de destination",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "ASN de l’IP de destination",
    ),
    "details": m22,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Utilise une API tierce ; résultats à titre indicatif uniquement",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Mode développeur"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Le mode développeur est activé.",
    ),
    "diagAllFailed": MessageLookupByLibrary.simpleMessage(
      "Tous les nœuds testés dans ce groupe ont échoué. L’URL de test peut aussi être inaccessible. Lancer l’autodiagnostic réseau ?",
    ),
    "diagCanceled": MessageLookupByLibrary.simpleMessage(
      "Diagnostic annulé ; résultats incomplets",
    ),
    "diagCaptureHint": MessageLookupByLibrary.simpleMessage(
      "Activez le proxy système ou TUN, ou configurez l’application concernée pour utiliser le proxy local.",
    ),
    "diagClock": MessageLookupByLibrary.simpleMessage(
      "Comparaison de l’heure système",
    ),
    "diagClockHint": MessageLookupByLibrary.simpleMessage(
      "Activez la date et l’heure automatiques, puis réessayez. Une horloge incorrecte peut affecter les certificats et les signatures DNS oixCloud.",
    ),
    "diagClockReady": MessageLookupByLibrary.simpleMessage(
      "Aucun décalage important et cohérent n’a été détecté dans ce test",
    ),
    "diagClockSkew": MessageLookupByLibrary.simpleMessage(
      "Deux réponses indépendantes suggèrent un décalage d’au moins cinq minutes",
    ),
    "diagClockUnknown": MessageLookupByLibrary.simpleMessage(
      "Trop peu de réponses HTTPS sans cache pour comparer l’heure",
    ),
    "diagCopy": MessageLookupByLibrary.simpleMessage("Copier le rapport"),
    "diagCopyProxyAddress": MessageLookupByLibrary.simpleMessage(
      "Copier l’adresse du proxy",
    ),
    "diagCore": MessageLookupByLibrary.simpleMessage("Réponse du cœur"),
    "diagCoreDns": MessageLookupByLibrary.simpleMessage("DNS du cœur"),
    "diagCoreHint": MessageLookupByLibrary.simpleMessage(
      "Vérifiez l’interrupteur de connexion et les exclusions Wi-Fi. Si le cœur ne répond pas, redémarrez-le et utilisez des versions actuelles compatibles du client et du cœur.",
    ),
    "diagCoreReady": MessageLookupByLibrary.simpleMessage(
      "Le cœur répond et indique des ports d’écoute actifs",
    ),
    "diagCoreStopped": MessageLookupByLibrary.simpleMessage(
      "Le cœur indique que le transfert du trafic est arrêté",
    ),
    "diagCoreUnknown": MessageLookupByLibrary.simpleMessage(
      "Le diagnostic du cœur est indisponible ou la configuration a changé",
    ),
    "diagDisabled": MessageLookupByLibrary.simpleMessage(
      "Cette option n’est pas activée",
    ),
    "diagDnsHint": MessageLookupByLibrary.simpleMessage(
      "Vérifiez les remplacements DNS et essayez un autre réseau. Si le DNS système fonctionne mais pas celui du cœur, examinez les paramètres DNS de la configuration.",
    ),
    "diagDnsNoAnswer": MessageLookupByLibrary.simpleMessage(
      "Le DNS n’a renvoyé aucune adresse utilisable ; cela ne prouve pas à lui seul un échec d’authentification",
    ),
    "diagDnsPartial": MessageLookupByLibrary.simpleMessage(
      "Seule une partie des noms testés a été résolue",
    ),
    "diagDnsReady": MessageLookupByLibrary.simpleMessage(
      "Les noms testés ont été résolus",
    ),
    "diagDnsRefused": MessageLookupByLibrary.simpleMessage(
      "La requête DNS a été refusée",
    ),
    "diagEntryHint": MessageLookupByLibrary.simpleMessage(
      "Vérifier le cœur, le proxy système, TUN et le DNS",
    ),
    "diagFailed": MessageLookupByLibrary.simpleMessage("Échec"),
    "diagFixApplyProfile": MessageLookupByLibrary.simpleMessage(
      "Appliquer la configuration",
    ),
    "diagFixEnableSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Activer le proxy système",
    ),
    "diagFixFailed": MessageLookupByLibrary.simpleMessage(
      "Le correctif n’a pas pu être appliqué. Suivez la suggestion ci-dessus.",
    ),
    "diagFixRestartConnection": MessageLookupByLibrary.simpleMessage(
      "Se reconnecter",
    ),
    "diagFixRestartCore": MessageLookupByLibrary.simpleMessage(
      "Redémarrer le cœur",
    ),
    "diagFixRetest": MessageLookupByLibrary.simpleMessage("Retester les nœuds"),
    "diagFixStart": MessageLookupByLibrary.simpleMessage(
      "Démarrer la connexion",
    ),
    "diagFixSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Réappliquer le proxy système",
    ),
    "diagFixTun": MessageLookupByLibrary.simpleMessage("Réactiver TUN"),
    "diagFixing": MessageLookupByLibrary.simpleMessage(
      "Application du correctif, puis nouvelle vérification",
    ),
    "diagListener": MessageLookupByLibrary.simpleMessage(
      "Entrée du proxy local",
    ),
    "diagListenerFailed": MessageLookupByLibrary.simpleMessage(
      "Le port proxy attendu ne répond pas ou diffère du port du cœur",
    ),
    "diagListenerHint": MessageLookupByLibrary.simpleMessage(
      "Vérifiez les conflits de ports ou l’arrêt de l’écoute. Reconnectez-vous d’abord ; si l’échec persiste, ouvrez Ports et authentification pour vérifier ou modifier le port mixte.",
    ),
    "diagListenerReady": MessageLookupByLibrary.simpleMessage(
      "Le port attendu a répondu au protocole proxy",
    ),
    "diagNoCapture": MessageLookupByLibrary.simpleMessage(
      "Ni le proxy système ni TUN ne sont activés",
    ),
    "diagOixDns": MessageLookupByLibrary.simpleMessage("DNS signé oixCloud"),
    "diagOixDnsAuthMissing": MessageLookupByLibrary.simpleMessage(
      "La fonction de signature DNS gérée n’est pas prête",
    ),
    "diagOixDnsHint": MessageLookupByLibrary.simpleMessage(
      "Vérifiez la version du client et l’heure système, puis actualisez l’abonnement. Si la résolution échoue encore, transmettez ce rapport à l’assistance.",
    ),
    "diagOixDnsNoSample": MessageLookupByLibrary.simpleMessage(
      "Aucun nom d’hôte de nœud géré n’était disponible pour ce test",
    ),
    "diagOpenDnsSettings": MessageLookupByLibrary.simpleMessage(
      "Remplacements DNS",
    ),
    "diagOpenNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Paramètres réseau et TUN",
    ),
    "diagOpenPortSettings": MessageLookupByLibrary.simpleMessage(
      "Ports et authentification",
    ),
    "diagOpenSettingsFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible d’ouvrir les paramètres système. Suivez le chemin indiqué ci-dessus pour les ouvrir manuellement.",
    ),
    "diagOpenSystemSettings": MessageLookupByLibrary.simpleMessage(
      "Ouvrir les paramètres système",
    ),
    "diagPassed": MessageLookupByLibrary.simpleMessage("Réussi"),
    "diagProfile": MessageLookupByLibrary.simpleMessage(
      "Configuration appliquée",
    ),
    "diagProfileHint": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez une configuration valide et démarrez la connexion avant de vérifier à nouveau.",
    ),
    "diagProfileMissing": MessageLookupByLibrary.simpleMessage(
      "La configuration sélectionnée n’est pas appliquée",
    ),
    "diagProfileReady": MessageLookupByLibrary.simpleMessage(
      "La configuration sélectionnée est appliquée",
    ),
    "diagProxyAutomatic": MessageLookupByLibrary.simpleMessage(
      "Une configuration automatique du proxy existe ; son trajet effectif n’a pas été vérifié",
    ),
    "diagProxyAutomaticHint": MessageLookupByLibrary.simpleMessage(
      "Un script PAC ou la détection automatique peut choisir un proxy différent selon le site. Cela ne signifie pas forcément que la connexion est en panne. Vérifiez l’origine de la configuration avant de la modifier.",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "Le proxy du système ne correspond pas au port de l’application",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "L’application a demandé un proxy système, mais le système l’indique désactivé",
    ),
    "diagProxyGuide": MessageLookupByLibrary.simpleMessage(
      "Dépannage et configuration manuelle",
    ),
    "diagProxyGuideApp": MessageLookupByLibrary.simpleMessage(
      "Sur cet appareil, ouvrez les paramètres proxy de l’application concernée, choisissez HTTP ou SOCKS5, puis saisissez l’adresse et le port ci-dessous.\nAndroid fournit le proxy système via le service VPN. Pour l’accès VPN, vérifiez l’interrupteur VPN et le contrôle d’accès des applications dans les paramètres réseau de FlClash.",
    ),
    "diagProxyGuideAuthenticated": MessageLookupByLibrary.simpleMessage(
      "L’authentification du proxy local est activée ; FlClash n’applique donc pas automatiquement de proxy système.\nDans une application compatible, choisissez HTTP ou SOCKS5 et saisissez l’adresse et le port ci-dessous. Utilisez le nom d’utilisateur et le mot de passe de FlClash → Remplacement → Général → Entrées → Authentification.\nN’incluez pas ces identifiants dans les rapports de diagnostic.",
    ),
    "diagProxyGuideInvalidPort": MessageLookupByLibrary.simpleMessage(
      "Le port mixte est indisponible. Définissez un port valide dans Ports et authentification, puis démarrez la connexion.",
    ),
    "diagProxyGuideLinux": MessageLookupByLibrary.simpleMessage(
      "Ouvrez les paramètres du bureau → Réseau → Proxy réseau et choisissez Manuel (les noms varient selon le bureau).\nSaisissez l’adresse et le port ci-dessous pour HTTP et HTTPS, puis appliquez. Si aucun panneau de proxy système n’existe, configurez l’application concernée.\nAvant de remplacer une configuration automatique, vérifiez sa source et si votre réseau en a encore besoin.",
    ),
    "diagProxyGuideMacos": MessageLookupByLibrary.simpleMessage(
      "Réglages Système → Réseau → connexion Wi-Fi ou Ethernet active → Détails → Proxies\nmacOS 12 : Préférences Système → Réseau → connexion active → Avancé → Proxies\nSi les paramètres automatiques proviennent d’une autre application et ne sont plus nécessaires, désactivez la découverte et la configuration automatiques du proxy.\nActivez Proxy web (HTTP) et Proxy web sécurisé (HTTPS). Saisissez l’adresse et le port ci-dessous pour chacun, puis enregistrez. Conservez les exclusions nécessaires au réseau.",
    ),
    "diagProxyGuideManualTitle": MessageLookupByLibrary.simpleMessage(
      "2. Vérifier ou saisir les paramètres du proxy",
    ),
    "diagProxyGuidePrepare": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez un profil valide, démarrez la connexion dans FlClash et vérifiez que le test du proxy local réussit avant de saisir son adresse.\nQuittez les autres applications proxy susceptibles de modifier les paramètres système. Si votre entreprise ou école gère les paramètres, s’ils sont verrouillés ou se rétablissent sans cesse, contactez l’administrateur.",
    ),
    "diagProxyGuidePrepareTitle": MessageLookupByLibrary.simpleMessage(
      "1. Vérifier d’abord le proxy local",
    ),
    "diagProxyGuideValues": m23,
    "diagProxyGuideVerify": MessageLookupByLibrary.simpleMessage(
      "Revenez et choisissez Vérifier à nouveau, puis réessayez dans votre navigateur ou application.\nSi le proxy local passe le test mais qu’une application échoue encore, vérifiez ses paramètres de proxy système, personnalisé ou d’extension. Le proxy système ne prend pas en charge toutes les applications.\nÀ l’arrêt de FlClash, vous devrez peut-être désactiver le proxy configuré manuellement ou rétablir ses anciens paramètres pour conserver l’accès à Internet.",
    ),
    "diagProxyGuideVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "3. Enregistrer et vérifier dans l’application",
    ),
    "diagProxyGuideWindows": MessageLookupByLibrary.simpleMessage(
      "Paramètres → Réseau et Internet → Proxy\nSi les paramètres automatiques proviennent d’une autre application et ne sont plus nécessaires au réseau, désactivez Utiliser un script d’installation et Détecter automatiquement les paramètres.\nDans Configuration manuelle du proxy, activez Utiliser un serveur proxy, saisissez l’adresse et le port ci-dessous dans leurs champs respectifs, puis enregistrez. N’ajoutez pas http:// devant l’adresse. Conservez les exceptions nécessaires au réseau.",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "Ouvrez Dépannage et configuration manuelle pour comparer l’adresse et le port du proxy système. Si les paramètres se rétablissent sans cesse, vérifiez les autres applications proxy ou les politiques de gestion de l’appareil.",
    ),
    "diagProxyPath": MessageLookupByLibrary.simpleMessage("Via le proxy local"),
    "diagProxyPathHint": MessageLookupByLibrary.simpleMessage(
      "Si le chemin système fonctionne, vérifiez le nœud sélectionné, les règles de routage et le DNS du cœur. L’échec d’un site test ne signifie pas que tous les nœuds sont inutilisables.",
    ),
    "diagProxyReady": MessageLookupByLibrary.simpleMessage(
      "Les proxies HTTP et HTTPS pointent vers le port local attendu",
    ),
    "diagRecheck": MessageLookupByLibrary.simpleMessage("Vérifier à nouveau"),
    "diagRun": MessageLookupByLibrary.simpleMessage("Lancer le diagnostic"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "Test de la connexion actuelle sur un petit échantillon. Le chemin réseau du système peut aussi passer par TUN. Les résultats ne couvrent pas toutes les applications ni tous les nœuds.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("Ignoré"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "Le transfert du trafic est suspendu par l’exclusion Wi-Fi actuelle",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("DNS système"),
    "diagSystemDnsHint": MessageLookupByLibrary.simpleMessage(
      "Essayez un autre réseau et vérifiez les serveurs DNS de la connexion active dans votre système. Modifier uniquement les remplacements DNS du client peut ne pas corriger la résolution système.",
    ),
    "diagSystemPath": MessageLookupByLibrary.simpleMessage(
      "Chemin réseau du système",
    ),
    "diagSystemPathHint": MessageLookupByLibrary.simpleMessage(
      "Ce chemin n’utilise pas explicitement le proxy HTTP de l’application, mais peut passer par TUN. Un échec peut provenir du DNS, d’un filtrage ou du site testé ; comparez le résultat du proxy local.",
    ),
    "diagSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Paramètres du proxy système",
    ),
    "diagTitle": MessageLookupByLibrary.simpleMessage("Autodiagnostic réseau"),
    "diagTrafficCapture": MessageLookupByLibrary.simpleMessage(
      "Prise en charge du trafic",
    ),
    "diagTun": MessageLookupByLibrary.simpleMessage("Interface et route TUN"),
    "diagTunHint": MessageLookupByLibrary.simpleMessage(
      "Désactivez puis réactivez TUN et accordez l’autorisation système. Si la route diffère, vérifiez les autres VPN. IPv6, UDP et les exclusions par application nécessitent des tests séparés.",
    ),
    "diagTunMissing": MessageLookupByLibrary.simpleMessage(
      "Aucune interface TUN active du cœur n’a été trouvée",
    ),
    "diagTunReady": MessageLookupByLibrary.simpleMessage(
      "L’interface TUN du cœur est active et utilisée par la route IPv4 testée",
    ),
    "diagTunRouteMismatch": MessageLookupByLibrary.simpleMessage(
      "TUN est actif, mais la route IPv4 testée utilise une autre interface",
    ),
    "diagTunRouteUnknown": MessageLookupByLibrary.simpleMessage(
      "TUN est actif ; sa route IPv4 n’a pas pu être vérifiée",
    ),
    "diagUnknown": MessageLookupByLibrary.simpleMessage("Non confirmé"),
    "diagWarning": MessageLookupByLibrary.simpleMessage("À vérifier"),
    "diagWebResult": m24,
    "dialerProxy": MessageLookupByLibrary.simpleMessage("Proxy de connexion"),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Le proxy de connexion est la sortie utilisée pour joindre le serveur NTP.",
    ),
    "dialerProxyLoopStopped": m25,
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "directNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS des connexions directes",
    ),
    "directNameserverFollowPolicy": MessageLookupByLibrary.simpleMessage(
      "Appliquer la politique au DNS direct",
    ),
    "disableIcmpForwarding": MessageLookupByLibrary.simpleMessage(
      "Désactiver le transfert ICMP",
    ),
    "disableIcmpForwardingDesc": MessageLookupByLibrary.simpleMessage(
      "Avec le transfert ICMP désactivé, TUN répond lui-même au ping, qui n’indique donc plus la latence réelle.",
    ),
    "disableKeepAlive": MessageLookupByLibrary.simpleMessage(
      "Désactiver le keep-alive TCP",
    ),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Désactiver UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Désactivé"),
    "discard": MessageLookupByLibrary.simpleMessage("Ignorer"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "Abandonner les modifications ?",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Déconnecté"),
    "discountCode": MessageLookupByLibrary.simpleMessage("Code de réduction"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Code de réduction (facultatif)",
    ),
    "discountCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Saisissez un code de réduction",
    ),
    "discountedPriceLabel": MessageLookupByLibrary.simpleMessage("Prix réduit"),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Nouvelle version disponible",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Modifier les paramètres DNS",
    ),
    "dnsHijackDesc": MessageLookupByLibrary.simpleMessage(
      "Sans cette entrée, TUN détourne toutes les requêtes DNS vers le port 53 (any:53).",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("Détournement DNS"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Mode DNS"),
    "dnsOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Les entrées ajoutées ici remplacent les paramètres DNS de chaque profil ; les autres restent ceux du profil. Les entrées d’un profil personnalisé sont prioritaires",
    ),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("Requêtes DNS"),
    "dnsQueriesDesc": MessageLookupByLibrary.simpleMessage(
      "Consulter les 500 dernières requêtes du résolveur",
    ),
    "dnsQueryAll": MessageLookupByLibrary.simpleMessage("Toutes les requêtes"),
    "dnsQueryAnswers": MessageLookupByLibrary.simpleMessage("Réponses"),
    "dnsQueryCached": MessageLookupByLibrary.simpleMessage("En cache"),
    "dnsQueryFailures": MessageLookupByLibrary.simpleMessage(
      "Requêtes échouées",
    ),
    "dnsQueryInitiatorApp": MessageLookupByLibrary.simpleMessage("Application"),
    "dnsQueryInitiatorDirect": MessageLookupByLibrary.simpleMessage(
      "Connexion directe",
    ),
    "dnsQueryInitiatorOther": MessageLookupByLibrary.simpleMessage("Autre"),
    "dnsQueryInitiatorProxy": MessageLookupByLibrary.simpleMessage(
      "Connexion proxy",
    ),
    "dnsQueryInitiatorRule": MessageLookupByLibrary.simpleMessage(
      "Correspondance de règle",
    ),
    "dnsQueryRcode": MessageLookupByLibrary.simpleMessage("Code de réponse"),
    "dnsQueryType": MessageLookupByLibrary.simpleMessage("Type de requête"),
    "dnsQueryUpstream": MessageLookupByLibrary.simpleMessage("Amont"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous continuer ?",
    ),
    "docked": MessageLookupByLibrary.simpleMessage("Ancrée"),
    "domain": MessageLookupByLibrary.simpleMessage("Domaine"),
    "done": MessageLookupByLibrary.simpleMessage("Terminé"),
    "download": MessageLookupByLibrary.simpleMessage("Réception"),
    "downloadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Bande passante de réception",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Durée"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "Inclure automatiquement les nœuds de cette configuration au fil des mises à jour. Utilisez un filtre de nom, par exemple Japan|JP.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Modifier"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Modifier le routage personnalisé",
    ),
    "editDashboard": MessageLookupByLibrary.simpleMessage(
      "Modifier le tableau de bord",
    ),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Modifier les règles globales",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Modifier le profil"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Modifier le groupe de proxys",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Modifier la règle"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Modifier le SSID"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Éditeur indisponible",
    ),
    "elapsed": MessageLookupByLibrary.simpleMessage("Durée"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage(
      "Saisissez le code à 6 chiffres",
    ),
    "emailCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code reçu par e-mail",
    ),
    "emailCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez le code reçu par e-mail",
    ),
    "emailFormatValidation": MessageLookupByLibrary.simpleMessage(
      "Format d’adresse e-mail invalide",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage(
      "Saisissez votre adresse e-mail",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailPassword": MessageLookupByLibrary.simpleMessage(
      "E-mail et mot de passe",
    ),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez votre adresse e-mail",
    ),
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "Le remplacement personnalisé est vide. Utilisez le remplissage rapide ou ajoutez des règles et des groupes de proxies. Pour conserver le contenu de l’abonnement, utilisez le mode Superposition.",
    ),
    "emptyCustomProfile": MessageLookupByLibrary.simpleMessage(
      "Ajoutez d’abord un groupe de proxies ou une règle à ce profil personnalisé",
    ),
    "emptyFallback": MessageLookupByLibrary.simpleMessage("Repli si vide"),
    "emptyTip": m26,
    "en": MessageLookupByLibrary.simpleMessage("Anglais"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Activer le renouvellement automatique",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Activé"),
    "enabledOnStart": MessageLookupByLibrary.simpleMessage(
      "Activer au démarrage",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" entrées"),
    "error": MessageLookupByLibrary.simpleMessage("Erreur"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Détails de l’erreur"),
    "es": MessageLookupByLibrary.simpleMessage("Espagnol"),
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Masquer des tâches récentes",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Masquer l’application des tâches récentes lorsqu’elle est en arrière-plan",
    ),
    "excludeDstPort": MessageLookupByLibrary.simpleMessage(
      "Ports de destination exclus",
    ),
    "excludeDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Le trafic vers les ports de destination exclus ne passe pas par TUN.",
    ),
    "excludeInterface": MessageLookupByLibrary.simpleMessage(
      "Interfaces exclues",
    ),
    "excludeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Le trafic qui arrive sur les interfaces exclues, par exemple docker0, ne passe pas par TUN.",
    ),
    "excludeNetworks": MessageLookupByLibrary.simpleMessage(
      "Suspendre selon l’IP ou la passerelle",
    ),
    "excludeNetworksDesc": MessageLookupByLibrary.simpleMessage(
      "Suspendre sur les adresses IPv4 Wi-Fi/Ethernet, sous-réseaux ou passerelles correspondants ; reprendre après déconnexion. Séparez par des virgules, ex. 192.168.1.0/24,gateway:192.168.1.1",
    ),
    "excludeNetworksInvalid": MessageLookupByLibrary.simpleMessage(
      "Jusqu’à 16 règles ; saisissez une IPv4, un CIDR ou gateway:adresse valide",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Filtre d’exclusion de proxies",
    ),
    "excludeSrcPort": MessageLookupByLibrary.simpleMessage(
      "Ports source exclus",
    ),
    "excludeSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Le trafic issu des ports source exclus ne passe pas par TUN.",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage(
      "Réseaux Wi-Fi qui suspendent le proxy",
    ),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Suspendre le proxy sur les réseaux Wi-Fi indiqués ; reprendre après les avoir quittés, uniquement si l’application reste démarrée",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Type à exclure"),
    "excludeUid": MessageLookupByLibrary.simpleMessage("ID utilisateur exclus"),
    "excludeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Le trafic des processus des ID utilisateur exclus ne passe pas par TUN.",
    ),
    "existsTip": m27,
    "exit": MessageLookupByLibrary.simpleMessage("Quitter"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Quitter le plein écran",
    ),
    "exitNodes": MessageLookupByLibrary.simpleMessage("Nœuds de sortie"),
    "expandList": MessageLookupByLibrary.simpleMessage("Développer"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Statut attendu"),
    "expireDate": m28,
    "expireTime": MessageLookupByLibrary.simpleMessage("Date d’expiration"),
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("Date d’expiration"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Exporter le fichier"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Exporter les journaux"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage(
      "Exportation réussie",
    ),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Contrôleur externe",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Le contrôleur externe permet de piloter le cœur à l’adresse configurée",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("Lien externe"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Très grande"),
    "fade": MessageLookupByLibrary.simpleMessage("Fondu"),
    "failedItem": m29,
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Filtre Fake-IP"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Mode du filtre Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "En mode filtre Fake-IP, la liste noire exclut les correspondances, la liste blanche ne falsifie que les correspondances, et « rule » les traite comme des règles.",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Plage Fake-IP"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Plage Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("DNS de secours"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Liste généralement des serveurs DNS à l’étranger",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Filtre de repli"),
    "fallbackLazyQuery": MessageLookupByLibrary.simpleMessage(
      "Requête différée du DNS de secours",
    ),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les achats",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les offres",
    ),
    "file": MessageLookupByLibrary.simpleMessage("Fichier"),
    "fileDesc": MessageLookupByLibrary.simpleMessage(
      "Importer directement un fichier de profil",
    ),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Le fichier a été modifié. Enregistrer les modifications ?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Filtrer"),
    "filters": MessageLookupByLibrary.simpleMessage("Filtres"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage(
      "Recherche de processus",
    ),
    "findProcessModeAutomaticDesc": MessageLookupByLibrary.simpleMessage(
      "Rechercher le processus uniquement lors de la vérification d’une règle de processus",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "L’activation peut réduire les performances",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("Flottante"),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "Navigation flottante",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Suivre le profil"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Suivre le système"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Police"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Taille"),
    "forceDnsMapping": MessageLookupByLibrary.simpleMessage(
      "Forcer le mappage DNS",
    ),
    "forceDnsMappingDesc": MessageLookupByLibrary.simpleMessage(
      "Forcer le mappage DNS analyse aussi les connexions dont le domaine provient d’un mappage DNS.",
    ),
    "forceDomain": MessageLookupByLibrary.simpleMessage("Domaines forcés"),
    "forceDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Les domaines forcés sont aussi analysés ; les autres connexions qui ont déjà un domaine sont laissées telles quelles.",
    ),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment forcer le redémarrage du cœur ?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié ?",
    ),
    "format": MessageLookupByLibrary.simpleMessage("Format"),
    "fr": MessageLookupByLibrary.simpleMessage("Français"),
    "general": MessageLookupByLibrary.simpleMessage("Général"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage(
      "Mise à jour automatique",
    ),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Intervalle de mise à jour automatique",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "L’intervalle doit être compris entre 1 et 8760 heures",
    ),
    "geoBackupSource": MessageLookupByLibrary.simpleMessage("CDN de secours"),
    "geoDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Échec du téléchargement GEO",
    ),
    "geoDownloadRecoveryHint": MessageLookupByLibrary.simpleMessage(
      "Le téléchargement suit les règles réseau actuelles, ou utilise une connexion directe si le proxy est indisponible. Réessayez l’adresse actuelle, choisissez une autre source ou saisissez une URL. L’opération reprendra automatiquement après validation.",
    ),
    "geoDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "URL de téléchargement",
    ),
    "geoFileMissing": MessageLookupByLibrary.simpleMessage("Non téléchargé"),
    "geoFileReadFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de lire le fichier de ressource",
    ),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "Saisissez une URL HTTP ou HTTPS valide",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Options Geo"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage(
      "Adresse actuelle",
    ),
    "geoResources": MessageLookupByLibrary.simpleMessage("Ressources Geo"),
    "geoSkipped": m30,
    "geoUpdated": m31,
    "geoUpdating": m32,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Mode Geo à faible mémoire",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Utiliser le chargeur Geo à faible consommation de mémoire",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Code GeoIP"),
    "getProfileSuccess": MessageLookupByLibrary.simpleMessage("Profil importé"),
    "global": MessageLookupByLibrary.simpleMessage("Global"),
    "go": MessageLookupByLibrary.simpleMessage("Aller"),
    "goLogin": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "goPay": MessageLookupByLibrary.simpleMessage("Payer"),
    "goToConfigureAddedRules": MessageLookupByLibrary.simpleMessage(
      "Aller à la configuration des règles ajoutées",
    ),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Configurer le script",
    ),
    "googleLoginInvalidCallback": MessageLookupByLibrary.simpleMessage(
      "Impossible de vérifier la connexion à Google. Réessayez.",
    ),
    "googleLoginTimedOut": MessageLookupByLibrary.simpleMessage(
      "Le délai de connexion à Google a expiré. Réessayez.",
    ),
    "googleLoginUnavailable": MessageLookupByLibrary.simpleMessage(
      "Impossible d’ouvrir la connexion à Google. Réessayez.",
    ),
    "googleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Terminez la connexion à Google dans votre navigateur",
    ),
    "grid": MessageLookupByLibrary.simpleMessage("Grille"),
    "groupCount": m33,
    "groupCountUnit": MessageLookupByLibrary.simpleMessage("groupes"),
    "groupCycleError": m34,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "Filtre les nœuds inclus automatiquement et ceux des fournisseurs. Les membres sélectionnés manuellement sont toujours conservés.",
    ),
    "groupTimeoutCount": m35,
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage("Basculement"),
    "groupTypeFallbackHint": MessageLookupByLibrary.simpleMessage(
      "Essayer les membres dans l’ordre et basculer si le membre actif échoue.",
    ),
    "groupTypeLoadBalance": MessageLookupByLibrary.simpleMessage(
      "Répartition de charge",
    ),
    "groupTypeLoadBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Répartir les connexions entre les membres disponibles.",
    ),
    "groupTypeSelect": MessageLookupByLibrary.simpleMessage(
      "Sélection manuelle",
    ),
    "groupTypeSelectHint": MessageLookupByLibrary.simpleMessage(
      "Choisissez le membre actif sur la page Proxies.",
    ),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage(
      "Sélection automatique",
    ),
    "groupTypeUrlTestHint": MessageLookupByLibrary.simpleMessage(
      "Tester régulièrement les membres et choisir un nœud à faible latence.",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Mettre les modifications en cache ?",
    ),
    "hashByInUser": MessageLookupByLibrary.simpleMessage(
      "Hachage par utilisateur entrant",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ?",
    ),
    "healthCheck": MessageLookupByLibrary.simpleMessage("Contrôle d’état"),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Service Helper indisponible ; le mode TUN ne peut pas être activé. Réinstallez FlClash pour le rétablir.",
    ),
    "hex": MessageLookupByLibrary.simpleMessage("Hex"),
    "hide": MessageLookupByLibrary.simpleMessage("Masquer"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Masquer de la liste"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Masquer l’IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage(
      "Masquer le mot de passe",
    ),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Masquer les nœuds en échec",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Conserver le nœud sélectionné et ceux dont le test n’est pas terminé",
    ),
    "hopInterval": MessageLookupByLibrary.simpleMessage("Intervalle de saut"),
    "host": MessageLookupByLibrary.simpleMessage("Hôte"),
    "hostname": MessageLookupByLibrary.simpleMessage("Nom d’hôte"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage(
      "Ajouter des entrées Hosts",
    ),
    "hotkeyConflictWith": m36,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Les raccourcis globaux fonctionnent même lorsque la fenêtre est masquée. Appuyez sur une action pour enregistrer sa combinaison de touches.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Gestion des raccourcis",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Contrôler l’application au clavier",
    ),
    "hotkeyNeedsModifier": m37,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Non défini"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Raccourci indisponible",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("heures"),
    "hoursAgo": m38,
    "hoursAgoShort": m39,
    "hoursCount": m40,
    "hue": MessageLookupByLibrary.simpleMessage("Teinte"),
    "iHavePaid": MessageLookupByLibrary.simpleMessage("J’ai payé"),
    "icon": MessageLookupByLibrary.simpleMessage("Icône"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("Icônes récentes"),
    "iconSets": MessageLookupByLibrary.simpleMessage("Jeux d’icônes"),
    "iconSetsEmptyTip": MessageLookupByLibrary.simpleMessage(
      "Aucun jeu d’icônes pour le moment. Ajoutez-en dans Ressources des profils personnalisés → Jeux d’icônes",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Style des icônes"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("Pleines"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Masquées"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Simples"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL de l’icône"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Ignorer l’optimisation de la batterie",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Importer"),
    "importConfig": MessageLookupByLibrary.simpleMessage(
      "Importer une configuration",
    ),
    "importConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Créer un profil personnalisé à partir des proxies, groupes, règles et paramètres d’une configuration",
    ),
    "importConfigInvalid": MessageLookupByLibrary.simpleMessage(
      "Cette configuration ne peut pas être importée",
    ),
    "importConfigReplaceTip": MessageLookupByLibrary.simpleMessage(
      "L’importation remplace les nœuds, groupes de proxies, règles et paramètres actuels de ce profil",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage(
      "Importer depuis un fichier",
    ),
    "importFromLink": MessageLookupByLibrary.simpleMessage(
      "Importer depuis un lien",
    ),
    "importFromURL": MessageLookupByLibrary.simpleMessage(
      "Importer depuis une URL",
    ),
    "importText": MessageLookupByLibrary.simpleMessage("Importer du texte"),
    "importUrl": MessageLookupByLibrary.simpleMessage(
      "Importer depuis une URL",
    ),
    "inbound": MessageLookupByLibrary.simpleMessage("Entrant"),
    "includeAll": MessageLookupByLibrary.simpleMessage(
      "Inclure tous les proxies et fournisseurs",
    ),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Inclure tous les proxies",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Inclure tous les fournisseurs de proxies",
    ),
    "includeInterface": MessageLookupByLibrary.simpleMessage(
      "Interfaces incluses",
    ),
    "includeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Seul le trafic arrivant sur les interfaces incluses passe par TUN, et les interfaces exclues ne s’appliquent plus.",
    ),
    "includeUid": MessageLookupByLibrary.simpleMessage("ID utilisateur inclus"),
    "includeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Seul le trafic des processus des ID utilisateur inclus passe par TUN.",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Sans expiration"),
    "init": MessageLookupByLibrary.simpleMessage("Initialisation"),
    "initFailed": MessageLookupByLibrary.simpleMessage("Échec du démarrage"),
    "initFailedTip": MessageLookupByLibrary.simpleMessage(
      "L’application a rencontré une erreur critique au démarrage et ne peut pas continuer.",
    ),
    "initiatorShort": MessageLookupByLibrary.simpleMessage("De"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Saisissez le nom du groupe de proxys",
    ),
    "installedAppsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les applications installées. Réessayez.",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage(
          "L’autorisation n’a pas été accordée. Vous pouvez l’activer dans les paramètres système.",
        ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Autorisez l’accès à la liste des applications installées pour choisir celles qui utilisent le VPN.",
    ),
    "installedAppsPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Autoriser l’accès",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Autorisation d’accès aux applications installées requise",
    ),
    "installedFonts": MessageLookupByLibrary.simpleMessage(
      "Polices installées",
    ),
    "insufficientBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Solde insuffisant. Rechargez avant de continuer.",
    ),
    "insufficientBalanceRecharge": MessageLookupByLibrary.simpleMessage(
      "Rechargez et réessayez.",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Sélection intelligente",
    ),
    "interfaceAutomatic": MessageLookupByLibrary.simpleMessage(
      "Effacer le remplacement (interface automatique)",
    ),
    "interfaceFollowProfile": MessageLookupByLibrary.simpleMessage(
      "Suivre le profil",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Nom de l’interface"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Le nom de l’interface est l’interface réseau utilisée par les connexions sortantes.",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Interface sortante",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "interval": MessageLookupByLibrary.simpleMessage("Intervalle"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("IP du réseau local"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage(
      "Saisissez un montant valide",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Fichier de sauvegarde non valide",
    ),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "Le certificat du serveur n’a pas pu être vérifié. Ignorer la vérification peut permettre l’usurpation du serveur et le vol ou la modification des identifiants et des données d’abonnement échangés.\n\nNe continuez que si vous faites confiance à ce réseau et à ce serveur. L’exception ne s’applique qu’à cette tentative, avec le même serveur et le même certificat, et disparaît à la fin de l’opération.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "Échec de la vérification du certificat",
    ),
    "invalidCidrContent": MessageLookupByLibrary.simpleMessage(
      "Saisissez une plage d’IP au format CIDR, par exemple 192.168.0.0/16",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Une marque DSCP ne peut pas dépasser 63",
    ),
    "invalidHostContent": MessageLookupByLibrary.simpleMessage(
      "Saisissez un domaine ou une adresse IP",
    ),
    "invalidIpv6CidrContent": MessageLookupByLibrary.simpleMessage(
      "Saisissez une plage IPv6 au format CIDR, par exemple fd00::/8",
    ),
    "invalidLinkTip": MessageLookupByLibrary.simpleMessage(
      "Ce n’est ni un lien d’abonnement ni un lien de partage de proxy",
    ),
    "invalidListenContent": MessageLookupByLibrary.simpleMessage(
      "Saisissez une adresse et un port, par exemple 0.0.0.0:1053",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Seuls tcp ou udp sont pris en charge",
    ),
    "invalidPolicy": m41,
    "invalidPortRangeContent": MessageLookupByLibrary.simpleMessage(
      "Saisissez un port ou une plage, par exemple 443 ou 8000-9000",
    ),
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Ce code QR ne contient pas de lien de profil",
    ),
    "invalidProxyProvider": m42,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Saisissez des nombres ou des plages tels que 80 ou 8000-9000, séparés par /",
    ),
    "invalidRuleSet": m43,
    "invalidSubRule": m44,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Saisissez le code d’invitation",
    ),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code d’invitation",
    ),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez le code d’invitation",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Type"),
    "ipVersion": MessageLookupByLibrary.simpleMessage("Version d’IP"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("CIDR IP"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Le trafic IPv6 n’est reçu que si IPv6 est activé.",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Avec IPv6 activé, le VPN autorise le trafic IPv6 entrant.",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage(
      "Délai d’expiration IPv6 (ms)",
    ),
    "itemsCount": m45,
    "ja": MessageLookupByLibrary.simpleMessage("Japonais"),
    "justNow": MessageLookupByLibrary.simpleMessage("À l’instant"),
    "keepAliveIdle": MessageLookupByLibrary.simpleMessage(
      "Inactivité keep-alive TCP",
    ),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Intervalle keep-alive TCP",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Clé"),
    "ko": MessageLookupByLibrary.simpleMessage("Coréen"),
    "label": MessageLookupByLibrary.simpleMessage("Libellé"),
    "language": MessageLookupByLibrary.simpleMessage("Langue"),
    "large": MessageLookupByLibrary.simpleMessage("Grande"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Dernière mise à jour"),
    "layout": MessageLookupByLibrary.simpleMessage("Disposition"),
    "lazy": MessageLookupByLibrary.simpleMessage("Chargement différé"),
    "light": MessageLookupByLibrary.simpleMessage("Clair"),
    "lineIssueTip": m46,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Retour à la ligne"),
    "link": MessageLookupByLibrary.simpleMessage("Lien"),
    "linkDesc": MessageLookupByLibrary.simpleMessage(
      "Obtenir un profil depuis un lien d’abonnement ou un lien de partage de proxy",
    ),
    "liquidGlass": MessageLookupByLibrary.simpleMessage("Liquid Glass"),
    "list": MessageLookupByLibrary.simpleMessage("Liste"),
    "listen": MessageLookupByLibrary.simpleMessage("Écoute"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Marque de routage d’écoute",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "La marque de routage d’écoute ne fonctionne que sous Linux.",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage(
      "Connexions en direct",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Chargement…"),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Sauvegarder les données sur cet appareil",
    ),
    "localImage": MessageLookupByLibrary.simpleMessage("Image locale"),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "Accès au réseau local refusé ; gVisor sera utilisé pour cette connexion. Les proxies et services du réseau local peuvent rester indisponibles",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage(
      "Localiser le nœud sélectionné",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Autorisation de localisation",
    ),
    "locationPermissionGuide": m47,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Autorisation de localisation requise",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Journal"),
    "logLevel": MessageLookupByLibrary.simpleMessage(
      "Niveau de journalisation",
    ),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Désactiver cette option masque l’entrée des journaux",
    ),
    "loggedOutViewDesc": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour consulter votre compte et gérer vos abonnements",
    ),
    "loggedOutViewTitle": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la connexion",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Connexion réussie"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Connexion"),
    "logoutContent": MessageLookupByLibrary.simpleMessage("Se déconnecter ?"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Déconnexion"),
    "logs": MessageLookupByLibrary.simpleMessage("Journaux"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Journaux et diagnostic",
    ),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Journal des événements"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Test des journaux"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Exemption de bouclage UWP",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Autoriser le bouclage réseau des applications UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Aérée"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "Peut ne pas convenir aux réseaux de Chine continentale",
    ),
    "matchCase": MessageLookupByLibrary.simpleMessage("Respecter la casse"),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage(
      "Cible de correspondance",
    ),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Nombre maximal d’échecs",
    ),
    "maxLengthTip": m48,
    "maximize": MessageLookupByLibrary.simpleMessage("Agrandir"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "L’ordre de sélection définit l’ordre de secours. Retirez puis sélectionnez à nouveau un membre pour le placer à la fin.",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Mémoire résidente",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage("App et partagée"),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage("Tas inactif"),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage("Tas utilisé"),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "Le cœur n’est pas en cours d’exécution",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage(
      "Surcharge du runtime",
    ),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage(
      "Piles de goroutines",
    ),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "Estimation d’après la mémoire résidente du processus ; elle peut différer de ce qu’indique le système.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "Le cœur s’exécute dans le processus de l’app. Sa part est estimée à partir des statistiques du runtime, et le reste compte comme mémoire de l’app et partagée.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Infos mémoire"),
    "memoryInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Mémoire utilisée par l’app et le cœur",
    ),
    "memoryReleased": MessageLookupByLibrary.simpleMessage("Mémoire libérée"),
    "memoryReleasedSize": m49,
    "messageTest": MessageLookupByLibrary.simpleMessage("Test de message"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "Ceci est un message.",
    ),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage(
      "Configuration minimale",
    ),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "Utiliser des règles simplifiées pour réduire la taille du profil",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("Réduire"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Réduire à la fermeture",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modifier le comportement à la fermeture",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
    "minutesAgo": m50,
    "minutesAgoShort": m51,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Port mixte"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "monthsAgo": m52,
    "monthsAgoShort": m53,
    "more": MessageLookupByLibrary.simpleMessage("Plus"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Offres achetées"),
    "name": MessageLookupByLibrary.simpleMessage("Nom"),
    "nameCustomProfileTip": MessageLookupByLibrary.simpleMessage(
      "Nommez ce profil personnalisé",
    ),
    "nameserver": MessageLookupByLibrary.simpleMessage("Serveur DNS"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Résout les noms de domaine",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Politique des serveurs DNS",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Sélectionner le serveur DNS selon le domaine correspondant",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage(
      "Barre inférieure",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Réseau"),
    "networkAccessDeniedError": m54,
    "networkBadResponseError": m55,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "La requête a été annulée",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "Impossible de se connecter au serveur. Vérifiez votre connexion réseau ou vos réglages de proxy",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modifier les paramètres réseau",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Diagnostic réseau",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Erreur réseau. Vérifiez votre connexion et réessayez",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "Impossible de résoudre l’adresse du serveur. Vérifiez que l’URL est correcte et que le DNS fonctionne",
    ),
    "networkName": MessageLookupByLibrary.simpleMessage("Nom du réseau"),
    "networkNotFoundError": m56,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Trop de requêtes (HTTP 429). Patientez un instant puis réessayez",
    ),
    "networkSecret": MessageLookupByLibrary.simpleMessage("Secret du réseau"),
    "networkServerError": m57,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Débit réseau"),
    "networkTakeover": MessageLookupByLibrary.simpleMessage(
      "Prise en charge du trafic",
    ),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "La requête a expiré. Vérifiez votre réseau ou votre proxy, puis réessayez",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Échec de la connexion sécurisée. Le certificat du serveur est peut-être invalide, ou la connexion est interceptée",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Type de réseau"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "nextMatch": MessageLookupByLibrary.simpleMessage("Résultat suivant"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage(
      "Lettres et chiffres, 12 caractères maximum",
    ),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("Pseudonyme"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez un pseudonyme",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Non"),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "Aucune offre disponible",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Aucune donnée"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Aucune information"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Aucun réseau"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage(
      "Applications sans accès réseau",
    ),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "Aucun moyen de paiement disponible",
    ),
    "noProxy": MessageLookupByLibrary.simpleMessage("Sans proxy"),
    "noPurchaseRecords": MessageLookupByLibrary.simpleMessage(
      "Aucune offre achetée",
    ),
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage(
      "Aucune sauvegarde sur WebDAV",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("Ne pas résoudre l’IP"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage(
      "Aucun résultat correspondant",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage("Aucun résultat"),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "Aucune offre disponible pour la mise à niveau",
    ),
    "nodeCoreValidationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Démarrez le cœur avant de valider ce nœud",
    ),
    "nodeDefinition": MessageLookupByLibrary.simpleMessage(
      "Définition du nœud",
    ),
    "nodeFilter": MessageLookupByLibrary.simpleMessage("Filtre des nœuds"),
    "nodeFilterAccountNote": MessageLookupByLibrary.simpleMessage(
      "Enregistré dans votre compte et appliqué à tous les appareils connectés à cette application.",
    ),
    "nodeFilterAny": MessageLookupByLibrary.simpleMessage("Tous"),
    "nodeFilterCustomized": MessageLookupByLibrary.simpleMessage(
      "Personnalisé",
    ),
    "nodeFilterExclude": MessageLookupByLibrary.simpleMessage("Exclure"),
    "nodeFilterKeepOne": MessageLookupByLibrary.simpleMessage(
      "Conservez au moins un nœud",
    ),
    "nodeFilterKept": m58,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("Lignes"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage(
      "Le nom contient",
    ),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage(
      "Le nom exclut",
    ),
    "nodeFilterNodeExcluded": m59,
    "nodeFilterNodeKept": m60,
    "nodeFilterOnly": MessageLookupByLibrary.simpleMessage("Uniquement"),
    "nodeFilterPreview": MessageLookupByLibrary.simpleMessage("Aperçu"),
    "nodeFilterRegions": MessageLookupByLibrary.simpleMessage("Régions"),
    "nodeFilterRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "nodeFilterSearch": MessageLookupByLibrary.simpleMessage(
      "Rechercher des nœuds",
    ),
    "nodeFilterSmartSelection": MessageLookupByLibrary.simpleMessage(
      "Sélection intelligente",
    ),
    "nodeInvalidDefinition": MessageLookupByLibrary.simpleMessage(
      "Saisissez une définition complète du proxy, avec un nom et un type",
    ),
    "nodeQuickFields": MessageLookupByLibrary.simpleMessage(
      "Modification rapide",
    ),
    "nodes": MessageLookupByLibrary.simpleMessage("Nœuds"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "Cette ressource externe n’est pas un fichier texte",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Aucun"),
    "notRunning": MessageLookupByLibrary.simpleMessage("À l’arrêt"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Le groupe de proxys actuel n’est pas sélectionnable",
    ),
    "ntpDesc": MessageLookupByLibrary.simpleMessage(
      "Modifier les paramètres NTP",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Intervalle de synchronisation (minutes)",
    ),
    "ntpOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Les entrées ajoutées ici remplacent les paramètres NTP de chaque profil ; les autres restent ceux du profil. Les entrées d’un profil personnalisé sont prioritaires",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "NTP récupère l’heure auprès d’un serveur NTP au lieu de l’horloge système.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Aucun profil. Ajoutez-en un pour commencer",
    ),
    "nullTip": m61,
    "numberRangeTip": m62,
    "numberTip": m63,
    "obfs": MessageLookupByLibrary.simpleMessage("Obfuscation"),
    "obfsHost": MessageLookupByLibrary.simpleMessage("Hôte d’obfuscation"),
    "obfsMode": MessageLookupByLibrary.simpleMessage("Mode d’obfuscation"),
    "obfsParam": MessageLookupByLibrary.simpleMessage(
      "Paramètre d’obfuscation",
    ),
    "obfsPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe d’obfuscation",
    ),
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onDemand": MessageLookupByLibrary.simpleMessage("À la demande"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Suspendre et reprendre le proxy selon le Wi-Fi ou les conditions réseau",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Ne compter que le trafic proxy",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Comptabiliser uniquement le trafic du proxy",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le tableau de bord",
    ),
    "openInBrowser": MessageLookupByLibrary.simpleMessage(
      "Ouvrir dans le navigateur",
    ),
    "openLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible d’ouvrir le lien. Vérifiez qu’un navigateur est installé, puis réessayez.",
    ),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de l’opération",
    ),
    "operationSuccess": MessageLookupByLibrary.simpleMessage(
      "Opération réussie",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Facultatif"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "other": MessageLookupByLibrary.simpleMessage("Autre"),
    "outbound": MessageLookupByLibrary.simpleMessage("Sortant"),
    "outboundExit": MessageLookupByLibrary.simpleMessage("Sortie"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Mode sortant"),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "Indisponible dans cette configuration. Supprimez ou remplacez cet élément.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Enregistré séparément de l’abonnement et réappliqué après les mises à jour. Les nouveaux groupes bloquent les connexions si aucun membre ne correspond.",
    ),
    "overlayNameConflict": m64,
    "override": MessageLookupByLibrary.simpleMessage("Remplacement"),
    "overrideDestination": MessageLookupByLibrary.simpleMessage(
      "Remplacer la destination",
    ),
    "overrideDestinationDesc": MessageLookupByLibrary.simpleMessage(
      "Remplacer la destination se connecte au domaine détecté plutôt qu’à l’adresse d’origine.",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Entrées de remplacement",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Mode de remplacement",
    ),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Script de remplacement",
    ),
    "overwriteIssueDuplicateName": m65,
    "overwriteIssueEmptyFallback": m66,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Le nom est vide",
    ),
    "overwriteIssueGroupLoop": m67,
    "overwriteIssueMissingProviders": m68,
    "overwriteIssueMissingProxies": m69,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "Aucun proxy ni fournisseur n’est sélectionné ; le cœur refuse donc ce groupe",
    ),
    "overwriteIssueReservedName": m70,
    "overwriteIssuesSummary": m71,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("Personnalisé"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Personnaliser entièrement les groupes de proxies et les règles",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("Superposition"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "Conserver les règles et groupes de l’abonnement, puis ajouter les vôtres. Les règles personnelles priment sur celles de l’abonnement ; les règles ajoutées existantes conservent leur priorité.",
    ),
    "parsePureIp": MessageLookupByLibrary.simpleMessage(
      "Analyser les IP seules",
    ),
    "parsePureIpDesc": MessageLookupByLibrary.simpleMessage(
      "Analyser les IP seules inspecte les connexions qui ne portent qu’une adresse IP.",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas",
    ),
    "passwordRuleHint": MessageLookupByLibrary.simpleMessage(
      "10 à 36 caractères, dont majuscule, minuscule, chiffre et symbole",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez le mot de passe",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Coller"),
    "pauseUpdates": MessageLookupByLibrary.simpleMessage(
      "Suspendre l’actualisation",
    ),
    "payWithBalance": MessageLookupByLibrary.simpleMessage(
      "Payer avec le solde",
    ),
    "paymentAmount": MessageLookupByLibrary.simpleMessage(
      "Montant du paiement",
    ),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Moyen de paiement"),
    "paymentPending": MessageLookupByLibrary.simpleMessage(
      "Le paiement n’a pas encore été reçu. Vérifiez à nouveau dans un instant.",
    ),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la demande de paiement",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage("Paiement réussi"),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "Le service de paiement a renvoyé un format inconnu",
    ),
    "peers": MessageLookupByLibrary.simpleMessage("Pairs"),
    "personalRouting": MessageLookupByLibrary.simpleMessage(
      "Routage personnel",
    ),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage(
      "Choisir dans l’album",
    ),
    "pinWindow": MessageLookupByLibrary.simpleMessage("Épingler la fenêtre"),
    "planEnded": MessageLookupByLibrary.simpleMessage("Terminé"),
    "planInUse": MessageLookupByLibrary.simpleMessage("En cours"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "En attente d’activation",
    ),
    "planNumber": m72,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("Indisponible"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Veuillez lier un WebDAV",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Saisissez le mot de passe administrateur",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Veuillez importer un code QR valide",
    ),
    "plugin": MessageLookupByLibrary.simpleMessage("Plugin"),
    "pluginHost": MessageLookupByLibrary.simpleMessage("Hôte du plugin"),
    "pluginMode": MessageLookupByLibrary.simpleMessage("Mode du plugin"),
    "points": MessageLookupByLibrary.simpleMessage("Points"),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Veuillez saisir un autre port",
    ),
    "portHopping": MessageLookupByLibrary.simpleMessage("Saut de port"),
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "Si une autre application proxy est en cours d’exécution, fermez-la d’abord.",
    ),
    "portSuggestionTip": m73,
    "portTip": m74,
    "portUnavailableMessage": m75,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Port indisponible",
    ),
    "portValue": m76,
    "ports": MessageLookupByLibrary.simpleMessage("Ports"),
    "preSharedKey": MessageLookupByLibrary.simpleMessage("Clé prépartagée"),
    "preferH3": MessageLookupByLibrary.simpleMessage("Préférer HTTP/3"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Essayer HTTP/3 en priorité pour les serveurs DoH",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage("Prérequis"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Appuyez sur une touche.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Aperçu"),
    "previousMatch": MessageLookupByLibrary.simpleMessage("Résultat précédent"),
    "privateKey": MessageLookupByLibrary.simpleMessage("Clé privée"),
    "privateKeyPassphrase": MessageLookupByLibrary.simpleMessage(
      "Phrase secrète de la clé privée",
    ),
    "process": MessageLookupByLibrary.simpleMessage("Processus"),
    "profile": MessageLookupByLibrary.simpleMessage("Profil"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("Saisissez un intervalle valide"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Saisissez l’intervalle de mise à jour automatique",
        ),
    "profileDaysLeft": m77,
    "profileExpiresIn": m78,
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Le profil a été modifié. Désactiver la mise à jour automatique ?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Saisissez le nom du profil",
    ),
    "profileOverrideSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "S’applique uniquement à ce profil et prime sur les remplacements DNS et NTP de l’application ; les entrées non ajoutées suivent ces remplacements",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "Erreur d’analyse du profil",
    ),
    "profileProviderInUse": m79,
    "profileSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "S’applique uniquement à ce profil ; tout ce qui n’est pas ajouté utilise la valeur par défaut.",
    ),
    "profileTunSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "S’applique uniquement à ce profil et prime sur les entrées de remplacement TUN des réglages réseau.",
    ),
    "profileUpdatedAt": m80,
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Saisissez une URL de profil valide",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Saisissez l’URL du profil",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profils"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Tri des profils"),
    "project": MessageLookupByLibrary.simpleMessage("Projet"),
    "protocol": MessageLookupByLibrary.simpleMessage("Protocole"),
    "protocolParam": MessageLookupByLibrary.simpleMessage(
      "Paramètre du protocole",
    ),
    "protocolVersion": MessageLookupByLibrary.simpleMessage(
      "Version du protocole",
    ),
    "providerChanged": MessageLookupByLibrary.simpleMessage(
      "La ressource a changé pendant la modification ; rouvrez-la et réessayez",
    ),
    "providerContent": MessageLookupByLibrary.simpleMessage(
      "Contenu de la ressource",
    ),
    "providerContentInvalid": MessageLookupByLibrary.simpleMessage(
      "Le contenu ou le format de la ressource est invalide",
    ),
    "providerContentTooLarge": MessageLookupByLibrary.simpleMessage(
      "La ressource dépasse 32 Mio",
    ),
    "providerInUse": m81,
    "providerLocal": MessageLookupByLibrary.simpleMessage("Fichier local"),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Saisissez un nom sans virgule ni saut de ligne",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("URL distante"),
    "providerRenameShadowed": m82,
    "providerSourceApp": MessageLookupByLibrary.simpleMessage(
      "Bibliothèque de l’application",
    ),
    "providerSourceProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "providerSourceReference": m83,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage(
      "Abonnement",
    ),
    "providerSourceUnavailable": m84,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Saisissez une URL HTTP ou HTTPS sans identifiants intégrés",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Fournisseurs"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxys"),
    "proxiesCount": m85,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Nœuds disponibles",
    ),
    "proxyChainConflictTip": m86,
    "proxyChainCustomNode": MessageLookupByLibrary.simpleMessage(
      "Nœud personnalisé",
    ),
    "proxyChainCustomNodes": MessageLookupByLibrary.simpleMessage(
      "Nœuds personnalisés",
    ),
    "proxyChainEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucun nœud dans la chaîne",
    ),
    "proxyChainEntry": MessageLookupByLibrary.simpleMessage("Entrée"),
    "proxyChainExit": MessageLookupByLibrary.simpleMessage("Sortie"),
    "proxyChainInstruction": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez les nœuds dans l’ordre : le premier est l’entrée et le dernier la sortie. Sélectionnez le nœud de sortie pour utiliser la chaîne.",
    ),
    "proxyChainMinimumNodes": MessageLookupByLibrary.simpleMessage(
      "Une chaîne nécessite au moins 2 nœuds",
    ),
    "proxyChainMinimumNodesHint": MessageLookupByLibrary.simpleMessage(
      "Une chaîne nécessite au moins 2 nœuds. Ajoutez un nœud de sortie.",
    ),
    "proxyChainNodeAdded": MessageLookupByLibrary.simpleMessage(
      "Nœud ajouté à la chaîne",
    ),
    "proxyChainOtherNodes": MessageLookupByLibrary.simpleMessage(
      "Autres nœuds",
    ),
    "proxyChainRelatedChainsUpdated": MessageLookupByLibrary.simpleMessage(
      "Chaînes associées mises à jour",
    ),
    "proxyChainSavedAndApplied": MessageLookupByLibrary.simpleMessage(
      "Chaîne enregistrée et appliquée. Sélectionnez le nœud de sortie pour l’utiliser",
    ),
    "proxyChainSelectedNodes": MessageLookupByLibrary.simpleMessage(
      "Chaîne de proxies",
    ),
    "proxyChainUnavailableNodeTip": m87,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Formats pris en charge : ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "Une chaîne de proxies peut fortement réduire le débit. Laissez cette fonction désactivée sauf si vous en avez réellement besoin.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Chaînes de proxies"),
    "proxyConflictAutoConfig": MessageLookupByLibrary.simpleMessage(
      "Avant le démarrage, le proxy système utilisait un script de configuration automatique.",
    ),
    "proxyConflictHint": MessageLookupByLibrary.simpleMessage(
      "Si cela appartient à une autre application proxy ou à un VPN, fermez-les ; leur fonctionnement simultané peut interrompre la connexion.",
    ),
    "proxyConflictSystemProxy": m88,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "Conflit de proxy possible",
    ),
    "proxyConflictVpn": m89,
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Filtre de proxies"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Groupe de proxys"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Le groupe de proxys est vide",
    ),
    "proxyGroupMembersEmpty": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un proxy, un fournisseur ou une option d’inclusion globale",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "Le nom du groupe de proxies ne peut pas être vide",
    ),
    "proxyGroupsAfterStart": MessageLookupByLibrary.simpleMessage(
      "Les groupes s’affichent ici une fois le cœur démarré",
    ),
    "proxyGroupsCount": m90,
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS des nœuds proxy",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Résout les noms de domaine des nœuds proxy",
    ),
    "proxyNameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Politique DNS des nœuds proxy",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Nœud proxy"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("Port du proxy"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage(
      "Fournisseurs de proxys",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("Type de proxy"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Nettoyer le cache"),
    "publicKey": MessageLookupByLibrary.simpleMessage("Clé publique"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Renouvellement automatique",
    ),
    "purchaseDays": m91,
    "purchaseHours": m92,
    "purchaseMinutes": m93,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage("Prix d’achat"),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Désactivé"),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("Activé"),
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Trafic total",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Date d’achat"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("Noir pur"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Mode noir pur"),
    "qrcode": MessageLookupByLibrary.simpleMessage("Code QR"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scanner un QR code pour obtenir un profil",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Actions rapides"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Ajout rapide"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Modification rapide"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Remplissage rapide"),
    "rawOutboundInUse": m94,
    "readFullAnnouncement": MessageLookupByLibrary.simpleMessage(
      "Lire l’annonce complète",
    ),
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Adresse de réception",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Recharger"),
    "rechargeAllowedRange": m95,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Montant à recharger (¥)",
    ),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "Le montant est hors de la plage autorisée par ce moyen de paiement",
    ),
    "recommendedIcons": MessageLookupByLibrary.simpleMessage("Suggestions"),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "Les prochains renouvellements automatiques conserveront cette réduction",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Port Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Rétablir"),
    "refresh": MessageLookupByLibrary.simpleMessage("Actualiser"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "Après le paiement, tirez vers le bas pour actualiser et vérifier le résultat",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("Remboursement"),
    "regex": MessageLookupByLibrary.simpleMessage("Regex"),
    "register": MessageLookupByLibrary.simpleMessage("S’inscrire"),
    "registerClosed": MessageLookupByLibrary.simpleMessage(
      "Les inscriptions sont actuellement fermées",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de l’inscription",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Créer un compte"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "Le cœur ne prend plus en charge les groupes Relay. Choisissez un autre type.",
    ),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Libérer la mémoire"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la libération de la mémoire",
    ),
    "remaining": m96,
    "remainingStock": m97,
    "remainingTimeLabel": MessageLookupByLibrary.simpleMessage("Temps restant"),
    "remainingTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Trafic restant",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Distant"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Sauvegarder les données locales sur WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Destination distante",
    ),
    "remoteDnsResolve": MessageLookupByLibrary.simpleMessage(
      "Résolution DNS distante",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Retirer"),
    "rename": MessageLookupByLibrary.simpleMessage("Renommer"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Prix du renouvellement",
    ),
    "replace": MessageLookupByLibrary.simpleMessage("Remplacer"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Tout remplacer"),
    "request": MessageLookupByLibrary.simpleMessage("Requête"),
    "requests": MessageLookupByLibrary.simpleMessage("Requêtes"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Consulter les requêtes récentes",
    ),
    "required": MessageLookupByLibrary.simpleMessage("Obligatoire"),
    "resendCodeIn": m98,
    "reset": MessageLookupByLibrary.simpleMessage("Réinitialiser"),
    "resetDns": MessageLookupByLibrary.simpleMessage("Réinitialiser le DNS"),
    "resetDnsFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de réinitialiser le DNS. Vérifiez la connexion au noyau, puis réessayez.",
    ),
    "resetDnsSuccess": MessageLookupByLibrary.simpleMessage("État DNS effacé"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "E-mail envoyé. Collez ci-dessous le lien ou le code de réinitialisation reçu.",
    ),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "Cette page contient des modifications. Voulez-vous la réinitialiser ?",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Mot de passe réinitialisé. Connectez-vous avec le nouveau mot de passe",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser le mot de passe",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Confirmer la réinitialisation",
    ),
    "resetTokenLabel": MessageLookupByLibrary.simpleMessage(
      "Lien ou code de réinitialisation",
    ),
    "resetTokenValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez le lien ou le code de réinitialisation",
    ),
    "resourceSizeLimitTip": m99,
    "resources": MessageLookupByLibrary.simpleMessage("Ressources"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Informations sur les ressources externes",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage(
      "Respecter les règles",
    ),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Router les connexions DNS selon les règles ; nécessite un serveur DNS pour les nœuds proxy",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("Redémarrer"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment redémarrer le cœur ?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurer"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Restaurer toutes les données",
    ),
    "restoreDefault": MessageLookupByLibrary.simpleMessage(
      "Rétablir les valeurs par défaut",
    ),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Erreur de restauration",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Restaurer les données depuis un fichier",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Restaurer les données depuis WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Restaurer uniquement les fichiers de configuration",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Stratégie de restauration",
    ),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Compatible",
    ),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Remplacer",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Restauration réussie",
    ),
    "result": MessageLookupByLibrary.simpleMessage("Résultat"),
    "resumeUpdates": MessageLookupByLibrary.simpleMessage(
      "Reprendre l’actualisation",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "retryCloudSyncWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "Autoriser temporairement et synchroniser",
        ),
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "Vérifier temporairement l’API",
    ),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "La rétro-ingénierie, la décompilation, le désassemblage et l’analyse de cette application assistée par IA sont strictement interdits.",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Adresses de route"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Configurer les adresses de routage écoutées",
    ),
    "routeExcludeAddress": MessageLookupByLibrary.simpleMessage(
      "Adresses de route exclues",
    ),
    "routingApplied": MessageLookupByLibrary.simpleMessage(
      "Paramètres personnels appliqués.",
    ),
    "routingApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Les modifications sont enregistrées, mais n’ont pas pu être appliquées. Vérifiez la configuration et réessayez.",
    ),
    "routingChanged": MessageLookupByLibrary.simpleMessage(
      "Cette configuration a changé pendant la modification ou la vérification. Rouvrez l’éditeur ou vérifiez-la à nouveau.",
    ),
    "routingChecked": MessageLookupByLibrary.simpleMessage(
      "La configuration est valide. Les paramètres personnels sont enregistrés pour ce profil.",
    ),
    "routingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Enregistrez un brouillon pour corriger d’autres éléments. Les paramètres ne s’appliquent qu’après validation de toute la configuration.",
    ),
    "routingGroupType": MessageLookupByLibrary.simpleMessage("Type de groupe"),
    "routingMark": MessageLookupByLibrary.simpleMessage("Marque de routage"),
    "ru": MessageLookupByLibrary.simpleMessage("Russe"),
    "rule": MessageLookupByLibrary.simpleMessage("Règle"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Règle logique ET",
    ),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au domaine complet",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à un mot-clé de domaine",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à une regex de domaine",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à un suffixe de domaine",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Correspondance par caractères génériques ; seuls * et ? sont pris en charge",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à la marque DSCP (entrant UDP tproxy uniquement)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à la plage de ports de destination",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au code pays de l’IP",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond aux domaines de Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au nom entrant",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au port entrant",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au type entrant",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au nom d’utilisateur entrant ; séparez plusieurs noms par /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à l’ASN de l’IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Correspond à une plage d’adresses IP ; IP-CIDR6 n’est qu’un alias",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à une plage d’adresses IP",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à une plage de suffixes d’IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à toutes les requêtes, sans condition",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à TCP ou UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Règle logique NON",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage(
      "Règle logique OU",
    ),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au nom du processus ; correspond au nom du paquet sur Android",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond par regex au nom du processus ; correspond au nom du paquet sur Android",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond par caractères génériques au nom du processus ; seuls * et ? sont pris en charge",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au chemin complet du processus",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond par regex au chemin du processus",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond par caractères génériques au chemin du processus ; seuls * et ? sont pris en charge",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au nom de rematch ; séparez plusieurs noms par /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Référence un jeu de règles ; nécessite rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond au code pays de l’IP source",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à l’ASN de l’IP source",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à une plage d’adresses IP source",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à une plage de suffixes d’IP source",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à la plage de ports source",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond vers une sous-règle ; attention aux parenthèses",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Correspond à l’ID d’utilisateur Linux",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("La règle est vide"),
    "ruleListInvalid": MessageLookupByLibrary.simpleMessage(
      "Les règles doivent former une liste YAML avec une règle par élément, par exemple - DOMAIN,example.com,DIRECT",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Nom de la règle"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent en direct",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Bloquer DNS over TLS",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage("Bloquer QUIC"),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage("Bloquer STUN"),
    "rulePresetInsertHint": MessageLookupByLibrary.simpleMessage(
      "Ajouter les préréglages sélectionnés avant les règles existantes. Les règles identiques ne sont pas ajoutées à nouveau.",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage(
      "LAN en direct",
    ),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple et Microsoft en direct",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage(
      "Fournisseurs de règles",
    ),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Cible de la règle"),
    "rules": MessageLookupByLibrary.simpleMessage("Règles"),
    "rulesCount": m100,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Les règles de routage personnel s’appliquent en mode Règles.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("Durée de fonctionnement"),
    "running": MessageLookupByLibrary.simpleMessage("En cours d’exécution"),
    "runtimeConfig": MessageLookupByLibrary.simpleMessage(
      "Configuration d’exécution",
    ),
    "safeMode": MessageLookupByLibrary.simpleMessage("Mode sans échec"),
    "safeModeAppTitle": m101,
    "saturation": MessageLookupByLibrary.simpleMessage("Saturation"),
    "save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage(
      "Enregistrer et réessayer",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Enregistrer les modifications ?",
    ),
    "saveRoutingDraft": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le brouillon",
    ),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage(
      "Paiement par QR code ou virement",
    ),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Scannez avec Alipay ou WeChat pour payer",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "scriptChanged": MessageLookupByLibrary.simpleMessage(
      "Le script a été modifié ou supprimé. Rouvrez-le et réessayez.",
    ),
    "scriptChanges": MessageLookupByLibrary.simpleMessage(
      "Modifications du script",
    ),
    "scriptChangesAdded": m102,
    "scriptChangesDescription": MessageLookupByLibrary.simpleMessage(
      "Champs de premier niveau ajoutés, modifiés ou supprimés par le script. La configuration complète inclut aussi les paramètres de l’application.",
    ),
    "scriptChangesEmpty": MessageLookupByLibrary.simpleMessage(
      "Le script n’a pas modifié la configuration",
    ),
    "scriptChangesModified": m103,
    "scriptChangesRemoved": m104,
    "scriptFullConfig": MessageLookupByLibrary.simpleMessage(
      "Configuration complète",
    ),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Mode Script : utilise un script d’extension pour remplacer la configuration en une seule action",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("Options du script"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "Ce script ne propose aucun interrupteur configurable",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Rechercher"),
    "seconds": MessageLookupByLibrary.simpleMessage("secondes"),
    "secondsCount": m105,
    "secretKey": MessageLookupByLibrary.simpleMessage("Clé"),
    "sectionsInEffect": m106,
    "selectAll": MessageLookupByLibrary.simpleMessage("Tout sélectionner"),
    "selectBackup": MessageLookupByLibrary.simpleMessage(
      "Choisir une sauvegarde",
    ),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Choisir l’offre cible",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Sélectionné"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Envoyer le code"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage(
      "Envoyer l’e-mail de réinitialisation",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Serveur"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la vérification du service",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la vérification",
    ),
    "settingEntries": MessageLookupByLibrary.simpleMessage("réglages"),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "settingsCount": m107,
    "shareLinkNodesAdded": m108,
    "shareLinksNotRead": m109,
    "show": MessageLookupByLibrary.simpleMessage("Afficher"),
    "showLess": MessageLookupByLibrary.simpleMessage("Réduire"),
    "showMore": MessageLookupByLibrary.simpleMessage("Développer"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Bouton Arrêter dans la notification",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage(
      "Afficher le mot de passe",
    ),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Flouter la barre latérale",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Afficher un fond système translucide derrière la barre latérale",
    ),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Se connecter avec Google",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage(
      "Lancement silencieux",
    ),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Démarrer en arrière-plan",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("Ajout unique"),
    "singleValueTip": m110,
    "size": MessageLookupByLibrary.simpleMessage("Taille"),
    "skipCertVerify": MessageLookupByLibrary.simpleMessage(
      "Ignorer la vérification du certificat",
    ),
    "skipDomain": MessageLookupByLibrary.simpleMessage("Domaines ignorés"),
    "skipDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Un domaine détecté figurant dans la liste des domaines ignorés n’est pas utilisé.",
    ),
    "skipDstAddress": MessageLookupByLibrary.simpleMessage(
      "Adresses de destination ignorées",
    ),
    "skipSrcAddress": MessageLookupByLibrary.simpleMessage(
      "Adresses sources ignorées",
    ),
    "slide": MessageLookupByLibrary.simpleMessage("Glissement"),
    "sliders": MessageLookupByLibrary.simpleMessage("Curseurs"),
    "sniffProtocols": MessageLookupByLibrary.simpleMessage("Protocoles"),
    "sniffer": MessageLookupByLibrary.simpleMessage("Sniffer"),
    "snifferStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Le sniffer lit le domaine dans le trafic TLS, HTTP et QUIC afin que les règles puissent le reconnaître.",
    ),
    "socksPort": MessageLookupByLibrary.simpleMessage("Port SOCKS"),
    "softStyle": MessageLookupByLibrary.simpleMessage("Doux"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Épuisé"),
    "sort": MessageLookupByLibrary.simpleMessage("Trier"),
    "source": MessageLookupByLibrary.simpleMessage("Source"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("IP source"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Proxy spécial"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Règles spéciales"),
    "spectrum": MessageLookupByLibrary.simpleMessage("Spectre"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Statistiques de débit",
    ),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Autorisez l’accès à la localisation pour lire les noms Wi-Fi. Sur Android, autorisez toujours la position précise et activez la localisation du système.",
    ),
    "ssidPermissionMacosGuide": MessageLookupByLibrary.simpleMessage(
      "Autorisez la localisation pour cette application dans les Réglages Système afin de lire les noms Wi-Fi.",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("Les SSID sont vides"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Mode de pile"),
    "stackTrace": MessageLookupByLibrary.simpleMessage("Trace de pile"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Mode Standard : remplace les paramètres de base et permet d’ajouter simplement des règles",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Démarrer"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "Le profil a été importé. Voulez-vous démarrer le cœur maintenant ?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage(
      "Confirmation",
    ),
    "startFromScratch": MessageLookupByLibrary.simpleMessage("Partir de zéro"),
    "startSuccess": MessageLookupByLibrary.simpleMessage("Démarrage réussi"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Démarrage du VPN…"),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Démarrage et arrière-plan",
    ),
    "startupDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Diagnostic de démarrage",
    ),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "Le démarrage précédent n’a pas abouti. La configuration automatique et le démarrage du VPN sont suspendus pour ce lancement. Le profil et les paramètres sélectionnés sont inchangés. Vérifiez la configuration et appuyez sur Démarrer pour réessayer ; un VPN déjà actif restera connecté.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Récupération au démarrage",
    ),
    "startupTimeoutTip": MessageLookupByLibrary.simpleMessage(
      "Le démarrage a expiré. Quittez puis rouvrez l’application. Si le problème persiste, copiez le diagnostic ci-dessous.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("État"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Si DNS est désactivé, le DNS du système est utilisé.",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Arrêter"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Arrêt du VPN…"),
    "store": MessageLookupByLibrary.simpleMessage("Boutique"),
    "storeOutcomeUnknown": MessageLookupByLibrary.simpleMessage(
      "La demande a peut-être abouti. Vérifiez vos offres achetées avant de réessayer.",
    ),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Acheter, renouveler et changer d’offre",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Stratégie"),
    "strictRoute": MessageLookupByLibrary.simpleMessage("Route stricte"),
    "strictRouteDesc": MessageLookupByLibrary.simpleMessage(
      "La route stricte empêche le trafic tel que le DNS de contourner TUN et, avec IPv6 désactivé, bloque les connexions IPv6 de cet appareil.",
    ),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sous-règle"),
    "submit": MessageLookupByLibrary.simpleMessage("Valider"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Infos d’abonnement",
    ),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage(
      "Suspendre le proxy en veille",
    ),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "Arrête le transfert du trafic et les tests de disponibilité lorsque l’écran est éteint et le système inactif. Cela peut interrompre les appels et l’audio en direct, et retarder les notifications",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("Suspendu…"),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Changer de profil"),
    "sync": MessageLookupByLibrary.simpleMessage("Synchroniser"),
    "system": MessageLookupByLibrary.simpleMessage("Système"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Applications système"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Proxy système"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Associer le proxy HTTP à VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Onglet"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage(
      "Animation des onglets",
    ),
    "tailscaleAccount": MessageLookupByLibrary.simpleMessage("Compte"),
    "tailscaleAddNetwork": MessageLookupByLibrary.simpleMessage(
      "Ajouter un réseau",
    ),
    "tailscaleAdvanced": MessageLookupByLibrary.simpleMessage("Avancé"),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage(
      "Clé d’authentification",
    ),
    "tailscaleAuthKeyInvalid": MessageLookupByLibrary.simpleMessage(
      "Cela ne ressemble pas à une clé d’authentification",
    ),
    "tailscaleAuthKeySaved": MessageLookupByLibrary.simpleMessage(
      "Une clé d’authentification est enregistrée sur cet appareil. Saisissez-en une nouvelle pour la remplacer.",
    ),
    "tailscaleAutoRoute": MessageLookupByLibrary.simpleMessage(
      "Routage automatique",
    ),
    "tailscaleAutoRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Acheminer les adresses des pairs, les noms MagicDNS et les sous-réseaux approuvés via ce réseau",
    ),
    "tailscaleAvailableExitNodes": MessageLookupByLibrary.simpleMessage(
      "Nœuds de sortie disponibles",
    ),
    "tailscaleCheckSettings": m111,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("Connecté"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage(
      "Connexion en cours",
    ),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage(
      "URL de contrôle",
    ),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "L’authentification et l’identité de l’appareil restent sur cet appareil.",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage(
      "Nom de l’appareil",
    ),
    "tailscaleDevices": m112,
    "tailscaleDirect": MessageLookupByLibrary.simpleMessage("Direct"),
    "tailscaleEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un réseau, connectez-vous sur cet appareil, puis démarrez le proxy pour accéder à vos appareils.",
    ),
    "tailscaleEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Accéder à votre tailnet",
    ),
    "tailscaleEnterAuthKey": MessageLookupByLibrary.simpleMessage(
      "Saisissez la clé d’authentification pour connecter cet appareil.",
    ),
    "tailscaleEntryHint": MessageLookupByLibrary.simpleMessage(
      "Accéder aux appareils de votre tailnet",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("Nœud de sortie"),
    "tailscaleExitNodeActive": MessageLookupByLibrary.simpleMessage(
      "Nœud de sortie utilisé",
    ),
    "tailscaleExitNodeAllowLan": MessageLookupByLibrary.simpleMessage(
      "Autoriser l’accès au réseau local",
    ),
    "tailscaleExitNodeDesc": MessageLookupByLibrary.simpleMessage(
      "Laissez vide pour aucun, ou saisissez auto, le nom ou l’adresse IP d’un pair.",
    ),
    "tailscaleGuide": MessageLookupByLibrary.simpleMessage("Guide"),
    "tailscaleGuideDevices": MessageLookupByLibrary.simpleMessage(
      "Appareils et MagicDNS",
    ),
    "tailscaleGuideDevicesBody": MessageLookupByLibrary.simpleMessage(
      "Le routage automatique envoie les adresses et noms MagicDNS des pairs connus ainsi que les sous-réseaux approuvés du tailnet vers ce réseau. Le reste du trafic suit vos règles.\nIl s’applique après vos règles ajoutées et personnalisées, avant celles du profil.\nAvec un domaine de serveur de contrôle personnalisé, seuls les noms d’appareils connus sont acheminés ; les sites publics du domaine restent accessibles.\nLes adresses de sous-réseau situées dans le réseau local actuel restent locales. Pour atteindre un sous-réseau distant utilisant les mêmes adresses, ajoutez une règle vers ce réseau.\nUn nom d’hôte résolu vers un sous-réseau approuvé passe aussi par ce réseau. Si le profil transmet directement ce nom à un proxy, ajoutez une règle de domaine vers ce réseau.",
    ),
    "tailscaleGuideExitNodes": MessageLookupByLibrary.simpleMessage(
      "Nœuds de sortie",
    ),
    "tailscaleGuideExitNodesBody": MessageLookupByLibrary.simpleMessage(
      "Avec un nœud de sortie, le réseau apparaît dans les groupes de sélection du profil. Le trafic n’utilise le nœud de sortie qu’après sélection du réseau dans ces groupes ou ajout d’une règle vers lui.\nLaissez le champ vide pour ne pas utiliser de nœud de sortie. auto choisit un nœud disponible ; un nom ou une adresse d’appareil sélectionne cet appareil.",
    ),
    "tailscaleGuideGetStarted": MessageLookupByLibrary.simpleMessage(
      "Premiers pas",
    ),
    "tailscaleGuideGetStartedBody": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un réseau et choisissez « Enregistrer et se connecter ». Ouvrez la page de connexion et autorisez cet appareil ; la connexion se termine automatiquement.\nPour utiliser une clé, choisissez « Clé d’authentification » et saisissez-la. Aucun navigateur n’est nécessaire.\nLe réseau ne transporte du trafic que lorsque le proxy fonctionne. La connexion au compte seule n’achemine aucun trafic.",
    ),
    "tailscaleGuideSignIn": MessageLookupByLibrary.simpleMessage(
      "Connexion et sauvegarde",
    ),
    "tailscaleGuideSignInBody": MessageLookupByLibrary.simpleMessage(
      "Les paramètres réseau sont inclus dans les sauvegardes. Les clés d’authentification et l’identité restent sur cet appareil ; reconnectez-vous après restauration sur un autre appareil.\nÀ l’expiration de la clé du nœud, choisissez à nouveau « Enregistrer et se connecter ». L’approbation des appareils et les accès sont gérés dans votre tailnet.\nSupprimer un réseau déconnecte cet appareil et efface son identité de cet appareil.",
    ),
    "tailscaleGuideTroubleshooting": MessageLookupByLibrary.simpleMessage(
      "Dépannage",
    ),
    "tailscaleGuideTroubleshootingBody": MessageLookupByLibrary.simpleMessage(
      "Vérifiez que le proxy fonctionne, que cet appareil est approuvé et que le pair est en ligne. Pour les sous-réseaux ou Internet, vérifiez aussi l’approbation des routes et le nœud de sortie.\n« Non appliqué » signifie que la configuration active ne contient pas ce réseau : sélectionnez un profil et vérifiez qu’aucun nœud ne porte le même nom.\nCette application établit uniquement des connexions sortantes vers le tailnet. Elle n’accepte aucune connexion entrante et ne propose jamais cet appareil comme routeur de sous-réseau ou nœud de sortie.",
    ),
    "tailscaleHostnameInvalid": MessageLookupByLibrary.simpleMessage(
      "Utilisez des minuscules, chiffres et traits d’union, jusqu’à 63 caractères",
    ),
    "tailscaleInteractiveLogin": MessageLookupByLibrary.simpleMessage(
      "Interactif",
    ),
    "tailscaleKeyExpired": MessageLookupByLibrary.simpleMessage(
      "La clé du nœud a expiré",
    ),
    "tailscaleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la connexion à Tailscale",
    ),
    "tailscaleLoginFooter": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous une fois par réseau sur cet appareil.",
    ),
    "tailscaleLoginHint": MessageLookupByLibrary.simpleMessage(
      "La connexion autorise cet appareil. Démarrez le proxy pour utiliser le réseau.",
    ),
    "tailscaleLoginMethod": MessageLookupByLibrary.simpleMessage(
      "Méthode de connexion",
    ),
    "tailscaleLoginTimeout": MessageLookupByLibrary.simpleMessage(
      "La connexion n’a pas été terminée en cinq minutes. Réessayez.",
    ),
    "tailscaleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Ouvrez la page de connexion ou scannez le code. La connexion se termine automatiquement après autorisation.",
    ),
    "tailscaleLogout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "tailscaleNameInUse": MessageLookupByLibrary.simpleMessage(
      "Ce nom est déjà utilisé",
    ),
    "tailscaleNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Utilisez au plus 64 caractères, sans virgule",
    ),
    "tailscaleNeedsApproval": MessageLookupByLibrary.simpleMessage(
      "Appareil en attente d’approbation",
    ),
    "tailscaleNeedsLogin": MessageLookupByLibrary.simpleMessage(
      "Connexion requise",
    ),
    "tailscaleNetworkInUse": m113,
    "tailscaleNetworkName": MessageLookupByLibrary.simpleMessage(
      "Nom du réseau",
    ),
    "tailscaleNetworks": MessageLookupByLibrary.simpleMessage("Réseaux"),
    "tailscaleNotApplied": MessageLookupByLibrary.simpleMessage("Non appliqué"),
    "tailscaleNotAppliedHint": MessageLookupByLibrary.simpleMessage(
      "Le réseau n’est pas dans la configuration active. Sélectionnez un profil et vérifiez qu’aucun de ses nœuds ne porte le même nom.",
    ),
    "tailscaleNotSignedIn": MessageLookupByLibrary.simpleMessage(
      "Non authentifié",
    ),
    "tailscaleOffline": MessageLookupByLibrary.simpleMessage("Hors ligne"),
    "tailscaleOnline": MessageLookupByLibrary.simpleMessage("En ligne"),
    "tailscaleOpenLoginPage": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la page de connexion",
    ),
    "tailscaleRelay": m114,
    "tailscaleRemoveConfirm": m115,
    "tailscaleRemoveNetwork": MessageLookupByLibrary.simpleMessage(
      "Supprimer le réseau",
    ),
    "tailscaleSaveAndLogin": MessageLookupByLibrary.simpleMessage(
      "Enregistrer et se connecter",
    ),
    "tailscaleSignedIn": MessageLookupByLibrary.simpleMessage("Authentifié"),
    "tailscaleSigningIn": MessageLookupByLibrary.simpleMessage(
      "Connexion en cours",
    ),
    "tailscaleStatus": MessageLookupByLibrary.simpleMessage("État"),
    "tailscaleStopped": MessageLookupByLibrary.simpleMessage("Arrêté"),
    "tailscaleThisDevice": MessageLookupByLibrary.simpleMessage("Cet appareil"),
    "tailscaleUnavailable": MessageLookupByLibrary.simpleMessage(
      "Connexion indisponible",
    ),
    "tapIconToRetry": MessageLookupByLibrary.simpleMessage(
      "Appuyez sur l’icône pour réessayer",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Appuyez pour autoriser",
    ),
    "target": MessageLookupByLibrary.simpleMessage("Cible"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP simultané"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Autoriser les connexions TCP simultanées",
    ),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "Accélérer l’établissement des connexions TCP",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage("Intervalle de test"),
    "testUrl": MessageLookupByLibrary.simpleMessage("URL de test"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage(
      "Tester à l’utilisation",
    ),
    "textScale": MessageLookupByLibrary.simpleMessage("Taille du texte"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Le texte de l’app ressemblera à ceci",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Thème"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Couleur du thème"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Configurer le mode sombre et les couleurs",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Mode du thème"),
    "tight": MessageLookupByLibrary.simpleMessage("Serrée"),
    "time": MessageLookupByLibrary.simpleMessage("Heure"),
    "timeout": MessageLookupByLibrary.simpleMessage("Expiré"),
    "tintedStyle": MessageLookupByLibrary.simpleMessage("Teinté"),
    "tip": MessageLookupByLibrary.simpleMessage("Astuce"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Utilisation du jour"),
    "toggle": MessageLookupByLibrary.simpleMessage("Basculer"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage(
      "Activer/Désactiver la lampe",
    ),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Jeton d’accès"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Saisissez le jeton d’accès",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Tolérance"),
    "tools": MessageLookupByLibrary.simpleMessage("Outils"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalDownload": MessageLookupByLibrary.simpleMessage("Reçu"),
    "totalUpload": MessageLookupByLibrary.simpleMessage("Envoyé"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Port TProxy"),
    "traffic": MessageLookupByLibrary.simpleMessage("Trafic"),
    "trafficPeak": m116,
    "trafficTotal": m117,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Trafic utilisé"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "Le virement sera confirmé automatiquement et l’offre choisie sera activée.",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("Transport"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAdminAccountRequired": MessageLookupByLibrary.simpleMessage(
      "TUN nécessite un compte administrateur sur ce Mac. Connectez-vous avec un tel compte pour l’activer.",
    ),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible d’activer TUN : l’autorisation administrateur a été refusée. Acceptez la demande d’autorisation système, puis réessayez.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "TUN ne fonctionne qu’en mode administrateur.",
    ),
    "tunHelperInstallFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible d’activer TUN : l’installation ou le démarrage du service auxiliaire a échoué. Vérifiez que l’application est correctement installée et que le service système fonctionne, puis réessayez.",
    ),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "Par défaut : 9000 ; alternatives : 1480 ou 4064. Redémarrez le VPN Android pour appliquer",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "Saisissez un entier entre 1280 et 65535",
    ),
    "tunOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Les entrées ajoutées ici remplacent les réglages TUN de tous les profils ; tout ce qui n’est pas ajouté garde le réglage du profil. Les entrées qu’un profil personnalisé ajoute lui-même priment.",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Désactiver"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Activer"),
    "udpRelayMode": MessageLookupByLibrary.simpleMessage("Mode de relais UDP"),
    "udpTimeout": MessageLookupByLibrary.simpleMessage("Délai UDP"),
    "udpTimeoutDesc": MessageLookupByLibrary.simpleMessage(
      "Le délai UDP est en secondes et ne fonctionne qu’avec les piles gvisor, system et mixed.",
    ),
    "ultra": MessageLookupByLibrary.simpleMessage("Ultra"),
    "undo": MessageLookupByLibrary.simpleMessage("Annuler"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Délai unifié"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Exclure les délais supplémentaires, notamment la négociation",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Inconnu"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Erreur réseau inconnue",
    ),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Restaurer"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Sans nom"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage(
      "Désépingler la fenêtre",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Mettre à jour"),
    "updateAppImageTip": MessageLookupByLibrary.simpleMessage(
      "Une AppImage ne peut pas s’installer automatiquement. Remplacez le programme actuel par le fichier téléchargé ; son dossier a été ouvert.",
    ),
    "updateApplyFailed": MessageLookupByLibrary.simpleMessage(
      "La mise à jour automatique n’a pas abouti. Réessayez ou utilisez la page de téléchargement.",
    ),
    "updateBuildNumber": m118,
    "updateCancelDownload": MessageLookupByLibrary.simpleMessage(
      "Annuler le téléchargement",
    ),
    "updateDownloadBackground": MessageLookupByLibrary.simpleMessage(
      "Télécharger en arrière-plan",
    ),
    "updateDownloadBrowser": MessageLookupByLibrary.simpleMessage(
      "Télécharger dans le navigateur",
    ),
    "updateDownloadConfirm": MessageLookupByLibrary.simpleMessage(
      "Télécharger la mise à jour",
    ),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Échec du téléchargement de la mise à jour",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage(
      "Téléchargement de la mise à jour",
    ),
    "updateInstall": MessageLookupByLibrary.simpleMessage(
      "Installer la mise à jour",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Plus tard"),
    "updateNotice": MessageLookupByLibrary.simpleMessage(
      "Nouvelle version détectée",
    ),
    "updatePackageFormat": MessageLookupByLibrary.simpleMessage(
      "Choisir le format du paquet",
    ),
    "updatePackageFormatTip": MessageLookupByLibrary.simpleMessage(
      "La méthode d’installation de cette version n’a pas pu être déterminée. Choisissez le format correspondant.",
    ),
    "updatePackageManagerTip": MessageLookupByLibrary.simpleMessage(
      "Cette version a été installée par un gestionnaire de paquets ; mettez-la à jour de la même façon.",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage(
      "Mise à jour prête à installer",
    ),
    "updateReadyHint": MessageLookupByLibrary.simpleMessage(
      "La mise à jour est téléchargée. Installez-la quand vous le souhaitez.",
    ),
    "updateReleaseNotes": MessageLookupByLibrary.simpleMessage(
      "Notes de version",
    ),
    "updateReleaseNotesFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les notes de version. Réessayez.",
    ),
    "updateRestart": MessageLookupByLibrary.simpleMessage(
      "Mettre à jour et redémarrer",
    ),
    "updateRestartHint": MessageLookupByLibrary.simpleMessage(
      "L’application va se fermer, se mettre à jour sur place et se rouvrir. Vos paramètres seront conservés.",
    ),
    "updateVersionNumber": m119,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Changer d’offre"),
    "upload": MessageLookupByLibrary.simpleMessage("Envoi"),
    "uploadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Bande passante d’envoi",
    ),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtenir un profil depuis une URL",
    ),
    "urlTip": m120,
    "useHosts": MessageLookupByLibrary.simpleMessage("Utiliser hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Utiliser les hosts du système",
    ),
    "usedShort": MessageLookupByLibrary.simpleMessage("utilisé"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage("Trafic utilisé"),
    "userCenter": MessageLookupByLibrary.simpleMessage("Espace utilisateur"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "Espace utilisateur (secours)",
    ),
    "userGuide": MessageLookupByLibrary.simpleMessage("Guide d’utilisation"),
    "username": MessageLookupByLibrary.simpleMessage("Nom d’utilisateur"),
    "value": MessageLookupByLibrary.simpleMessage("Valeur"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("Vérifier"),
    "view": MessageLookupByLibrary.simpleMessage("Afficher"),
    "virtualIpv4": MessageLookupByLibrary.simpleMessage("IPv4 virtuelle"),
    "vividStyle": MessageLookupByLibrary.simpleMessage("Vif"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Modification de la configuration VPN détectée",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Le VPN fait passer automatiquement tout le trafic du système par VpnService.",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Les modifications prennent effet après le redémarrage du VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Configuration WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Mode liste blanche"),
    "writeToSystem": MessageLookupByLibrary.simpleMessage(
      "Écrire dans le système",
    ),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "Écrire dans le système règle aussi l’horloge système ; Android l’ignore.",
    ),
    "yearsAgo": m121,
    "yearsAgoShort": m122,
    "yes": MessageLookupByLibrary.simpleMessage("Oui"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Chinois simplifié"),
  };
}
