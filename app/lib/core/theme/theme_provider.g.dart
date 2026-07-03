// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeModeNotifier)
final themeModeProvider = ThemeModeNotifierProvider._();

final class ThemeModeNotifierProvider
    extends $AsyncNotifierProvider<ThemeModeNotifier, ThemeMode> {
  ThemeModeNotifierProvider._()
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
}

String _$themeModeNotifierHash() => r'bc2ef8a73b04c25deda4229ffc73b105f3de8993';

abstract class _$ThemeModeNotifier extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
              AsyncValue<ThemeMode>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(BrightnessNotifier)
final brightnessProvider = BrightnessNotifierProvider._();

final class BrightnessNotifierProvider
    extends $NotifierProvider<BrightnessNotifier, ui.Brightness> {
  BrightnessNotifierProvider._()
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
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ui.Brightness, ui.Brightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ui.Brightness, ui.Brightness>,
              ui.Brightness,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
