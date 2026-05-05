// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_json_parser.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parameterJsonParser)
final parameterJsonParserProvider = ParameterJsonParserProvider._();

final class ParameterJsonParserProvider
    extends
        $FunctionalProvider<
          ParameterJsonParser,
          ParameterJsonParser,
          ParameterJsonParser
        >
    with $Provider<ParameterJsonParser> {
  ParameterJsonParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parameterJsonParserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parameterJsonParserHash();

  @$internal
  @override
  $ProviderElement<ParameterJsonParser> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ParameterJsonParser create(Ref ref) {
    return parameterJsonParser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParameterJsonParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParameterJsonParser>(value),
    );
  }
}

String _$parameterJsonParserHash() =>
    r'44db88067e9de0ba4e3333a847c0729f9f957ade';
