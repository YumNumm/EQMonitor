import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// Device API が返すデバイスのロール。
///
/// backend は環境変数 `ADMIN_DEVICE_IDS`(デバイス ID のカンマ区切り)に
/// 列挙されたデバイスにのみ `ADMIN` を返し、それ以外は `USER` を返す。
/// 管理者向け機能のゲートには [DeviceRole.admin] のみを使う。
enum DeviceRole {
  admin('ADMIN'),
  user('USER');

  new(this.value);

  /// API が返すロールの値。デバッグ画面での表示にも使う。
  final String value;
}

extension DeviceRoleApiExtension on api.DeviceRole {
  DeviceRole get toDeviceRole => switch (this) {
    .admin => .admin,
    .user => .user,
  };
}
