// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_eew_xml_converter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jmaEewXmlConverter)
final jmaEewXmlConverterProvider = JmaEewXmlConverterProvider._();

final class JmaEewXmlConverterProvider
    extends
        $FunctionalProvider<
          JmaEewXmlConverter,
          JmaEewXmlConverter,
          JmaEewXmlConverter
        >
    with $Provider<JmaEewXmlConverter> {
  JmaEewXmlConverterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaEewXmlConverterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaEewXmlConverterHash();

  @$internal
  @override
  $ProviderElement<JmaEewXmlConverter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JmaEewXmlConverter create(Ref ref) {
    return jmaEewXmlConverter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JmaEewXmlConverter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JmaEewXmlConverter>(value),
    );
  }
}

String _$jmaEewXmlConverterHash() =>
    r'2297be803c717be5bad6a9542ca85231d3321425';
