// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kmoni_view_settings.dart';

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
          isUpper0Only:
              $checkedConvert('isUpper0Only', (v) => v as bool? ?? false),
          isShowIntensityIcon: $checkedConvert(
              'isShowIntensityIcon', (v) => v as bool? ?? false),
          useKmoni: $checkedConvert('useKmoni', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KmoniSettingsStateImplToJson(
        _$KmoniSettingsStateImpl instance) =>
    <String, dynamic>{
      'isUpper0Only': instance.isUpper0Only,
      'isShowIntensityIcon': instance.isShowIntensityIcon,
      'useKmoni': instance.useKmoni,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$kmoniSettingsHash() => r'3a624489de7f8bd258d81cbd5e30d570bbe2951a';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
