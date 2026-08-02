// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_map_focus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewMapFocus)
final eewMapFocusProvider = EewMapFocusProvider._();

final class EewMapFocusProvider
    extends $NotifierProvider<EewMapFocus, EewMapFocusState> {
  EewMapFocusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewMapFocusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewMapFocusHash();

  @$internal
  @override
  EewMapFocus create() => EewMapFocus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewMapFocusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewMapFocusState>(value),
    );
  }
}

String _$eewMapFocusHash() => r'65fae6b0ed2ed10e9de006cb38aa6055b49f0caf';

abstract class _$EewMapFocus extends $Notifier<EewMapFocusState> {
  EewMapFocusState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EewMapFocusState, EewMapFocusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EewMapFocusState, EewMapFocusState>,
              EewMapFocusState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
