// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_by_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedBySource)
final feedBySourceProvider = FeedBySourceFamily._();

final class FeedBySourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<api.FeedDetailResponse>,
          api.FeedDetailResponse,
          FutureOr<api.FeedDetailResponse>
        >
    with
        $FutureModifier<api.FeedDetailResponse>,
        $FutureProvider<api.FeedDetailResponse> {
  FeedBySourceProvider._({
    required FeedBySourceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'feedBySourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedBySourceHash();

  @override
  String toString() {
    return r'feedBySourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<api.FeedDetailResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<api.FeedDetailResponse> create(Ref ref) {
    final argument = this.argument as String;
    return feedBySource(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedBySourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedBySourceHash() => r'37807bb92070c3ffd76da7e7f6098d4e050b9a71';

final class FeedBySourceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<api.FeedDetailResponse>, String> {
  FeedBySourceFamily._()
    : super(
        retry: null,
        name: r'feedBySourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FeedBySourceProvider call(String telegramHash) =>
      FeedBySourceProvider._(argument: telegramHash, from: this);

  @override
  String toString() => r'feedBySourceProvider';
}
