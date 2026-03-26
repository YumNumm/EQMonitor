// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'secure_preferences_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(securePreferencesDataSource)
final securePreferencesDataSourceProvider =
    SecurePreferencesDataSourceProvider._();

final class SecurePreferencesDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SecurePreferencesDataSource>,
          SecurePreferencesDataSource,
          FutureOr<SecurePreferencesDataSource>
        >
    with
        $FutureModifier<SecurePreferencesDataSource>,
        $FutureProvider<SecurePreferencesDataSource> {
  SecurePreferencesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securePreferencesDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securePreferencesDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<SecurePreferencesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SecurePreferencesDataSource> create(Ref ref) {
    return securePreferencesDataSource(ref);
  }
}

String _$securePreferencesDataSourceHash() =>
    r'e58bcb0be7f3ea5a373aaa97f529ce0282293852';
