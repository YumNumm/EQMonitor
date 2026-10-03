# 市区町村別最大震度の選択枠

- 選択枠は最大震度 API の取得状態に依存させない。`IntensityFillLayer.items == null` は未取得を表し、塗りの更新だけを待機する。空の震度データで代用しない。
- 枠の本線は地域選択 UI と同じ `Theme.of(context).colorScheme.primary` と幅 2.5 を使う。震度色とのコントラストを確保するハローは維持する。
- 地図タップで詳細シートを開くときは、市区町村ポリゴンの実際の bounds をシート上の表示領域に収める。シートの初期高さは `CityDetailModalAction.initialChildSize` と共有し、選択枠がシートの裏に隠れることを防ぐ。bounds がない場合に架空の範囲を補わない。
- 市区町村の履歴は観測震度の降順が初期値。`EarthquakeSortChips` の `showRegionalIntensity` を有効にして「観測震度」の選択状態を表示する。
- 取得前・初回失敗・再取得時の表示を以下で確認する。Widget テストのみでネイティブ地図の描画を検証済みとしない。

```sh
cd app
mise exec -- flutter test test/feature/intensity_history --dart-define=CI=true
```

検証環境の mise が `min_version` より古い場合は、設定外のディレクトリから `mise exec flutter@<mise.toml の固定 ref> -- sh -c 'cd <worktree> && flutter pub get'` として同じ SDK を明示できる。リポジトリの最低バージョンや SDK ref を下げない。
