import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
export 'package:eqmonitor/feature/parameter/data/model/tsunami/tsunami_parameter.dart';

part 'jma_parameter.g.dart';

typedef JmaParameterState = ({
  EarthquakeParameter earthquake,
  TsunamiParameter tsunami,
});

@Riverpod(keepAlive: true)
Future<JmaParameterState> jmaParameter(Ref ref) async {
  final parameterSet = await ref.watch(parameterSetProvider.future);
  return (
    earthquake: parameterSet.earthquake,
    tsunami: parameterSet.tsunami,
  );
}
