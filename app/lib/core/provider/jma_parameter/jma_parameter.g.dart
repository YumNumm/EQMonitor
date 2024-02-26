// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'jma_parameter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jmaParameterHash() => r'778c903288d44df594fbb91198d68712d8dcf6b7';

/// See also [JmaParameter].
@ProviderFor(JmaParameter)
final jmaParameterProvider = AsyncNotifierProvider<JmaParameter,
    ({EarthquakeParameter earthquake, TsunamiParameter tsunami})>.internal(
  JmaParameter.new,
  name: r'jmaParameterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jmaParameterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JmaParameter = AsyncNotifier<
    ({EarthquakeParameter earthquake, TsunamiParameter tsunami})>;
String _$earthquakeParameterEtagHash() =>
    r'2351454514903ab08fe4100dc59680743b4ee26d';

/// See also [EarthquakeParameterEtag].
@ProviderFor(EarthquakeParameterEtag)
final earthquakeParameterEtagProvider =
    NotifierProvider<EarthquakeParameterEtag, String?>.internal(
  EarthquakeParameterEtag.new,
  name: r'earthquakeParameterEtagProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeParameterEtagHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EarthquakeParameterEtag = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
