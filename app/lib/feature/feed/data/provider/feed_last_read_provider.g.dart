// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_last_read_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// お知らせの既読位置(最後に既読にしたアイテムの publishedAt)を
/// 端末に永続化する。未設定(初回起動)の場合は null。

@ProviderFor(FeedLastRead)
final feedLastReadProvider = FeedLastReadProvider._();

/// お知らせの既読位置(最後に既読にしたアイテムの publishedAt)を
/// 端末に永続化する。未設定(初回起動)の場合は null。
final class FeedLastReadProvider
    extends $AsyncNotifierProvider<FeedLastRead, DateTime?> {
  /// お知らせの既読位置(最後に既読にしたアイテムの publishedAt)を
  /// 端末に永続化する。未設定(初回起動)の場合は null。
  FeedLastReadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedLastReadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedLastReadHash();

  @$internal
  @override
  FeedLastRead create() => FeedLastRead();
}

String _$feedLastReadHash() => r'ef73e130b44e6075e33f1e2dbf26e3ba1e01de44';

/// お知らせの既読位置(最後に既読にしたアイテムの publishedAt)を
/// 端末に永続化する。未設定(初回起動)の場合は null。

abstract class _$FeedLastRead extends $AsyncNotifier<DateTime?> {
  FutureOr<DateTime?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DateTime?>, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DateTime?>, DateTime?>,
              AsyncValue<DateTime?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
