// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'start_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StartNotifier)
final startProvider = StartNotifierProvider._();

final class StartNotifierProvider
    extends $AsyncNotifierProvider<StartNotifier, api.StartResponse> {
  StartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startNotifierHash();

  @$internal
  @override
  StartNotifier create() => StartNotifier();
}

String _$startNotifierHash() => r'f634afb86dfe07569d1e9ec4e6453ce20e353958';

abstract class _$StartNotifier extends $AsyncNotifier<api.StartResponse> {
  FutureOr<api.StartResponse> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<api.StartResponse>, api.StartResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<api.StartResponse>, api.StartResponse>,
              AsyncValue<api.StartResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
