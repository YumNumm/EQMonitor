// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_image_parser_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorImageParser)
const kyoshinMonitorImageParserProvider = KyoshinMonitorImageParserProvider._();

final class KyoshinMonitorImageParserProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorImageParser,
          KyoshinMonitorImageParser,
          KyoshinMonitorImageParser
        >
    with $Provider<KyoshinMonitorImageParser> {
  const KyoshinMonitorImageParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorImageParserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorImageParserHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorImageParser> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorImageParser create(Ref ref) {
    return kyoshinMonitorImageParser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorImageParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorImageParser>(value),
    );
  }
}

String _$kyoshinMonitorImageParserHash() =>
    r'c343437d7d4e5a9ddbae9041f8c356cd6c8132d2';
