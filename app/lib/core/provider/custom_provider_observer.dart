import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

final class CustomProviderObserver extends ProviderObserver {
  CustomProviderObserver(this.talker);

  final Talker talker;

  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) => switch (context.provider.name) {
    _ when value.toString().length > 1000 => log(
      '${context.provider.name} (${context.provider.runtimeType}) '
      '${value?.toString().length} ',
      name: 'didAddProvider',
    ),
    _ => log(
      '${context.provider.name} (${context.provider})',
      name: 'didAddProvider',
    ),
  };

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) => switch (context.provider.name) {
    'timeTickerProvider' || 'eewAliveTelegramProvider' => null,
    _
        when context.provider.name?.contains('LayerControllerProvider') ??
            false =>
      null,
    _ => log('${context.provider.name}', name: 'didDisposeProvider'),
  };

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) => switch (context.provider.name) {
    'mapViewModelProvider' ||
    'kyoshinMonitorTimerStreamProvider' ||
    'periodicTimerProvider' ||
    'timeTickerProvider' ||
    'kyoshinMonitorNotifierProvider' => null,
    _
        when context.provider.name?.contains('LayerControllerProvider') ??
            false =>
      null,
    _ when newValue.toString().length + previousValue.toString().length > 300 =>
      log(
        '${context.provider.name} (${previousValue.runtimeType} '
        '-> ${newValue.runtimeType})',
        name: 'didUpdateProvider',
      ),
    _ => log(
      '${context.provider.name} ($previousValue -> $newValue)',
      name: 'didUpdateProvider',
    ),
  };

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    talker.handle(
      error,
      stackTrace,
      'providerDidFail: ${context.provider.name}',
    );
    log(
      '${context.provider.name} $error',
      name: 'providerDidFail',
      error: error,
    );
  }
}
