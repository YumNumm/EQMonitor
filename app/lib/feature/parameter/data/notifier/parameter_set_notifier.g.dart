// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_set_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParameterSetNotifier)
final parameterSetProvider = ParameterSetNotifierProvider._();

final class ParameterSetNotifierProvider
    extends $AsyncNotifierProvider<ParameterSetNotifier, ParameterSet> {
  ParameterSetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parameterSetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parameterSetNotifierHash();

  @$internal
  @override
  ParameterSetNotifier create() => ParameterSetNotifier();
}

String _$parameterSetNotifierHash() =>
    r'c5ab1eaa91a7ac5748630eff5dce0f0d073ff9db';

abstract class _$ParameterSetNotifier extends $AsyncNotifier<ParameterSet> {
  FutureOr<ParameterSet> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ParameterSet>, ParameterSet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ParameterSet>, ParameterSet>,
              AsyncValue<ParameterSet>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
