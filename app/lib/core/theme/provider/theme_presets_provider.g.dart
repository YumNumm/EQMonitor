// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'theme_presets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(themePresets)
final themePresetsProvider = ThemePresetsProvider._();

final class ThemePresetsProvider
    extends $FunctionalProvider<List<AppTheme>, List<AppTheme>, List<AppTheme>>
    with $Provider<List<AppTheme>> {
  ThemePresetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themePresetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themePresetsHash();

  @$internal
  @override
  $ProviderElement<List<AppTheme>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<AppTheme> create(Ref ref) {
    return themePresets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AppTheme> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AppTheme>>(value),
    );
  }
}

String _$themePresetsHash() => r'a6900a47dd914db3861d4ea5518fb479a650cb8a';
