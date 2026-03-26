enum SecureStorageKey {
  sessionToken('SESSION_TOKEN'),
  userId('user_id'),
  ;

  const SecureStorageKey(this.key);
  final String key;
}
