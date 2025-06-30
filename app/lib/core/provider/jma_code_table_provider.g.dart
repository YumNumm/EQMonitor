// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_code_table_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(jmaCodeTable)
const jmaCodeTableProvider = JmaCodeTableProvider._();

final class JmaCodeTableProvider
    extends $FunctionalProvider<JmaCodeTable, JmaCodeTable>
    with $Provider<JmaCodeTable> {
  const JmaCodeTableProvider._()
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
      providerOverride: $ValueProvider<JmaCodeTable>(value),
    );
  }
}

String _$jmaCodeTableHash() => r'94db7e0261aaf71cfee48960a72415da70d378c7';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
