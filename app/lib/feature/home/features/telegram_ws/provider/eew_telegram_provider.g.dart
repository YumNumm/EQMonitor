// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_telegram_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewWsTelegramHash() => r'835bc8ff7c4b0b742034359755e5efb2dca9ffbb';

/// See also [EewWsTelegram].
@ProviderFor(EewWsTelegram)
final eewWsTelegramProvider =
    StreamNotifierProvider<EewWsTelegram, EewWsItem>.internal(
  EewWsTelegram.new,
  name: r'eewWsTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewWsTelegramHash,
  dependencies: <ProviderOrFamily>[telegramWsProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    telegramWsProvider,
    ...?telegramWsProvider.allTransitiveDependencies
  },
);

typedef _$EewWsTelegram = StreamNotifier<EewWsItem>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
