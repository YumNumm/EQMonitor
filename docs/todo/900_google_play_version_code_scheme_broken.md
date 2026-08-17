# Google Play の versionCode 採番が破綻している

## 症状

`Deploy App` の `Deploy Android (Google Play)` が必ず失敗する。

```
Error: failed to upload bundle: googleapi: Error 403: Version code 1050 has already been used., forbidden
Error: failed to upload bundle: googleapi: Error 403: Version code 1051 has already been used., forbidden
```

- run 1050（develop への push / #1628 merge commit）: [31740641014](https://github.com/YumNumm/EQMonitor/actions/runs/31740641014)
- run 1051（workflow_dispatch / android のみ）: [31742867528](https://github.com/YumNumm/EQMonitor/actions/runs/31742867528)

いずれも `Build Android` は成功しており、**AAB のビルドは通っている**。
`Deploy Android (Firebase App Distribution)` も成功する。
Google Play への upload だけが versionCode 重複で 403 になる。

## 原因

`app/android/app/build.gradle.kts` の `versionCode = flutter.versionCode` は
`flutter build appbundle --build-number=...` の値をそのまま使う。
`.github/workflows/deploy-app.yaml` はこれに **`github.run_number` をそのまま渡している**。

```yaml
      - name: Build Android (AAB)
        env:
          BUILD_NUMBER: ${{ github.run_number }}
```

`github.run_number` は現在 1050 前後だが、Google Play 側には既に
1051 以上の versionCode が存在する。run_number は Play の採番より遅れており、
**このままでは今後どの run でも versionCode 重複で必ず失敗する**。

さらに、本来の「最新 + 1」ロジックは死んでいる。
`Extract keystore` ステップに以下が残っているが、`LATEST_BUILD_NUMBER` は
ワークフロー中のどこでも定義されておらず、出力 `BUILD_NUMBER` も参照されていない。

```yaml
      - name: Extract keystore
        run: |
          ...
          BUILD_NUMBER=$((LATEST_BUILD_NUMBER + 1))     # LATEST_BUILD_NUMBER が未定義
          echo "BUILD_NUMBER=${BUILD_NUMBER}" >> "$GITHUB_OUTPUT"   # 誰も使っていない
```

## 対応方針（オーナー判断が必要）

versionCode は **一度使うと二度と再利用できない**ため、採番方式の変更は
リリース運用の判断を伴う。以下のいずれかを選ぶ必要がある。

1. Google Play の現在の最大 versionCode を取得し、`+1` を渡す
   （`google-play-cli` で最新 versionCode を取得するステップを追加し、
   死んでいる `LATEST_BUILD_NUMBER` ロジックを復活させる）
2. `github.run_number` に十分大きなオフセットを足して Play の最大値を超えさせる
3. `versionCode` を日時ベース（例: `yyMMddHH`）などの単調増加値に切り替える

現在の Play 上の最大 versionCode を確認してから決めること。

```bash
# Play 上の versionCode を確認する（要 Play 権限）
google-play-cli bundles list --package-name net.yumnumm.eqmonitor
```

## 補足

この問題はアプリのコンパイルとは無関係で、
Dart 3.14 のコンパイルエラー修正（#1628）以前から潜在していた。
#1628 で `Build Android` / `Build iOS` が復旧したことで初めて表面化した。
