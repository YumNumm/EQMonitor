import 'package:material_ui/material_ui.dart';

class HistorySelection extends StatelessWidget {
  const new({
    required this.selected,
    required this.child,
    super.key,
  });

  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: Container(
      foregroundDecoration: selected
          ? BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            )
          : null,
      child: child,
    ),
  );
}
