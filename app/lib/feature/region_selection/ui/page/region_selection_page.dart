import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_hierarchy.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_option_label.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_search.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_selection_reducer.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_catalog_provider.dart';
import 'package:eqmonitor/feature/region_selection/ui/component/region_hierarchy_list.dart';
import 'package:eqmonitor/feature/region_selection/ui/component/region_selection_map.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class RegionSelectionPage extends ConsumerWidget {
  const new({
    required this.request,
    this.onConfirmed,
    super.key,
  });

  final RegionSelectionRequest request;
  final ValueChanged<List<RegionOption>>? onConfirmed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(
      regionCatalogProvider(notification: request.notification),
    );
    return catalog.when(
      data: (items) => _RegionSelectionContent(
        request: request,
        catalog: items,
        onConfirmed: onConfirmed,
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: Text(request.title)),
        body: const Center(child: AccessibleCircularProgressIndicator()),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(title: Text(request.title)),
        body: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              const Text('地域情報を読み込めませんでした'),
              M3ETextButton(
                onPressed: () {
                  ref.invalidate(parameterSetProvider);
                  ref.invalidate(
                    regionCatalogProvider(notification: request.notification),
                  );
                },
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionSelectionContent extends HookWidget {
  const new({
    required this.request,
    required this.catalog,
    this.onConfirmed,
  });

  final RegionSelectionRequest request;
  final List<RegionOption> catalog;
  final ValueChanged<List<RegionOption>>? onConfirmed;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: request.initialQuery);
    useListenable(controller);
    final kind = useState<RegionKind?>(
      request.kinds.length == 1 ? request.kinds.first : null,
    );
    final parent = useState<RegionOption?>(null);
    final showMap = useState(false);
    final selection = useState(request.initialSelection);
    const reducer = RegionSelectionReducer();
    final selected = useMemoized(
      () => reducer.restore(
        selected: selection.value,
        catalog: catalog,
        mode: request.mode,
      ),
      [selection.value, catalog, request.mode],
    );
    final unavailable = useMemoized(
      () => {for (final item in request.unavailable) item.identity},
      [request.unavailable],
    );
    final available = catalog
        .where((item) => request.kinds.contains(item.kind))
        .toList();
    final items = const RegionSearch().filter(
      items: available,
      query: controller.text,
      kind: kind.value,
      parent: parent.value,
    );
    final canConfirm = selected.isNotEmpty || request.allowEmpty;
    final multiple = request.mode == .multiple;
    final hasKindFilter = request.kinds.length > 1 && kind.value != null;
    final initialLocation = useMemoized(
      () => const RegionHierarchy().location(
        catalog: catalog,
        option: request.hierarchical ? selected.firstOrNull : null,
      ),
      // ignore_keys: selected
      [catalog, request.hierarchical],
    );
    final browsePrefecture = useState(initialLocation.prefecture);
    final browseRegion = useState(initialLocation.region);
    final prefectures = useMemoized(
      () => request.hierarchical
          ? const RegionHierarchy().prefectures(catalog)
          : const <RegionOption>[],
      [catalog, request.hierarchical],
    );
    final isBrowsing =
        request.hierarchical && !showMap.value && controller.text.isEmpty;
    final canLeave = !isBrowsing || browsePrefecture.value == null;

    void confirm(List<RegionOption> value) {
      final callback = onConfirmed;
      if (callback != null) {
        callback(value);
      } else {
        Navigator.of(context).pop(value);
      }
    }

    void select(RegionOption option) {
      if (!multiple) {
        confirm([option]);
        return;
      }
      selection.value = reducer.select(
        selected: selected,
        option: option,
        mode: request.mode,
      );
    }

    final hasConfirmButton = multiple
        ? canConfirm
        : showMap.value && selected.isNotEmpty;
    final actionInset = hasConfirmButton ? 88.0 : 0.0;

    return PopScope(
      canPop: canLeave,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        if (browseRegion.value != null) {
          browseRegion.value = null;
        } else {
          browsePrefecture.value = null;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(request.title),
          actions: [
            if (multiple && selected.isNotEmpty)
              M3ETextButton(
                onPressed: () {
                  selection.value = const [];
                },
                child: const Text('すべて解除'),
              ),
            if (!multiple &&
                request.allowEmpty &&
                request.initialSelection.isNotEmpty)
              M3ETextButton(
                onPressed: () => confirm(const []),
                child: const Text('指定を解除'),
              ),
            M3ETextButton.icon(
              onPressed: () {
                showMap.value = !showMap.value;
                if (showMap.value) {
                  kind.value ??=
                      selected.firstOrNull?.kind ?? request.kinds.first;
                  controller.clear();
                  FocusScope.of(context).unfocus();
                }
              },
              icon: Icon(showMap.value ? Icons.list : Icons.map_outlined),
              label: Text(showMap.value ? '一覧' : '地図'),
            ),
          ],
        ),
        floatingActionButton: hasConfirmButton
            ? FloatingActionButton.extended(
                onPressed: () => confirm(selected),
                icon: const Icon(Icons.check),
                label: Text(
                  multiple && selected.isNotEmpty
                      ? '決定（${selected.length}）'
                      : '決定',
                ),
              )
            : null,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SearchBar(
                  controller: controller,
                  hintText: '地域名・ふりがなで検索',
                  leading: const Icon(Icons.search),
                  onChanged: (_) {
                    showMap.value = false;
                  },
                  trailing: [
                    if (controller.text.isNotEmpty)
                      IconButton(
                        onPressed: controller.clear,
                        tooltip: '検索語を消去',
                        icon: const Icon(Icons.clear),
                      ),
                  ],
                ),
              ),
              if (isBrowsing)
                RegionHierarchyBreadcrumb(
                  prefecture: browsePrefecture.value,
                  region: browseRegion.value,
                  onRootSelected: () {
                    browsePrefecture.value = null;
                    browseRegion.value = null;
                  },
                  onPrefectureSelected: () {
                    browseRegion.value = null;
                  },
                )
              else if (request.kinds.length > 1)
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    spacing: 8,
                    children: [
                      if (!showMap.value)
                        ChoiceChip(
                          label: const Text('すべて'),
                          selected: kind.value == null,
                          onSelected: (_) {
                            kind.value = null;
                            parent.value = null;
                          },
                        ),
                      for (final value in request.kinds)
                        ChoiceChip(
                          label: Text(value.label),
                          selected: kind.value == value,
                          onSelected: (_) {
                            kind.value = value;
                            parent.value = null;
                          },
                        ),
                    ],
                  ),
                ),
              if (parent.value case final scope?)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: Align(
                    alignment: .centerLeft,
                    child: InputChip(
                      avatar: const Icon(Icons.filter_alt_outlined, size: 18),
                      label: Text('${scope.name}の地域'),
                      deleteButtonTooltipMessage: '絞り込みを解除',
                      onDeleted: () {
                        parent.value = null;
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Expanded(
                child: showMap.value
                    ? RegionSelectionMap(
                        kind: kind.value ?? request.kinds.first,
                        catalog: catalog,
                        selected: selected,
                        parent: parent.value,
                        bottomInset: actionInset,
                        onSelected: (option) {
                          if (unavailable.contains(option.identity)) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${option.name}は${request.unavailableLabel}です',
                                  ),
                                ),
                              );
                            return;
                          }
                          selection.value = reducer.select(
                            selected: reducer.restore(
                              selected: selection.value,
                              catalog: catalog,
                              mode: request.mode,
                            ),
                            option: option,
                            mode: request.mode,
                          );
                        },
                      )
                    : isBrowsing
                    ? RegionHierarchyList(
                        catalog: available,
                        kinds: request.kinds,
                        prefectures: prefectures,
                        prefecture: browsePrefecture.value,
                        region: browseRegion.value,
                        selected: selected,
                        unavailable: unavailable,
                        unavailableLabel: request.unavailableLabel,
                        multiple: multiple,
                        bottomInset: actionInset,
                        onPrefectureSelected: (value) {
                          browsePrefecture.value = value;
                        },
                        onRegionSelected: (value) {
                          browseRegion.value = value;
                        },
                        onOptionSelected: select,
                      )
                    : items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: .min,
                          children: [
                            const Text('該当する地域がありません'),
                            if (hasKindFilter || parent.value != null)
                              M3ETextButton(
                                onPressed: () {
                                  if (request.kinds.length > 1) {
                                    kind.value = null;
                                  }
                                  parent.value = null;
                                },
                                child: const Text('絞り込みを解除して探す'),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        keyboardDismissBehavior: .onDrag,
                        padding: EdgeInsets.only(bottom: actionInset),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected = selected.any(
                            (value) => value.identity == item.identity,
                          );
                          final isUnavailable = unavailable.contains(
                            item.identity,
                          );
                          final childKind = switch (item.kind) {
                            .prefecture =>
                              request.kinds.contains(RegionKind.region)
                                  ? RegionKind.region
                                  : RegionKind.city,
                            .region || .eewRegion => RegionKind.city,
                            _ => null,
                          };
                          final canBrowse =
                              childKind != null &&
                              request.kinds.contains(childKind);
                          return ListTile(
                            selected: isSelected,
                            enabled: !isUnavailable,
                            leading: multiple
                                ? Icon(
                                    isSelected
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                  )
                                : null,
                            title: Text(item.name),
                            subtitle: Text(
                              isUnavailable
                                  ? '${const RegionOptionLabel().subtitle(item)}'
                                        '・${request.unavailableLabel}'
                                  : const RegionOptionLabel().subtitle(item),
                            ),
                            onTap: () => select(item),
                            trailing: !canBrowse
                                ? (!multiple && (isSelected || isUnavailable)
                                      ? const Icon(Icons.check)
                                      : null)
                                : IconButton(
                                    tooltip:
                                        '${item.name}の${childKind.label}を探す',
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: () {
                                      parent.value = item;
                                      kind.value = childKind;
                                      controller.clear();
                                    },
                                  ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
