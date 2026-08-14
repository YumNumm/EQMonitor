import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shared_preferences/debug_app_group_preferences_entries_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shared_preferences/debug_shared_preferences_entries_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 編集対象のストア種別。sync/async 双方のAPI差異をこの層で吸収する。
enum _StoreKind { shared, appGroup }

typedef _Entry = ({String key, Object? value});

class DebugSharedPreferencesPage extends HookConsumerWidget {
  const DebugSharedPreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIOS = Platform.isIOS;
    final tabs = <Tab>[
      const Tab(text: 'SharedPreferences'),
      if (isIOS) const Tab(text: 'App Group'),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SharedPreferences'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: '再取得',
              onPressed: () {
                ref
                  ..invalidate(debugSharedPreferencesEntriesProvider)
                  ..invalidate(debugAppGroupPreferencesEntriesProvider);
              },
            ),
          ],
          bottom: tabs.length > 1 ? TabBar(tabs: tabs) : null,
        ),
        body: TabBarView(
          children: [const _SharedView(), if (isIOS) const _AppGroupView()],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                final index = DefaultTabController.of(context).index;
                final kind = (isIOS && index == 1)
                    ? _StoreKind.appGroup
                    : _StoreKind.shared;
                unawaited(
                  ref
                      .read(_debugPreferencesEditorActionProvider)
                      .showAddDialog(context, kind),
                );
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class _SharedView extends ConsumerWidget {
  const _SharedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(debugSharedPreferencesEntriesProvider);
    return _EntriesList(
      entries: entries,
      kind: _StoreKind.shared,
      onRefresh: () => ref.invalidate(debugSharedPreferencesEntriesProvider),
    );
  }
}

class _AppGroupView extends ConsumerWidget {
  const _AppGroupView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(debugAppGroupPreferencesEntriesProvider);
    return _EntriesList(
      entries: entries,
      kind: _StoreKind.appGroup,
      onRefresh: () => ref.invalidate(debugAppGroupPreferencesEntriesProvider),
    );
  }
}

class _EntriesList extends ConsumerWidget {
  const _EntriesList({
    required this.entries,
    required this.kind,
    required this.onRefresh,
  });

  final AsyncValue<List<_Entry>> entries;
  final _StoreKind kind;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return entries.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('エラー: $error')),
      data: (list) {
        if (list.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async => onRefresh(),
            child: ListView(
              children: const [
                SizedBox(height: 200),
                Center(child: Text('エントリがありません')),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final entry = list[index];
              return ListTile(
                title: Text(entry.key),
                subtitle: Text(
                  const _DebugPreferenceValueFormatter().preview(entry.value),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: FontFamily.googleSansCode),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '削除',
                  onPressed: () async {
                    await ref
                        .read(_debugPreferencesEditorActionProvider)
                        .remove(ref, kind, entry.key);
                    onRefresh();
                  },
                ),
                onTap: () => ref
                    .read(_debugPreferencesEditorActionProvider)
                    .showEditDialog(context, kind, entry),
              );
            },
          ),
        );
      },
    );
  }
}

/// SharedPreferences / AppGroup Preferences のエントリ値をデバッグ表示用の
/// 文字列へ変換する。
class _DebugPreferenceValueFormatter {
  const _DebugPreferenceValueFormatter();

  String typeName(Object? value) => switch (value) {
    bool() => 'bool',
    int() => 'int',
    double() => 'double',
    String() => 'String',
    List<String>() => 'List<String>',
    _ => value.runtimeType.toString(),
  };

  String preview(Object? value) => '${typeName(value)}: $value';
}

final _debugPreferencesEditorActionProvider = Provider(
  (ref) => const _DebugPreferencesEditorAction(),
);

/// デバッグ画面から SharedPreferences / AppGroup Preferences の
/// 読み書き・削除・編集ダイアログ表示を行う。
class _DebugPreferencesEditorAction {
  const _DebugPreferencesEditorAction();

  Future<void> remove(WidgetRef ref, _StoreKind kind, String key) async {
    switch (kind) {
      case _StoreKind.shared:
        final prefs = await ref.read(sharedPreferencesProvider.future);
        await prefs.remove(key);
      case _StoreKind.appGroup:
        final prefs = await ref.read(appGroupPreferencesProvider.future);
        await prefs.remove(key);
    }
  }

  void invalidate(WidgetRef ref, _StoreKind kind) {
    switch (kind) {
      case _StoreKind.shared:
        ref.invalidate(debugSharedPreferencesEntriesProvider);
      case _StoreKind.appGroup:
        ref.invalidate(debugAppGroupPreferencesEntriesProvider);
    }
  }

