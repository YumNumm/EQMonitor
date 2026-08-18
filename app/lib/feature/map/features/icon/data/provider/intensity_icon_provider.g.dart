// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(intensityIcon)
final intensityIconProvider = IntensityIconProvider._();

final class IntensityIconProvider
    extends
        $FunctionalProvider<
          AsyncValue<IntensityIconData>,
          IntensityIconData,
          FutureOr<IntensityIconData>
        >
    with
        $FutureModifier<IntensityIconData>,
        $FutureProvider<IntensityIconData> {
  IntensityIconProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityIconProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityIconHash();

  @$internal
  @override
  $FutureProviderElement<IntensityIconData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IntensityIconData> create(Ref ref) {
    return intensityIcon(ref);
  }
}

String _$intensityIconHash() => r'1e4cf5537f7a7ae8558f7bf740e61dec2edb44b2';
