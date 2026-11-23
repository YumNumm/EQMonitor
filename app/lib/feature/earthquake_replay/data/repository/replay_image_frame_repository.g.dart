// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_image_frame_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayImageFrameRepository)
final replayImageFrameRepositoryProvider =
    ReplayImageFrameRepositoryProvider._();

final class ReplayImageFrameRepositoryProvider
    extends
        $FunctionalProvider<
          ReplayImageFrameRepository,
          ReplayImageFrameRepository,
          ReplayImageFrameRepository
        >
    with $Provider<ReplayImageFrameRepository> {
  ReplayImageFrameRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayImageFrameRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayImageFrameRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReplayImageFrameRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayImageFrameRepository create(Ref ref) {
    return replayImageFrameRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayImageFrameRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayImageFrameRepository>(value),
    );
  }
}

String _$replayImageFrameRepositoryHash() =>
    r'3f9725f8d6050e312b1a34e7f3d51327133ec3ca';
