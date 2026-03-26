// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IntensityColor)
final intensityColorProvider = IntensityColorProvider._();

final class IntensityColorProvider
    extends $AsyncNotifierProvider<IntensityColor, IntensityColorModel> {
  IntensityColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityColorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityColorHash();

  @$internal
  @override
  IntensityColor create() => IntensityColor();
}

String _$intensityColorHash() => r'9c75c8ceb246c0929f3e94366ec8f8c69f2fcabe';

abstract class _$IntensityColor extends $AsyncNotifier<IntensityColorModel> {
  FutureOr<IntensityColorModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<IntensityColorModel>, IntensityColorModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IntensityColorModel>, IntensityColorModel>,
              AsyncValue<IntensityColorModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
