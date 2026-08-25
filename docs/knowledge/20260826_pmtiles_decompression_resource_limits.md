# PMTiles gzip展開にはencoded/decoded両方の上限を設ける

- PMTilesのroot/leaf directoryとtile payloadは、`gzip.decode`で一括展開しない。
- encoded長はrange readと展開の前、decoded長はchunkを蓄積する前に検証する。
- 上限値は汎用decoderへhidden defaultとして置かず、source ownerが
  `PmTilesV3Limits`へ明示する。
- 上限超過は`corruptArchive`へ丸めず`resourceLimitExceeded`として扱い、URL、
  payload、codec例外文をlogや`toString`へ含めない。
- per-tile上限だけでは並列展開の合計memoryを制限できない。callerの
  `maxInFlightDecodes`と掛け合わせ、aggregate budgetも別途設計する。

確認例:

```bash
rg -n 'gzip\.decode|compressionDecoder\.decode\(' packages/pmtiles_v3/lib
cd packages/pmtiles_v3
mise exec -- dart test
mise exec -- dart analyze --fatal-infos
```
