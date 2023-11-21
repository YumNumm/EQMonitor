# FCM 戦略

## Topic

本アプリにおける通知は、全て Firebase Cloud Messaging のTopic機能を利用して配信されます。

### Topicの種類
#### main group
- `all`: 全てのユーザーに配信されます。
- `dev`: 開発用

#### EEW group
- `eew_[id]`: 