// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_configuration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeConfigurationNotifier)
const homeConfigurationProvider = HomeConfigurationNotifierProvider._();

final class HomeConfigurationNotifierProvider
    extends
        $NotifierProvider<HomeConfigurationNotifier, HomeConfigurationModel> {
  const HomeConfigurationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeConfigurationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeConfigurationNotifierHash();

  @$internal
  @override
  HomeConfigurationNotifier create() => HomeConfigurationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeConfigurationModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeConfigurationModel>(value),
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
    final ref =
        this.ref as $Ref<HomeConfigurationModel, HomeConfigurationModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeConfigurationModel, HomeConfigurationModel>,
              HomeConfigurationModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
