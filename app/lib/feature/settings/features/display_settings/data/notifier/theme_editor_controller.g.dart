// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'theme_editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeEditorController)
final themeEditorControllerProvider = ThemeEditorControllerFamily._();

final class ThemeEditorControllerProvider
    extends $NotifierProvider<ThemeEditorController, ThemeColorSet> {
  ThemeEditorControllerProvider._({
    required ThemeEditorControllerFamily super.from,
    required ThemeBrightnessMode super.argument,
  }) : super(
         retry: null,
         name: r'themeEditorControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$themeEditorControllerHash();

  @override
  String toString() {
    return r'themeEditorControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ThemeEditorController create() => ThemeEditorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeColorSet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeColorSet>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeEditorControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$themeEditorControllerHash() =>
    r'3fe2cb83027cfe5a381f37e66b88a1f8e8e521ea';

final class ThemeEditorControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ThemeEditorController,
          ThemeColorSet,
          ThemeColorSet,
          ThemeColorSet,
          ThemeBrightnessMode
        > {
  ThemeEditorControllerFamily._()
    : super(
        retry: null,
        name: r'themeEditorControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ThemeEditorControllerProvider call(ThemeBrightnessMode mode) =>
      ThemeEditorControllerProvider._(argument: mode, from: this);

  @override
  String toString() => r'themeEditorControllerProvider';
}

abstract class _$ThemeEditorController extends $Notifier<ThemeColorSet> {
  late final _$args = ref.$arg as ThemeBrightnessMode;
  ThemeBrightnessMode get mode => _$args;

  ThemeColorSet build(ThemeBrightnessMode mode);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeColorSet, ThemeColorSet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeColorSet, ThemeColorSet>,
              ThemeColorSet,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
