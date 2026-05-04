import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_code_table_provider.g.dart';

@Riverpod(keepAlive: true)
Future<JmaCodeTableParameter> jmaCodeTable(Ref ref) async {
  final parameterSet = await ref.watch(parameterSetProvider.future);
  return parameterSet.jmaCodeTable;
}
