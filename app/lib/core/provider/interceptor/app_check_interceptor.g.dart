// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_check_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appCheckInterceptor)
final appCheckInterceptorProvider = AppCheckInterceptorProvider._();

final class AppCheckInterceptorProvider
    extends
        $FunctionalProvider<
          AppCheckInterceptor,
          AppCheckInterceptor,
          AppCheckInterceptor
        >
    with $Provider<AppCheckInterceptor> {
  AppCheckInterceptorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appCheckInterceptorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appCheckInterceptorHash();

  @$internal
  @override
  $ProviderElement<AppCheckInterceptor> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppCheckInterceptor create(Ref ref) {
    return appCheckInterceptor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppCheckInterceptor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppCheckInterceptor>(value),
    );
  }
}

String _$appCheckInterceptorHash() =>
    r'a3d3e299ae67e1cb5fef35c3c41a83e8f38ee908';
