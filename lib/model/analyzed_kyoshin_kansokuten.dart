import 'package:eqmonitor/schema/local/kyoshin_kansokuten.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:flutter/cupertino.dart';


class AnalyzedKoshinKansokuten extends KyoshinKansokuten {
  const AnalyzedKoshinKansokuten({
    required this.shindo,
    required this.shindoColor,
    required this.pga,
    required this.pgaColor,
    required this.hadValue,
    required this.intensity,
    required super.code,
    required super.name,
    required super.pref,
    required super.lat,
    required super.lon,
    required super.x,
    required super.y,
    required super.arv,
  });

  final double? shindo;
  final Color? shindoColor;
  final double? pga;
  final Color? pgaColor;
  final bool hadValue;
  final JmaIntensity? intensity;

}
