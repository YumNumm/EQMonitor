// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_event_bootstrap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリ起動時にリアルタイムイベントの購読を開始する。

@ProviderFor(realtimeEventBootstrap)
final realtimeEventBootstrapProvider = RealtimeEventBootstrapProvider._();

/// アプリ起動時にリアルタイムイベントの購読を開始する。

final class RealtimeEventBootstrapProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// アプリ起動時にリアルタイムイベントの購読を開始する。
  RealtimeEventBootstrapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'realtimeEventBootstrapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$realtimeEventBootstrapHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return realtimeEventBootstrap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$realtimeEventBootstrapHash() =>
    r'401143efe2b93958d4d7e2d997859f413fa15a1c';
