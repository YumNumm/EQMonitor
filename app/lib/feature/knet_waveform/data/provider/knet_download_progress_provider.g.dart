// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_download_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
///
/// total が -1 の場合、ファイルサイズ不明。

@ProviderFor(KnetDownloadProgress)
final knetDownloadProgressProvider = KnetDownloadProgressFamily._();

/// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
///
/// total が -1 の場合、ファイルサイズ不明。
final class KnetDownloadProgressProvider
    extends
        $NotifierProvider<KnetDownloadProgress, ({int received, int total})?> {
  /// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
  ///
  /// total が -1 の場合、ファイルサイズ不明。
  KnetDownloadProgressProvider._({
    required KnetDownloadProgressFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'knetDownloadProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$knetDownloadProgressHash();

  @override
  String toString() {
    return r'knetDownloadProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  KnetDownloadProgress create() => KnetDownloadProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({int received, int total})? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({int received, int total})?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is KnetDownloadProgressProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$knetDownloadProgressHash() =>
    r'fdb16db3e0ad6ca09fde4ddc0746eb4dc11f2269';

/// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
///
/// total が -1 の場合、ファイルサイズ不明。

final class KnetDownloadProgressFamily extends $Family
    with
        $ClassFamilyOverride<
          KnetDownloadProgress,
          ({int received, int total})?,
          ({int received, int total})?,
          ({int received, int total})?,
          DateTime
        > {
  KnetDownloadProgressFamily._()
    : super(
        retry: null,
        name: r'knetDownloadProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
  ///
  /// total が -1 の場合、ファイルサイズ不明。

  KnetDownloadProgressProvider call(DateTime eventTime) =>
      KnetDownloadProgressProvider._(argument: eventTime, from: this);

  @override
  String toString() => r'knetDownloadProgressProvider';
}

/// ZIP ダウンロードの進捗 (received, total) を保持するプロバイダー
///
/// total が -1 の場合、ファイルサイズ不明。

abstract class _$KnetDownloadProgress
    extends $Notifier<({int received, int total})?> {
  late final _$args = ref.$arg as DateTime;
  DateTime get eventTime => _$args;

  ({int received, int total})? build(DateTime eventTime);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<({int received, int total})?, ({int received, int total})?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({int received, int total})?,
                ({int received, int total})?
              >,
              ({int received, int total})?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
