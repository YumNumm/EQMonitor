import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_directory_provider.g.dart';

/// all/zip/ 配下の利用可能な年一覧（昇順）
@riverpod
Future<List<int>> knetYears(Ref ref) async {
  final client = await ref.watch(knetDownloadClientProvider.future);
  if (client == null) {
    return [];
  }
  return client.fetchYears();
}

/// all/zip/{year}/ 配下の月一覧（昇順）
@riverpod
Future<List<int>> knetMonths(Ref ref, int year) async {
  final client = await ref.watch(knetDownloadClientProvider.future);
  if (client == null) {
    return [];
  }
  return client.fetchMonths(year);
}

/// all/zip/{year}/{month}/ 配下の地震記録時刻一覧（降順: 新しい順）
@riverpod
Future<List<DateTime>> knetRecords(Ref ref, int year, int month) async {
  final client = await ref.watch(knetDownloadClientProvider.future);
  if (client == null) {
    return [];
  }
  return client.fetchRecords(year, month);
}
