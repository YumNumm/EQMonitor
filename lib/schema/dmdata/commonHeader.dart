/// # Schema head
/// 共通部分
class CommonHead {
  CommonHead({
    required this.originalId,
    required this.schema,
    required this.type,
    required this.title,
    required this.status,
    required this.infoType,
    required this.editoralOffice,
    required this.publishingOffice,
    required this.pressDateTime,
    required this.reportDateTime,
    required this.targetDateTime,
    required this.targetDateTimeDubious,
    required this.targetDuration,
    required this.validDateTime,
    required this.eventId,
    required this.serialNo,
    required this.infoKind,
    required this.infoKindVersion,
    required this.headline,
    required this.body,
  });
  CommonHead.fromJson(Map<String, dynamic> j)
      : originalId = j['_originalId'].toString(),
        schema =
            CommonHeadSchema.fromJson(j['_schema'] as Map<String, dynamic>),
        type = j['type'].toString(),
        title = j['title'].toString(),
        status = (j['status'].toString() == '通常')
            ? CommonHeadStatus.normal
            : (j['status'].toString() == '訓練')
                ? CommonHeadStatus.training
                : CommonHeadStatus.test,
        infoType = (j['infoType'].toString() == '発表')
            ? CommonHeadInfoType.announcement
            : (j['infoType'].toString() == '訂正')
                ? CommonHeadInfoType.correction
                : (j['infoType'].toString() == '遅延')
                    ? CommonHeadInfoType.delay
                    : CommonHeadInfoType.cancel,
        editoralOffice = j['editorialOffice'].toString(),
        publishingOffice = List<String>.generate(
          (j['publishingOffice'] as List<dynamic>).length,
          (i) => j['publishingOffice'][i].toString(),
        ),
        pressDateTime = DateTime.parse(j['pressDateTime'].toString()),
        reportDateTime = DateTime.parse(j['reportDateTime'].toString()),
        targetDateTime = (j['targetDateTime'] == null)
            ? null
            : DateTime.parse(j['targetDateTime'].toString()),
        targetDateTimeDubious = (j['targetDateTimeDubious'] == null)
            ? null
            : j['targetDateTimeDubious'].toString(),
        targetDuration = (j['targetDuration'] == null)
            ? null
            : j['targetDuration'].toString(),
        validDateTime = (j['validDateTime'] == null)
            ? null
            : DateTime.parse(j['validDateTime'].toString()),
        eventId = (j['eventId'] == null) ? null : j['eventId'].toString(),
        serialNo = (j['serialNo'] == null) ? null : j['serialNo'].toString(),
        infoKind = j['infoKind'].toString(),
        infoKindVersion = j['infoKindVersion'].toString(),
        headline = (j['headline'] == null) ? null : j['headline'].toString(),
        body = j['body'] as Map<String, dynamic>;

  /// 基となったXMLデータの電文ID
  final String originalId;

  /// JSONスキーマ情報（内部利用）
  final CommonHeadSchema schema;

  /// 情報名称(Control/Title部)
  final String type;

  /// 情報の標題(Head/Title部)
  final String title;

  /// 情報の運用状態、取りうる値は`通常`,`訓練`,`試験`。
  /// 通常以外の情報につては内部利用にとどめること
  final CommonHeadStatus status;

  /// 情報の発表状態、取りうる値は`発表`,`訂正`,`遅延`,`取消`
  final CommonHeadInfoType infoType;

  /// 情報の編集官署名
  final String editoralOffice;

  /// 情報の発表官署名又は組織名、複数入る場合がある
  final List<String> publishingOffice;

  /// 情報作成時刻
  final DateTime pressDateTime;

  /// 情報の発表時刻
  final DateTime reportDateTime;

  ///情報の基となった時刻、無い場合はNullとする
  final DateTime? targetDateTime;

  /// 情報の基となった時刻のあいまいさ
  final String? targetDateTimeDubious;

  /// 情報の予報期間
  final String? targetDuration;

  /// 情報の失効時刻
  final DateTime? validDateTime;

  /// 現象ごとに割り振られたイベントID、無い場合はNullとする
  final String? eventId;

  /// 現象ごとに割り振られたイベントIDの発表番号、無い場合はNullとする
  final String? serialNo;

  /// XMLデータのスキーマ名
  final String infoKind;

  /// XMLデータのスキーマバージョン
  final String infoKindVersion;

  /// 情報の見出し、無い場合は`Null`とする
  final String? headline;

  /// 中身
  final Map<String, dynamic> body;
}

/// JSONスキーマ情報（内部利用）
class CommonHeadSchema {
  CommonHeadSchema({
    required this.type,
    required this.version,
  });
  CommonHeadSchema.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        version = j['version'].toString();

  /// JSONスキーマ名
  final String type;

  /// JSONスキーマバージョン
  final String version;
}

enum CommonHeadStatus {
  /// 通常
  normal,

  /// 訓練
  training,

  ///試験
  test,
}

enum CommonHeadInfoType {
  /// 発表
  announcement,

  /// 訂正
  correction,

  /// 遅延
  delay,

  /// 取消
  cancel,
}
