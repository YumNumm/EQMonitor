# Beta Release Please の TestFlight リリースノート

## ルール

- `v*-beta.*` タグから iOS を配布する場合、TestFlight の「テスト内容」は
  `CHANGELOG.beta.md` の同じバージョンの節から生成する。
- 対象節の比較リンクは、直前の beta release から現在の beta release までを表す。
- 見出しと箇条書きは TestFlight 向けのプレーンテキストへ変換し、コミットリンクは除去する。
- TestFlight の上限に合わせて 4,000 文字以内に収め、末尾の `rev: <commit SHA>` は維持する。
- beta タグ以外の iOS 配布は、従来どおり App Store Connect の直前ビルドにある
  `rev:` を起点にする。Android の生成方法も変更しない。

## ローカル確認

```bash
GITHUB_REF_TYPE=tag \
GITHUB_REF_NAME=v3.0.0-beta.12 \
PLATFORM=ios \
OUTPUT_PATH=/tmp/release-notes-ios.txt \
bash scripts/ci/generate_release_note.sh

wc -m /tmp/release-notes-ios.txt
bash scripts/ci/test_generate_release_note.sh
```

対象タグと同名の節が `CHANGELOG.beta.md` に存在しない場合は、古い配布ノートへ
フォールバックせずジョブを失敗させる。Release Please の changelog 生成漏れを
そのまま TestFlight 配布へ持ち込まないためである。
