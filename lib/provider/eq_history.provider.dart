import 'package:eqmonitor/state/eq_history.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../model/eq_histroy.model.dart';

final isarProvider = Provider<Isar>((_) {
  debugPrint('Run isarProvider');
  throw UnimplementedError('アプリケーション起動時にmainでawaitして生成したインスタンスを使用する');
});

class EqHistoryProvider extends StateNotifier<EQHistoryModel> {
  EqHistoryProvider(this.isar) : super(EQHistoryModel(isar: isar));

  final Isar isar;

  // 処理
}

