# FCM 戦略

## Topic

本アプリにおける通知は、全て Firebase Cloud Messaging のTopic機能を利用して配信されます。

### Topicの種類

#### main group

- `all`: 全てのユーザーに配信されます。
- `dev`: 開発用

#### Earthquake related

- `eew_[id]`: 震度4以上の緊急地震速報(精度安定済み・地域ID)を受信 AreaForecastLocalEew
- `earthquake_[id]`: 当該地域で有感になった地震情報を受信 (震度速報、震源に関する情報、震源・震度に関する情報など) 任意のeventIdで配信されると、当該eventIdの地震情報を受信します。 AreaInformationPrefectureEarthquake

- `eew_all`: すべての緊急地震速報を受信
- `earthquake_all`: すべての地震情報を受信

#### Others

- `notice`: お知らせ (アップデート情報など) を受信 (重大な情報は選択の有無に関わらず配信されます)
- `notice_from_jma`: 気象庁からのお知らせ
