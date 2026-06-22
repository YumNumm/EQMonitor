import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_telegram_meta.freezed.dart';

@freezed
abstract class TsunamiTelegramMeta with _$TsunamiTelegramMeta {
  const factory TsunamiTelegramMeta({
    required String telegramId,
    required int? serialNo,
    required String title,
    required String? headline,
    required DateTime publishedAt,
    required DateTime reportedAt,
    required DateTime? targetedAt,
    required DateTime? revokedAt,
    required String infoKind,
  }) = _TsunamiTelegramMeta;
}

extension LatestTelegramApiExt on api.LatestTelegram {
  TsunamiTelegramMeta toTelegramMeta() => TsunamiTelegramMeta(
    telegramId: id,
    serialNo: serialNo?.toInt(),
    title: title,
    headline: headline,
    publishedAt: pressedAt,
    reportedAt: reportedAt,
    targetedAt: targetedAt,
    revokedAt: revokedAt,
    infoKind: infoKind,
  );
}
