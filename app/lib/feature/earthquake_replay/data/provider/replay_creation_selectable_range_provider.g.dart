// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_creation_selectable_range_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayCreationSelectableRange)
final replayCreationSelectableRangeProvider =
    ReplayCreationSelectableRangeProvider._();

final class ReplayCreationSelectableRangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReplayCreationRange>,
          ReplayCreationRange,
          Stream<ReplayCreationRange>
        >
    with
        $FutureModifier<ReplayCreationRange>,
        $StreamProvider<ReplayCreationRange> {
  ReplayCreationSelectableRangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayCreationSelectableRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayCreationSelectableRangeHash();

  @$internal
  @override
  $StreamProviderElement<ReplayCreationRange> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ReplayCreationRange> create(Ref ref) {
    return replayCreationSelectableRange(ref);
  }
}

String _$replayCreationSelectableRangeHash() =>
    r'df2077e9338f6c0f2c0119cdbe8c358b6e4f2afe';
