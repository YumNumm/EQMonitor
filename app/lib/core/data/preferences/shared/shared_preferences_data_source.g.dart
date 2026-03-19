// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shared_preferences_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferencesDataSource)
final sharedPreferencesDataSourceProvider =
    SharedPreferencesDataSourceProvider._();

final class SharedPreferencesDataSourceProvider
    extends
        $FunctionalProvider<
          SharedPreferencesDataSource,
          SharedPreferencesDataSource,
          SharedPreferencesDataSource
        >
    with $Provider<SharedPreferencesDataSource> {
  SharedPreferencesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesDataSourceHash();

  @$internal
  @override
  $ProviderElement<SharedPreferencesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferencesDataSource create(Ref ref) {
    return sharedPreferencesDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferencesDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferencesDataSource>(value),
    );
  }
}

String _$sharedPreferencesDataSourceHash() =>
    r'0b2e0e0aeb939b045382730cae64c4cf5febab89';
