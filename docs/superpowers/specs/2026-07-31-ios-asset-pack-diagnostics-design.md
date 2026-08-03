# iOS Asset Pack 診断・更新操作の設計

## 背景

TestFlight で `eqmonitor-assets` が取得済みにならない事象が発生している。
現在の `AssetsUtil.resolvePackRoot()` は、iOS 26 未満、manifest の未取得、
manifest の解析失敗、ファイル欠落、サイズ不一致をすべて
`AssetPackNotReadyException` に変換する。そのため、デバッグ画面だけでは
どの段階で失敗したか判別できない。

App Store Connect への Asset Pack upload と TestFlight build upload は成功し、
Apple Developer Portal の Background Assets capability も有効であることが
確認済みである。次の調査では端末上の状態を構造化して観測する必要がある。

## 目的

- iOS 端末上で Asset Pack が利用できない理由をデバッグ画面だけで特定する。
- 明示操作により Apple の `checkForUpdates()` を実行し、結果を確認する。
- 診断の再読込と更新操作を分離し、観測前の状態を不用意に変えない。

## 対象範囲

- iOS の Managed Background Assets のみを対象とする。
- Android Play Asset Delivery と macOS bundle assets の挙動は変更しない。
- Asset Pack の自動再試行やアプリ通常画面のエラー表示は変更しない。
- PMTiles の地物数など、ファイル内容の意味的妥当性検証は対象外とする。

## 採用方針

Swift 側に構造化診断APIと更新確認APIを追加し、Dart側へ型付き結果として渡す。
Dart側だけで失敗理由を推測する方式や、OSログだけに記録する方式は採用しない。
現在 `nil` に集約される前の情報を保持できるのはSwift層だけであり、端末ログを
別途取得せずデバッグ画面で完結させるためである。

## 診断モデル

診断は例外ではなく結果として返し、最低限次の状態を区別する。

- `ready`: manifest と全assetの存在・サイズが一致する。
- `unsupportedOs`: iOS 26.0未満である。
- `manifestUrlResolutionFailed`: `AssetPackManager.url(for:)` が失敗した。
- `manifestMissing`: 解決したURLに `manifest.json` が存在しない。
- `manifestUnreadable`: manifest を読み込めない。
- `manifestInvalid`: JSONまたは必須フィールドが不正である。
- `assetMissing`: manifest記載ファイルが存在しない。
- `assetSizeMismatch`: 実ファイルサイズが `size_bytes` と一致しない。

診断結果には次を含める。

- platform、OS version、Asset Pack ID
- iOS 26.4以上では `assetPackIsAvailableLocally(withID:)` の判定値、
  それ未満ではAPI利用不可であること
- 状態と開発者向け詳細
- 解決できた場合のmanifest URLとpack root
- 各assetのrelative path、存在有無、期待サイズ、実サイズ
- ネイティブAPIが返したエラーのdomain、code、description

複数ファイルに問題がある場合は、最初のエラーだけで終了せず、確認可能な
全ファイルの状態を返す。manifest自体を読めない場合のみファイル一覧は空になる。

## ネイティブ境界

`packages/assets_util` のSwift実装に、既存の
`resolvePackRoot(packIdentifier:)` とは独立した診断メソッドを追加する。
通常のアプリ処理の契約や例外挙動は変更しない。

診断結果はバージョン付きのJSONとしてDartへ渡し、Dart側で専用モデルへ変換する。
JSON境界を使うことで、ffigenで多数のObjective-C DTOを公開せず、診断項目の追加を
局所化する。未知のschema versionや必須値欠落は変換エラーとして扱う。

`AssetPackManager.checkForUpdates()` はasync APIであるため、Swiftで `Task` を開始し、
Objective-C互換completion handlerへ成功またはエラーを返す。Dart側は処理完了まで
awaitし、fire-and-forgetにはしない。

更新結果には `updatingIDs`、`removedIDs` と実行時刻を含める。APIエラーは握り潰さず、
型付き失敗として画面に表示しtalkerにも記録する。`checkForUpdates()` の完了は
全ファイルのdownload完了を意味しないため、結果を「取得完了」とは表示しない。
packの削除による強制再downloadはデバッグ画面の対象外とする。

## Dart・Riverpod構成

- assets_util packageにiOS診断・更新結果モデルとAPIを配置する。
- app側のproviderは診断結果を取得し、既存manifest modelと結合して表示用状態を作る。
- 更新操作はRiverpod 3 Mutationで管理する。
- ボタンイベントやSnackBarなどのUI副作用は専用Actionクラスに置く。
- `WidgetRef` と `BuildContext` はAction以外のロジックへ渡さない。

更新成功後は診断providerをinvalidateし、最新状態を再取得する。更新失敗時は
失敗時点の診断表示を保持し、エラーだけを操作結果欄へ追加する。

## UI

右上の更新アイコンは従来どおり診断情報の再読込だけを行う。
Asset Packの状態を変更しない。

画面上部に診断サマリーを表示する。

- 状態名と説明
- OS version、pack ID
- manifest URL、pack root（取得できた項目のみ）
- ネイティブエラー詳細（取得できた場合）

その下に「更新を確認」ボタンを配置する。明示的に押した場合のみ
`checkForUpdates()` を実行する。実行中は多重実行を禁止し、progressを表示する。
完了後は `updatingIDs` / `removedIDs` またはエラーを画面内に残し、診断を
再読込する。更新対象に入ったpackがまだreadyでない場合は「download処理中の
可能性あり」と表示し、右上の更新アイコンで再確認できるようにする。

manifestを読めた場合は、pack全体がreadyでなくても各assetの状態一覧を表示する。
pathやエラー詳細はコピー可能にする。長い例外文字列をそのまま主要UIへ流さず、
折返し可能な開発者向け詳細として表示する。

## エラー処理

- 診断APIは想定される未取得・不整合を結果として返す。
- API境界やschemaの予期しない失敗だけを例外にする。
- 更新APIのAppleエラーはdomain/codeを保持し、再試行可否を推測しない。
- 固定値やbundled dataへのフォールバックは追加しない。
- 通常の地図・parameter読込契約は変更しない。

## テスト

### Swift

- 各診断状態への分類
- manifest JSON不正、assets空、path欠落
- 複数assetの欠落・サイズ不一致収集
- `checkForUpdates()` の成功・エラーcompletion

Apple frameworkを直接差し替えられない箇所は、ファイル検証と結果構築を
小さな依存境界に分離し、fixture directoryで検証する。

### Dart package

- 診断JSONの全状態のdecode
- 未知schema versionと必須値欠落
- 更新成功・Apple APIエラーの変換

### Flutter app

- providerが途中状態のasset一覧を保持すること
- Mutation実行中・成功・失敗
- 未取得理由、native error、asset欠落、size不一致のWidget表示
- refreshは診断再読込のみ、操作ボタンだけが更新APIを呼ぶこと
- text scale拡大時にoverflowしないこと

## 完了条件

- TestFlight端末で「未取得」以外の具体的な失敗段階を確認できる。
- 更新確認の開始、API応答、Apple APIエラー、端末上の取得完了が区別できる。
- 診断再読込だけではAsset Packの状態を変更しない。
- 既存の通常読込、Android、macOSの挙動が変わらない。
