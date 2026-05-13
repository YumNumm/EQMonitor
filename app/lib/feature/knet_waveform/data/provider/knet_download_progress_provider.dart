import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_download_progress_provider.g.dart';

/// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
///
/// total が -1 の場合、ファイルサイズ不明。
@riverpod
class KnetDownloadProgress extends _$KnetDownloadProgress {
  @override
  ({int received, int total})? build(DateTime eventTime) => null;

  void update(int received, int total) =>
      state = (received: received, total: total);

  void reset() => state = null;
}
