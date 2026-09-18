# 推計震度PMTilesのarchive identity確認

## 前提

推計震度PMTilesは、イベントIDだけのlegacy URLとcontent-addressed URLで同じbytesを返すとは
限らない。Flutter GPU mapはlegacy URLからSHA-256、size、header zoomを推測せず、APIが返す
immutable descriptorと取得後の実bytesを照合する。

2026-08-25にevent `20260823020050`を確認した時点では、REST APIの
`estimated_intensity_tile`はSHA-256をpathに含むURLを返した。一方、イベントIDだけの旧URLも
HTTP 200だったが、両者はsize、SHA-256、PMTiles headerのmin zoomが異なる別archiveだった。

- content-addressed URL: 1,013,133 bytes、path digestと実SHA-256が一致、PMTiles v3、MVT、
  gzip、min zoom 0、max zoom 14
- event-ID-only URL: 998,436 bytes、別SHA-256、PMTiles v3、MVT、gzip、min zoom 5、
  max zoom 14

このためevent-ID-only URLをfallbackやdescriptor validationへ使わない。実装とruntime gateは
REST descriptorが指すcontent-addressed URLだけを、exact sizeとSHA-256の全件stream検証後に開く。

## 再確認コマンド

redirectを追わず、最初にheaderとsizeを確認する。

```bash
curl --fail --silent --show-error --max-redirs 0 --head \
  "${ARCHIVE_URL}"
```

一時領域へ取得し、sizeとSHA-256を確認する。`ARCHIVE_URL`は実行時のAPI responseから取り、
ソースコードへ固定しない。

```bash
ARCHIVE_FILE="$(mktemp /tmp/eqmonitor-estimated-intensity.XXXXXX)"
curl --fail --silent --show-error --max-redirs 0 \
  --output "${ARCHIVE_FILE}" "${ARCHIVE_URL}"
stat -f '%z bytes' "${ARCHIVE_FILE}"
shasum -a 256 "${ARCHIVE_FILE}"
xxd -s 96 -l 32 "${ARCHIVE_FILE}"
```

PMTiles v3 headerのoffset 96以降はclustered、internal compression、tile compression、tile type、
min zoom、max zoomの順である。raw byteの目視だけをproduction parserにせず、appでは
`PmTilesV3Archive.open`のtyped header validationを使う。

確認後はagentが作った一時fileだけを削除する。
