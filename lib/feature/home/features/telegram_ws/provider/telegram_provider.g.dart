// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$telegramWsHash() => r'3eac4885bad8ff0d8bb18e87be0ec5b47dbf504f';

/// See also [TelegramWs].
@ProviderFor(TelegramWs)
final telegramWsProvider =
    StreamNotifierProvider<TelegramWs, TelegramV3>.internal(
  TelegramWs.new,
  name: r'telegramWsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$telegramWsHash,
  dependencies: <ProviderOrFamily>[telegramSocketIoProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    telegramSocketIoProvider,
    ...?telegramSocketIoProvider.allTransitiveDependencies
  },
);

typedef _$TelegramWs = StreamNotifier<TelegramV3>;
String _$socketStatusHash() => r'd5b4ba16e6da4e30d35deee2e63ca28e877af6ff';

/// See also [SocketStatus].
@ProviderFor(SocketStatus)
final socketStatusProvider =
    NotifierProvider<SocketStatus, SocketStatusModel>.internal(
  SocketStatus.new,
  name: r'socketStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$socketStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocketStatus = Notifier<SocketStatusModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
