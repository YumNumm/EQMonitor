/// 取消時や付加的な情報がない場合は出現しません。
class Comments {
  Comments({
    required this.free,
    required this.forecast,
    required this.comments,
    required this.uri,
  });
  Comments.fromJson(Map<String, dynamic> j)
      : free = (j['free'] == null) ? null : j['free'].toString(),
        forecast = (j['forecast'] == null)
            ? null
            : Forecast.fromJson(j['forecast'] as Map<String, dynamic>),
        comments = (j['var'] == null)
            ? null
            : OtherComments.fromJson(j['var'] as Map<String, dynamic>),
        uri = (j['uri'] == null) ? null : j['uri'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (free != null) 'free': free.toString(),
        if (forecast != null) 'forecast': forecast!.toJson(),
        if (comments != null) 'comments': comments!.toJson(),
        if (uri != null) 'uri': uri.toString()
      };

  /// ## その他の付加的な情報を自由形式で記載する
  final String? free;

  /// ## 津波や緊急地震速報に関する情報を固定付加文の形式で記載する
  /// [#4.2. forecast](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#4-2-forecast)
  final Forecast? forecast;

  /// ## その他の付加的な情報を固定付加文の形式で記載する
  /// [#4.3. var](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#4-3-var)
  final OtherComments? comments;

  /// ## 詳細な情報を記載する気象庁HPへのURIを記載する
  /// VXSE62時のみ
  final String? uri;
}

class Forecast {
  Forecast({
    required this.text,
    required this.codes,
  });
  Forecast.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        codes = List<int>.generate(
          (j['codes'] as List<dynamic>).length,
          (i) => int.parse((j['codes'] as List<dynamic>)[i].toString()),
        );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'codes': codes,
      };

  /// ## 固定付加文を記載する。複数ある場合は改行コード 0x0A を区切りに挿入する
  final String text;

  /// ## 固定付加文をのコードを記載する
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final List<int> codes;
}

class OtherComments {
  OtherComments({
    required this.text,
    required this.codes,
  });
  OtherComments.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        codes = List<int>.generate(
          (j['codes'] as List<dynamic>).length,
          (i) => int.parse((j['codes'] as List<dynamic>)[i].toString()),
        );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'codes': codes,
      };

  /// ## 固定付加文を記載する。複数ある場合は改行コード 0x0A を区切りに挿入する
  final String text;

  /// ## 固定付加文をのコードを記載する
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final List<int> codes;
}
