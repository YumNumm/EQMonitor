// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KyoshinMonitorSettings)
final kyoshinMonitorSettingsProvider = KyoshinMonitorSettingsProvider._();

final class KyoshinMonitorSettingsProvider
    extends
        $AsyncNotifierProvider<
          KyoshinMonitorSettings,
          KyoshinMonitorSettingsModel
        > {
  KyoshinMonitorSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorSettingsHash();

  @$internal
  @override
  KyoshinMonitorSettings create() => KyoshinMonitorSettings();
}

String _$kyoshinMonitorSettingsHash() =>
    r'be53c983e73cd5cdf70c27caacfb4e8defddd24d';

abstract class _$KyoshinMonitorSettings
    extends $AsyncNotifier<KyoshinMonitorSettingsModel> {
  FutureOr<KyoshinMonitorSettingsModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<KyoshinMonitorSettingsModel>,
              KyoshinMonitorSettingsModel
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<KyoshinMonitorSettingsModel>,
                KyoshinMonitorSettingsModel
              >,
              AsyncValue<KyoshinMonitorSettingsModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
