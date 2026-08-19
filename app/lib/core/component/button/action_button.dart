import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:material_ui/material_ui.dart';

class ActionButton extends StatelessWidget {
  const new({
    required this.onPressed,
    required this.isEnabled,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.accentColor,
    super.key,
  });

  factory enabled({
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

  factory disabled({
    required void Function() onPressed,
    required Widget child,
  }) {
    return ActionButton(onPressed: onPressed, isEnabled: false, child: child);
  }

  factory text({
    required void Function() onPressed,
    required String text,
    required BuildContext context,
    Color? accentColor,
  }) => ActionButton(
    onPressed: onPressed,
    accentColor: accentColor,
    isEnabled: true,
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Flexible(
      child: Center(
        child: Text(
          text,
          style: (Theme.of(context).textTheme.titleMedium ?? const TextStyle())
              .copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
        ),
      ),
    ),
  );

  factory textOutline({
    required void Function() onPressed,
    required String text,
    required BuildContext context,
    Color? textColor,
  }) => ActionButton(
    onPressed: onPressed,
    accentColor: Colors.transparent,
    isEnabled: true,
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Center(
      child: Text(
        text,
        style: (Theme.of(context).textTheme.titleMedium ?? const TextStyle())
            .copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 1.1,
            ),
      ),
    ),
  );

  final void Function() onPressed;
  final bool isEnabled;
  final Widget child;
  final EdgeInsets padding;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final enabledWidget = BorderedContainer(
      accentColor: accentColor ?? Colors.blue.shade800,
      onPressed: onPressed,
      child: Padding(padding: padding, child: child),
    );
    final disabledWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.white.withValues(alpha: 0.75),
        border: const Border.fromBorderSide(BorderSide(color: Colors.grey)),
      ),
      child: child,
    );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: isEnabled ? enabledWidget : disabledWidget,
    );
  }
}
