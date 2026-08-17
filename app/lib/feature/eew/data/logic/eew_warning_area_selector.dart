import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_area_selector.g.dart';

@riverpod
EewWarningAreaSelector eewWarningAreaSelector(Ref ref) =>
    const EewWarningAreaSelector();

class EewWarningAreaSelector {
  const new();

  List<String> selectPrefectureCodes({
    required Iterable<EewTelegramItem> events,
  }) => {
    for (final event in events)
      if (event.isWarning == true && !event.isCanceled)
        for (final prefecture
            in event.warning?.prefectures ?? const <EewWarningZoneInfo>[])
          prefecture.code,
  }.toList(growable: false);
}
