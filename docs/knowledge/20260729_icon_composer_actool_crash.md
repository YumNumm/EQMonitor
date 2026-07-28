# Icon Composer の新形式 `.icon` は actool をクラッシュさせる

## 症状

`xcodebuild archive` が exit 65 で落ちるが、`xcbeautify` 経由だとエラー本文が
一切出ず、`Copy ... bundle` と `note: Run script build phase ...` の後に
いきなり `Process completed with exit code 65` になる。

raw log を見ると実体はこれ。

```text
Could not open “AppIcon-dev.icon”.
/* com.apple.actool.errors */
error: Exception while running actool: *** -[__NSPlaceholderArray initWithObjects:count:]:
attempt to insert nil object from objects[0]
  ...
  4 -[IBICAbstractPlatformAdapter selectCatalogIconComposerItemsFromCollection:...]
```

```text
The following build commands failed:
	CompileAssetCatalogVariant thinned ... AppIcon-dev.icon ...
```

## 原因

Icon Composer が書き出した `icon.json` に、Xcode 26.3 / 26.6 の `actool` が
解釈できない新しいキーが含まれていた。

| キー | 壊れる値 | 互換のある値 |
| --- | --- | --- |
| `features` | `["specular-location"]` | キーごと削除 |
| `groups[].specular` | `"inside"`（文字列） | `true` / `false`（真偽値） |

`.icon` を開けないと actool が nil を配列に入れてクラッシュするだけで、
「どのキーが悪いか」は一切出力されない。**両方**直さないと通らない。

## 切り分け手順

`--output-partial-info-plist` を付けないと actool はアイコンを
コンパイルしないので、再現には必須。

```bash
cd app/ios
xcrun actool AppIcon-dev.icon \
  --compile /tmp/at --output-partial-info-plist /tmp/at.plist \
  --app-icon AppIcon-dev --include-all-app-icons \
  --output-format human-readable-text --notices --warnings \
  --development-region ja --target-device iphone --target-device ipad \
  --minimum-deployment-target 16.0 --platform iphoneos
```

`Assets.car` が出れば OK、`error: Exception while running actool` なら NG。

## 運用ルール

Icon Composer でアイコンを更新したら、**コミット前に上記 actool 単体実行で
検証する**。Icon Composer の方が Xcode 同梱 actool より先行して新形式を
吐くことがあり、CI（Xcode 26.3）だけでなくローカル（26.6）でも落ちる。
