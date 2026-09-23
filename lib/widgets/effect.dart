import 'dart:ui';

import 'package:fl_clash/widgets/inherited.dart';
import 'package:material_ui/material_ui.dart';

class EffectGestureDetector extends StatefulWidget {
  final Widget child;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onTap;

  const EffectGestureDetector({
    super.key,
    required this.child,
    this.onLongPress,
    this.onTap,
  });

  @override
  State<EffectGestureDetector> createState() => _EffectGestureDetectorState();
}

class _EffectGestureDetectorState extends State<EffectGestureDetector> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        onLongPressStart: (_) {
          setState(() {
            _scale = 0.95;
          });
        },
        onTap: widget.onTap,
        onLongPressEnd: (_) {
          setState(() {
            _scale = 1;
          });
        },
        child: widget.child,
      ),
    );
  }
}

class CommonExpandIcon extends StatefulWidget {
  final bool expand;

  const CommonExpandIcon({super.key, this.expand = false});

  @override
  State<CommonExpandIcon> createState() => _CommonExpandIconState();
}

class _CommonExpandIconState extends State<CommonExpandIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween = Tween<double>(
    begin: 0.0,
    end: 0.5,
  ).chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: widget.expand ? 1.0 : 0.0,
    );
    _iconTurns = _animationController.drive(_iconTurnTween);
  }

  @override
  void didUpdateWidget(covariant CommonExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expand != widget.expand) {
      if (widget.expand) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _iconTurns,
      child: const Icon(Icons.expand_more),
    );
  }
}

Widget commonProxyDecorator(
  Widget child,
  int index,
  Animation<double> animation,
) {
  return ProxyDecoratorProvider(
    isProxyDecorator: true,
    child: AnimatedBuilder(
      animation: animation,
      builder: (_, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(scale: scale, child: child);
      },
      child: child,
    ),
  );
}
