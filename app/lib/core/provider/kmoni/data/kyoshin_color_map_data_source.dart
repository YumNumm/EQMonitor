import 'dart:convert';

import 'package:eqmonitor/core/provider/kmoni/model/kyoshin_color_map_model.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/services.dart';

Future<List<KyoshinColorMapModel>> getKyoshinColorMap() async {
  final str = await rootBundle.loadString(Assets.kyoshinShindoColorMap);
  final json = jsonDecode(str) as List<dynamic>;
  return json
      .map(
        (e) => KyoshinColorMapModel.fromJson(e as Map<String, dynamic>),
      )
      .toList();
}
