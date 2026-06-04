enum SecureStorageKey {
  userId('user_id'),
  deviceToken('device_token'),
  ;

  const SecureStorageKey(this.key);
  final String key;
}
