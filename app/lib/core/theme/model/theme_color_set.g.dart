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
          onSecondary: $checkedConvert(
            'on_secondary',
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
          onTertiary: $checkedConvert(
            'on_tertiary',
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
          onError: $checkedConvert(
            'on_error',
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
          surfaceContainerLowest: $checkedConvert(
            'surface_container_lowest',
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
          inverseSurface: $checkedConvert(
            'inverse_surface',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          onInverseSurface: $checkedConvert(
            'on_inverse_surface',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          inversePrimary: $checkedConvert(
            'inverse_primary',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          shadow: $checkedConvert(
            'shadow',
            (v) => const ColorJsonConverter().fromJson(v as String),
          ),
          scrim: $checkedConvert(
            'scrim',
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
        'onSecondary': 'on_secondary',
        'secondaryContainer': 'secondary_container',
        'onSecondaryContainer': 'on_secondary_container',
        'onTertiary': 'on_tertiary',
        'tertiaryContainer': 'tertiary_container',
        'onTertiaryContainer': 'on_tertiary_container',
        'onError': 'on_error',
        'errorContainer': 'error_container',
        'onErrorContainer': 'on_error_container',
        'onSurface': 'on_surface',
        'onSurfaceVariant': 'on_surface_variant',
        'surfaceContainerLowest': 'surface_container_lowest',
        'surfaceContainerLow': 'surface_container_low',
        'surfaceContainer': 'surface_container',
        'surfaceContainerHigh': 'surface_container_high',
        'surfaceContainerHighest': 'surface_container_highest',
        'outlineVariant': 'outline_variant',
        'inverseSurface': 'inverse_surface',
        'onInverseSurface': 'on_inverse_surface',
        'inversePrimary': 'inverse_primary',
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
  'on_secondary': const ColorJsonConverter().toJson(instance.onSecondary),
  'secondary_container': const ColorJsonConverter().toJson(
    instance.secondaryContainer,
  ),
  'on_secondary_container': const ColorJsonConverter().toJson(
    instance.onSecondaryContainer,
  ),
  'tertiary': const ColorJsonConverter().toJson(instance.tertiary),
  'on_tertiary': const ColorJsonConverter().toJson(instance.onTertiary),
  'tertiary_container': const ColorJsonConverter().toJson(
    instance.tertiaryContainer,
  ),
  'on_tertiary_container': const ColorJsonConverter().toJson(
    instance.onTertiaryContainer,
  ),
  'error': const ColorJsonConverter().toJson(instance.error),
  'on_error': const ColorJsonConverter().toJson(instance.onError),
  'error_container': const ColorJsonConverter().toJson(instance.errorContainer),
  'on_error_container': const ColorJsonConverter().toJson(
    instance.onErrorContainer,
  ),
  'surface': const ColorJsonConverter().toJson(instance.surface),
  'on_surface': const ColorJsonConverter().toJson(instance.onSurface),
  'on_surface_variant': const ColorJsonConverter().toJson(
    instance.onSurfaceVariant,
  ),
  'surface_container_lowest': const ColorJsonConverter().toJson(
    instance.surfaceContainerLowest,
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
  'inverse_surface': const ColorJsonConverter().toJson(instance.inverseSurface),
  'on_inverse_surface': const ColorJsonConverter().toJson(
    instance.onInverseSurface,
  ),
  'inverse_primary': const ColorJsonConverter().toJson(instance.inversePrimary),
  'shadow': const ColorJsonConverter().toJson(instance.shadow),
  'scrim': const ColorJsonConverter().toJson(instance.scrim),
  'status': instance.status,
  'intensity': instance.intensity,
  'estimated_intensity': instance.estimatedIntensity,
  'map': instance.mapColors,
};
