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
        $NotifierProvider<KyoshinMonitorSettings, KyoshinMonitorSettingsModel> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorSettingsModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorSettingsModel>(value),
    );
  }
}

String _$kyoshinMonitorSettingsHash() =>
    r'6e7b5c58da4f50177bda98f59deec91e8292a9db';

abstract class _$KyoshinMonitorSettings
    extends $Notifier<KyoshinMonitorSettingsModel> {
  KyoshinMonitorSettingsModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<KyoshinMonitorSettingsModel, KyoshinMonitorSettingsModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                KyoshinMonitorSettingsModel,
                KyoshinMonitorSettingsModel
              >,
              KyoshinMonitorSettingsModel,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
