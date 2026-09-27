import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// Keeps parent-owned selection in sync without treating rebuilds as user input.
class ControlledDropdown<T> extends HookWidget {
  const new({
    required this.items,
    this.onSelectionChanged,
    this.enabled = true,
    this.singleSelect = true,
    this.allowEmptySelection = false,
    this.searchEnabled = false,
    this.fieldStyle = const M3EDropdownFieldStyle(),
    this.searchStyle = const M3ESearchStyle(),
    this.chipStyle = const M3EChipStyle(),
    this.dropdownStyle = const M3EDropdownStyle(),
    this.itemBuilder,
    this.selectedItemBuilder,
    super.key,
  });

  final List<M3EDropdownItem<T>> items;
  final ValueChanged<List<M3EDropdownItem<T>>>? onSelectionChanged;
  final bool enabled;
  final bool singleSelect;
  final bool allowEmptySelection;
  final bool searchEnabled;
  final M3EDropdownFieldStyle fieldStyle;
  final M3ESearchStyle searchStyle;
  final M3EChipStyle chipStyle;
  final M3EDropdownStyle dropdownStyle;
  final M3EDropdownItemBuilder<T>? itemBuilder;
  final Widget Function(M3EDropdownItem<T>)? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(M3EDropdownController<(T,)>.new);
    final callback = useRef(onSelectionChanged)..value = onSelectionChanged;
    final selectionPolicy = useRef((singleSelect, allowEmptySelection, enabled))
      ..value = (singleSelect, allowEmptySelection, enabled);
    final nativeItems = useRef(<M3EDropdownItem<(T,)>>[]);
    final nativeCallback = useRef<ValueChanged<List<M3EDropdownItem<(T,)>>>?>(
      null,
    );
    final handleSelection = useMemoized(
      () => (List<M3EDropdownItem<(T,)>> selection) {
        if (!selectionPolicy.value.$3 ||
            (selection.isEmpty &&
                selectionPolicy.value.$1 &&
                !selectionPolicy.value.$2)) {
          controller.setOnSelectionChange(null);
          controller.setItems(nativeItems.value);
          controller.setOnSelectionChange(nativeCallback.value);
          return;
        }
        callback.value?.call([
          for (final item in selection)
            M3EDropdownItem(
              value: item.value.$1,
              label: item.label,
              disabled: item.disabled,
              selected: item.selected,
            ),
        ]);
      },
      [callback, controller, nativeCallback, nativeItems, selectionPolicy],
    );
    nativeCallback.value = handleSelection;
    useEffect(() => controller.dispose, [controller]);
    useEffect(() {
      // m3e_core setItems also calls its selection handler. External changes
      // must not trigger persistence or form callbacks during a rebuild.
      controller.setOnSelectionChange(null);
      // The native chip animation requires non-null keys, including when a
      // null domain value represents a valid "not specified" option.
      nativeItems.value = [
        for (final item in items)
          M3EDropdownItem(
            value: (item.value,),
            label: item.label,
            disabled: item.disabled,
            selected: item.selected,
          ),
      ];
      controller.setItems(nativeItems.value);
      controller.setOnSelectionChange(handleSelection);
      return null;
    }, [controller, items, handleSelection, nativeItems]);

    useEffect(() {
      if (!enabled) controller.closeDropdown();
      return null;
    }, [controller, enabled]);

    final customItemBuilder = itemBuilder;
    final customSelectedItemBuilder = selectedItemBuilder;
    return M3EDropdownMenu<(T,)>(
      controller: controller,
      items: const [],
      onSelectionChanged: handleSelection,
      enabled: enabled,
      singleSelect: singleSelect,
      showChipAnimation: false,
      searchEnabled: searchEnabled,
      fieldStyle: fieldStyle,
      searchStyle: searchStyle,
      chipStyle: chipStyle,
      dropdownStyle: dropdownStyle,
      itemBuilder: customItemBuilder == null
          ? null
          : (item, selected, onTap) => customItemBuilder(
              M3EDropdownItem(
                value: item.value.$1,
                label: item.label,
                disabled: item.disabled,
                selected: item.selected,
              ),
              selected,
              onTap,
            ),
      selectedItemBuilder: customSelectedItemBuilder == null
          ? null
          : (item) => customSelectedItemBuilder(
              M3EDropdownItem(
                value: item.value.$1,
                label: item.label,
                disabled: item.disabled,
                selected: item.selected,
              ),
            ),
    );
  }
}
