import 'package:fl_clash/common/common.dart';
import 'package:material_ui/material_ui.dart';

const _contentMaxWidth = 720.0;

/// Keeps the account page and the store readable in a wide desktop window.
class CloudContentWidth extends StatelessWidget {
  final Widget child;

  const CloudContentWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
        child: child,
      ),
    );
  }
}

class CloudIconTile extends StatelessWidget {
  final IconData icon;
  final double size;

  const CloudIconTile({super.key, required this.icon, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: context.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
