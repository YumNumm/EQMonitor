// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ai_credentials_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AiCredentialsNotifier)
final aiCredentialsProvider = AiCredentialsNotifierProvider._();

final class AiCredentialsNotifierProvider
    extends $AsyncNotifierProvider<AiCredentialsNotifier, AiCredentialsStore> {
  AiCredentialsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCredentialsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCredentialsNotifierHash();

  @$internal
  @override
  AiCredentialsNotifier create() => AiCredentialsNotifier();
}

String _$aiCredentialsNotifierHash() =>
    r'614d02067ba7631ef2629b910d4f3672d9d5a699';

abstract class _$AiCredentialsNotifier
    extends $AsyncNotifier<AiCredentialsStore> {
  FutureOr<AiCredentialsStore> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AiCredentialsStore>, AiCredentialsStore>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AiCredentialsStore>, AiCredentialsStore>,
              AsyncValue<AiCredentialsStore>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
