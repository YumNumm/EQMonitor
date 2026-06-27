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

String _$startNotifierHash() => r'df406add3f047c02ea8659dc5bff5dad049a4f3b';

abstract class _$StartNotifier extends $AsyncNotifier<api.StartResponse> {
  FutureOr<api.StartResponse> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
