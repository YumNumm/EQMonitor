// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_group_settings_writer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリ本体の設定を iOS App Group UserDefaults へ同期する。
///
/// [telegramUrlProvider] / [confirmedIsProProvider] / [widgetRegionProvider] を
/// watch するため、URL 変更・Pro 状態変化・任意地域の選択/解除が Widget に即時
/// 反映される。現在地の地域コードは位置権限が許可済みのときのみベストエフォートで
/// 書き込む（新規の権限要求はしない）。位置変化への追従は
/// `backgroundLocationService` 側で別途行う。
///
/// 購読状態が確定するまで（読み込み中・エラー時）は、Pro 状態とそれに依存する
/// 任意地域を書き換えず、前回の値を残す。Pro に依存しない URL・現在地は先に書く。
///
/// 書き込み内容が実際に変化したときだけ Widget のタイムライン再読み込みを要求する。

@ProviderFor(appGroupSettingsWriter)
final appGroupSettingsWriterProvider = AppGroupSettingsWriterProvider._();

/// アプリ本体の設定を iOS App Group UserDefaults へ同期する。
///
/// [telegramUrlProvider] / [confirmedIsProProvider] / [widgetRegionProvider] を
/// watch するため、URL 変更・Pro 状態変化・任意地域の選択/解除が Widget に即時
/// 反映される。現在地の地域コードは位置権限が許可済みのときのみベストエフォートで
/// 書き込む（新規の権限要求はしない）。位置変化への追従は
/// `backgroundLocationService` 側で別途行う。
///
/// 購読状態が確定するまで（読み込み中・エラー時）は、Pro 状態とそれに依存する
/// 任意地域を書き換えず、前回の値を残す。Pro に依存しない URL・現在地は先に書く。
///
/// 書き込み内容が実際に変化したときだけ Widget のタイムライン再読み込みを要求する。

final class AppGroupSettingsWriterProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// アプリ本体の設定を iOS App Group UserDefaults へ同期する。
  ///
  /// [telegramUrlProvider] / [confirmedIsProProvider] / [widgetRegionProvider] を
  /// watch するため、URL 変更・Pro 状態変化・任意地域の選択/解除が Widget に即時
  /// 反映される。現在地の地域コードは位置権限が許可済みのときのみベストエフォートで
  /// 書き込む（新規の権限要求はしない）。位置変化への追従は
  /// `backgroundLocationService` 側で別途行う。
  ///
  /// 購読状態が確定するまで（読み込み中・エラー時）は、Pro 状態とそれに依存する
  /// 任意地域を書き換えず、前回の値を残す。Pro に依存しない URL・現在地は先に書く。
  ///
  /// 書き込み内容が実際に変化したときだけ Widget のタイムライン再読み込みを要求する。
  AppGroupSettingsWriterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appGroupSettingsWriterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appGroupSettingsWriterHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return appGroupSettingsWriter(ref);
  }
}

String _$appGroupSettingsWriterHash() =>
    r'8c0d0033547f8b13e9722a43fdc7113769f35971';
