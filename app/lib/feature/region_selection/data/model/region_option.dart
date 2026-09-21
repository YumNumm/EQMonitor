import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_option.freezed.dart';

enum RegionKind { prefecture, region, eewRegion, city, epicenter, station }

extension RegionKindLabel on RegionKind {
  String get label => switch (this) {
    .prefecture => '都道府県',
    .region => '細分化地域',
    .eewRegion => '通知地域',
    .city => '市区町村',
    .epicenter => '震央地名',
    .station => '観測点',
  };
}

@freezed
abstract class RegionOption with _$RegionOption {
  const new _();

  const factory({
    required RegionKind kind,
    required String code,
    required String name,
    String? kana,
    String? englishName,
    RegionKind? parentKind,
    String? parentCode,
    String? parentName,
    String? prefectureCode,
  }) = _RegionOption;

  /// 通知では同一市区町村が複数のEEW区域に属し得る。
  String get identity =>
      '${kind.name}:$code:${parentKind == .eewRegion ? parentCode : ''}';
}
