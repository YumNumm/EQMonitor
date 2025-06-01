// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'platform_brightness.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(PlatformBrightness)
const platformBrightnessProvider = PlatformBrightnessProvider._();

final class PlatformBrightnessProvider
    extends $NotifierProvider<PlatformBrightness, Brightness> {
  const PlatformBrightnessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformBrightnessProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$platformBrightnessHash();

  @$internal
  @override
  PlatformBrightness create() => PlatformBrightness();

  @$internal
  @override
  $NotifierProviderElement<PlatformBrightness, Brightness> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Brightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<Brightness>(value),
    );
  }
}

String _$platformBrightnessHash() =>
    r'e43fc04a4fd2a5fecc5c7c47cc022f3e56179bc9';

abstract class _$PlatformBrightness extends $Notifier<Brightness> {
  Brightness build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Brightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Brightness>,
              Brightness,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
