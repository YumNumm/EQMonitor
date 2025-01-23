// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

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
          depth: $checkedConvert('depth', (v) => (v as num).toInt()),
          magnitude: $checkedConvert('magnitude', (v) => (v as num).toDouble()),
          isLowPrecise: $checkedConvert('is_low_precise', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'isLowPrecise': 'is_low_precise'},
    );

Map<String, dynamic> _$$_EewHypocenterPropertiesImplToJson(
        _$_EewHypocenterPropertiesImpl instance) =>
    <String, dynamic>{
      'depth': instance.depth,
      'magnitude': instance.magnitude,
      'is_low_precise': instance.isLowPrecise,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mainMapViewModelHash() => r'2482955d561fb1806225808587c47a13fdb712ef';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
