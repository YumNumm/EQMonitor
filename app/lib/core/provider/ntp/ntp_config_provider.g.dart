// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ntp_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NtpConfig)
final ntpConfigProvider = NtpConfigProvider._();

final class NtpConfigProvider
    extends $AsyncNotifierProvider<NtpConfig, NtpConfigModel> {
  NtpConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ntpConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ntpConfigHash();

  @$internal
  @override
  NtpConfig create() => NtpConfig();
}

String _$ntpConfigHash() => r'459c8b150322a62b39d1013b395e17beab64d1e0';

abstract class _$NtpConfig extends $AsyncNotifier<NtpConfigModel> {
  FutureOr<NtpConfigModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NtpConfigModel>, NtpConfigModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NtpConfigModel>, NtpConfigModel>,
              AsyncValue<NtpConfigModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
