// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'store_screenshot_director.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StoreScreenshotDirector)
final storeScreenshotDirectorProvider = StoreScreenshotDirectorProvider._();

final class StoreScreenshotDirectorProvider
    extends $NotifierProvider<StoreScreenshotDirector, void> {
  StoreScreenshotDirectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storeScreenshotDirectorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storeScreenshotDirectorHash();

  @$internal
  @override
  StoreScreenshotDirector create() => StoreScreenshotDirector();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$storeScreenshotDirectorHash() =>
    r'75eba7158705105f750cb0f9bdb7c67e2a9b087d';

abstract class _$StoreScreenshotDirector extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
