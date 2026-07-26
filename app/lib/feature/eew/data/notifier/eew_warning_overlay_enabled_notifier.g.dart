// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_overlay_enabled_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewWarningOverlayEnabled)
final eewWarningOverlayEnabledProvider = EewWarningOverlayEnabledProvider._();

final class EewWarningOverlayEnabledProvider
    extends $AsyncNotifierProvider<EewWarningOverlayEnabled, bool> {
  EewWarningOverlayEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningOverlayEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningOverlayEnabledHash();

  @$internal
  @override
  EewWarningOverlayEnabled create() => EewWarningOverlayEnabled();
}

String _$eewWarningOverlayEnabledHash() =>
    r'e377f9a5c0708a322831b29d6bd27c022b821cda';

abstract class _$EewWarningOverlayEnabled extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
