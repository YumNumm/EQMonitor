import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_configuration_model.freezed.dart';
part 'home_configuration_model.g.dart';

/// ホームの地震履歴カードで表示する対象
@JsonEnum(alwaysCreate: true)
enum HomeEarthquakeHistoryScope {
  /// 全国の地震一覧
  @JsonValue('nationwide')
  nationwide,

  /// 現在地（市区町村）に関連する地震
  @JsonValue('currentLocation')
  currentLocation,

  /// 設定で指定した地域
  @JsonValue('designatedRegion')
  designatedRegion,
}

@freezed
abstract class HomeConfigurationModel with _$HomeConfigurationModel {
  const factory HomeConfigurationModel({
    /// 位置情報を表示するかどうか
    @Default(false) bool showLocation,

    /// ホーム地震履歴の表示スコープ
    @Default(HomeEarthquakeHistoryScope.nationwide)
    HomeEarthquakeHistoryScope earthquakeHistoryScope,
  }) = _HomeConfigurationModel;

  factory HomeConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$HomeConfigurationModelFromJson(json);
}
