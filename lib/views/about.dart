import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  Future<void> _checkUpdate(BuildContext context) async {
    final commonScaffoldState = context.commonScaffoldState;
    if (commonScaffoldState?.mounted != true) return;
    final data = await globalState.appController.safeRun<Map<String, dynamic>?>(
      request.checkForUpdate,
      title: appLocalizations.checkUpdate,
      needLoading: true,
    );
    globalState.appController.checkUpdateResultHandle(
      data: data,
      handleError: true,
    );
  }

  List<Widget> _buildMoreSection(BuildContext context) {
    return generateSection(
      separated: false,
      title: appLocalizations.more,
      items: [
        ListItem(
          title: Text(appLocalizations.checkUpdate),
          onTap: () {
            _checkUpdate(context);
          },
        ),
        ListItem(
          title: const Text('Dler Cloud'),
          onTap: () {
            globalState.openUrl('https://dlercloud.com');
          },
          trailing: const Icon(Icons.launch),
        ),
        ListItem(
          title: const Text('Dler Cloud (备用地址)'),
          onTap: () {
            globalState.openUrl('https://dler.pro');
          },
          trailing: const Icon(Icons.launch),
        ),
        ListItem(
          title: Text(appLocalizations.project),
          onTap: () {
            globalState.openUrl('https://github.com/$repository');
          },
          trailing: const Icon(Icons.launch),
        ),
        ListItem(
          title: Text(appLocalizations.core),
          onTap: () {
            globalState.openUrl(
              'https://github.com/chen08209/Clash.Meta/tree/FlClash',
            );
          },
          trailing: const Icon(Icons.launch),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, ref, _) {
                return _DeveloperModeDetector(
                  child: Wrap(
                    spacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/images/icon.png',
                          width: 64,
                          height: 64,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appName,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            globalState.packageInfo.fullVersion,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                  onEnterDeveloperMode: () {
                    ref
                        .read(appSettingProvider.notifier)
                        .updateState(
                          (state) => state.copyWith(developerMode: true),
                        );
                    context.showNotifier(
                      appLocalizations.developerModeEnableTip,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      ..._buildMoreSection(context),
    ];
    return Padding(
      padding: kMaterialListPadding.copyWith(top: 16, bottom: 16),
      child: generateListView(items),
    );
  }
}

class _DeveloperModeDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onEnterDeveloperMode;

  const _DeveloperModeDetector({
    required this.child,
    required this.onEnterDeveloperMode,
  });

  @override
  State<_DeveloperModeDetector> createState() => _DeveloperModeDetectorState();
}

class _DeveloperModeDetectorState extends State<_DeveloperModeDetector> {
  int _counter = 0;
  Timer? _timer;

  void _handleTap() {
    _counter++;
    if (_counter >= 5) {
      widget.onEnterDeveloperMode();
      _resetCounter();
    } else {
      _timer?.cancel();
      _timer = Timer(Duration(seconds: 1), _resetCounter);
    }
  }

  void _resetCounter() {
    _counter = 0;
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _handleTap, child: widget.child);
  }
}
