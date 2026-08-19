import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_comments_model.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_detail_model.freezed.dart';

/// 電文詳細のドメインモデル
///
/// [earthquakeBody] は電文タイプが EARTHQUAKE の場合のみ値を持つ。
@freezed
abstract class TelegramDetailModel with _$TelegramDetailModel {
  const factory({
    EarthquakeTelegramBodyModel? earthquakeBody,
    TelegramCommentsModel? comments,
  }) = _TelegramDetailModel;
}

extension TelegramDetailResponseApiExtension on api.TelegramDetailResponse {
  TelegramDetailModel toTelegramDetailModel() {
    final body = telegram.body;
    return TelegramDetailModel(
      earthquakeBody: body is api.TelegramBodyUnionEarthquakeTelegramBody
          ? body.toEarthquakeTelegramBodyModel()
          : null,
      comments: comments?.toTelegramCommentsModel(),
    );
  }
}
