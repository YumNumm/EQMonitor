# Earthquake Replay Package

[KyoshinEewViewerIngen](https://github.com/ingen084/KyoshinEewViewerIngen)の[EarthquakeReplay](https://github.com/ingen084/KyoshinEewViewerIngen/blob/529be3497505e8e4a1b262d76e666074d1f51e6d/src/KyoshinEewViewer.Core/Models/EarthquakeReplay/KyoshinReplayFileReader.cs)に準拠したファイルを読み込むパッケージです。

## 時刻の扱い

KyoshinEewViewerIngen は強震モニタ画像の JST の時刻を `DateTimeKind.Unspecified` のまま書き出し、MessagePack-CSharp は Unspecified を変換せず timestamp に格納する。
そのため EQRP の timestamp は「JST の壁時計を UTC として格納した値」である。
`ReplayDataParser` は読み込み時に 9 時間戻し、ヘッダと各フレームの時刻を実際の時刻（UTC）として返す。
EQRP を書き出す場合も同じ規約に従い、JST の壁時計を UTC として格納する。

EQMonitor 形式の EEW（Union 1003）は、EEW API が返す `EewItemWithRelations` の JSON をそのまま格納する。JSON 内の時刻は実際の時刻（UTC）である。
