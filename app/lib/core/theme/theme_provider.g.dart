// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeModeNotifier)
const themeModeProvider = ThemeModeNotifierProvider._();

final class ThemeModeNotifierProvider
    extends $NotifierProvider<ThemeModeNotifier, ThemeMode> {
  const ThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeNotifierHash() => r'fc896b63bda7ea9e58659851b10234f4074bab94';

abstract class _$ThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(BrightnessNotifier)
const brightnessProvider = BrightnessNotifierProvider._();

final class BrightnessNotifierProvider
    extends $NotifierProvider<BrightnessNotifier, ui.Brightness> {
  const BrightnessNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'brightnessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$brightnessNotifierHash();

  @$internal
  @override
  BrightnessNotifier create() => BrightnessNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ui.Brightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ui.Brightness>(value),
    );
  }
}

String _$brightnessNotifierHash() =>
    r'88e015eda55ab1620f249131f4b6e002121cb237';

abstract class _$BrightnessNotifier extends $Notifier<ui.Brightness> {
  ui.Brightness build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ui.Brightness, ui.Brightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ui.Brightness, ui.Brightness>,
              ui.Brightness,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
