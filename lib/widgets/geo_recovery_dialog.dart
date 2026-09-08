import 'package:fl_clash/common/geo_recovery.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:flutter/material.dart';

class GeoRecoveryDialog extends StatefulWidget {
  final GeoResource resource;
  final String url;
  final String error;
  final Future<String?> Function(String url) download;
  final bool Function()? shouldContinue;

  const GeoRecoveryDialog({
    super.key,
    required this.resource,
    required this.url,
    required this.error,
    required this.download,
    this.shouldContinue,
  });

  @override
  State<GeoRecoveryDialog> createState() => _GeoRecoveryDialogState();
}

class _GeoRecoveryDialogState extends State<GeoRecoveryDialog> {
  final _form = GlobalKey<FormState>();
  late final _url = TextEditingController(text: widget.url);
  late String _error = widget.error;
  bool _downloading = false;
  bool _dismissed = false;

  void _close(bool result) {
    if (!mounted || _dismissed) return;
    final route = ModalRoute.of<bool>(context);
    final navigator = route?.navigator;
    if (route == null || !route.isActive || navigator == null) return;
    _dismissed = true;
    if (route.isCurrent) {
      navigator.pop(result);
    } else {
      navigator.removeRoute(route, result);
    }
  }

  Future<void> _download() async {
    if (_downloading || _dismissed) return;
    if (widget.shouldContinue?.call() == false) {
      _close(false);
      return;
    }
    if (!_form.currentState!.validate()) return;

    final fallbackError = AppLocalizations.of(context).geoDownloadFailed;
    setState(() => _downloading = true);
    String? error;
    try {
      error = await widget.download(_url.text.trim());
    } catch (_) {
      error = fallbackError;
    }
    if (!mounted || _dismissed) return;
    if (widget.shouldContinue?.call() == false) {
      _close(false);
      return;
    }
    if (error == null || error.isEmpty) {
      _close(true);
      return;
    }
    setState(() {
      _downloading = false;
      _error = error!;
    });
  }

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final file = geoReleaseFileName(widget.resource);
    return PopScope<bool>(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _dismissed = true;
      },
      child: CommonDialog(
        title: l.geoDownloadFailed,
        actions: [
          TextButton(onPressed: () => _close(false), child: Text(l.cancel)),
          FilledButton(
            onPressed: _downloading ? null : _download,
            child: Text(l.download),
          ),
        ],
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.geoDownloadRecoveryHint),
              const SizedBox(height: 12),
              Text(widget.resource.name),
              const SizedBox(height: 8),
              Text(_error, maxLines: 5, overflow: TextOverflow.ellipsis),
              if (_downloading) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(semanticsLabel: l.loading),
              ],
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ActionChip(
                    label: Text(l.geoOriginalSource),
                    onPressed: _downloading
                        ? null
                        : () => _url.text = widget.url,
                  ),
                  ActionChip(
                    label: const Text('GitHub'),
                    onPressed: _downloading
                        ? null
                        : () => _url.text =
                              'https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/$file',
                  ),
                  ActionChip(
                    label: Text(l.geoBackupSource),
                    onPressed: _downloading
                        ? null
                        : () => _url.text =
                              'https://cdn.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/$file',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _url,
                enabled: !_downloading,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: l.geoDownloadUrl,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  final uri = Uri.tryParse(value?.trim() ?? '');
                  return uri != null &&
                          uri.host.isNotEmpty &&
                          (uri.scheme == 'https' || uri.scheme == 'http')
                      ? null
                      : l.geoInvalidDownloadUrl;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
