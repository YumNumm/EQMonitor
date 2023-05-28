import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_url_model.freezed.dart';
part 'telegram_url_model.g.dart';

@freezed
class TelegramUrlModel with _$TelegramUrlModel {
  const factory TelegramUrlModel({
    required String restApiUrl,
    required String wsApiUrl,
    required String? apiAuthorization,
  }) = _TelegramUrlModel;

  factory TelegramUrlModel.fromJson(Map<String, dynamic> json) =>
      _$TelegramUrlModelFromJson(json);
}
