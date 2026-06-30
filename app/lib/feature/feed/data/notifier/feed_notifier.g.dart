// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedNotifier)
final feedProvider = FeedNotifierProvider._();

final class FeedNotifierProvider
    extends $AsyncNotifierProvider<FeedNotifier, FeedNotifierState> {
  FeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedNotifierHash();

  @$internal
  @override
  FeedNotifier create() => FeedNotifier();
}

String _$feedNotifierHash() => r'25469433435c72f308a62362821a40a0737a3357';

abstract class _$FeedNotifier extends $AsyncNotifier<FeedNotifierState> {
  FutureOr<FeedNotifierState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<FeedNotifierState>, FeedNotifierState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FeedNotifierState>, FeedNotifierState>,
              AsyncValue<FeedNotifierState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
