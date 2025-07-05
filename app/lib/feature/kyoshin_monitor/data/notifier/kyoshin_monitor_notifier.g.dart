// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'kyoshin_monitor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(KyoshinMonitorNotifier)
const kyoshinMonitorNotifierProvider = KyoshinMonitorNotifierProvider._();

final class KyoshinMonitorNotifierProvider
    extends
        $AsyncNotifierProvider<KyoshinMonitorNotifier, KyoshinMonitorState> {
  const KyoshinMonitorNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorNotifierHash();

  @$internal
  @override
  KyoshinMonitorNotifier create() => KyoshinMonitorNotifier();

  @$internal
  @override
  $AsyncNotifierProviderElement<KyoshinMonitorNotifier, KyoshinMonitorState>
  $createElement($ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$kyoshinMonitorNotifierHash() =>
    r'8a878dff247cd95647f48e51800268d081aee526';

abstract class _$KyoshinMonitorNotifier
    extends $AsyncNotifier<KyoshinMonitorState> {
  FutureOr<KyoshinMonitorState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<KyoshinMonitorState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KyoshinMonitorState>>,
              AsyncValue<KyoshinMonitorState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
