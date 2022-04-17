class EEWSecurity {
  /// realm
  final String? realm;

  /// ハッシュ値
  final String? hash;

  EEWSecurity({
    required this.realm,
    required this.hash,
  });

  EEWSecurity.fromJson(Map<String, dynamic> j)
      : realm = (j['realm'].toString() == '') ? null : j['realm'].toString(),
        hash = (j['hash'].toString() == '') ? null : j['hash'].toString();
}
