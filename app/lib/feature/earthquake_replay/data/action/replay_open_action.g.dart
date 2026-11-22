// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_open_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayOpenAction)
final replayOpenActionProvider = ReplayOpenActionProvider._();

final class ReplayOpenActionProvider
    extends
        $FunctionalProvider<
          ReplayOpenAction,
          ReplayOpenAction,
          ReplayOpenAction
        >
    with $Provider<ReplayOpenAction> {
  ReplayOpenActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayOpenActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayOpenActionHash();

  @$internal
  @override
  $ProviderElement<ReplayOpenAction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReplayOpenAction create(Ref ref) {
    return replayOpenAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayOpenAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayOpenAction>(value),
    );
  }
}

String _$replayOpenActionHash() => r'263d3baceee22f5cf8ed4d26db22ac97cd1034eb';
