// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ntp_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Ntp)
final ntpProvider = NtpProvider._();

final class NtpProvider extends $NotifierProvider<Ntp, NtpStateModel> {
  NtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ntpProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ntpHash();

  @$internal
  @override
  Ntp create() => Ntp();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NtpStateModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NtpStateModel>(value),
    );
  }
}

String _$ntpHash() => r'a1a7bc977b5acc5a68f99efa734f4035afc7695a';

abstract class _$Ntp extends $Notifier<NtpStateModel> {
  NtpStateModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NtpStateModel, NtpStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NtpStateModel, NtpStateModel>,
              NtpStateModel,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
