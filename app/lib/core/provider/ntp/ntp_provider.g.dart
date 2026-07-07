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

final class NtpProvider extends $AsyncNotifierProvider<Ntp, NtpState> {
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
}

String _$ntpHash() => r'108cce1b0028d98175fa1eaa516106cfcb74dc15';

abstract class _$Ntp extends $AsyncNotifier<NtpState> {
  FutureOr<NtpState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NtpState>, NtpState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NtpState>, NtpState>,
              AsyncValue<NtpState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
