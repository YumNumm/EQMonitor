# Flutter Sceneの`scene` source pin

Flutter Sceneは同じmonorepo内の`scene`と組み合わせて使う。hosted版や異なる
revisionへのfallbackは行わない。

2026-08-15以降、source は fork `YumNumm/flutter_scene` の submodule
`third_party/flutter_scene`（#1602）であり、**固定revisionの正本は submodule の
commit**である。`packages/eqmonitor_map/pubspec.yaml`は`path`で参照するだけなので、
revisionを変えるときは submodule を動かして commit する。

```yaml
dependencies:
  flutter_scene:
    path: ../../third_party/flutter_scene/packages/flutter_scene
dependency_overrides:
  scene:
    path: ../../third_party/flutter_scene/packages/scene
```

依存関係を更新した後は、root lockfileの`flutter_scene`と`scene`が
どちらも submodule 配下の`path`を指すことを確認する。

```bash
git submodule status third_party/flutter_scene
mise exec -- dart pub get --enforce-lockfile
rg -n -A 6 "^  (flutter_scene|scene):" pubspec.lock
```

Flutter Sceneがhosted `scene`の必要APIを持つversion/sourceを正しく宣言した
revisionへ更新できた場合のみ、overrideの削除を別changeで検討する。

## 履歴

`7f71993b7e2a0ab1d2f59726a406098709be7291`までは`bdero/flutter_scene`への
git依存だった。#1602で永続 instance buffer と resource lifecycle API をfork側へ
追加するため、submodule + `path`依存へ移した。
