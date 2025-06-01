// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'ntp_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NtpConfig)
const ntpConfigProvider = NtpConfigProvider._();

final class NtpConfigProvider
    extends $NotifierProvider<NtpConfig, NtpConfigModel> {
  const NtpConfigProvider._()
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

  @$internal
  @override
  $NotifierProviderElement<NtpConfig, NtpConfigModel> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NtpConfigModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<NtpConfigModel>(value),
    );
  }
}

String _$ntpConfigHash() => r'ea839c3c8aa2d5b12e392bacb05eb123541d753b';

abstract class _$NtpConfig extends $Notifier<NtpConfigModel> {
  NtpConfigModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NtpConfigModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NtpConfigModel>,
              NtpConfigModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
