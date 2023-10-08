// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$telegramWsHash() => r'f5b344ef68759cf23ece6a0bc36a6e6ba2a39a13';

/// See also [TelegramWs].
@ProviderFor(TelegramWs)
final telegramWsProvider =
    StreamNotifierProvider<TelegramWs, TelegramV3>.internal(
  TelegramWs.new,
  name: r'telegramWsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$telegramWsHash,
  dependencies: null,
  allTransitiveDependencies: null,
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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
