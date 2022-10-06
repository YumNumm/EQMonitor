class Comments {
  Comments({required this.free, required this.warning});
  Comments.fromJson(Map<String, dynamic> j)
      : free = (j['free'] == null) ? null : j['free'].toString(),
        warning = (j['warning'] == null)
            ? null
            : Warning.fromJson(j['warning'] as Map<String, dynamic>);

  /// その他の付加的な情報を自由形式で記載する
  final String? free;

  /// 津波や緊急地震速報に関する情報を固定付加文の形式で記載する
  /// #4.2. warning
  final Warning? warning;
}

class Warning {
  Warning({required this.text, required this.codes});
  Warning.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        codes = List<int>.generate(
          (j['codes'] as List<dynamic>).length,
          (index) => int.parse((j['codes'] as List<dynamic>)[index].toString()),
        );

  /// 固定付加文を記載する。複数ある場合は改行コード 0x0A を区切りに挿入する
  final String text;

  /// 固定付加文をのコードを記載する
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final List<int> codes;
}
