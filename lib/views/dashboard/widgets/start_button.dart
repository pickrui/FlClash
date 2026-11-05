import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartButton extends ConsumerStatefulWidget {
  final Future<void> Function(bool isStart)? statusUpdater;

  const StartButton({super.key, this.statusUpdater});

  @override
  ConsumerState<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends ConsumerState<StartButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  bool isStart = false;
  int _toggleGeneration = 0;

  @override
  void initState() {
    super.initState();
    isStart = ref.read(isStartProvider);
    _controller = AnimationController(
      vsync: this,
      value: isStart ? 1 : 0,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutBack,
    );
    ref.listenManual(isStartProvider, (prev, next) {
      if (next != isStart) {
        isStart = next;
        updateController();
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  void handleSwitchStart() {
    isStart = !isStart;
    final requestedStart = isStart;
    final generation = ++_toggleGeneration;
    updateController();
    debouncer.call(FunctionTag.updateStatus, () async {
      if (!mounted) return;
      try {
        final statusUpdater = widget.statusUpdater;
        if (statusUpdater != null) {
          await statusUpdater(requestedStart);
        } else {
          await appController.updateStatus(
            requestedStart,
            isInit: !ref.read(initProvider),
          );
        }
      } finally {
        if (mounted && generation == _toggleGeneration) {
          setState(() => isStart = ref.read(isStartProvider));
          updateController();
        }
      }
    }, duration: commonDuration);
  }

  void updateController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isStart && mounted) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = ref.watch(
      profilesProvider.select((state) => state.isNotEmpty),
    );
    if (!hasProfile) {
      return FloatingActionButton(
        heroTag: null,
        onPressed: () {
          globalState.showNotifier(appLocalizations.nullProfileDesc);
          appController.toProfiles();
        },
        child: const Icon(Icons.add),
      );
    }
    final textWidth =
        globalState.measure
            .computeTextSize(
              Text(
                utils.getTimeText(null),
                style: context.textTheme.titleMedium?.toSoftBold,
              ),
            )
            .width +
        16;
    return Theme(
      data: Theme.of(context).copyWith(
        floatingActionButtonTheme: Theme.of(context).floatingActionButtonTheme
            .copyWith(
              sizeConstraints: const BoxConstraints(
                minWidth: 56,
                maxWidth: 200,
              ),
            ),
      ),
      child: AnimatedBuilder(
        animation: _controller!.view,
        builder: (_, child) {
          return FloatingActionButton(
            clipBehavior: Clip.antiAlias,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            heroTag: null,
            onPressed: () {
              handleSwitchStart();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  alignment: Alignment.center,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animation,
                  ),
                ),
                SizedBox(width: textWidth * _animation.value, child: child!),
              ],
            ),
          );
        },
        child: Consumer(
          builder: (_, ref, _) {
            final runTime = ref.watch(runTimeProvider);
            final text = utils.getTimeText(runTime);
            return Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: Theme.of(context).textTheme.titleMedium?.toSoftBold
                  .copyWith(color: context.colorScheme.onPrimaryContainer),
            );
          },
        ),
      ),
    );
  }
}
