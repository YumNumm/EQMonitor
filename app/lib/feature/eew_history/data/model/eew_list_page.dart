import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_list_page.freezed.dart';

@freezed
abstract class EewListPage with _$EewListPage {
  const factory({
    required List<EewTelegramItem> items,
    required String? nextToken,
  }) = _EewListPage;
}
