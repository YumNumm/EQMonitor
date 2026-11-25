// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_intensity_icon_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayIntensityIcon)
final replayIntensityIconProvider = ReplayIntensityIconProvider._();

final class ReplayIntensityIconProvider
    extends $NotifierProvider<ReplayIntensityIcon, bool> {
  ReplayIntensityIconProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayIntensityIconProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayIntensityIconHash();

  @$internal
  @override
  ReplayIntensityIcon create() => ReplayIntensityIcon();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$replayIntensityIconHash() =>
    r'fd69d6f4a74979fe24bb34ad941e4cc28f49963f';

abstract class _$ReplayIntensityIcon extends $Notifier<bool> {
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
