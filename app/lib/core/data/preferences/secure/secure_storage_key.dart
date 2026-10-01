enum SecureStorageKey(final String key) {
  /// v2 の端末 JWT。旧 ID の回収と設定移行が完了するまで保持する。
  legacyApiToken('api_token'),
  userId('user_id'),
  deviceToken('device_token'),
  betterAuthSessionToken('better_auth_session_token'),
  hinetBosaiUserId('hinet_bosai_user_id'),
  hinetBosaiPassword('hinet_bosai_password'),
  knetBosaiUserId('knet_bosai_user_id'),
  knetBosaiPassword('knet_bosai_password'),
}
