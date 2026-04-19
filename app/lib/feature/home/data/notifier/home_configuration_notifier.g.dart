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
    r'3dd7a380e389aaf19a8657d398ee1e219c20c64b';

abstract class _$HomeConfigurationNotifier
    extends $AsyncNotifier<HomeConfigurationModel> {
  FutureOr<HomeConfigurationModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
