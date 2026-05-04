// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_parameter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jmaParameter)
final jmaParameterProvider = JmaParameterProvider._();

final class JmaParameterProvider
    extends
        $FunctionalProvider<
          AsyncValue<JmaParameterState>,
          JmaParameterState,
          FutureOr<JmaParameterState>
        >
    with
        $FutureModifier<JmaParameterState>,
        $FutureProvider<JmaParameterState> {
  JmaParameterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaParameterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaParameterHash();

  @$internal
  @override
  $FutureProviderElement<JmaParameterState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JmaParameterState> create(Ref ref) {
    return jmaParameter(ref);
  }
}

String _$jmaParameterHash() => r'7971760b2c25010dbc83e68aef3286beb7c88d96';
