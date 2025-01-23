import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_color_map_model.dart';
import 'package:flutter/material.dart';

extension KyoshinColorMapModelEx on KyoshinColorMapModel {
  Color get color => Color.fromARGB(255, r, g, b);
}
