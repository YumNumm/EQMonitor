import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomProviderObserver extends ProviderObserver {
  CustomProviderObserver(this.talker);

  final Talker talker;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      switch (provider.name) {
        _ when value.toString().length > 1000 => log(
            '${provider.name} (${provider.runtimeType}) '
            '${value?.toString().length} ',
            name: 'didAddProvider',
          ),
        _ => log(
            '${provider.name} ($provider)',
            name: 'didAddProvider',
          ),
      };

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      log('didDisposeProvider: ${provider.name}');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      switch (provider.name) {
        'mapViewModelProvider' || 'kmoniViewModelProvider' => null,
        _
            when newValue.toString().length + previousValue.toString().length >
                300 =>
          log(
            '${provider.name} (${previousValue.runtimeType} '
            '-> ${newValue.runtimeType})',
            name: 'didUpdateProvider',
          ),
        _ => log(
            '${provider.name} ($previousValue -> $newValue)',
            name: 'didUpdateProvider',
          ),
      };

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    talker.handle(error, stackTrace, 'providerDidFail: ${provider.name}');
    log(
      '${provider.name} $error',
      name: 'providerDidFail',
      error: error,
    );
  }
}
