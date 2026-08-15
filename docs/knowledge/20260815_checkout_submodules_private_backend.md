# `actions/checkout` の `submodules: true` は private backend も掴む

## 結論

CI の checkout で `submodules: true` を使ってはいけない。`third_party/flutter_scene`
が必要なジョブは composite action
`./.github/actions/init-flutter-scene-submodule` を使う。

```yaml
- name: Checkout repository
  uses: actions/checkout@... # v7.0.1
  with:
    persist-credentials: false

# third_party/flutter_scene は pubspec の path 依存なので pub 解決に必須
- name: Init flutter_scene submodule
  uses: ./.github/actions/init-flutter-scene-submodule
```

## 理由

`.gitmodules` には 2 つの submodule が登録されている。

| path | url | 可視性 |
| --- | --- | --- |
| `backend` | `git@github.com:YumNumm/eqmonitor-backend.git` | private |
| `third_party/flutter_scene` | `https://github.com/YumNumm/flutter_scene.git` | public |

`submodules: true` は `.gitmodules` の**全 submodule**を対象にするため、
リポジトリスコープしか持たない `GITHUB_TOKEN` では private な `backend` の clone が
404 になり、checkout ステップごと失敗する。

```
fatal: repository 'https://github.com/YumNumm/eqmonitor-backend.git/' not found
fatal: clone of 'git@github.com:YumNumm/eqmonitor-backend.git' into submodule path '.../backend' failed
```

`submodules: recursive` → `true` に落としても回避できない。`backend` は nested ではなく
トップレベルの submodule であるため。

`backend` は pub workspace（root `pubspec.yaml` の `workspace:`）に含まれないので、
`dart pub get` / `flutter pub get` / `dart analyze` には不要。
public な `flutter_scene` のみ個別に取れば認証は要らない。

## backend が本当に必要なジョブ

`wc-check-integration.yaml` のみ（api-stub を node で起動するため）。ここは
`actions/create-github-app-token` で `YumNumm/eqmonitor-backend` に
`contents:read` のトークンを発行し、`submodules: true` + `token:` を使う。
GitHub App が対象リポジトリへ install されていることが前提。

## ローカル手順との一致

`CLAUDE.md` の Setup も同じで、submodule はパス指定で初期化する。

```bash
git submodule update --init third_party/flutter_scene
```

初期化しないと `pub get` が `path` 依存を解決できずに失敗する。

## 履歴

952093de9（#1602 準備）で `submodules: true` を 6 箇所へ追加した結果、
`PR Flutter Check` と `Deploy App` が全滅した。#1648 で composite action へ置換。
