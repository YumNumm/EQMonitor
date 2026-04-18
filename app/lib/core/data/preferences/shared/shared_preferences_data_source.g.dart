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
          AsyncValue<SharedPreferencesDataSource>,
          SharedPreferencesDataSource,
          FutureOr<SharedPreferencesDataSource>
        >
    with
        $FutureModifier<SharedPreferencesDataSource>,
        $FutureProvider<SharedPreferencesDataSource> {
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
  $FutureProviderElement<SharedPreferencesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferencesDataSource> create(Ref ref) {
    return sharedPreferencesDataSource(ref);
  }
}

String _$sharedPreferencesDataSourceHash() =>
    r'cd1c749989ac5152f8cd5071d6da9b90644fd685';
