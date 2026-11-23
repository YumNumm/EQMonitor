// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_library_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayLibraryAction)
final replayLibraryActionProvider = ReplayLibraryActionProvider._();

final class ReplayLibraryActionProvider
    extends
        $FunctionalProvider<
          ReplayLibraryAction,
          ReplayLibraryAction,
          ReplayLibraryAction
        >
    with $Provider<ReplayLibraryAction> {
  ReplayLibraryActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayLibraryActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayLibraryActionHash();

  @$internal
  @override
  $ProviderElement<ReplayLibraryAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayLibraryAction create(Ref ref) {
    return replayLibraryAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayLibraryAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayLibraryAction>(value),
    );
  }
}

String _$replayLibraryActionHash() =>
    r'48b7d37dfd08d2270413a21aaa5b347c0f94e3ae';
