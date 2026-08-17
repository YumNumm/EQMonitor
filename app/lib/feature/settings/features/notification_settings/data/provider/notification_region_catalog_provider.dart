import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_catalog_builder.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_catalog_provider.g.dart';

@Riverpod(keepAlive: true)
Future<NotificationRegionCatalog> notificationRegionCatalog(Ref ref) async {
  final parameters = await ref.watch(parameterSetProvider.future);
  final catalog = ref
      .watch(notificationRegionCatalogBuilderProvider)
      .build(
        codeTable: parameters.jmaCodeTable,
        earthquake: parameters.earthquake,
      );
  for (final cityCode in catalog.unmappedCityCodes) {
    talker.warning(
      'NotificationRegionCatalog: EEW regionを解決できない市区町村を除外しました: $cityCode',
    );
  }
  return catalog;
}
