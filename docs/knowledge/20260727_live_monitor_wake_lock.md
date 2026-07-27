# LiveMonitor の画面点灯維持

## 不変条件

- `wakelock_plus` を呼ぶのは、LiveMonitor の session・設定・アプリ lifecycle を監視する controller だけにする。
- 画面点灯を有効にするのは、LiveMonitor session が active、`keepScreenAwake` が有効、かつ lifecycle が `resumed` の場合だけにする。
- background 移行、LiveMonitor からの exit、または設定の無効化は、いずれも画面点灯の無効化へ収束させる。
- plugin 呼び出しは直列化し、処理中に状態が複数回変わった場合は generation で古い未実行状態を破棄する。enable の完了後に pause や exit が残っている場合は、続けて disable を完了する。
- adapter・queue・generation・適用済み状態は Riverpod の `Ref` に依存しない owner が保持する。queue の非同期区間から `Ref` を参照しない。
- owner Provider の lifetime 終了時は generation を進め、実行中の処理後に強制 disable を queue する。依存値による controller の再構築ごとに owner を破棄しない。
- 同じ desired state への plugin 呼び出しは重複させない。
- plugin の例外は talker に記録し、地震・緊急地震速報などの表示状態や UI のエラーへ置き換えない。

## 依存追加と検証

依存は `pubspec.yaml` を直接編集せず、`app/` で次を実行する。

```sh
mise exec -- flutter pub add wakelock_plus
```

provider の生成は `app/` で full build を実行する。

```sh
mise exec -- dart run build_runner build
```

現行の `build_runner` では限定した `--build-filter` を使うと、filter 外の追跡済み生成物が stale output として削除される場合がある。生成後は必ず `git status --short` と `git diff --stat` で対象外の削除がないことを確認する。

focused test と analyze はプロジェクトルートで実行する。

```sh
mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart
mise exec -- flutter analyze app/lib/feature/live_monitor app/lib/app.dart app/test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart
```

## iOS / Android の手動確認

iOS と Android の実機で、それぞれ次を確認する。

1. 画面点灯設定を有効にして LiveMonitor へ入り、端末の自動ロック時間を超えても画面が点灯している。
2. アプリを background に移すと画面点灯維持が解除され、foreground に戻ると LiveMonitor session 中だけ再び有効になる。
3. LiveMonitor から退出すると画面点灯維持が解除される。
4. LiveMonitor session 中に画面点灯設定を無効にすると、直ちに画面点灯維持が解除される。
5. background・foreground、設定変更、退出を短時間に繰り返しても、最後の状態と画面点灯状態が一致し、地震情報 UI がエラー表示へ変わらない。
