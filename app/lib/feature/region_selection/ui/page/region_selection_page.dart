import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_search.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_selection_reducer.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_catalog_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(request.title),
        actions: [
          M3ETextButton(
            onPressed: !canConfirm
                ? null
                : () {
                    final callback = onConfirmed;
                    if (callback != null) {
                      callback(selected);
                    } else {
                      Navigator.of(context).pop(selected);
                    }
                  },
            child: const Text('決定'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SearchBar(
                controller: controller,
                hintText: '地域名・ふりがなで検索',
                leading: const Icon(Icons.search),
                onChanged: (_) {
                  showMap.value = false;
                  parent.value = null;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  if (!showMap.value && request.kinds.length > 1)
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false,
                    label: Text('一覧'),
                    icon: Icon(Icons.list),
                  ),
                  ButtonSegment(
                    value: true,
                    label: Text('地図'),
                    icon: Icon(Icons.map_outlined),
                  ),
                ],
                selected: {showMap.value},
                onSelectionChanged: (value) {
                  showMap.value = value.single;
                  if (value.single) {
                    kind.value ??=
                        selected.firstOrNull?.kind ?? request.kinds.first;
                    controller.clear();
                  }
                },
              ),
            ),
            if (parent.value case final scope?)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: Text('${scope.name}の地域')),
                    M3ETextButton(
                      onPressed: () {
                        parent.value = null;
                      },
                      child: const Text('絞り込みを解除'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: showMap.value
                  ? RegionSelectionMap(
                      kind: kind.value ?? request.kinds.first,
                      catalog: catalog,
                      selected: selected,
                      parent: parent.value,
                      onSelected: (option) {
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
                  : items.isEmpty
                  ? const Center(child: Text('該当する地域がありません'))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = selected.any(
                          (value) => value.identity == item.identity,
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
                          leading: Icon(
                            multiple
                                ? (isSelected
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank)
                                : (isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked),
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                            '${item.kind.label}${item.parentName == null ? '' : '・${item.parentName}'}',
                          ),
                          onTap: () {
                            selection.value = reducer.select(
                              selected: selected,
                              option: item,
                              mode: request.mode,
                            );
                          },
                          trailing: !canBrowse
                              ? null
                              : IconButton(
                                  tooltip: '${item.name}の${childKind.label}を探す',
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
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selected.isEmpty
                          ? '地域を選択してください'
                          : '選択中（${selected.length}）',
                    ),
                  ),
                  if (selected.isNotEmpty)
                    M3ETextButton(
                      onPressed: () {
                        selection.value = const [];
                      },
                      child: const Text('すべて解除'),
                    ),
                ],
              ),
            ),
            if (selected.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.22,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selected.length,
                  itemBuilder: (context, index) {
                    final item = selected[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.parentName ?? item.kind.label),
                      trailing: IconButton(
                        tooltip: '${item.name}の選択を解除',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          selection.value = reducer.remove(
                            selected: selected,
                            option: item,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
