import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_model.freezed.dart';
part 'eew_model.g.dart';

@freezed
class EewWsItem with _$EewWsItem {
  const factory EewWsItem({
    required TelegramV3 telegram,
    required Vxse45 body,
  }) = _EewWsItem;

  factory EewWsItem.fromJson(Map<String, dynamic> json) =>
      _$EewWsItemFromJson(json);
}
