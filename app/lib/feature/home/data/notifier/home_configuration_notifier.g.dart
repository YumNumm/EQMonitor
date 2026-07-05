// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_configuration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeConfigurationNotifier)
final homeConfigurationProvider = HomeConfigurationNotifierProvider._();

final class HomeConfigurationNotifierProvider
    extends
        $AsyncNotifierProvider<
          HomeConfigurationNotifier,
          HomeConfigurationModel
        > {
  HomeConfigurationNotifierProvider._()
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
}

String _$homeConfigurationNotifierHash() =>
    r'979e4b49665f95f3683d1b8bf523c1fa4e4646a3';

abstract class _$HomeConfigurationNotifier
    extends $AsyncNotifier<HomeConfigurationModel> {
  FutureOr<HomeConfigurationModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<HomeConfigurationModel>, HomeConfigurationModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<HomeConfigurationModel>,
                HomeConfigurationModel
              >,
              AsyncValue<HomeConfigurationModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
