// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_shared_preferences_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_debugPreferencesEditorAction)
final _debugPreferencesEditorActionProvider =
    _DebugPreferencesEditorActionProvider._();

final class _DebugPreferencesEditorActionProvider
    extends
        $FunctionalProvider<
          _DebugPreferencesEditorAction,
          _DebugPreferencesEditorAction,
          _DebugPreferencesEditorAction
        >
    with $Provider<_DebugPreferencesEditorAction> {
  _DebugPreferencesEditorActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_debugPreferencesEditorActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_debugPreferencesEditorActionHash();

  @$internal
  @override
  $ProviderElement<_DebugPreferencesEditorAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  _DebugPreferencesEditorAction create(Ref ref) {
    return _debugPreferencesEditorAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(_DebugPreferencesEditorAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<_DebugPreferencesEditorAction>(
        value,
      ),
    );
  }
}

String _$_debugPreferencesEditorActionHash() =>
    r'594c4d53250b21ab4fe15cdb89b9fd71b25999d6';
