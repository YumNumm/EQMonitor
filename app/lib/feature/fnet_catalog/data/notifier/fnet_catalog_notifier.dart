import 'package:eqmonitor/feature/fnet_catalog/data/repository/fnet_catalog_repository.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fnet_catalog_notifier.g.dart';

@riverpod
class FnetCatalogNotifier extends _$FnetCatalogNotifier {
  @override
  Future<List<FnetEvent>> build({required int year, int? month}) async {
    if (month != null) {
      return ref
          .read(fnetCatalogRepositoryProvider)
          .fetchCatalog(year: year, month: month);
    } else {
      return ref
          .read(fnetCatalogRepositoryProvider)
          .fetchYearCatalog(year: year);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final month = this.month;
      if (month != null) {
        return ref
            .read(fnetCatalogRepositoryProvider)
            .fetchCatalog(year: year, month: month);
      } else {
        return ref
            .read(fnetCatalogRepositoryProvider)
            .fetchYearCatalog(year: year);
      }
    });
  }
}
