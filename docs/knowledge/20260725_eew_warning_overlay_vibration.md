# EEW警報overlayの端末振動

## 実装上の前提

- Android は `app/android/app/src/main/AndroidManifest.xml` に
  `android.permission.VIBRATE` が既に宣言されている。重複追加しない。
- iOS の端末振動には `Info.plist` の usage description は不要である。
- OS設定、端末能力、plugin呼び出しの失敗で振動できなくても、警報UIの表示は
  継続する。振動serviceは例外をtalkerへ記録し、呼び出し元へ送出しない。
- custom pattern対応端末では、700msの振動を10回、間に300msの停止を9回入れる。
  patternは9700msで有限に終了させ、停止処理の失敗時も無期限に振動させない。
- custom pattern非対応端末では700msの振動を1回だけ実行する。

## 実機確認

接続端末を確認し、アプリを実機起動する。

```bash
cd app
mise exec -- flutter devices
mise exec -- flutter run -d <device-id>
```

設定画面のEEW警報overlayシミュレーションを開始し、振動開始を確認する。
全画面の閉じる操作、手動最小化、10秒経過、アプリのbackground移行の各操作で
振動が停止することも確認する。iOS Simulatorなど振動非対応環境では、UIが継続し
talkerに失敗が記録されてもアプリが終了しないことを確認する。
