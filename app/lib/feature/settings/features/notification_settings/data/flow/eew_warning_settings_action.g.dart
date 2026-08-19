// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_settings_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewWarningSettingsAction)
final eewWarningSettingsActionProvider = EewWarningSettingsActionProvider._();

final class EewWarningSettingsActionProvider
    extends
        $FunctionalProvider<
          EewWarningSettingsAction,
          EewWarningSettingsAction,
          EewWarningSettingsAction
        >
    with $Provider<EewWarningSettingsAction> {
  EewWarningSettingsActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningSettingsActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningSettingsActionHash();

  @$internal
  @override
  $ProviderElement<EewWarningSettingsAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EewWarningSettingsAction create(Ref ref) {
    return eewWarningSettingsAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewWarningSettingsAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewWarningSettingsAction>(value),
    );
  }
}

String _$eewWarningSettingsActionHash() =>
    r'e226d631b23e515103547113b65d1f6bbf56ae74';
