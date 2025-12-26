import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:jma_parameter_types/tsunami_param.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:jma_parameter_types/earthquake_param.pb.dart';
export 'package:jma_parameter_types/tsunami_param.pb.dart';

part 'jma_parameter.g.dart';

typedef JmaParameterState = ({
  EarthquakeParameter earthquake,
  TsunamiParameter tsunami,
});

@Riverpod(keepAlive: true)
Future<JmaParameterState> jmaParameter(Ref ref) async {
  final earthquake = await _loadEarthquakeParameter();
  final tsunami = await _loadTsunamiParameter();
  return (earthquake: earthquake, tsunami: tsunami);
}

Future<EarthquakeParameter> _loadEarthquakeParameter() async {
  final bytes = await rootBundle.load(Assets.parameter.earthquake);
  return EarthquakeParameter.fromBuffer(bytes.buffer.asUint8List());
}

Future<TsunamiParameter> _loadTsunamiParameter() async {
  final bytes = await rootBundle.load(Assets.parameter.tsunami);
  return TsunamiParameter.fromBuffer(bytes.buffer.asUint8List());
}
