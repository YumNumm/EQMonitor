import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/src/model/app_api/prefecture.dart';
import 'package:kyoshin_monitor_api/src/model/result.dart';
import 'package:kyoshin_monitor_api/src/model/security.dart';

part 'site_list.freezed.dart';
part 'site_list.g.dart';

@freezed
class SiteList with _$SiteList {
  const factory SiteList({
    /// 観測点一覧
    @JsonKey(name: 'items') List<Site>? sites,

    /// セキュリティ情報
    Security? security,

    /// 時間
    String? dataTime,

    /// リザルト
    Result? result,

    /// シリアル番号
    String? serialNo,
  }) = _SiteList;

  factory SiteList.fromJson(Map<String, dynamic> json) =>
      _$SiteListFromJson(json);
}

@freezed
class Site with _$Site {
  const factory Site({
    /// 不明(内部ID?)
    int? muni,

    /// RealtimeDataでのインデックス
    int? siteidx,

    /// 都道府県ID
    @JsonKey(name: 'pref') int? prefectureId,

    /// ID
    @JsonKey(name: 'siteid') String? siteId,

    /// 緯度
    double? lat,

    /// 経度
    double? lng,
  }) = _Site;
  const Site._();

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

  /// 都道府県
  Prefecture? get prefecture => Prefecture.fromId(prefectureId);
}
