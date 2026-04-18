// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_map_isolate.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jmaMapIsolate)
final jmaMapIsolateProvider = JmaMapIsolateProvider._();

final class JmaMapIsolateProvider
    extends
        $FunctionalProvider<
          AsyncValue<JmaMapIsolate>,
          JmaMapIsolate,
          FutureOr<JmaMapIsolate>
        >
    with $FutureModifier<JmaMapIsolate>, $FutureProvider<JmaMapIsolate> {
  JmaMapIsolateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaMapIsolateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaMapIsolateHash();

  @$internal
  @override
  $FutureProviderElement<JmaMapIsolate> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JmaMapIsolate> create(Ref ref) {
    return jmaMapIsolate(ref);
  }
}

String _$jmaMapIsolateHash() => r'ceebc450b0cd5b11a7e414ead059241f226cb21b';
