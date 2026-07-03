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

String _$ntpConfigHash() => r'ac98e16287cce39fb584c180b251f49e02e45d52';

abstract class _$NtpConfig extends $AsyncNotifier<NtpConfigModel> {
  FutureOr<NtpConfigModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NtpConfigModel>, NtpConfigModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NtpConfigModel>, NtpConfigModel>,
              AsyncValue<NtpConfigModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
