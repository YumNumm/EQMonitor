import 'package:flutter/material.dart';

class ViolationWidget extends StatelessWidget {
  const ViolationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return ColoredBox(color: color, child: const SizedBox());
  }
}
