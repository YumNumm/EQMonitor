// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ntp_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Ntp)
const ntpProvider = NtpProvider._();

final class NtpProvider extends $NotifierProvider<Ntp, NtpStateModel> {
  const NtpProvider._()
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

String _$ntpHash() => r'f1cf77031c9013023256e11988e32e4019102541';

abstract class _$Ntp extends $Notifier<NtpStateModel> {
  NtpStateModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NtpStateModel, NtpStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NtpStateModel, NtpStateModel>,
              NtpStateModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
