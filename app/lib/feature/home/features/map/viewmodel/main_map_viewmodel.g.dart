// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'main_map_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EewHypocenterPropertiesImpl _$$_EewHypocenterPropertiesImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EewHypocenterPropertiesImpl',
      json,
      ($checkedConvert) {
        final val = _$_EewHypocenterPropertiesImpl(
          depth: $checkedConvert('depth', (v) => v as int),
          magnitude: $checkedConvert('magnitude', (v) => (v as num).toDouble()),
          isLowPrecise: $checkedConvert('isLowPrecise', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EewHypocenterPropertiesImplToJson(
        _$_EewHypocenterPropertiesImpl instance) =>
    <String, dynamic>{
      'depth': instance.depth,
      'magnitude': instance.magnitude,
      'isLowPrecise': instance.isLowPrecise,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mainMapViewModelHash() => r'a702b6396ccc83374e4250bb3c5f0c7d96a8de80';

/// See also [MainMapViewModel].
@ProviderFor(MainMapViewModel)
final mainMapViewModelProvider =
    NotifierProvider<MainMapViewModel, MainMapViewmodelState>.internal(
  MainMapViewModel.new,
  name: r'mainMapViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mainMapViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MainMapViewModel = Notifier<MainMapViewmodelState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
