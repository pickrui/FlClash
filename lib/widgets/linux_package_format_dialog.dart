import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:material_ui/material_ui.dart';

/// Asked once, when neither the AppImage runtime nor a package manager can say
/// how this build was installed. The answer is remembered.
class LinuxPackageFormatDialog extends StatelessWidget {
  const LinuxPackageFormatDialog({super.key, required this.formats});

  final List<LinuxPackageFormat> formats;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return CommonDialog(
      title: localizations.updatePackageFormat,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations.cancel),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(localizations.updatePackageFormatTip),
          const SizedBox(height: 8),
          for (final format in formats)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(format.extension),
              onTap: () => Navigator.of(context).pop(format),
            ),
        ],
      ),
    );
  }
}
