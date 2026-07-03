import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_cached_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_geojson_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_manifest_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';

/// manifest → GeoJSON の取得を行い、失敗時はローカルキャッシュへ
/// フォールバックする。矩形選択後の分析はすべてクライアント側で完結するため、
/// このリポジトリが返す [SeismicityDataset.events] が唯一の分析用データソース。
class SeismicityRepository {
  SeismicityRepository({
    required Dio dio,
    SeismicityLocalCacheDataSource? cache,
  }) : _manifestDataSource = SeismicityManifestDataSource(dio),
       _geoJsonDataSource = SeismicityGeoJsonDataSource(dio),
       _cache = cache ?? SeismicityLocalCacheDataSource();

  final SeismicityManifestDataSource _manifestDataSource;
  final SeismicityGeoJsonDataSource _geoJsonDataSource;
  final SeismicityLocalCacheDataSource _cache;

  Future<SeismicityDataset> fetch({required SeismicitySpan span}) async {
    try {
      final manifest = await _manifestDataSource.fetchManifest();
      final layer = manifest.layers.firstWhere(
        (l) => l.span == span,
        orElse: () => throw StateError('No manifest layer for span $span'),
      );
      final events = await _geoJsonDataSource.fetchEvents(layer.url);

      await _cache.save(
        span,
        SeismicityCachedDataset(
          events: events,
          generatedAt: layer.generatedAt,
        ),
      );

      return SeismicityDataset(
        events: events,
        generatedAt: layer.generatedAt,
        isFromCache: false,
      );
    } on Object {
      final cached = await _cache.read(span);
      if (cached == null) {
        rethrow;
      }
      return SeismicityDataset(
        events: cached.events,
        generatedAt: cached.generatedAt,
        isFromCache: true,
      );
    }
  }
}
