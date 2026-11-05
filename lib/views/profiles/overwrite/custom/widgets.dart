import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InfoMessageButton extends StatelessWidget {
  final String message;

  const InfoMessageButton({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return CommonMinIconButtonTheme(
      child: IconButton(
        onPressed: () {
          globalState.showMessage(message: TextSpan(text: message));
        },
        icon: Icon(Icons.info, size: 20.ap, color: context.colorScheme.error),
      ),
    );
  }
}
