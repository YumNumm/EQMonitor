import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_item.freezed.dart';

@Freezed()
abstract class TelegramItem with _$TelegramItem {
  const factory({
    required String id,
    required String eventId,
    required TelegramType type,
    required String title,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required String editorialOffice,
    required List<String> publishingOffice,
    required DateTime pressAt,
    required DateTime reportAt,
    required String infoKind,
    required String infoKindVersion,
    required String hash,
    required DateTime createdAt,
    int? serialNo,
    DateTime? targetAt,
    DateTime? revokeAt,
    String? headline,
  }) = _TelegramItem;
}

extension ItemsApiExtension on api.TelegramPartial {
  TelegramItem get toTelegramItem => TelegramItem(
    id: id,
    eventId: eventId,
    type: type.toTelegramType,
    title: title,
    status: status.toTelegramStatus,
    infoType: infoType.toTelegramInfoType,
    editorialOffice: editorialOffice,
    publishingOffice: publishingOffice,
    pressAt: pressedAt,
    reportAt: reportedAt,
    infoKind: infoKind,
    infoKindVersion: infoKindVersion,
    hash: hash,
    createdAt: createdAt,
    serialNo: serialNo?.toInt(),
    targetAt: targetedAt,
    revokeAt: revokedAt,
    headline: headline,
  );
}
