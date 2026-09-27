import 'package:m3e_core/m3e_core.dart';
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
    child: Center(
      child: Text(
        text,
        style: (Theme.of(context).textTheme.titleMedium ?? const TextStyle())
            .copyWith(
              fontWeight: .bold,
              color: Colors.white,
              letterSpacing: 1.1,
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
              fontWeight: .bold,
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
    return M3EButton(
      onPressed: isEnabled ? onPressed : null,
      style: accentColor == Colors.transparent ? .outlined : .filled,
      decoration: M3EButtonDecoration.styleFrom(
        backgroundColor: accentColor,
        padding: padding,
      ),
      child: child,
    );
  }
}
