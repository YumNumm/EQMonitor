// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_control_panel_expanded_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayControlPanelExpanded)
final replayControlPanelExpandedProvider =
    ReplayControlPanelExpandedProvider._();

final class ReplayControlPanelExpandedProvider
    extends $NotifierProvider<ReplayControlPanelExpanded, bool> {
  ReplayControlPanelExpandedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayControlPanelExpandedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayControlPanelExpandedHash();

  @$internal
  @override
  ReplayControlPanelExpanded create() => ReplayControlPanelExpanded();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$replayControlPanelExpandedHash() =>
    r'080e2236d27a9f594e01939568964a7ee6af7a05';

abstract class _$ReplayControlPanelExpanded extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
