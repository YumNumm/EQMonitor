import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    required this.child,
    this.backgroundColor,
    super.key,
  });
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: child,
      backgroundColor: backgroundColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        side: BorderSide(
          width: 0,
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.zero,
    );
  }
}
