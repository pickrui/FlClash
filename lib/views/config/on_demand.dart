import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wifi_ssid/wifi_ssid.dart';

class OnDemandView extends ConsumerStatefulWidget {
  const OnDemandView({super.key});

  @override
  ConsumerState createState() => _OnDemandViewState();
}

class _OnDemandViewState extends ConsumerState<OnDemandView> {
  void _handleRequestLocationPermission() {
    final permission = ref.read(locationPermissionsProvider);
    if (permission == WifiSsidPermission.granted) {
      if (system.isAndroid) {
        app?.openAppSettings();
      }
      return;
    }
    if (permission == WifiSsidPermission.permanentlyDenied) {
      if (system.isMacOS) {
        final macAppLocalizations = context.appLocalizations;
        globalState.showMessage(
          title: macAppLocalizations.locationPermissionRequired,
          cancelable: false,
          message: TextSpan(
            style: context.textTheme.bodyMedium,
            text: macAppLocalizations.locationPermissionGuide(appName),
          ),
        );
      }
      if (system.isAndroid) {
        app?.openAppSettings();
      }
      return;
    }
  }

  void _handleOpenBatteryOptimizationSettings() {
    app?.openBatteryOptimizationSettings();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final batteryOptimizationDisable = ref.watch(
      batteryOptimizationDisableProvider,
    );
    final locationPermissions = ref.watch(locationPermissionsProvider);
    return CommonScaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: generateSectionV3(
                title: appLocalizations.prerequisites,
                items: [
                  if (system.isAndroid)
                    DecorationListItem(
                      onPressed: _handleOpenBatteryOptimizationSettings,
                      minVerticalPadding: 8,
                      title: Text(appLocalizations.ignoreBatteryOptimization),
                      subtitle: Text(appLocalizations.batteryOptimizationDesc),
                      trailing: Switch(
                        value: batteryOptimizationDisable,
                        onChanged: (_) {
                          _handleOpenBatteryOptimizationSettings();
                        },
                      ),
                    ),
                  if (system.isAndroid || system.isMacOS)
                    DecorationListItem(
                      onPressed: _handleRequestLocationPermission,
                      minVerticalPadding: 8,
                      title: Text(appLocalizations.locationPermission),
                      subtitle: Text(appLocalizations.locationPermissionDesc),
                      trailing: Switch(
                        value:
                            locationPermissions == WifiSsidPermission.granted,
                        onChanged: (_) {
                          _handleRequestLocationPermission();
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: ListHeader(
                title: appLocalizations.excludeSsids,
                subTitle: appLocalizations.excludeSsidsDesc,
                actions: [
                  CommonMinFilledButtonTheme(
                    child: FilledButton.tonal(
                      onPressed: () {},
                      child: Text(appLocalizations.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(top: 12),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 48,
                ),
                // type: CommonCardType.filled,
                child: NullStatus(label: appLocalizations.ssidsEmpty),
              ),
            ),
          ),
        ],
      ),
      title: appLocalizations.onDemand,
    );
  }
}
