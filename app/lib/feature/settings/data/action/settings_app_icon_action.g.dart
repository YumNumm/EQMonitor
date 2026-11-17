// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'settings_app_icon_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsAppIconAction)
final settingsAppIconActionProvider = SettingsAppIconActionProvider._();

final class SettingsAppIconActionProvider
    extends
        $FunctionalProvider<
          SettingsAppIconAction,
          SettingsAppIconAction,
          SettingsAppIconAction
        >
    with $Provider<SettingsAppIconAction> {
  SettingsAppIconActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsAppIconActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsAppIconActionHash();

  @$internal
  @override
  $ProviderElement<SettingsAppIconAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsAppIconAction create(Ref ref) {
    return settingsAppIconAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsAppIconAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsAppIconAction>(value),
    );
  }
}

String _$settingsAppIconActionHash() =>
    r'70995bdad99f1cf228fe34e40d9d8bb38bc8a5a6';
