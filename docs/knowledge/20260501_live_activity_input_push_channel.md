# Live Activity の Broadcast 更新チャンネル指定

iOS Live Activity を push-to-start で開始し、その後 APNs Broadcast で update/end を届ける場合、開始リクエストでは更新チャンネルを `input-push-channel` ヘッダーで指定する。

```http
POST /3/device/{pushToStartToken}
apns-push-type: liveactivity
apns-topic: {bundleId}.push-type.liveactivity
input-push-channel: {apnsChannelId}
```

`apns-channel-id` は Broadcast 更新やチャンネル管理 API で使うヘッダーであり、開始リクエストの購読チャンネル指定として使わない。開始時に `apns-channel-id` を送ってしまうと Live Activity 自体は開始できても、Broadcast の `update` / `end` を受け取れず、画面上の Live Activity が終了しない原因になる。

確認観点:

```bash
rg -n "input-push-channel|apns-channel-id" backend/service/notification-resolver backend/service/redis-manager backend/service/notification-sender
```
