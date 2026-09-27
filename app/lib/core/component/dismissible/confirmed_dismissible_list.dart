import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// Keeps rejected asynchronous deletions visible in an expressive swipe list.
///
/// [onDismiss] reports persistence success. Successful items remain hidden until
/// the authoritative [items] update removes them; false restores the original row.
class ConfirmedDismissibleList<T> extends HookWidget {
  const new({
    required this.items,
    required this.itemId,
    required this.itemBuilder,
    required this.onDismiss,
    this.onTap,
    this.style = const M3EDismissibleCardStyle(),
    this.padding,
    super.key,
  });

  final List<T> items;
  final String Function(T item) itemId;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<bool> Function(T item) onDismiss;
  final ValueChanged<T>? onTap;
  final M3EDismissibleCardStyle style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final pendingIds = useState(<String>{});
    final revision = useState(0);
    final saving = useState(false);
    final controller = useScrollController();
    final storageKey = useMemoized(() => PageStorageKey(UniqueKey()));
    final ids = items.map(itemId).toSet();
    useEffect(() {
      final retained = pendingIds.value.intersection(ids);
      if (retained.length != pendingIds.value.length) {
        pendingIds.value = retained;
      }
      return null;
    }, [ids, pendingIds.value]);
    final visible = items
        .where((item) => !pendingIds.value.contains(itemId(item)))
        .toList();

    final dismiss = (T item) async {
      final id = itemId(item);
      saving.value = true;
      pendingIds.value = {...pendingIds.value, id};
      var accepted = false;
      try {
        accepted = await onDismiss(item);
      } finally {
        if (context.mounted) saving.value = false;
        if (context.mounted && !accepted) {
          pendingIds.value = {...pendingIds.value}..remove(id);
          // m3e_core disposes collapse controllers before awaiting the
          // save. Its delayed false path reuses disposed controllers;
          // recreate that visual state instead, preserving page storage.
          revision.value++;
        }
      }
      return true;
    };

    return ExcludeFocus(
      excluding: saving.value,
      child: AbsorbPointer(
        absorbing: saving.value,
        child: KeyedSubtree(
          key: ValueKey(revision.value),
          child: M3EDismissibleCardList(
            key: storageKey,
            scrollController: controller,
            listPadding: padding,
            style: style,
            itemCount: visible.length,
            itemBuilder: (context, index) => Semantics(
              onDismiss:
                  !saving.value && style.direction != DismissDirection.none
                  ? () async {
                      await dismiss(visible[index]);
                    }
                  : null,
              child: itemBuilder(context, visible[index]),
            ),
            onTap: onTap == null
                ? null
                : (index) => onTap?.call(visible[index]),
            onDismiss: (index, _) => dismiss(visible[index]),
          ),
        ),
      ),
    );
  }
}
