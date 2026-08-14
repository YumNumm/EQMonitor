# eqmonitor_map: remote PMTiles を検証済み digest へ束縛する

## 背景

`MapRemotePmTilesRandomAccessReader`（#1591 Task 8）は Range framing・identity
encoding・strong ETag の安定性・厳密 Content-Range・body 長を検証するが、
**受信内容が `VerifiedRemotePmTilesSource.sha256` の attested archive と一致するか**
は検証していない。

strong ETag は「同一 URL への複数リクエスト間の整合性」を保証するだけで、
attested asset との対応は保証しない。CDN/origin が安定した ETag のまま古い/別の
archive を返した場合、reader はそれを受理してしまう。

## やること

1. archive を open した後（または全 byte を読める文脈で）、検証済み範囲の
   digest を計算し `source.sha256` と突き合わせる。
   - full-archive digest は random-access reader の趣旨（部分取得）と相反するため、
     header + root directory など**取得済みの検証済み範囲**の digest を
     `source.sha256`（または別途 attested な部分 digest）と照合する設計を検討する。
   - 設計は `docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`
     の trust 境界と整合させる。
2. 不一致は typed exception（`MapRemoteTile...` 系）で fail closed。空 tile へ
   丸めない。
3. controlled server で「ETag 据え置き・内容だけ差し替え」を模した回帰テスト。

## 参照

- PR #1627 review コメント（P1: "Bind remote range responses to the expected digest"）
- `packages/eqmonitor_map/lib/src/tile/remote/map_remote_pm_tiles_reader.dart`
- Issue #1591 / parent #1611
