// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'unread_high_urgency_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 未読の緊急度の高いお知らせのうち最新の1件。該当なしなら null。
/// 既読位置が未設定(初回起動直後)の間も null を返し、表示しない。

@ProviderFor(unreadHighUrgencyFeed)
final unreadHighUrgencyFeedProvider = UnreadHighUrgencyFeedProvider._();

/// 未読の緊急度の高いお知らせのうち最新の1件。該当なしなら null。
/// 既読位置が未設定(初回起動直後)の間も null を返し、表示しない。

final class UnreadHighUrgencyFeedProvider
    extends $FunctionalProvider<FeedItem?, FeedItem?, FeedItem?>
    with $Provider<FeedItem?> {
  /// 未読の緊急度の高いお知らせのうち最新の1件。該当なしなら null。
  /// 既読位置が未設定(初回起動直後)の間も null を返し、表示しない。
  UnreadHighUrgencyFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadHighUrgencyFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadHighUrgencyFeedHash();

  @$internal
  @override
  $ProviderElement<FeedItem?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedItem? create(Ref ref) {
    return unreadHighUrgencyFeed(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedItem? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedItem?>(value),
    );
  }
}

String _$unreadHighUrgencyFeedHash() =>
    r'1ae5dd4d11d74acef336fa7c49d7161cfa2054fb';
