// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'update_banner_seen_version_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アップデートバナーで最後に既読/Dismiss したアプリバージョン。
/// 現在のアプリバージョンと異なる場合にバナーを表示する。

@ProviderFor(UpdateBannerSeenVersion)
final updateBannerSeenVersionProvider = UpdateBannerSeenVersionProvider._();

/// アップデートバナーで最後に既読/Dismiss したアプリバージョン。
/// 現在のアプリバージョンと異なる場合にバナーを表示する。
final class UpdateBannerSeenVersionProvider
    extends $AsyncNotifierProvider<UpdateBannerSeenVersion, String?> {
  /// アップデートバナーで最後に既読/Dismiss したアプリバージョン。
  /// 現在のアプリバージョンと異なる場合にバナーを表示する。
  UpdateBannerSeenVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateBannerSeenVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateBannerSeenVersionHash();

  @$internal
  @override
  UpdateBannerSeenVersion create() => UpdateBannerSeenVersion();
}

String _$updateBannerSeenVersionHash() =>
    r'62d706e9c660a871a47984583b8c5a835d6c2bc6';

/// アップデートバナーで最後に既読/Dismiss したアプリバージョン。
/// 現在のアプリバージョンと異なる場合にバナーを表示する。

abstract class _$UpdateBannerSeenVersion extends $AsyncNotifier<String?> {
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
