// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_exit_notice_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayExitNoticeNotifier)
final replayExitNoticeProvider = ReplayExitNoticeNotifierProvider._();

final class ReplayExitNoticeNotifierProvider
    extends $NotifierProvider<ReplayExitNoticeNotifier, ReplayExitNotice?> {
  ReplayExitNoticeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayExitNoticeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayExitNoticeNotifierHash();

  @$internal
  @override
  ReplayExitNoticeNotifier create() => ReplayExitNoticeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayExitNotice? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayExitNotice?>(value),
    );
  }
}

String _$replayExitNoticeNotifierHash() =>
    r'456db5b69b7f72d970061e4ace094ac5f9f46604';

abstract class _$ReplayExitNoticeNotifier extends $Notifier<ReplayExitNotice?> {
  ReplayExitNotice? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReplayExitNotice?, ReplayExitNotice?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplayExitNotice?, ReplayExitNotice?>,
              ReplayExitNotice?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
