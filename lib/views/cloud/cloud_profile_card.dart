import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CloudProfileCard extends ConsumerStatefulWidget {
  final CloudProfile profile;

  const CloudProfileCard({super.key, required this.profile});

  @override
  ConsumerState<CloudProfileCard> createState() => _CloudProfileCardState();
}

class _CloudProfileCardState extends ConsumerState<CloudProfileCard> {
  CloudParams _params = const CloudParams();
  bool _paramsLoaded = false;
  int _paramsGeneration = 0;
  bool? _pageActive;

  @override
  void initState() {
    super.initState();
    _loadParams();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final active = PageActivityScope.isActiveOf(context);
    if (active && _pageActive == false) _loadParams();
    _pageActive = active;
  }

  @override
  void didUpdateWidget(CloudProfileCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_tierOf(oldWidget.profile) != _tierOf(widget.profile)) _loadParams();
  }

  static SubscriptionTier _tierOf(CloudProfile profile) {
    return SubscriptionTier.fromServer(
      profile.subscription,
      planCode: profile.planCode,
      planRank: profile.planRank,
      nodeAccess: profile.nodeAccess,
    );
  }

  Future<void> _loadParams() async {
    final generation = _paramsGeneration;
    final loaded = await CloudParamsStorage.load();
    if (!mounted || generation != _paramsGeneration) return;
    setState(() {
      _params = loaded;
      _paramsLoaded = true;
    });
  }

  Future<void> _commit(CloudParams Function(CloudParams current) change) async {
    final commonAction = context.commonAction;
    final profileAction = context.profileAction;
    final setupAction = context.setupAction;
    final clashProfile = ref
        .read(profilesProvider)
        .where((p) => p.isoixCloudProfile)
        .firstOrNull;
    final generation = ++_paramsGeneration;

    setState(() => _params = change(_params));
    // The profile editor and tier reconciliation also write these params.
    final next = change(await CloudParamsStorage.load());
    await CloudParamsStorage.save(next);
    if (mounted && generation == _paramsGeneration) {
      setState(() => _params = next);
    }

    if (clashProfile != null) {
      final updatedProfile = await commonAction.safeRun(
        () => profileAction.updateProfile(
          clashProfile,
          showLoading: true,
          applyIfCurrent: false,
        ),
        title: AppLocalizations.current.update,
      );
      if (updatedProfile != null) {
        setupAction.applyProfileDebounce(silence: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final tier = _tierOf(profile);
    final clashProfile = ref
        .watch(profilesProvider)
        .where((p) => p.isoixCloudProfile)
        .firstOrNull;
    final isOverseas = _params.level == NetworkLevel.overseas;
    final isEmergency = _params.level == NetworkLevel.emergency;

    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => launchUrl(
                    Uri.parse('https://${Secrets.primarySiteDomain}/user'),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.account_circle,
                      color: context.colorScheme.onPrimaryContainer,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.subscription,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.current.expireDate(
                          profile.expireTime.toString(),
                        ),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfo(
              context,
              Icons.today,
              AppLocalizations.current.todayUsed,
              profile.todayUsed,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: profile.usageProgress),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(profile.totalUsed),
                Text(AppLocalizations.current.remaining(profile.remaining)),
              ],
            ),
            const Divider(height: 32),
            _buildInfo(
              context,
              Icons.account_balance_wallet,
              AppLocalizations.current.balance,
              profile.balance,
            ),
            const SizedBox(height: 12),
            _buildInfo(
              context,
              Icons.monetization_on,
              AppLocalizations.current.commission,
              profile.commission,
            ),
            const SizedBox(height: 12),
            _buildInfo(
              context,
              Icons.stars,
              AppLocalizations.current.points,
              profile.points,
            ),
            if (clashProfile != null && _paramsLoaded) ...[
              // These options are one choice each way, so a single rule
              // closes the account figures and none divides the block.
              const Divider(height: 16),
              if (tier != SubscriptionTier.none)
                ListItem.switchItem(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  title: Text(AppLocalizations.current.allNodes),
                  subtitle: Text(
                    AppLocalizations.current.allNodesDesc,
                    style: const TextStyle(fontSize: 12),
                  ),
                  delegate: SwitchDelegate<bool>(
                    value: _params.isAllNodes,
                    onChanged: (val) => _commit(
                      val
                          ? (p) => p.applyingAllNodes()
                          : (p) => p.applyingTierDefaults(tier.defaultParams),
                    ),
                  ),
                ),
              ListItem.switchItem(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                title: Text(
                  AppLocalizations.current.overseasNetworkEnvironment,
                ),
                subtitle: Text(
                  AppLocalizations.current.overseasNetworkEnvironmentDesc,
                  style: const TextStyle(fontSize: 12),
                ),
                delegate: SwitchDelegate<bool>(
                  value: isOverseas,
                  onChanged: (val) => _commit(
                    val
                        ? (p) => p.copyWith(level: NetworkLevel.overseas)
                        : (p) => p.applyingTierDefaults(tier.defaultParams),
                  ),
                ),
              ),
              if (tier.canSelectEmergency)
                ListItem.switchItem(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  title: Text(AppLocalizations.current.emergencyMode),
                  subtitle: Text(
                    AppLocalizations.current.emergencyModeDesc,
                    style: const TextStyle(fontSize: 12),
                  ),
                  delegate: SwitchDelegate<bool>(
                    value: isEmergency,
                    onChanged: (val) => _commit(
                      val
                          ? (p) => p.copyWith(level: NetworkLevel.emergency)
                          : (p) => p.applyingTierDefaults(tier.defaultParams),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.colorScheme.primary),
        const SizedBox(width: 12),
        Text(label, style: context.textTheme.bodyMedium),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
