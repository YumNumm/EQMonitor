// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// UI 層がドメイン型のみを参照できるよう、
/// API レスポンスをアプリ用ドメインモデルへ変換した変更履歴一覧を返す。

@ProviderFor(changelogEntries)
final changelogEntriesProvider = ChangelogEntriesProvider._();

/// UI 層がドメイン型のみを参照できるよう、
/// API レスポンスをアプリ用ドメインモデルへ変換した変更履歴一覧を返す。

final class ChangelogEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChangelogEntryModel>>,
          AsyncValue<List<ChangelogEntryModel>>,
          AsyncValue<List<ChangelogEntryModel>>
        >
    with $Provider<AsyncValue<List<ChangelogEntryModel>>> {
  /// UI 層がドメイン型のみを参照できるよう、
  /// API レスポンスをアプリ用ドメインモデルへ変換した変更履歴一覧を返す。
  ChangelogEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changelogEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changelogEntriesHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<ChangelogEntryModel>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<ChangelogEntryModel>> create(Ref ref) {
    return changelogEntries(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<ChangelogEntryModel>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<ChangelogEntryModel>>>(value),
    );
  }
}

String _$changelogEntriesHash() => r'661200bd8f340496e22ca45ca9692eadcfd22b86';
