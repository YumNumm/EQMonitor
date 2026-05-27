// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KyoshinMonitorNotifier)
final kyoshinMonitorProvider = KyoshinMonitorNotifierProvider._();

final class KyoshinMonitorNotifierProvider
    extends
        $AsyncNotifierProvider<KyoshinMonitorNotifier, KyoshinMonitorState> {
  KyoshinMonitorNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorNotifierHash();

  @$internal
  @override
  KyoshinMonitorNotifier create() => KyoshinMonitorNotifier();
}

String _$kyoshinMonitorNotifierHash() =>
    r'6cd369a21dd4a0280790add4441da993ec5facdf';

abstract class _$KyoshinMonitorNotifier
    extends $AsyncNotifier<KyoshinMonitorState> {
  FutureOr<KyoshinMonitorState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<KyoshinMonitorState>, KyoshinMonitorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KyoshinMonitorState>, KyoshinMonitorState>,
              AsyncValue<KyoshinMonitorState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
