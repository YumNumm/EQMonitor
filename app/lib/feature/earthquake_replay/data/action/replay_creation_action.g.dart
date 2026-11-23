// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_creation_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayCreationAction)
final replayCreationActionProvider = ReplayCreationActionProvider._();

final class ReplayCreationActionProvider
    extends
        $FunctionalProvider<
          ReplayCreationAction,
          ReplayCreationAction,
          ReplayCreationAction
        >
    with $Provider<ReplayCreationAction> {
  ReplayCreationActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayCreationActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayCreationActionHash();

  @$internal
  @override
  $ProviderElement<ReplayCreationAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayCreationAction create(Ref ref) {
    return replayCreationAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayCreationAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayCreationAction>(value),
    );
  }
}

String _$replayCreationActionHash() =>
    r'25046880793261dfdd5ccd4f3935ec180ea1a96f';
