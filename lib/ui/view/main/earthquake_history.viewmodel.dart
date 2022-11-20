import 'package:collection/collection.dart';
import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:eqmonitor/api/remote/supabase/telegram.dart';
import 'package:eqmonitor/provider/init/talker.dart';
import 'package:eqmonitor/schema/remote/dmdata/commonHeader.dart';
import 'package:eqmonitor/utils/talker_log/log_types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// EventIDごとにまとめた地震情報
class EarthquakeHistoryItem {
  EarthquakeHistoryItem({
    required this.id,
    required this.isSokuhou,
    required this.component,
    required this.intensity,
    required this.comments,
  });

  final int id;

  /// 速報かどうか
  final bool isSokuhou;

  /// 震源要素
  /// VXSE61 -> VXSE53 -> VXSE52
  final EarthquakeComponent? component;

  /// 各地の震度
  /// VXSE53 -> VXSE51
  final EarthquakeInformationIntensity? intensity;

  /// コメント
  final List<EarthquakeInformationComments> comments;
}

final earthquakeHistoryViewModel = StateNotifierProvider<
    EarthquakeHistoryViewModel, AsyncValue<List<EarthquakeHistoryItem>>>(
  EarthquakeHistoryViewModel.new,
);

class EarthquakeHistoryViewModel
    extends StateNotifier<AsyncValue<List<EarthquakeHistoryItem>>> {
  EarthquakeHistoryViewModel(this.ref) : super(const AsyncValue.loading()) {
    talker = ref.watch(talkerProvider);
    fetch();
  }

  final Ref ref;

  late Talker talker;

  /// 電文保管用
  final List<TelegramItem> _telegrams = [];

  /// 追加読み込み
  Future<void> fetch() async {
    state = const AsyncLoading<List<EarthquakeHistoryItem>>()
        .copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      // Telegramを取得
      final telegrams = await TelegramApi.getTelegramsRangeV2(
        offset: _telegrams.length,
      );

      _telegrams.addAll(telegrams);

      // 解析
      // EventIdごとにまとめる
      final grouped = _telegrams.groupListsBy(
        (e) => int.tryParse(e.telegram.eventId.toString()) ?? 0,
      );

      final toState = <EarthquakeHistoryItem>[];

      // 各EventIdごとに処理していく
      grouped.forEach(
        (eventId, items) {
          final vxse51Telegrams = <CommonHead>[];
          final vxse52Telegrams = <CommonHead>[];
          final vxse53Telegrams = <CommonHead>[];
          final vxse61Telegrams = <CommonHead>[];

          for (final e in items) {
            switch (e.type) {
              case 'VXSE51':
                vxse51Telegrams.add(e.telegram);
                break;
              case 'VXSE52':
                vxse52Telegrams.add(e.telegram);
                break;
              case 'VXSE53':
                vxse53Telegrams.add(e.telegram);
                break;
              case 'VXSE61':
                vxse61Telegrams.add(e.telegram);
                break;
            }
          }

          final latestVxse51Head =
              (vxse51Telegrams.isEmpty) ? null : vxse51Telegrams.last;
          final latestVxse51Info = (latestVxse51Head == null)
              ? null
              : EarthquakeInformation.fromJson(latestVxse51Head.body);
          final latestVxse52Head =
              (vxse52Telegrams.isEmpty) ? null : vxse52Telegrams.last;
          final latestVxse52Info = (latestVxse52Head == null)
              ? null
              : EarthquakeInformation.fromJson(latestVxse52Head.body);
          final latestVxse53Head =
              (vxse53Telegrams.isEmpty) ? null : vxse53Telegrams.last;
          final latestVxse53Info = (latestVxse53Head == null)
              ? null
              : EarthquakeInformation.fromJson(latestVxse53Head.body);
          final latestVxse61Head =
              (vxse61Telegrams.isEmpty) ? null : vxse61Telegrams.last;
          final latestVxse61Info = (latestVxse61Head == null)
              ? null
              : EarthquakeInformation.fromJson(latestVxse61Head.body);

          // 速報かどうか
          final isSokuhou =
              latestVxse61Head == null && latestVxse53Head == null;

          /// ## 震源要素
          /// VXSE61 -> VXSE53 -> VXSE52
          final component = latestVxse61Info?.earthquake ??
              latestVxse53Info?.earthquake ??
              latestVxse52Info?.earthquake;

          /// ## 各地の震度
          /// VXSE53 -> VXSE51
          final intensity =
              latestVxse53Info?.intensity ?? latestVxse51Info?.intensity;

          toState.add(
            EarthquakeHistoryItem(
              id: eventId,
              isSokuhou: isSokuhou,
              component: component,
              intensity: intensity,
              comments: [
                if (latestVxse61Info != null &&
                    latestVxse61Info.comments != null) ...[
                  latestVxse61Info.comments!
                ],
                if (latestVxse53Info != null &&
                    latestVxse53Info.comments != null) ...[
                  latestVxse53Info.comments!
                ],
                if (latestVxse52Info != null &&
                    latestVxse52Info.comments != null) ...[
                  latestVxse52Info.comments!
                ],
                if (latestVxse51Info != null &&
                    latestVxse51Info.comments != null) ...[
                  latestVxse51Info.comments!
                ],
              ],
            ),
          );
        },
      );
      talker.logTyped(EarthquakeHistoryLog('地震履歴を${toState.length}件取得しました'));
      return toState;
    });
  }

  void refresh() {
    _telegrams.clear();
      talker.logTyped(EarthquakeHistoryLog('地震履歴をクリアしました'));
    state = const AsyncValue.data([]);
    fetch();
  }

  void logError(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    talker.error(msg, exception, stackTrace);
  }
}
