import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// ref: https://github.com/GitGud31/theme_riverpod_hive/blob/master/lib/log.dart
class ProvidersLogger extends ProviderObserver {
  ProvidersLogger(this.talker);

  final Talker talker;

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    //super.didAddProvider(provider, value, container);

    talker.debug(
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
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    talker.debug(
      '''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }''',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    //super.didDisposeProvider(provider, containers);

    talker.debug(
      '''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "container": "$container"
    }''',
    );
  }
}
