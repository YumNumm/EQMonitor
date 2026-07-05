// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_by_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedBySource)
final feedBySourceProvider = FeedBySourceFamily._();

final class FeedBySourceProvider
    extends $AsyncNotifierProvider<FeedBySource, FeedDetail> {
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
  FeedBySource create() => FeedBySource();

  @override
  bool operator ==(Object other) {
    return other is FeedBySourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedBySourceHash() => r'20cf048e400bea1060012d4fb27b17ad7ddf34bd';

final class FeedBySourceFamily extends $Family
    with
        $ClassFamilyOverride<
          FeedBySource,
          AsyncValue<FeedDetail>,
          FeedDetail,
          FutureOr<FeedDetail>,
          String
        > {
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

abstract class _$FeedBySource extends $AsyncNotifier<FeedDetail> {
  late final _$args = ref.$arg as String;
  String get telegramHash => _$args;

  FutureOr<FeedDetail> build(String telegramHash);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FeedDetail>, FeedDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FeedDetail>, FeedDetail>,
              AsyncValue<FeedDetail>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
