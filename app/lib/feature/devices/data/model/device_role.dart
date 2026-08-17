/// Device API が返すデバイス所有者のロール。
///
/// backend では better-auth の `user.role` として管理されており、
/// `role === 'admin'` のみが管理者向け機能の判定に使われる。
enum DeviceRole {
  admin('admin'),
  user('user');

  new(this.value);

  final String value;

  /// API の値から [DeviceRole] へ変換する。
  ///
  /// 未知の値・未提供(null)は、権限を推測せず null を返す。
  static DeviceRole? fromApiValue(String? value) => switch (value) {
    'admin' => DeviceRole.admin,
    'user' => DeviceRole.user,
    _ => null,
  };
}
