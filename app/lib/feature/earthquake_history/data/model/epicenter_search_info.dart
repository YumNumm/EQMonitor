import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'epicenter_search_info.freezed.dart';
part 'epicenter_search_info.g.dart';

/// 震央情報（震央地検索結果用）
@freezed
abstract class EpicenterSearchInfo with _$EpicenterSearchInfo {
  const factory EpicenterSearchInfo({
    required int code,
    required String name,
  }) = _EpicenterSearchInfo;

  factory EpicenterSearchInfo.fromJson(Map<String, dynamic> json) =>
      _$EpicenterSearchInfoFromJson(json);
}

extension EpicenterInfoToApp on api.EpicenterInfo {
  EpicenterSearchInfo get toEpicenterSearchInfo => EpicenterSearchInfo(
    code: code.toInt(),
    name: name,
  );
}
