import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// ref: https://github.com/GitGud31/theme_riverpod_hive/blob/master/lib/log.dart
class ProvidersLogger extends ProviderObserver {
  final logger = Logger();

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    //super.didAddProvider(provider, value, container);

    logger.d(
      '''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "value": "$value",
      "container: "$container"
    }''',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.d(
      '''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }''',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer containers,
  ) {
    //super.didDisposeProvider(provider, containers);

    logger.d(
      '''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "containers": "$containers"
    }''',
    );
  }
}