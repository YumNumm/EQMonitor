// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'theme_color_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeColorSet _$ThemeColorSetFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_ThemeColorSet',
      json,
      ($checkedConvert) {
        final val = _ThemeColorSet(
          primary: $checkedConvert(
            'primary',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onPrimary: $checkedConvert(
            'on_primary',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          primaryContainer: $checkedConvert(
            'primary_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onPrimaryContainer: $checkedConvert(
            'on_primary_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          secondary: $checkedConvert(
            'secondary',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          secondaryContainer: $checkedConvert(
            'secondary_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onSecondaryContainer: $checkedConvert(
            'on_secondary_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          tertiary: $checkedConvert(
            'tertiary',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          tertiaryContainer: $checkedConvert(
            'tertiary_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onTertiaryContainer: $checkedConvert(
            'on_tertiary_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          error: $checkedConvert(
            'error',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          errorContainer: $checkedConvert(
            'error_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onErrorContainer: $checkedConvert(
            'on_error_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          surface: $checkedConvert(
            'surface',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onSurface: $checkedConvert(
            'on_surface',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onSurfaceVariant: $checkedConvert(
            'on_surface_variant',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          surfaceContainerLow: $checkedConvert(
            'surface_container_low',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          surfaceContainer: $checkedConvert(
            'surface_container',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          surfaceContainerHigh: $checkedConvert(
            'surface_container_high',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          surfaceContainerHighest: $checkedConvert(
            'surface_container_highest',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          outline: $checkedConvert(
            'outline',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          outlineVariant: $checkedConvert(
            'outline_variant',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onInverseSurface: $checkedConvert(
            'on_inverse_surface',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          status: $checkedConvert(
            'status',
            (v) => StatusColors.fromJson(v as Map<String, dynamic>),
          ),
          intensity: $checkedConvert(
            'intensity',
            (v) => IntensityColors.fromJson(v as Map<String, dynamic>),
          ),
          estimatedIntensity: $checkedConvert(
            'estimated_intensity',
            (v) => EstimatedIntensityColors.fromJson(v as Map<String, dynamic>),
          ),
          mapColors: $checkedConvert(
            'map',
            (v) => MapColors.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'onPrimary': 'on_primary',
        'primaryContainer': 'primary_container',
        'onPrimaryContainer': 'on_primary_container',
        'secondaryContainer': 'secondary_container',
        'onSecondaryContainer': 'on_secondary_container',
        'tertiaryContainer': 'tertiary_container',
        'onTertiaryContainer': 'on_tertiary_container',
        'errorContainer': 'error_container',
        'onErrorContainer': 'on_error_container',
        'onSurface': 'on_surface',
        'onSurfaceVariant': 'on_surface_variant',
        'surfaceContainerLow': 'surface_container_low',
        'surfaceContainer': 'surface_container',
        'surfaceContainerHigh': 'surface_container_high',
        'surfaceContainerHighest': 'surface_container_highest',
        'outlineVariant': 'outline_variant',
        'onInverseSurface': 'on_inverse_surface',
        'estimatedIntensity': 'estimated_intensity',
        'mapColors': 'map',
      },
    );

Map<String, dynamic> _$ThemeColorSetToJson(
  _ThemeColorSet instance,
) => <String, dynamic>{
  'primary': const ColorJsonConverter().toJson(instance.primary),
  'on_primary': const ColorJsonConverter().toJson(instance.onPrimary),
  'primary_container': const ColorJsonConverter().toJson(
    instance.primaryContainer,
  ),
  'on_primary_container': const ColorJsonConverter().toJson(
    instance.onPrimaryContainer,
  ),
  'secondary': const ColorJsonConverter().toJson(instance.secondary),
  'secondary_container': const ColorJsonConverter().toJson(
    instance.secondaryContainer,
  ),
  'on_secondary_container': const ColorJsonConverter().toJson(
    instance.onSecondaryContainer,
  ),
  'tertiary': const ColorJsonConverter().toJson(instance.tertiary),
  'tertiary_container': const ColorJsonConverter().toJson(
    instance.tertiaryContainer,
  ),
  'on_tertiary_container': const ColorJsonConverter().toJson(
    instance.onTertiaryContainer,
  ),
  'error': const ColorJsonConverter().toJson(instance.error),
  'error_container': const ColorJsonConverter().toJson(instance.errorContainer),
  'on_error_container': const ColorJsonConverter().toJson(
    instance.onErrorContainer,
  ),
  'surface': const ColorJsonConverter().toJson(instance.surface),
  'on_surface': const ColorJsonConverter().toJson(instance.onSurface),
  'on_surface_variant': const ColorJsonConverter().toJson(
    instance.onSurfaceVariant,
  ),
  'surface_container_low': const ColorJsonConverter().toJson(
    instance.surfaceContainerLow,
  ),
  'surface_container': const ColorJsonConverter().toJson(
    instance.surfaceContainer,
  ),
  'surface_container_high': const ColorJsonConverter().toJson(
    instance.surfaceContainerHigh,
  ),
  'surface_container_highest': const ColorJsonConverter().toJson(
    instance.surfaceContainerHighest,
  ),
  'outline': const ColorJsonConverter().toJson(instance.outline),
  'outline_variant': const ColorJsonConverter().toJson(instance.outlineVariant),
  'on_inverse_surface': const ColorJsonConverter().toJson(
    instance.onInverseSurface,
  ),
  'status': instance.status,
  'intensity': instance.intensity,
  'estimated_intensity': instance.estimatedIntensity,
  'map': instance.mapColors,
};
