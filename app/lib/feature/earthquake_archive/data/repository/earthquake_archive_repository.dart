import 'dart:typed_data';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_api_client.dart';
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
  client: await ref.watch(userApiClientProvider.future),
);

class const EarthquakeArchiveRepository({
  required final UserApiGateway client,
  final EarthquakeArchiveFailureMapper failureMapper =
      const EarthquakeArchiveFailureMapper(),
}) {
  static const pageSize = 50;

  Future<Result<EarthquakeArchivePage, EarthquakeArchiveException>> list({
    String? cursor,
  }) async {
    final response = await client.getJson(
      path: api.AdminApiClientUrls.getV2AdminEarthquakeArchives,
      queryParameters: {'limit': '$pageSize', 'cursor': ?cursor},
    );
    if (response case Failure(:final exception, :final stackTrace)) {
      return Failure(failureMapper.map(exception), stackTrace);
    }
    try {
      final page = api.AdminEarthquakeArchiveListResponse.fromJson(
        response.unwrap(),
      );
      return Success(
        EarthquakeArchivePage(
          items: [for (final item in page.items) item.toModel()],
          nextCursor: page.nextToken,
        ),
      );
    } on Object catch (_, stackTrace) {
      return Failure(const EarthquakeArchiveException(.unknown), stackTrace);
    }
  }

  Future<Result<EarthquakeArchive, EarthquakeArchiveException>> detail({
    required String eventId,
  }) async {
    final response = await client.getJson(
      path: api.AdminApiClientUrls.getV2AdminEarthquakeArchivesEventId
          .replaceFirst('{eventId}', Uri.encodeComponent(eventId)),
    );
    if (response case Failure(:final exception, :final stackTrace)) {
      return Failure(failureMapper.map(exception), stackTrace);
    }
    try {
      return Success(
        api.AdminEarthquakeArchiveDetailResponse.fromJson(
          response.unwrap(),
        ).item.toModel(),
      );
    } on Object catch (_, stackTrace) {
      return Failure(const EarthquakeArchiveException(.unknown), stackTrace);
    }
  }

  Future<Result<Uint8List, EarthquakeArchiveException>> download({
    required String eventId,
  }) async {
    final response = await client.getBytes(
      path: api.AdminApiClientUrls.getV2AdminEarthquakeArchivesEventIdFile
          .replaceFirst('{eventId}', Uri.encodeComponent(eventId)),
    );
    return switch (response) {
      Success(:final value) => Success(value),
      Failure(:final exception, :final stackTrace) => Failure(
        failureMapper.map(exception),
        stackTrace,
      ),
    };
  }
}
