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
    extends $NotifierProvider<StartNotifier, AsyncValue<api.StartResponse?>> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<api.StartResponse?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<api.StartResponse?>>(
        value,
      ),
    );
  }
}

String _$startNotifierHash() => r'd698cb59c4574aaabcb76cfa8c4505e1cf0732a9';

abstract class _$StartNotifier
    extends $Notifier<AsyncValue<api.StartResponse?>> {
  AsyncValue<api.StartResponse?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<api.StartResponse?>,
              AsyncValue<api.StartResponse?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<api.StartResponse?>,
                AsyncValue<api.StartResponse?>
              >,
              AsyncValue<api.StartResponse?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
