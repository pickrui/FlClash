import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/manager/status_manager.dart';
import 'package:fl_clash/models/state.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:material_ui/material_ui.dart';

extension BuildContextExtension on BuildContext {
  bool get disableAnimations => MediaQuery.disableAnimationsOf(this);
  Duration motionDuration(Duration duration) =>
      MediaQuery.disableAnimationsOf(this) ? Duration.zero : duration;

  CommonScaffoldState? get commonScaffoldState {
    return findAncestorStateOfType<CommonScaffoldState>();
  }

  void showNotifier(String text, {MessageActionState? actionState}) {
    return findAncestorStateOfType<StatusManagerState>()?.message(
      text,
      actionState: actionState,
    );
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations get appLocalizations => AppLocalizations.of(this);
}
