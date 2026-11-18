# sheet

[YumNumm/modal_bottom_sheet](https://github.com/YumNumm/modal_bottom_sheet) の `sheet` パッケージを、
コミット `f5be540e399a82ee94b0b4195a3d33095b5821db` の内容のまま取り込んだものである。
`lib/`・`LICENSE`・`pubspec.yaml` は元のファイルから変更していない。

## 取り込んだ理由

Dart 3.15 の `pub get` は、Git 依存のリポジトリにリポジトリ外を指すシンボリックリンクがあると取得を拒否する。
上記リポジトリは `.fvm/flutter_sdk` に開発者の端末の絶対パスを指すリンクを含むため、
pub キャッシュが空の環境（CI など）で `pub get` が失敗する。

## Git 依存へ戻す条件

上記リポジトリから `.fvm/flutter_sdk` を削除すれば、`app/pubspec.yaml` の `sheet` を Git 依存へ戻し、
このディレクトリを削除できる。
