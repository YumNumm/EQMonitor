// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_playback_selection_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TsunamiPlaybackSelection)
final tsunamiPlaybackSelectionProvider = TsunamiPlaybackSelectionProvider._();

final class TsunamiPlaybackSelectionProvider
    extends
        $NotifierProvider<
          TsunamiPlaybackSelection,
          TsunamiPlaybackSelectionState
        > {
  TsunamiPlaybackSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tsunamiPlaybackSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tsunamiPlaybackSelectionHash();

  @$internal
  @override
  TsunamiPlaybackSelection create() => TsunamiPlaybackSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TsunamiPlaybackSelectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TsunamiPlaybackSelectionState>(
        value,
      ),
    );
  }
}

String _$tsunamiPlaybackSelectionHash() =>
    r'9dff5e5a77a1c366e84186cdfe088f5f6dda7bc1';

abstract class _$TsunamiPlaybackSelection
    extends $Notifier<TsunamiPlaybackSelectionState> {
  TsunamiPlaybackSelectionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              TsunamiPlaybackSelectionState,
              TsunamiPlaybackSelectionState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                TsunamiPlaybackSelectionState,
                TsunamiPlaybackSelectionState
              >,
              TsunamiPlaybackSelectionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
