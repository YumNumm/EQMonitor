// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_url_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TelegramUrl)
final telegramUrlProvider = TelegramUrlProvider._();

final class TelegramUrlProvider
    extends $AsyncNotifierProvider<TelegramUrl, TelegramUrlModel> {
  TelegramUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telegramUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telegramUrlHash();

  @$internal
  @override
  TelegramUrl create() => TelegramUrl();
}

String _$telegramUrlHash() => r'5b095bb3fece90a011476cc2470fa478f1cb57d1';

abstract class _$TelegramUrl extends $AsyncNotifier<TelegramUrlModel> {
  FutureOr<TelegramUrlModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TelegramUrlModel>, TelegramUrlModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TelegramUrlModel>, TelegramUrlModel>,
              AsyncValue<TelegramUrlModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
