# Blenderによるアイコン試作

## 元素材

- 完成ロゴのSVGを輪郭の基準にする。
- ガイド線付きSVGは構造の参考資料として扱う。
- ガイド線、寸法線、補助円はアイコン本体へ含めない。
- SVGのstrokeは、線幅とround join/capを保持した閉じた輪郭にする。
- 異なるSVG間では原点・座標のずれを確認してから輪郭を転用する。

## Blenderの実行

2026-09-05、macOS上のBlender 5.2.1で確認した。

```sh
blender -b --python /path/to/source/create_icons.py -- 1024
```

サンドボックス内ではPython実行前のMetal初期化でクラッシュした。
クラッシュログは一時ディレクトリの `blender.crash.txt` に出力された。
スタックには `MTLBackend::metal_is_supported` と
`supports_barycentric_whitelist` が含まれていた。
同じコマンドを承認されたサンドボックス外実行に切り替えると生成できた。
この事例だけで、通常環境のBlenderでも同じ問題が起きるとは判断しない。

## 試作の確認

- `.blend`、透過PNG、確認用比較画像を分けて保存する。
- 正面の平行投影カメラで、元ロゴの輪郭を確認する。
- マット材質とガラス材質では、小サイズでの判別性を個別に確認する。
- 透明なロゴは台座と同化しやすいため、必要に応じて内側に白い芯を置く。
- PNGを縮小する際はpremultiplied alphaを使い、透明境界の色にじみを防ぐ。
- `.icns` の生成には `iconutil -c icns /path/to/name.iconset` を使う。
- 試作ファイルの生成と、アプリの正式アイコンへの組み込みは別作業とする。
