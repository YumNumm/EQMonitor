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
          AsyncValue<FeedDetail>,
          FeedDetail,
          FutureOr<FeedDetail>
        >
    with $FutureModifier<FeedDetail>, $FutureProvider<FeedDetail> {
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
  $FutureProviderElement<FeedDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FeedDetail> create(Ref ref) {
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

String _$feedBySourceHash() => r'69a23f2a19bc582cafba40569716fbb954a4ce2a';

final class FeedBySourceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FeedDetail>, String> {
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
