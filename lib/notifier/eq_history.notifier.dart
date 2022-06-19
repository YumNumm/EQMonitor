import 'package:eqmonitor/api/earthquake_history.dart';
import 'package:eqmonitor/api/kmoni/JmaIntensity.dart';
import 'package:eqmonitor/main.dart';
import 'package:eqmonitor/model/eq_history_content.model.dart';
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
                isar.eQHistorys.filter().typeEqualTo('VXSE53').findAllSync(),
            intensities: JmaIntensity.values,
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
    if (dbContentsCount() != totalRemoteDBCount) {
      for (final toGetFileid
          in List<int>.generate(totalRemoteDBCount ~/ 100, (i) => i)) {
        final fetchedData = await _eqApi.fetch(toGetFileid);
        fetchedData?.forEach(addFromApiContent);

        if (dbContentsCount() == totalRemoteDBCount) return;
      }
    }
    // 完了したので、すべての電文がLocalDBにも、EQHistoryModel.contentにも配置されています
  }

  Future<void> _resetHistoryState() async {
    final contentList = await isar.eQHistorys
        .filter()
        .typeEqualTo('VXSE53')
        .sortByTimeDesc()
        .thenBySerialNo()
        .findAll();
    state = state.copyWith(
      content: contentList,
      intensities: JmaIntensity.values,
    );
  }

  Future<void> _reloadDB() async {
    final tmpContentList = await isar.eQHistorys
        .filter()
        .typeEqualTo('VXSE53')
        .sortByTimeDesc()
        .findAll();
    final contentList = <EQHistory>[];
    for (final e in tmpContentList) {
      if (state.intensities.contains(
        JmaIntensity.values.firstWhere(
          (el) => el.name == e.maxint,
          orElse: () => JmaIntensity.Error,
        ),
      )) {
        contentList.add(e);
      }
    }
    state.copyWith(content: contentList);
  }

  Future<void> addFromApiContent(EQHistoryContent e) async {
    final eqHistory = EQHistory()
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
      ..hypoName = e.hypoName;
    final val = await isar.writeTxn((isar) => isar.eQHistorys.put(eqHistory));
    await _resetHistoryState();
  }

  Future<void> addFromApiContentList(List<EQHistoryContent> elements) async {
    final toInsert = <EQHistory>[];
    for (final e in elements) {
      final eqHistory = EQHistory()
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
        ..hypoName = e.hypoName;
      toInsert.add(eqHistory);
    }
    await isar.writeTxn((isar) => isar.eQHistorys.putAll(toInsert));
    await _resetHistoryState();
  }

  List<JmaIntensity> get choosedIntensities => state.intensities;

  List<JmaIntensity> addIntensity(JmaIntensity jmaInt, bool add) {
    final latestIntensitiesList = state.intensities;
    if (add) {
      latestIntensitiesList.add(jmaInt);
    } else {
      latestIntensitiesList.remove(jmaInt);
    }
    state = state.copyWith(
      intensities: latestIntensitiesList,
    );
    _reloadDB();
    return state.intensities;
  }

  int dbContentsCount() {
    return isar.eQHistorys.countSync();
  }
}
final eqHistroyProvider =
    StateNotifierProvider<EqHistoryNotifier, EQHistoryModel>((ref) {
  return EqHistoryNotifier(ref.watch(isarProvider));
});