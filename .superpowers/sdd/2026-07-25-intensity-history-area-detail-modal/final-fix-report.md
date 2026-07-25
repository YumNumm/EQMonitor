# Final Fix Report

## Changed files
- `app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`
- `app/test/feature/intensity_history/city_detail_modal_test.dart`

## Findings addressed
1. `BuildContext` と `WidgetRef` を受ける top-level helper `_buildEarthquakeListSlivers` を削除し、`_AreaEarthquakeListSliverGroup extends HookConsumerWidget` に置き換えた。`ref/context` は Widget の `build` の中でのみ扱う構成に修正した。
2. 「さらに読み込む」ボタンに `nextToken` 単位の in-flight 制御を追加した。押下中は `OutlinedButton` を無効化し、同じ cursor の `fetchNextData()` 並列実行を防止する。
3. 初期読み込み表示を `_InitialLoadingSliver` に切り出し、spinner と `地震一覧を読み込んでいます` を併記した。
4. Widget test を追加し、`fetchNextData()` 完了前にボタンを 2 回押しても呼び出し回数が 1 回に抑制されることを検証した。

## Verification
### Test
Command:
```sh
mise exec -- flutter test --no-pub app/test/feature/intensity_history/city_detail_modal_test.dart
```

Output:
```text
00:00 +0: 市区町村モーダルで地震一覧が表示される
00:01 +1: 都道府県モーダルで地震一覧が表示される
00:01 +2: 地震一覧が空の場合は空表示になる
00:01 +3: 地震一覧の取得に失敗した場合は再読み込み導線を表示する
00:02 +4: 地震一覧の初回読み込み中はローディング表示になる
00:02 +5: 続きがある場合はさらに読み込むボタンを表示する
00:02 +6: 追加読み込み中の二重押下は1回に抑制される
00:02 +7: All tests passed!
```

### Analyze
Command:
```sh
mise exec -- flutter analyze --no-pub app/lib/feature/intensity_history/ui/components/city_detail_modal.dart app/test/feature/intensity_history/city_detail_modal_test.dart
```

Output:
```text
Analyzing 2 items...

No issues found! (ran in 14.7s)
```

## Commit
- `HEAD` `fix: 地域詳細モーダルの追加読み込みを安定化`
