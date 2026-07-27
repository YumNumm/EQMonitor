// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_map_label_parameter_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeMapLabelParameterNotifier)
final homeMapLabelParameterProvider = HomeMapLabelParameterNotifierProvider._();

final class HomeMapLabelParameterNotifierProvider
    extends
        $AsyncNotifierProvider<
          HomeMapLabelParameterNotifier,
          HomeMapLabelParameter
        > {
  HomeMapLabelParameterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeMapLabelParameterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeMapLabelParameterNotifierHash();

  @$internal
  @override
  HomeMapLabelParameterNotifier create() => HomeMapLabelParameterNotifier();
}

String _$homeMapLabelParameterNotifierHash() =>
    r'1725aba5eec4e4551e79967e768120db1983c986';

abstract class _$HomeMapLabelParameterNotifier
    extends $AsyncNotifier<HomeMapLabelParameter> {
  FutureOr<HomeMapLabelParameter> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<HomeMapLabelParameter>, HomeMapLabelParameter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<HomeMapLabelParameter>,
                HomeMapLabelParameter
              >,
              AsyncValue<HomeMapLabelParameter>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
