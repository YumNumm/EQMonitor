// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_dataset_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。

@ProviderFor(SeismicityDatasetNotifier)
final seismicityDatasetNotifierProvider = SeismicityDatasetNotifierFamily._();

/// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。
final class SeismicityDatasetNotifierProvider
    extends
        $AsyncNotifierProvider<SeismicityDatasetNotifier, SeismicityDataset> {
  /// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。
  SeismicityDatasetNotifierProvider._({
    required SeismicityDatasetNotifierFamily super.from,
    required SeismicitySpan super.argument,
  }) : super(
         retry: null,
         name: r'seismicityDatasetNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$seismicityDatasetNotifierHash();

  @override
  String toString() {
    return r'seismicityDatasetNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SeismicityDatasetNotifier create() => SeismicityDatasetNotifier();

  @override
  bool operator ==(Object other) {
    return other is SeismicityDatasetNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$seismicityDatasetNotifierHash() =>
    r'ca396b52bb5969fb9fbf7f01565a684f93603deb';

/// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。

final class SeismicityDatasetNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SeismicityDatasetNotifier,
          AsyncValue<SeismicityDataset>,
          SeismicityDataset,
          FutureOr<SeismicityDataset>,
          SeismicitySpan
        > {
  SeismicityDatasetNotifierFamily._()
    : super(
        retry: null,
        name: r'seismicityDatasetNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。

  SeismicityDatasetNotifierProvider call(SeismicitySpan span) =>
      SeismicityDatasetNotifierProvider._(argument: span, from: this);

  @override
  String toString() => r'seismicityDatasetNotifierProvider';
}

/// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。

abstract class _$SeismicityDatasetNotifier
    extends $AsyncNotifier<SeismicityDataset> {
  late final _$args = ref.$arg as SeismicitySpan;
  SeismicitySpan get span => _$args;

  FutureOr<SeismicityDataset> build(SeismicitySpan span);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SeismicityDataset>, SeismicityDataset>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SeismicityDataset>, SeismicityDataset>,
              AsyncValue<SeismicityDataset>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
