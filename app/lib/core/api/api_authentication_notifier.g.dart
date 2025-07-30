// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'api_authentication_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ApiAuthenticationNotifier)
const apiAuthenticationNotifierProvider = ApiAuthenticationNotifierProvider._();

final class ApiAuthenticationNotifierProvider
    extends $AsyncNotifierProvider<ApiAuthenticationNotifier, String?> {
  const ApiAuthenticationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiAuthenticationNotifierProvider',
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
