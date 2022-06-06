import 'package:eqmonitor/api/earthquake_history.dart';
import 'package:eqmonitor/state/cities.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';

import '../model/db/eq_history.schema.dart';
import '../model/eq_histroy.model.dart';

class EqHistoryNotifier extends StateNotifier<EQHistoryModel> {
  EqHistoryNotifier(this.isar)
      : super(
          EQHistoryModel(
            isar: isar,
            content:
                isar.eQHistorys.where().typeEqualTo('VXSE53').findAllSync(),
          ),
        ) {
    _onInit();
  }

  final Isar isar;
  final EarthQuakeHistoryApi _eqApi = EarthQuakeHistoryApi();
  final Logger _logger = Logger();

  // 処理
  Future<void> _onInit() async {
    // API経由でRemoteDBにある電文の総数を取得
    final totalRemoteDBCount = await _eqApi.fetchCount();
    if (totalRemoteDBCount == null) {
      throw Exception('電文データの同期に失敗しました');
    }
    // RemoteDBとLocalDBの電文の総数が合致しない場合は取得
    if (isar.eQHistorys.countSync() != totalRemoteDBCount) {
      final toInsert = <EQHistory>[];
      for (final toGetFileid
          in List<int>.generate(totalRemoteDBCount ~/ 100, (i) => i)) {
        final fetchedData = await _eqApi.fetch(toGetFileid);

        fetchedData?.forEach((e) {
          toInsert.add(
            EQHistory()
              ..id = e.hashCode
              ..hash = e.hash
              ..type = e.type
              ..time = e.time
              ..url = e.url
              ..imageUrl = e.imageUrl
              ..headline = e.headline
              ..maxint = e.maxint
              ..magnitude = e.magnitude
              ..magnitudeCondition = e.magnitudeCondition
              ..depth = e.depth
              ..lat = e.lat
              ..lon = e.lon
              ..serialNo = e.serialNo
              ..hypoName = e.hypoName,
          );
        });
        print(toInsert.length);
      }
      final res = await isar.writeTxn<List<int>>((isar) async {
        return await isar.eQHistorys.putAll(toInsert);
      });
    }
    _logger.w(isar.eQHistorys.countSync());
    // 完了したので、すべての電文がLocalDBにも、EQHistoryModel.contentにも配置されています
  }
}

final eqHistroyProvider =
    StateNotifierProvider<EqHistoryNotifier, EQHistoryModel>((ref) {
  return EqHistoryNotifier(ref.watch(isarProvider));
});
