import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_converter.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/repository/earthquake_archive_failure_mapper.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_archive_repository.g.dart';

@riverpod
Future<EarthquakeArchiveRepository> earthquakeArchiveRepository(
  Ref ref,
) async => EarthquakeArchiveRepository(
  client: await ref.watch(apiClientProvider.future),
  dio: await ref.watch(dioProvider.future),
);

// 認証は DeviceAuthTokenInterceptor がデバイスのトークンを付ける。サーバーは ADMIN_DEVICE_IDS の端末だけを通す。
class const EarthquakeArchiveRepository({
  required final api.ApiClient client,
  required final Dio dio,
  final EarthquakeArchiveFailureMapper failureMapper =
      const EarthquakeArchiveFailureMapper(),
}) {
  static const pageSize = 50;

  Future<Result<EarthquakeArchivePage, EarthquakeArchiveException>> list({
    String? cursor,
  }) async {
    try {
      final response = await client.admin.getV2AdminEarthquakeArchives(
        limit: pageSize,
        cursor: cursor,
      );
      return Success(
        EarthquakeArchivePage(
          items: [for (final item in response.data.items) item.toModel()],
          nextCursor: response.data.nextToken,
        ),
      );
    } on DioException catch (error, stackTrace) {
      return Failure(failureMapper.map(error), stackTrace);
    } on Exception catch (_, stackTrace) {
      return Failure(const EarthquakeArchiveException(.unknown), stackTrace);
    }
  }

  Future<Result<EarthquakeArchive, EarthquakeArchiveException>> detail({
    required String eventId,
  }) async {
    try {
      final response = await client.admin.getV2AdminEarthquakeArchivesEventId(
        eventId: eventId,
      );
      return Success(response.data.item.toModel());
    } on DioException catch (error, stackTrace) {
      return Failure(failureMapper.map(error), stackTrace);
    } on Exception catch (_, stackTrace) {
      return Failure(const EarthquakeArchiveException(.unknown), stackTrace);
    }
  }

  Future<Result<Uint8List, EarthquakeArchiveException>> download({
    required String eventId,
  }) async {
    try {
      final response = await dio.get<List<int>>(
        api.AdminApiClientUrls.getV2AdminEarthquakeArchivesEventIdFile
            .replaceFirst('{eventId}', Uri.encodeComponent(eventId)),
        options: Options(responseType: .bytes),
      );
      return switch (response.data) {
        final List<int> bytes => Success(Uint8List.fromList(bytes)),
        _ => Failure(
          const EarthquakeArchiveException(.unknown),
          StackTrace.current,
        ),
      };
    } on DioException catch (error, stackTrace) {
      return Failure(failureMapper.map(error), stackTrace);
    } on Exception catch (_, stackTrace) {
      return Failure(const EarthquakeArchiveException(.unknown), stackTrace);
    }
  }
}
