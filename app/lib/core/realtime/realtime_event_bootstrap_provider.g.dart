// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_event_bootstrap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
@ProviderFor(realtimeEventBootstrap)
final realtimeEventBootstrapProvider = RealtimeEventBootstrapProvider._();

final class RealtimeEventBootstrapProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
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
}

String _$realtimeEventBootstrapHash() =>
    r'91f18185b6a2d3a50ad891c8d42202d466639b16';
