// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'store_screenshot_session_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storeScreenshotSessionRepository)
final storeScreenshotSessionRepositoryProvider =
    StoreScreenshotSessionRepositoryProvider._();

final class StoreScreenshotSessionRepositoryProvider
    extends
        $FunctionalProvider<
          StoreScreenshotSessionRepository,
          StoreScreenshotSessionRepository,
          StoreScreenshotSessionRepository
        >
    with $Provider<StoreScreenshotSessionRepository> {
  StoreScreenshotSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storeScreenshotSessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storeScreenshotSessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<StoreScreenshotSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StoreScreenshotSessionRepository create(Ref ref) {
    return storeScreenshotSessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StoreScreenshotSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StoreScreenshotSessionRepository>(
        value,
      ),
    );
  }
}

String _$storeScreenshotSessionRepositoryHash() =>
    r'5ecfb3b579fc75d71597c7825b3850b12c86ed8e';
