import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_history_search_results.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeHistorySearchPage extends HookConsumerWidget {
  const new({super.key, required this.initialQuery});

  final String initialQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initialQuery);
    useListenable(controller);
    final query = controller.text;
    final results = ref.watch(earthquakeHistorySearchResultsProvider(query));
    return Scaffold(
      appBar: AppBar(title: const Text('地域名で地震を検索')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              textInputAction: .search,
              decoration: InputDecoration(
                labelText: '都道府県・地域・市区町村名',
                hintText: '例：東京都、千代田区',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: '検索語を消去',
                  onPressed: controller.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          Expanded(
            child: results.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (_, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      const Text('地域情報を読み込めませんでした。'),
                      TextButton(
                        onPressed: () => ref.invalidate(parameterSetProvider),
                        child: const Text('再読み込み'),
                      ),
                    ],
                  ),
                ),
              ),
              data: (items) => items.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          query.trim().isEmpty
                              ? '地域名を入力してください。'
                              : '一致する地域がありません。東京都、千代田区などの地域名で検索してください。',
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.areaDescription),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => EarthquakeHistoryRoute(
                            $extra: item.parameter,
                          ).push<void>(context),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
