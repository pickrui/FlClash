import 'dart:io';

import 'package:fl_clash/core/desktop/launch_policy.dart';
import 'package:fl_clash/l10n/l10n.dart';

String? coreLaunchBlockedMessage(
  Object error,
  AppLocalizations? localizations,
) {
  if (!Platform.isWindows || !isPolicyBlockedLaunch(error)) return null;
  return (localizations ?? AppLocalizations()).coreBlockedByPolicyTip(
    launchOsError(error)!,
  );
}
