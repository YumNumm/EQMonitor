import 'package:eqapi_types/src/model/v2/eew/eew_accuracy.dart';
import 'package:eqapi_types/src/model/v2/eew/eew_hypocenter.dart';
import 'package:eqapi_types/src/model/v2/eew/eew_intensity.dart';
import 'package:eqapi_types/src/model/v2/eew/eew_warning.dart';
import 'package:eqapi_types/src/model/v2/enum/telegram_info_type.dart';
import 'package:eqapi_types/src/model/v2/enum/telegram_status.dart';
import 'package:eqapi_types/src/model/v2/enum/telegram_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_item.freezed.dart';
part 'eew_item.g.dart';

/// EEW基本情報
@freezed
abstract class EewItem with _$EewItem {
  const factory EewItem({
    /// yyyyMMddHHmmss形式のイベントID
    required String eventId,
    required TelegramType type,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required int serialNo,
    String? headline,
    required bool isCanceled,
    bool? isWarning,
    required bool isLastInfo,
    DateTime? originTime,
    DateTime? arrivalTime,
    EewHypocenter? hypocenter,
    EewIntensity? forecastIntensity,
    EewAccuracy? accuracy,
    required bool isPlum,
    String? editorialOffice,
    required DateTime reportTime,
  }) = _EewItem;

  factory EewItem.fromJson(Map<String, dynamic> json) =>
      _$EewItemFromJson(json);
}

/// 関連データ付きのEEW
@freezed
abstract class EewItemWithRelations with _$EewItemWithRelations {
  const factory EewItemWithRelations({
    /// yyyyMMddHHmmss形式のイベントID
    required String eventId,
    required TelegramType type,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required int serialNo,
    String? headline,
    required bool isCanceled,
    bool? isWarning,
    required bool isLastInfo,
    DateTime? originTime,
    DateTime? arrivalTime,
    EewHypocenter? hypocenter,
    EewIntensity? forecastIntensity,
    EewAccuracy? accuracy,
    required bool isPlum,
    String? editorialOffice,
    required DateTime reportTime,
    required List<EewIntensityItem> intensityRegions,
    EewWarning? warning,
  }) = _EewItemWithRelations;

  factory EewItemWithRelations.fromJson(Map<String, dynamic> json) =>
      _$EewItemWithRelationsFromJson(json);
}
