// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'contact_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contactTargetPlatform)
final contactTargetPlatformProvider = ContactTargetPlatformProvider._();

final class ContactTargetPlatformProvider
    extends $FunctionalProvider<TargetPlatform, TargetPlatform, TargetPlatform>
    with $Provider<TargetPlatform> {
  ContactTargetPlatformProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactTargetPlatformProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactTargetPlatformHash();

  @$internal
  @override
  $ProviderElement<TargetPlatform> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TargetPlatform create(Ref ref) {
    return contactTargetPlatform(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TargetPlatform value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TargetPlatform>(value),
    );
  }
}

String _$contactTargetPlatformHash() =>
    r'7582fd57371d5e390808e73900baa5a2a517728d';

@ProviderFor(contactUrl)
final contactUrlProvider = ContactUrlProvider._();

final class ContactUrlProvider
    extends $FunctionalProvider<AsyncValue<Uri>, Uri, FutureOr<Uri>>
    with $FutureModifier<Uri>, $FutureProvider<Uri> {
  ContactUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactUrlHash();

  @$internal
  @override
  $FutureProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uri> create(Ref ref) {
    return contactUrl(ref);
  }
}

String _$contactUrlHash() => r'a7cb0f978f61c7788d3d9e02a4291bc0ade05aed';

@ProviderFor(contactUrlLauncher)
final contactUrlLauncherProvider = ContactUrlLauncherProvider._();

final class ContactUrlLauncherProvider
    extends
        $FunctionalProvider<
          Future<bool> Function(Uri),
          Future<bool> Function(Uri),
          Future<bool> Function(Uri)
        >
    with $Provider<Future<bool> Function(Uri)> {
  ContactUrlLauncherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactUrlLauncherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactUrlLauncherHash();

  @$internal
  @override
  $ProviderElement<Future<bool> Function(Uri)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<bool> Function(Uri) create(Ref ref) {
    return contactUrlLauncher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<bool> Function(Uri) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<bool> Function(Uri)>(value),
    );
  }
}

String _$contactUrlLauncherHash() =>
    r'034198b70357baf3398f0db193037b56ac89df6d';

@ProviderFor(openContact)
final openContactProvider = OpenContactProvider._();

final class OpenContactProvider
    extends
        $FunctionalProvider<
          OpenContactAction,
          OpenContactAction,
          OpenContactAction
        >
    with $Provider<OpenContactAction> {
  OpenContactProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openContactProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openContactHash();

  @$internal
  @override
  $ProviderElement<OpenContactAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenContactAction create(Ref ref) {
    return openContact(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenContactAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenContactAction>(value),
    );
  }
}

String _$openContactHash() => r'6c4825b0be3eaaf12b8b061bac0c7f5c53f2f49c';
