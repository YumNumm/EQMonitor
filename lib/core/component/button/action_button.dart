import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onPressed,
    required this.isEnabled,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });
  factory ActionButton.enabled({
    required void Function() onPressed,
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
  }) {
    return ActionButton(
      onPressed: onPressed,
      isEnabled: true,
      padding: padding,
      child: child,
    );
  }

  factory ActionButton.disabled({
    required void Function() onPressed,
    required Widget child,
  }) {
    return ActionButton(
      onPressed: onPressed,
      isEnabled: false,
      child: child,
    );
  }

  factory ActionButton.text({
    required void Function() onPressed,
    required String text,
    required BuildContext context,
  }) =>
      ActionButton(
        onPressed: onPressed,
        isEnabled: true,
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
            ),
          ],
        ),
      );

  final void Function() onPressed;
  final bool isEnabled;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final enabledWidget = InkWell(
      onTap: onPressed,
      child: BorderedContainer(
        accentColor: Colors.blue[800],
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
    final disabledWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
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
