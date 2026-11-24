import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/repository/earthquake_archive_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_archive_detail_provider.g.dart';

@riverpod
Future<EarthquakeArchive> earthquakeArchiveDetail(
  Ref ref, {
  required String eventId,
}) async {
  final repository = await ref.watch(
    earthquakeArchiveRepositoryProvider.future,
  );
  return (await repository.detail(eventId: eventId)).unwrap();
}
