import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: child,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        side: BorderSide(
          width: 0,
        ),
      ),
      side: const BorderSide(
        width: 0,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
