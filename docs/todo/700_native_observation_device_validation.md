# Native観測解析の端末検証

内部ビルドの `EQMONITOR_LOCAL_SHAKE=true` と既存の揺れ検知許可設定で有効化する。通常ビルドはNativeライブラリをロードしない。AndroidはjniLibs、iOSはignoredの `Flutter/NativeShake.xcconfig` を通して明示的に供給する。iOSは `EQMONITOR_NATIVE_SHAKE_LIBRARY=process` を指定する。

未実施: Android/iOSでのlink/startup、地震途中の初回画像、EEW取消、復帰、リプレイ終了時のセッション切替、画像種別変更、継続実行時の処理時間・メモリ・電力。実画像の正解付き精度評価も別途必要。Linux結合確認を実機検証の代用としない。

Nativeのカードと範囲はpresentation判断に従い、推定は品質条件を満たすものだけを既存カード内に表示する。通常の観測点描画は既存の画像解析経路を使用する。OS通知・検知音への接続は含めない。
