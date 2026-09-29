import 'package:telemetry_store/telemetry_store.dart';

/// テレメトリ DB を開けない場合 (App Group コンテナのパス解決失敗など) に
/// 差し替える、何も記録しない [TelemetryRecorder]。
///
/// テレメトリは必須機能ではないため、DB が使えなくても通知受信や
/// プッシュトークン同期などの呼び出し側を失敗させない。
final class const NoopTelemetryRecorder() implements TelemetryRecorder {
  @override
  Future<void> record(TelemetryEvent event) async {}

  @override
  Future<void> recordAll(List<TelemetryEvent> events) async {}
}

/// テレメトリ DB を開けない場合に差し替える、何も送信しない
/// [TelemetryUploader]。
final class const NoopTelemetryUploader() implements TelemetryUploader {
  @override
  int get batchSize => 0;

  @override
  Future<UploadResult> flush() async =>
      const UploadResult(sentCount: 0, failedCount: 0);
}
