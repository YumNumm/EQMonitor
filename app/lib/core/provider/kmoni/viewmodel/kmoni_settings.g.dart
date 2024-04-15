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
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$kmoniSettingsHash() => r'5bfee9dfe90781154d43ff084a82cf74202b8631';

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
