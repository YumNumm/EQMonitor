// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_theme_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppThemeNotifier)
final appThemeProvider = AppThemeNotifierProvider._();

final class AppThemeNotifierProvider
    extends
        $AsyncNotifierProvider<
          AppThemeNotifier,
          ({AppTheme darkTheme, AppTheme lightTheme})
        > {
  AppThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeNotifierHash();

  @$internal
  @override
  AppThemeNotifier create() => AppThemeNotifier();
}

String _$appThemeNotifierHash() => r'1973fe0333a01fed0e58f1dbbc00f12aebed5798';

abstract class _$AppThemeNotifier
    extends $AsyncNotifier<({AppTheme darkTheme, AppTheme lightTheme})> {
  FutureOr<({AppTheme darkTheme, AppTheme lightTheme})> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<({AppTheme darkTheme, AppTheme lightTheme})>,
              ({AppTheme darkTheme, AppTheme lightTheme})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<({AppTheme darkTheme, AppTheme lightTheme})>,
                ({AppTheme darkTheme, AppTheme lightTheme})
              >,
              AsyncValue<({AppTheme darkTheme, AppTheme lightTheme})>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(activeColorSet)
final activeColorSetProvider = ActiveColorSetProvider._();

final class ActiveColorSetProvider
    extends $FunctionalProvider<ThemeColorSet, ThemeColorSet, ThemeColorSet>
    with $Provider<ThemeColorSet> {
  ActiveColorSetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeColorSetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeColorSetHash();

  @$internal
  @override
  $ProviderElement<ThemeColorSet> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeColorSet create(Ref ref) {
    return activeColorSet(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeColorSet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeColorSet>(value),
    );
  }
}

String _$activeColorSetHash() => r'96a2df8081657ffe1b38d60397ff2e758e497846';

@ProviderFor(colorSetForBrightness)
final colorSetForBrightnessProvider = ColorSetForBrightnessFamily._();

final class ColorSetForBrightnessProvider
    extends $FunctionalProvider<ThemeColorSet, ThemeColorSet, ThemeColorSet>
    with $Provider<ThemeColorSet> {
  ColorSetForBrightnessProvider._({
    required ColorSetForBrightnessFamily super.from,
    required Brightness super.argument,
  }) : super(
         retry: null,
         name: r'colorSetForBrightnessProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$colorSetForBrightnessHash();

  @override
  String toString() {
    return r'colorSetForBrightnessProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ThemeColorSet> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeColorSet create(Ref ref) {
    final argument = this.argument as Brightness;
    return colorSetForBrightness(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeColorSet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeColorSet>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ColorSetForBrightnessProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$colorSetForBrightnessHash() =>
    r'faf5a882aca1e8a1f3f9d3503a99a0b2ed323ea2';

final class ColorSetForBrightnessFamily extends $Family
    with $FunctionalFamilyOverride<ThemeColorSet, Brightness> {
  ColorSetForBrightnessFamily._()
    : super(
        retry: null,
        name: r'colorSetForBrightnessProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ColorSetForBrightnessProvider call(Brightness brightness) =>
      ColorSetForBrightnessProvider._(argument: brightness, from: this);

  @override
  String toString() => r'colorSetForBrightnessProvider';
}
