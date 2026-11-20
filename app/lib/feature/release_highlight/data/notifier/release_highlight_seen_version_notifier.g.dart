// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'release_highlight_seen_version_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 新機能の案内を最後に確認したアプリバージョン。
///
/// 新規インストールではオンボーディング完了時に現在のバージョンを保存し、
/// 更新していない端末に案内を出さない。

@ProviderFor(ReleaseHighlightSeenVersion)
final releaseHighlightSeenVersionProvider =
    ReleaseHighlightSeenVersionProvider._();

/// 新機能の案内を最後に確認したアプリバージョン。
///
/// 新規インストールではオンボーディング完了時に現在のバージョンを保存し、
/// 更新していない端末に案内を出さない。
final class ReleaseHighlightSeenVersionProvider
    extends $AsyncNotifierProvider<ReleaseHighlightSeenVersion, String?> {
  /// 新機能の案内を最後に確認したアプリバージョン。
  ///
  /// 新規インストールではオンボーディング完了時に現在のバージョンを保存し、
  /// 更新していない端末に案内を出さない。
  ReleaseHighlightSeenVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'releaseHighlightSeenVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$releaseHighlightSeenVersionHash();

  @$internal
  @override
  ReleaseHighlightSeenVersion create() => ReleaseHighlightSeenVersion();
}

String _$releaseHighlightSeenVersionHash() =>
    r'e746eb6b74eda7b6d4c608ef66bf66bda01d7475';

/// 新機能の案内を最後に確認したアプリバージョン。
///
/// 新規インストールではオンボーディング完了時に現在のバージョンを保存し、
/// 更新していない端末に案内を出さない。

abstract class _$ReleaseHighlightSeenVersion extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
