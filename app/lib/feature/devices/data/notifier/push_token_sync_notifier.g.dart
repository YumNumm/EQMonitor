// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_token_sync_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PushTokenSyncNotifier)
final pushTokenSyncProvider = PushTokenSyncNotifierProvider._();

final class PushTokenSyncNotifierProvider
    extends
        $AsyncNotifierProvider<PushTokenSyncNotifier, PushTokenSyncSnapshot> {
  PushTokenSyncNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushTokenSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushTokenSyncNotifierHash();

  @$internal
  @override
  PushTokenSyncNotifier create() => PushTokenSyncNotifier();
}

String _$pushTokenSyncNotifierHash() =>
    r'd6814827aeb3139217e7afc02ca72f5024d47768';

abstract class _$PushTokenSyncNotifier
    extends $AsyncNotifier<PushTokenSyncSnapshot> {
  FutureOr<PushTokenSyncSnapshot> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<PushTokenSyncSnapshot>, PushTokenSyncSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PushTokenSyncSnapshot>,
                PushTokenSyncSnapshot
              >,
              AsyncValue<PushTokenSyncSnapshot>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
