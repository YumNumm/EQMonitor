// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_global_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewGlobalSettingsNotifier)
final eewGlobalSettingsProvider = EewGlobalSettingsNotifierProvider._();

final class EewGlobalSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<EewGlobalSettingsNotifier, EewGlobalSettings> {
  EewGlobalSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewGlobalSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewGlobalSettingsNotifierHash();

  @$internal
  @override
  EewGlobalSettingsNotifier create() => EewGlobalSettingsNotifier();
}

String _$eewGlobalSettingsNotifierHash() =>
    r'c43f0ca59b9be7fc2684c0bfd8827d5f791f8ae2';

abstract class _$EewGlobalSettingsNotifier
    extends $AsyncNotifier<EewGlobalSettings> {
  FutureOr<EewGlobalSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<EewGlobalSettings>, EewGlobalSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EewGlobalSettings>, EewGlobalSettings>,
              AsyncValue<EewGlobalSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
