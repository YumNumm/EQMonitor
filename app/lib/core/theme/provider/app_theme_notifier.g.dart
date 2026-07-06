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
        $NotifierProvider<
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    ({AppTheme darkTheme, AppTheme lightTheme}) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({AppTheme darkTheme, AppTheme lightTheme})>(
            value,
          ),
    );
  }
}

String _$appThemeNotifierHash() => r'9d54e7f0af2142999693962a584dc0124ac5ebf1';

abstract class _$AppThemeNotifier
    extends $Notifier<({AppTheme darkTheme, AppTheme lightTheme})> {
  ({AppTheme darkTheme, AppTheme lightTheme}) build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({AppTheme darkTheme, AppTheme lightTheme}),
              ({AppTheme darkTheme, AppTheme lightTheme})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({AppTheme darkTheme, AppTheme lightTheme}),
                ({AppTheme darkTheme, AppTheme lightTheme})
              >,
              ({AppTheme darkTheme, AppTheme lightTheme}),
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

String _$activeColorSetHash() => r'8a16219fcadf26e9ab422e6a36210c5577e07286';

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
    r'a5e456add7e92597b9d23beb29600d8ec3e68d94';

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
