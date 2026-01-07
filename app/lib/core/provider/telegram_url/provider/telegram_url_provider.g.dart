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
    extends $NotifierProvider<TelegramUrl, TelegramUrlModel> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelegramUrlModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelegramUrlModel>(value),
    );
  }
}

String _$telegramUrlHash() => r'5204d0f0332e2b25e011b31dc421f81ad92aee0a';

abstract class _$TelegramUrl extends $Notifier<TelegramUrlModel> {
  TelegramUrlModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TelegramUrlModel, TelegramUrlModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TelegramUrlModel, TelegramUrlModel>,
              TelegramUrlModel,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
