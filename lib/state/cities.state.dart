import 'package:eqmonitor/model/cities.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// ダミーのProviderを用意する
final isarProvider = Provider<Isar>((_) {
  debugPrint('run isarprovider');
  throw UnimplementedError('アプリケーション起動時にmainでawaitして生成したインスタンスを使用する');
});

class CitiesStateNotifier extends StateNotifier<CitiesModel> {
  CitiesStateNotifier(this.isar)
      : super(
          CitiesModel(
            isar: isar,
          ),
        );

  final Isar isar;
}

final citiesStateNotifierProvider =
    StateNotifierProvider<CitiesStateNotifier, CitiesModel>(
  (ref) => CitiesStateNotifier(ref.watch(isarProvider)),
);
