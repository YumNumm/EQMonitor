// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_config_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewWarningConfigNotifier)
final eewWarningConfigProvider = EewWarningConfigNotifierProvider._();

final class EewWarningConfigNotifierProvider
    extends
        $AsyncNotifierProvider<EewWarningConfigNotifier, EewWarningSettings> {
  EewWarningConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningConfigNotifierHash();

  @$internal
  @override
  EewWarningConfigNotifier create() => EewWarningConfigNotifier();
}

String _$eewWarningConfigNotifierHash() =>
    r'9b2629b6c48b3b41edfa72a1cd41b066df12b4f5';

abstract class _$EewWarningConfigNotifier
    extends $AsyncNotifier<EewWarningSettings> {
  FutureOr<EewWarningSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<EewWarningSettings>, EewWarningSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EewWarningSettings>, EewWarningSettings>,
              AsyncValue<EewWarningSettings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
