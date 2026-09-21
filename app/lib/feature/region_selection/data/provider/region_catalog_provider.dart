import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_catalog_builder.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_catalog_provider.g.dart';

@riverpod
Future<List<RegionOption>> regionCatalog(
  Ref ref, {
  bool notification = false,
}) async {
  final parameters = await ref.watch(parameterSetProvider.future);
  return const RegionCatalogBuilder().build(
    earthquake: parameters.earthquake,
    codeTable: parameters.jmaCodeTable,
    notification: notification,
  );
}
