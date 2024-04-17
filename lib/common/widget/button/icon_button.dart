import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget child;

  const CommonIconButton({
    required this.child,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: child,
      highlightColor: Colors.transparent,
    );
  }
}
