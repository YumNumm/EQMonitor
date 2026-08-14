# eqmonitor_map: remote PMTiles を per-chunk attestation で digest 束縛する

## 状態（2026-08-15 更新）

**whole-file digest による束縛は採らないと決めた。** reader の doc・
`VerifiedTileSource.sha256` の doc・negative test で「照合しない」ことを明示し、
恒久対策を per-chunk attestation（#1592 の signed sidecar）へ送った。

## 背景

`MapRemotePmTilesRandomAccessReader`（#1591 Task 8）は Range framing・identity
encoding・strong ETag の安定性・厳密 Content-Range・body 長を検証するが、
受信内容が `VerifiedRemotePmTilesSource.sha256` の attested archive と一致するかは
検証していない。CDN/origin が安定した ETag のまま別の archive を返すと通る。

`sha256` は archive **全体**の digest なので、照合するには全 `sizeBytes` を読む
必要がある。random-access reader の存在理由は全体を落とさないことなので、両者は
原理的に両立しない（全体を落として hash するなら local descriptor を使えばよい）。

設計書
`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md` は remote range
の信頼境界を HTTPS + allowlist host + strong ETag + identity encoding + 厳密
Content-Range と定義しており、whole-file digest 照合は要求していない。現状の
reader はこの定義を満たしている。

## 残る穴

ETag は「同一 URL への複数リクエスト間の整合性」しか保証しない。ETag 据え置きで
中身を差し替えた origin/CDN を reader は検出できない。

## やること（#1592 の sidecar 拡張が前提）

1. signed sidecar payload へ range 単位の attested digest（per-chunk digest または
   Merkle root + proof）を追加する。archive SHA-256 / byte size と同じ署名対象に
   含め、署名なしの変更を許さない。
2. app が sidecar を検証したうえで、chunk digest を
   `VerifiedRemotePmTilesSource` へ渡す。
3. reader は各 range 応答をその chunk digest と突き合わせ、不一致は
   `MapRemoteTile...` 系 typed exception で fail closed（空 tile へ丸めない）。
4. controlled server で「ETag 据え置き・内容だけ差し替え」の回帰テスト。既存の
   negative test `does not bind response bytes to source.sha256` を差し替える。

## 参照

- PR #1627 review コメント（P1: "Bind remote range responses to the expected digest"）
- `packages/eqmonitor_map/lib/src/tile/remote/map_remote_pm_tiles_reader.dart`
- Issue #1592（signed sidecar）/ #1591 / parent #1611
