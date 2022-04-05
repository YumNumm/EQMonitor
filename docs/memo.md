## SharedPrefrences
|type|key|description|
|---|---|---|
|`bool`|`notifFirstReport`|第1報を通知するかどうか|
|`bool`|`notifLastReport`|最終報を通知するかどうか|
|`bool`|`notifOnUpdate`|マグニチュードもしくは、震度が修正された際に通知|
|`bool`|`notifOnUpwardUpdate`|マグニチュードもしくは、震度が上方修正された際に通知|
|||
残りの部分(ex.`震度速報`や`震源に関する情報`は、Androidの設定からでもいじれるので後回し

## SecureStorage
|key|value|
|---|---|
|AT|Twitter APIのAccess Token|
|AS|Twitter APIのAccess Secret|