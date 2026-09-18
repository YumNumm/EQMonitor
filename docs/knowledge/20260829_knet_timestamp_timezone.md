# K-NET日時のtimezoneルール

- K-NET/KiK-netのディレクトリ名`YYYYMMDDHHmmss`はAsia/Tokyoの日時として解析する。
- `KnetDirectoryParser.parseRecords`は`TZDateTime`を返し、端末のtimezoneへ依存させない。
- 解析した日時は表示だけでなく、図・動画・波形ZIPのURLパス生成にも使われる。
- UTCの`DateTime`へ置き換えて日時成分を変えると、K-NET上のディレクトリ名と一致しなくなるため注意する。
- 利用前にtimezone DBを初期化する。アプリでは`core.initializeTimeZones()`を使う。

```bash
mise exec -- dart analyze packages/knet_api_client
mise -C packages/knet_api_client exec -- dart test
```
