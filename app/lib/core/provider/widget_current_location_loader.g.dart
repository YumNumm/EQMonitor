// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'widget_current_location_loader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(widgetCurrentLocationLoader)
final widgetCurrentLocationLoaderProvider =
    WidgetCurrentLocationLoaderProvider._();

final class WidgetCurrentLocationLoaderProvider
    extends
        $FunctionalProvider<
          WidgetCurrentLocationLoader,
          WidgetCurrentLocationLoader,
          WidgetCurrentLocationLoader
        >
    with $Provider<WidgetCurrentLocationLoader> {
  WidgetCurrentLocationLoaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetCurrentLocationLoaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetCurrentLocationLoaderHash();

  @$internal
  @override
  $ProviderElement<WidgetCurrentLocationLoader> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WidgetCurrentLocationLoader create(Ref ref) {
    return widgetCurrentLocationLoader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetCurrentLocationLoader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetCurrentLocationLoader>(value),
    );
  }
}

String _$widgetCurrentLocationLoaderHash() =>
    r'710da1a3b79cdb08385480bf348338f5cb7941f5';
