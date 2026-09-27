# 限定コード生成後の差分確認

初期化直後のworktreeで `build_runner --build-filter` を実行すると、指定外の追跡済み生成ファイルが削除される場合がある。

```sh
mise exec -- dart run build_runner build --build-filter=lib/feature/earthquake_history/data/model/earthquake_intensity_area_filter.g.dart
git --no-pager diff --name-status
```

生成前に作業状態を確認する。無関係な生成ファイルに削除・変更が生じた場合、元の変更を失わないようファイルを特定して復元する。マージ中はHEADではなく、マージ結果が入ったインデックスを復元元にする。復元後に解析・テストを実行する。
