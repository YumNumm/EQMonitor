import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/hypocenter_archive_probe.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_analysis_loader.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_archive_selector.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_analysis_request.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_manifest.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_analysis_repository.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_manifest_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hypocenter_catalog_provider.g.dart';

@riverpod
Future<HypocenterManifest> hypocenterManifest(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  final result = await HypocenterManifestRepository(
    client: apiClient.hypocenters,
  ).fetch();
  return switch (result) {
    Success(:final value) => value,
    Failure(:final exception, :final stackTrace) => Error.throwWithStackTrace(
      exception,
      stackTrace ?? StackTrace.current,
    ),
  };
}

@riverpod
Future<bool> hypocenterArchiveAvailable(
  Ref ref,
  HypocenterArchive archive,
) async {
  final result = await HypocenterArchiveProbe(
    dio: Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  ).probe(url: archive.url);
  return switch (result) {
    Success() => true,
    Failure() => false,
  };
}

@riverpod
Future<List<SeismicityEvent>> hypocenterAnalysis(
  Ref ref,
  HypocenterAnalysisRequest request,
) async {
  if (request.archives.isEmpty) {
    return const [];
  }
  final apiClient = await ref.watch(apiClientProvider.future);
  final result = await HypocenterAnalysisLoader(
    repository: HypocenterAnalysisRepository(client: apiClient.hypocenters),
  ).load(archives: request.archives, bounds: request.bounds);
  if (result case Failure(:final exception) when exception.isRevisionChanged) {
    final manifest = await ref.refresh(hypocenterManifestProvider.future);
    final remapped = const HypocenterArchiveSelector().remap(
      selected: request.archives.map((archive) => archive.id).toSet(),
      archives: manifest.archives,
    );
    final retry = await HypocenterAnalysisLoader(
      repository: HypocenterAnalysisRepository(client: apiClient.hypocenters),
    ).load(archives: remapped, bounds: request.bounds);
    return switch (retry) {
      Success(:final value) => value,
      Failure(:final exception, :final stackTrace) => Error.throwWithStackTrace(
        exception,
        stackTrace ?? StackTrace.current,
      ),
    };
  }
  return switch (result) {
    Success(:final value) => value,
    Failure(:final exception, :final stackTrace) => Error.throwWithStackTrace(
      exception,
      stackTrace ?? StackTrace.current,
    ),
  };
}
