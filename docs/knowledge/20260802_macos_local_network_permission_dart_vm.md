# 実機デバッグで Dart VM に接続できない: macOS のローカルネットワーク権限

## 症状

`flutter run` で実機（iOS）にビルド・インストールまでは成功するが、デバッガが接続できない。

```
Flutter could not access the local network.

Please ensure your IDE or terminal app has permission to access devices on the local network.
You can grant this permission in System Settings > Privacy & Security > Local Network.

SocketException: Send failed (OS Error: No route to host, errno = 65), address = 0.0.0.0, port = 5353
Error connecting to the service protocol: failed to connect to http://127.0.0.1:<port>/<token>/
HttpException: Connection reset by peer
```

アプリ自体は端末上で起動しており、デバイスログも流れてくるため
「起動していないように見えて、実は attach だけ失敗している」状態になる。

## 原因

macOS 15 以降の **Local Network Privacy**。
`flutter` を起動したアプリ（ターミナル / Cursor / VS Code / Android Studio）に
ローカルネットワークアクセス権限が無いと、OS がローカルサブネット宛と
マルチキャスト宛の送信を `EHOSTUNREACH (errno 65)` で落とす。

Flutter は Dart VM Service の URL を mDNS（`_dartVmService._tcp` / 224.0.0.251:5353）で
探索するため、この時点で失敗する。

**重要:** この権限は TCC ではないため `tccutil` では操作できない。
GUI（システム設定）で手動許可するしかない。

## 切り分け方法

`dns-sd` は mDNSResponder デーモン経由なので成功してしまい、切り分けに使えない。
Dart プロセスから直接 UDP 送信して判定する。

```dart
// /tmp/probe.dart
import 'dart:io';

Future<void> main() async {
  for (final target in ['192.168.1.1', '8.8.8.8', '224.0.0.251']) {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final sent = socket.send([0], InternetAddress(target), 53);
    stdout.writeln('$target -> ${sent > 0 ? "OK" : "BLOCKED"}');
    socket.close();
  }
}
```

```bash
mise exec -- dart /tmp/probe.dart
```

- インターネット宛（8.8.8.8）は OK / **LAN 宛とマルチキャスト宛だけ BLOCKED** → 権限が原因で確定
- すべて BLOCKED → 権限ではなくルーティング・ファイアウォールを疑う

ルーティングやファイアウォールは以下で確認する（今回はいずれも正常だった）。

```bash
route -n get 224.0.0.251
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
```

## 対処

システム設定 > プライバシーとセキュリティ > ローカルネットワーク で、
**`flutter` を起動するアプリすべて**をオンにする。

- ターミナルから実行する場合: Terminal / iTerm / Ghostty など
- エディタの Run/Debug から実行する場合: Cursor / VS Code / Android Studio
- Xcode から実行する場合: Xcode

すでにオンなのに直らない場合は、オフ → オン → **アプリを再起動**する。
それでも直らなければ Mac と実機を再起動する。

一覧にアプリが出てこない場合は、そのアプリから一度 `flutter run` を実行して
OS にプロンプトを出させる（初回アクセス時に登録される）。

## 備考

- `flutter attach --verbose` のログで `MDnsClient.lookup` のスタックトレースが出れば同じ原因。
- mDNS が失敗すると Flutter はデバイスログ解析 + ポートフォワードにフォールバックするが、
  こちらも不安定で `Connection reset by peer` になりやすい。根本解決は権限付与。
- 参考: [flutter/flutter#150131](https://github.com/flutter/flutter/issues/150131),
  [flutter/flutter#166843](https://github.com/flutter/flutter/issues/166843)
