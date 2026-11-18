import 'package:material_ui/material_ui.dart';

class const HistorySelection({
  required final bool selected,
  required final Widget child,
  super.key,
}) extends StatelessWidget {
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
