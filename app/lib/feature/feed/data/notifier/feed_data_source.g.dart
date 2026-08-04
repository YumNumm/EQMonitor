// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedDataSource)
final feedDataSourceProvider = FeedDataSourceProvider._();

final class FeedDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<FeedDataSource>,
          FeedDataSource,
          FutureOr<FeedDataSource>
        >
    with $FutureModifier<FeedDataSource>, $FutureProvider<FeedDataSource> {
  FeedDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<FeedDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FeedDataSource> create(Ref ref) {
    return feedDataSource(ref);
  }
}

String _$feedDataSourceHash() => r'0297b7d14253f2dc8684950041e7b261b6836ad9';
