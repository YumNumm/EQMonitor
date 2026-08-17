enum SecureStorageKey {
  userId('user_id'),
  deviceToken('device_token'),
  hinetBosaiUserId('hinet_bosai_user_id'),
  hinetBosaiPassword('hinet_bosai_password'),
  knetBosaiUserId('knet_bosai_user_id'),
  knetBosaiPassword('knet_bosai_password');

  new(this.key);
  final String key;
}
