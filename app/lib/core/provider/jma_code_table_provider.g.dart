// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jmaCodeTable)
final jmaCodeTableProvider = JmaCodeTableProvider._();

final class JmaCodeTableProvider
    extends
        $FunctionalProvider<
          AsyncValue<JmaCodeTableParameter>,
          JmaCodeTableParameter,
          FutureOr<JmaCodeTableParameter>
        >
    with
        $FutureModifier<JmaCodeTableParameter>,
        $FutureProvider<JmaCodeTableParameter> {
  JmaCodeTableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaCodeTableProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaCodeTableHash();

  @$internal
  @override
  $FutureProviderElement<JmaCodeTableParameter> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JmaCodeTableParameter> create(Ref ref) {
    return jmaCodeTable(ref);
  }
}

String _$jmaCodeTableHash() => r'ad1f63ba2671aa6bb8c4f185b8517c6401e0a6f9';
