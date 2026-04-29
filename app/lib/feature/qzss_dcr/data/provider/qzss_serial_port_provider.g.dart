// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'qzss_serial_port_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 利用可能なシリアルポートのリストを取得

@ProviderFor(availableSerialPorts)
final availableSerialPortsProvider = AvailableSerialPortsProvider._();

/// 利用可能なシリアルポートのリストを取得

final class AvailableSerialPortsProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  /// 利用可能なシリアルポートのリストを取得
  AvailableSerialPortsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableSerialPortsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableSerialPortsHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return availableSerialPorts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$availableSerialPortsHash() =>
    r'599e509a435fb28cd82314704f8cdeb5c8bd9e3d';

/// QZSSシリアルポート接続管理プロバイダー

@ProviderFor(QzssSerialPortConnection)
final qzssSerialPortConnectionProvider = QzssSerialPortConnectionProvider._();

/// QZSSシリアルポート接続管理プロバイダー
final class QzssSerialPortConnectionProvider
    extends $NotifierProvider<QzssSerialPortConnection, QzssSerialPortState> {
  /// QZSSシリアルポート接続管理プロバイダー
  QzssSerialPortConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'qzssSerialPortConnectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$qzssSerialPortConnectionHash();

  @$internal
  @override
  QzssSerialPortConnection create() => QzssSerialPortConnection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QzssSerialPortState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QzssSerialPortState>(value),
    );
  }
}

String _$qzssSerialPortConnectionHash() =>
    r'90440ba11d14aa5212c40d944bd73d4abbb34796';

/// QZSSシリアルポート接続管理プロバイダー

abstract class _$QzssSerialPortConnection
    extends $Notifier<QzssSerialPortState> {
  QzssSerialPortState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<QzssSerialPortState, QzssSerialPortState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QzssSerialPortState, QzssSerialPortState>,
              QzssSerialPortState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// 最新の災危通報レポート

@ProviderFor(LatestQzssDcReport)
final latestQzssDcReportProvider = LatestQzssDcReportProvider._();

/// 最新の災危通報レポート
final class LatestQzssDcReportProvider
    extends $NotifierProvider<LatestQzssDcReport, QzssDcReport?> {
  /// 最新の災危通報レポート
  LatestQzssDcReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'latestQzssDcReportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$latestQzssDcReportHash();

  @$internal
  @override
  LatestQzssDcReport create() => LatestQzssDcReport();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QzssDcReport? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QzssDcReport?>(value),
    );
  }
}

String _$latestQzssDcReportHash() =>
    r'4a308b072a1353268d53de5283cd153d48369efd';

/// 最新の災危通報レポート

abstract class _$LatestQzssDcReport extends $Notifier<QzssDcReport?> {
  QzssDcReport? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<QzssDcReport?, QzssDcReport?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QzssDcReport?, QzssDcReport?>,
              QzssDcReport?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
