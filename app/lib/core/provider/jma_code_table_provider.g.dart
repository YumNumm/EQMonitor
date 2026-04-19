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
    extends $FunctionalProvider<JmaCodeTable, JmaCodeTable, JmaCodeTable>
    with $Provider<JmaCodeTable> {
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
  $ProviderElement<JmaCodeTable> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JmaCodeTable create(Ref ref) {
    return jmaCodeTable(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JmaCodeTable value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JmaCodeTable>(value),
    );
  }
}

String _$jmaCodeTableHash() => r'94db7e0261aaf71cfee48960a72415da70d378c7';