  Future<void> setBool(
    WidgetRef ref,
    _StoreKind kind,
    String key, {
    required bool value,
  }) async {
    switch (kind) {
      case _StoreKind.shared:
        final prefs = await ref.read(sharedPreferencesProvider.future);
        await prefs.setBool(key, value);
      case _StoreKind.appGroup:
        final prefs = await ref.read(appGroupPreferencesProvider.future);
        await prefs.setBool(key, value);
    }
  }

  Future<void> setInt(
    WidgetRef ref,
    _StoreKind kind,
    String key,
    int value,
  ) async {
    switch (kind) {
      case _StoreKind.shared:
        final prefs = await ref.read(sharedPreferencesProvider.future);
        await prefs.setInt(key, value);
      case _StoreKind.appGroup:
        final prefs = await ref.read(appGroupPreferencesProvider.future);
        await prefs.setInt(key, value);
    }
  }

  Future<void> setDouble(
    WidgetRef ref,
    _StoreKind kind,
    String key,
    double value,
  ) async {
    switch (kind) {
      case _StoreKind.shared:
        final prefs = await ref.read(sharedPreferencesProvider.future);
        await prefs.setDouble(key, value);
      case _StoreKind.appGroup:
        final prefs = await ref.read(appGroupPreferencesProvider.future);
        await prefs.setDouble(key, value);
    }
  }

  Future<void> setString(
    WidgetRef ref,
    _StoreKind kind,
    String key,
    String value,
  ) async {
    switch (kind) {
      case _StoreKind.shared:
        final prefs = await ref.read(sharedPreferencesProvider.future);
        await prefs.setString(key, value);
      case _StoreKind.appGroup:
        final prefs = await ref.read(appGroupPreferencesProvider.future);
        await prefs.setString(key, value);
    }
  }

  Future<void> setStringList(
    WidgetRef ref,
    _StoreKind kind,
    String key,
    List<String> value,
  ) async {
    switch (kind) {
      case _StoreKind.shared:
        final prefs = await ref.read(sharedPreferencesProvider.future);
        await prefs.setStringList(key, value);
      case _StoreKind.appGroup:
        final prefs = await ref.read(appGroupPreferencesProvider.future);
        await prefs.setStringList(key, value);
    }
  }

  Future<void> showEditDialog(
    BuildContext context,
    _StoreKind kind,
    _Entry entry,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) => _EditDialog(kind: kind, entry: entry),
    );
  }

  Future<void> showAddDialog(BuildContext context, _StoreKind kind) async {
    await showDialog<void>(
      context: context,
      builder: (context) => _AddDialog(kind: kind),
    );
  }
}

class _EditDialog extends HookConsumerWidget {
  const _EditDialog({required this.kind, required this.entry});

