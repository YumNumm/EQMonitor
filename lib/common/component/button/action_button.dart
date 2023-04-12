import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onPressed,
    required this.isEnabled,
    required this.child,
    super.key,
  });

  final void Function() onPressed;
  final bool isEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final enabledWidget = DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color.fromARGB(255, 22, 125, 225),
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: child,
    );
    final disabledWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white.withOpacity(0.75),
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: child,
    );
    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 150,
      ),
      child: isEnabled ? enabledWidget : disabledWidget,
    );
  }
}
