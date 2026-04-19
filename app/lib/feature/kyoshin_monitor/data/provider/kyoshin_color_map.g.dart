// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_color_map.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinColorMap)
final kyoshinColorMapProvider = KyoshinColorMapProvider._();

final class KyoshinColorMapProvider
    extends
        $FunctionalProvider<
          List<KyoshinColorMapModel>,
          List<KyoshinColorMapModel>,
          List<KyoshinColorMapModel>
        >
    with $Provider<List<KyoshinColorMapModel>> {
  KyoshinColorMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinColorMapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinColorMapHash();

  @$internal
  @override
  $ProviderElement<List<KyoshinColorMapModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<KyoshinColorMapModel> create(Ref ref) {
    return kyoshinColorMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<KyoshinColorMapModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<KyoshinColorMapModel>>(value),
    );
  }
}

String _$kyoshinColorMapHash() => r'74b3acf2ebc484ef656b4184e435dc4861052c0f';
