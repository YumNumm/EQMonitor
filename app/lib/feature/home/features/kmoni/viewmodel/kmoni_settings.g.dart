// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kmoni_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KmoniSettingsStateImpl _$$KmoniSettingsStateImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KmoniSettingsStateImpl',
      json,
      ($checkedConvert) {
        final val = _$KmoniSettingsStateImpl(
          minRealtimeShindo: $checkedConvert(
              'minRealtimeShindo', (v) => (v as num?)?.toDouble() ?? null),
          showRealtimeShindoScale: $checkedConvert(
              'showRealtimeShindoScale', (v) => v as bool? ?? true),
          useKmoni: $checkedConvert('useKmoni', (v) => v as bool? ?? false),
          showCurrentLocationMarker: $checkedConvert(
              'showCurrentLocationMarker', (v) => v as bool? ?? false),
          kmoniMarkerType: $checkedConvert(
              'kmoniMarkerType',
              (v) =>
                  $enumDecodeNullable(_$KmoniMarkerTypeEnumMap, v) ??
                  KmoniMarkerType.onlyEew),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KmoniSettingsStateImplToJson(
        _$KmoniSettingsStateImpl instance) =>
    <String, dynamic>{
      'minRealtimeShindo': instance.minRealtimeShindo,
      'showRealtimeShindoScale': instance.showRealtimeShindoScale,
      'useKmoni': instance.useKmoni,
      'showCurrentLocationMarker': instance.showCurrentLocationMarker,
      'kmoniMarkerType': _$KmoniMarkerTypeEnumMap[instance.kmoniMarkerType]!,
    };

const _$KmoniMarkerTypeEnumMap = {
  KmoniMarkerType.always: 'always',
  KmoniMarkerType.onlyEew: 'onlyEew',
  KmoniMarkerType.never: 'never',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$kmoniSettingsHash() => r'8340b5bb4d12719d1243ff4da13edec4ecfb16cb';

/// See also [KmoniSettings].
@ProviderFor(KmoniSettings)
final kmoniSettingsProvider =
    NotifierProvider<KmoniSettings, KmoniSettingsState>.internal(
  KmoniSettings.new,
  name: r'kmoniSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$kmoniSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$KmoniSettings = Notifier<KmoniSettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
