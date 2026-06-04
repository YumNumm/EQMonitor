import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

/// 3種類のプッシュトークンそれぞれの同期状態スナップショット。
final class PushTokenSyncSnapshot {
  const PushTokenSyncSnapshot({
    required this.fcm,
    required this.apnsNotification,
    required this.apnsPushToStart,
  });

  final PushTokenKindState fcm;
  final PushTokenKindState apnsNotification;
  final PushTokenKindState apnsPushToStart;

  bool get allSynced => kindEntries.every(
    (entry) => switch (entry.value) {
      SyncedTokenState() ||
      NotApplicableTokenState() ||
      AbsentTokenState() => true,
      PendingTokenState() || FailedTokenState() => false,
    },
  );

  bool get hasPending =>
      fcm is PendingTokenState ||
      apnsNotification is PendingTokenState ||
      apnsPushToStart is PendingTokenState;

  bool get hasFailed =>
      fcm is FailedTokenState ||
      apnsNotification is FailedTokenState ||
      apnsPushToStart is FailedTokenState;

  Iterable<MapEntry<PushTokenKind, PushTokenKindState>> get kindEntries => [
    MapEntry(PushTokenKind.fcm, fcm),
    MapEntry(PushTokenKind.apnsNotification, apnsNotification),
    MapEntry(PushTokenKind.apnsPushToStart, apnsPushToStart),
  ];
}

sealed class PushTokenKindState {
  const PushTokenKindState();
}

/// プラットフォーム非対応（macOS など）。
final class NotApplicableTokenState extends PushTokenKindState {
  const NotApplicableTokenState();
}

/// トークンが未取得。
final class AbsentTokenState extends PushTokenKindState {
  const AbsentTokenState();
}

/// サーバーと同期済み。
final class SyncedTokenState extends PushTokenKindState {
  const SyncedTokenState();
}

/// 差分あり — 同期が必要。
final class PendingTokenState extends PushTokenKindState {
  const PendingTokenState();
}

/// 同期失敗。
final class FailedTokenState extends PushTokenKindState {
  const FailedTokenState({required this.error});
  final DeviceProvisioningException error;
}

/// ファクトリショートカット（設計書の freezed 風 API に近づける）。
extension PushTokenKindStateX on PushTokenKindState {
  static const PushTokenKindState notApplicable = NotApplicableTokenState();
  static const PushTokenKindState absent = AbsentTokenState();
  static const PushTokenKindState synced = SyncedTokenState();
  static const PushTokenKindState pending = PendingTokenState();
  static PushTokenKindState failed(DeviceProvisioningException error) =>
      FailedTokenState(error: error);
}
