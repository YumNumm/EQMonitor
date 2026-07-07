// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location_permission_banner_dismissed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationPermissionBannerDismissed)
final locationPermissionBannerDismissedProvider =
    LocationPermissionBannerDismissedProvider._();

final class LocationPermissionBannerDismissedProvider
    extends $AsyncNotifierProvider<LocationPermissionBannerDismissed, bool> {
  LocationPermissionBannerDismissedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionBannerDismissedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$locationPermissionBannerDismissedHash();

  @$internal
  @override
  LocationPermissionBannerDismissed create() =>
      LocationPermissionBannerDismissed();
}

String _$locationPermissionBannerDismissedHash() =>
    r'2525fe13700256a84fde3e83962f1df2f6f01c8f';

abstract class _$LocationPermissionBannerDismissed
    extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
