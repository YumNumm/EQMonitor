// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'home_configuration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(HomeConfigurationNotifier)
const homeConfigurationNotifierProvider = HomeConfigurationNotifierProvider._();

final class HomeConfigurationNotifierProvider
    extends
        $NotifierProvider<HomeConfigurationNotifier, HomeConfigurationModel> {
  const HomeConfigurationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeConfigurationNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeConfigurationNotifierHash();

  @$internal
  @override
  HomeConfigurationNotifier create() => HomeConfigurationNotifier();

  @$internal
  @override
  $NotifierProviderElement<HomeConfigurationNotifier, HomeConfigurationModel>
  $createElement($ProviderPointer pointer) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeConfigurationModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<HomeConfigurationModel>(value),
    );
  }
}

String _$homeConfigurationNotifierHash() =>
    r'd304e781e1d01913d5f9b3c16c3e8fb27541f88b';

abstract class _$HomeConfigurationNotifier
    extends $Notifier<HomeConfigurationModel> {
  HomeConfigurationModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HomeConfigurationModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeConfigurationModel>,
              HomeConfigurationModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