  final _StoreKind kind;
  final _Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = entry.value;
    return AlertDialog(
      title: Text(entry.key),
      content: SingleChildScrollView(
        child: _ValueEditor(
          kind: kind,
          keyName: () => entry.key,
          initialValue: value,
          onSaved: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

/// 型に応じた入力UIと保存処理をまとめる。新規追加時は [initialValue] が
/// 選択された型のデフォルト値で渡ってくる。[keyName] は保存時に評価するため
/// 関数で受け取る（新規追加ダイアログでキー入力が後から確定するため）。
class _ValueEditor extends HookConsumerWidget {
  const _ValueEditor({
    required this.kind,
    required this.keyName,
    required this.initialValue,
    required this.onSaved,
    this.guard,
    super.key,
  });

  final _StoreKind kind;
  final String Function() keyName;
  final Object? initialValue;
  final VoidCallback onSaved;

  /// 保存前チェック。false を返したら保存しない。
  final bool Function()? guard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = initialValue;
    final key = keyName;

    final editorAction = ref.read(_debugPreferencesEditorActionProvider);

    // UI コールバックから呼ぶため void 戻り。内部で fire-and-forget する。
    void save(Future<void> Function(String key) setter) {
      final guardFn = guard;
      if (guardFn != null && !guardFn()) {
        return;
      }
      unawaited(() async {
        await setter(key());
        editorAction.invalidate(ref, kind);
        onSaved();
      }());
    }

    void showError(String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    switch (value) {
      case final bool boolValue:
        final state = useState(boolValue);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text(state.value.toString()),
              value: state.value,
              onChanged: (v) => state.value = v,
            ),
            _SaveButton(
              onPressed: () => save(
                (key) =>
                    editorAction.setBool(ref, kind, key, value: state.value),
              ),
            ),
          ],
        );
      case final int intValue:
        final controller = useTextEditingController(text: intValue.toString());
        return _SingleFieldEditor(
          controller: controller,
          keyboardType: TextInputType.number,
          onSave: () {
            final parsed = int.tryParse(controller.text.trim());
            if (parsed == null) {
              showError('int としてパースできません');
              return;
            }
            save((key) => editorAction.setInt(ref, kind, key, parsed));
          },
        );
      case final double doubleValue:
        final controller = useTextEditingController(
          text: doubleValue.toString(),
        );
        return _SingleFieldEditor(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onSave: () {
            final parsed = double.tryParse(controller.text.trim());
            if (parsed == null) {
              showError('double としてパースできません');
              return;
            }
            save((key) => editorAction.setDouble(ref, kind, key, parsed));
          },
        );
      case final String stringValue:
        final controller = useTextEditingController(text: stringValue);
        return _SingleFieldEditor(
          controller: controller,
          maxLines: 8,
          onSave: () => save(
            (key) => editorAction.setString(ref, kind, key, controller.text),
          ),
        );
      case final List<String> listValue:
        return _StringListEditor(
          initial: listValue,
          onSave: (list) =>
              save((key) => editorAction.setStringList(ref, kind, key, list)),
        );
      case null:
        return const Text('null 値は編集できません');
      default:
        return Text('未対応の型: ${value.runtimeType}');
    }
  }
}

class _SingleFieldEditor extends StatelessWidget {
  const _SingleFieldEditor({
    required this.controller,
    required this.onSave,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final VoidCallback onSave;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: 1,
        ),
        const SizedBox(height: 16),
        _SaveButton(onPressed: onSave),
      ],
    );
  }
}

class _StringListEditor extends HookWidget {
  const _StringListEditor({required this.initial, required this.onSave});

  final List<String> initial;
  final void Function(List<String>) onSave;

  @override
  Widget build(BuildContext context) {
    final items = useState<List<String>>([...initial]);

    List<Widget> buildFields() => [
      for (var i = 0; i < items.value.length; i++)
        Row(
          key: ValueKey(i),
          children: [
            Expanded(
              child: TextFormField(
                initialValue: items.value[i],
                onChanged: (v) {
                  final next = [...items.value];
                  next[i] = v;
                  items.value = next;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                final next = [...items.value]..removeAt(i);
                items.value = next;
              },
            ),
          ],
        ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...buildFields(),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('要素を追加'),
          onPressed: () => items.value = [...items.value, ''],
        ),
        const SizedBox(height: 8),
        _SaveButton(onPressed: () => onSave(items.value)),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: const Text('保存'));
  }
}

enum _NewValueType { boolType, intType, doubleType, stringType, stringListType }

class _AddDialog extends HookConsumerWidget {
  const _AddDialog({required this.kind});

  final _StoreKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyController = useTextEditingController();
    final type = useState(_NewValueType.stringType);

    Object? defaultValueFor(_NewValueType t) => switch (t) {
      _NewValueType.boolType => false,
      _NewValueType.intType => 0,
      _NewValueType.doubleType => 0.0,
      _NewValueType.stringType => '',
      _NewValueType.stringListType => <String>[],
    };

    return AlertDialog(
      title: const Text('新規追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              decoration: const InputDecoration(labelText: 'キー名'),
            ),
            const SizedBox(height: 8),
            DropdownButton<_NewValueType>(
              value: type.value,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: _NewValueType.boolType,
                  child: Text('bool'),
                ),
                DropdownMenuItem(
                  value: _NewValueType.intType,
                  child: Text('int'),
                ),
                DropdownMenuItem(
                  value: _NewValueType.doubleType,
                  child: Text('double'),
                ),
                DropdownMenuItem(
                  value: _NewValueType.stringType,
                  child: Text('String'),
                ),
                DropdownMenuItem(
                  value: _NewValueType.stringListType,
                  child: Text('List<String>'),
                ),
              ],
              onChanged: (v) {
                if (v != null) {
                  type.value = v;
                }
              },
            ),
            const SizedBox(height: 8),
            _ValueEditor(
              // 型を切り替えたら Editor 内部の hooks を作り直す。
              key: ValueKey(type.value),
              kind: kind,
              keyName: () => keyController.text.trim(),
              initialValue: defaultValueFor(type.value),
              guard: () {
                if (keyController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('キー名を入力してください')));
                  return false;
                }
                return true;
              },
              onSaved: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
