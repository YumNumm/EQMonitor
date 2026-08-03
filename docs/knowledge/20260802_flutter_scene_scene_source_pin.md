# Flutter Sceneの`scene` source pin

Flutter Scene `7f71993b7e2a0ab1d2f59726a406098709be7291`は、同じmonorepo内の
`scene`と組み合わせて使う。hosted版や異なるrevisionへのfallbackは行わない。

固定revisionの正本は`packages/eqmonitor_map/pubspec.yaml`とroot
`pubspec.lock`である。packageの`dependency_overrides`で`scene`を同一repo、
同一revision、`packages/scene`へ固定する。

```yaml
dependency_overrides:
  scene:
    git:
      url: https://github.com/bdero/flutter_scene.git
      ref: 7f71993b7e2a0ab1d2f59726a406098709be7291
      path: packages/scene
```

依存関係を更新した後は、root lockfileの`flutter_scene`と`scene`が
どちらも同じ`resolved-ref`を持つことを確認する。

```bash
mise exec -- dart pub get --enforce-lockfile
rg -n -A 8 "^  (flutter_scene|scene):" pubspec.lock
```

Flutter Sceneがhosted `scene`の必要APIを持つversion/sourceを正しく宣言した
revisionへ更新できた場合のみ、overrideの削除を別changeで検討する。
