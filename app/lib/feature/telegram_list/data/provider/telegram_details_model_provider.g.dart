// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_details_model_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// UI 層がドメイン型のみを参照できるよう、
/// 電文詳細レスポンスをアプリ用ドメインモデルへ変換したマップを返す。

@ProviderFor(telegramDetailsModel)
final telegramDetailsModelProvider = TelegramDetailsModelFamily._();

/// UI 層がドメイン型のみを参照できるよう、
/// 電文詳細レスポンスをアプリ用ドメインモデルへ変換したマップを返す。

final class TelegramDetailsModelProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, TelegramDetailModel>>,
          AsyncValue<Map<String, TelegramDetailModel>>,
          AsyncValue<Map<String, TelegramDetailModel>>
        >
    with $Provider<AsyncValue<Map<String, TelegramDetailModel>>> {
  /// UI 層がドメイン型のみを参照できるよう、
  /// 電文詳細レスポンスをアプリ用ドメインモデルへ変換したマップを返す。
  TelegramDetailsModelProvider._({
    required TelegramDetailsModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'telegramDetailsModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$telegramDetailsModelHash();

  @override
  String toString() {
    return r'telegramDetailsModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<Map<String, TelegramDetailModel>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<Map<String, TelegramDetailModel>> create(Ref ref) {
    final argument = this.argument as String;
    return telegramDetailsModel(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    AsyncValue<Map<String, TelegramDetailModel>> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<Map<String, TelegramDetailModel>>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TelegramDetailsModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$telegramDetailsModelHash() =>
    r'06cdc68cb8a496cbf9303fac79520e04109a540d';

/// UI 層がドメイン型のみを参照できるよう、
/// 電文詳細レスポンスをアプリ用ドメインモデルへ変換したマップを返す。

final class TelegramDetailsModelFamily extends $Family
    with
        $FunctionalFamilyOverride<
          AsyncValue<Map<String, TelegramDetailModel>>,
          String
        > {
  TelegramDetailsModelFamily._()
    : super(
        retry: null,
        name: r'telegramDetailsModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// UI 層がドメイン型のみを参照できるよう、
  /// 電文詳細レスポンスをアプリ用ドメインモデルへ変換したマップを返す。

  TelegramDetailsModelProvider call(String eventId) =>
      TelegramDetailsModelProvider._(argument: eventId, from: this);

  @override
  String toString() => r'telegramDetailsModelProvider';
}
