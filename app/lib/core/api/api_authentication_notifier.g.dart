// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'api_authentication_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApiAuthenticationNotifier)
const apiAuthenticationProvider = ApiAuthenticationNotifierProvider._();

final class ApiAuthenticationNotifierProvider
    extends $AsyncNotifierProvider<ApiAuthenticationNotifier, String?> {
  const ApiAuthenticationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiAuthenticationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiAuthenticationNotifierHash();

  @$internal
  @override
  ApiAuthenticationNotifier create() => ApiAuthenticationNotifier();
}

String _$apiAuthenticationNotifierHash() =>
    r'58c92c79f8b9c6eaea300322c2ad6d9ed7594881';

abstract class _$ApiAuthenticationNotifier extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
