class EEWResult {
  /// ステータス
  final String? status;

  /// メッセージ
  final String? message;

  /// * EEW情報を持っているかどうか
  final bool hasData;

  EEWResult({
    required this.status,
    required this.message,
    required this.hasData,
  });

  EEWResult.fromJson(Map<String, dynamic> j)
      : status = (j['status'].toString() == '') ? null : j['status'].toString(),
        message =
            (j['message'].toString() == '') ? null : j['message'].toString(),
        hasData = j['message'].toString() == '';
}
