// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_eew_frame_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayEewFrameRepository)
final replayEewFrameRepositoryProvider = ReplayEewFrameRepositoryProvider._();

final class ReplayEewFrameRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReplayEewFrameRepository>,
          ReplayEewFrameRepository,
          FutureOr<ReplayEewFrameRepository>
        >
    with
        $FutureModifier<ReplayEewFrameRepository>,
        $FutureProvider<ReplayEewFrameRepository> {
  ReplayEewFrameRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayEewFrameRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayEewFrameRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ReplayEewFrameRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReplayEewFrameRepository> create(Ref ref) {
    return replayEewFrameRepository(ref);
  }
}

String _$replayEewFrameRepositoryHash() =>
    r'0f74df52856e2ee13a234202bc2b687de208ed78';
