import 'dart:convert';

import 'package:eqmonitor/feature/home/features/kmoni/model/kyoshin_color_map_model.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_color_map_data_source.g.dart';

@Riverpod(keepAlive: true)
KyoshinColorMapDataSource kyoshinColorMapDataSource(
  KyoshinColorMapDataSourceRef ref,
) =>
    KyoshinColorMapDataSource();

class KyoshinColorMapDataSource {
  Future<List<KyoshinColorMapModel>> getKyoshinColorMap() async {
    final str = await rootBundle.loadString(Assets.kyoshinShindoColorMap);
    final json = jsonDecode(str) as List<dynamic>;
    return json
        .map(
          (e) => KyoshinColorMapModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
