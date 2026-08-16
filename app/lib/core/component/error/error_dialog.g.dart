// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'error_dialog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(errorDialogAction)
final errorDialogActionProvider = ErrorDialogActionProvider._();

final class ErrorDialogActionProvider
    extends
        $FunctionalProvider<
          ErrorDialogAction,
          ErrorDialogAction,
          ErrorDialogAction
        >
    with $Provider<ErrorDialogAction> {
  ErrorDialogActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorDialogActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorDialogActionHash();

  @$internal
  @override
  $ProviderElement<ErrorDialogAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ErrorDialogAction create(Ref ref) {
    return errorDialogAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorDialogAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorDialogAction>(value),
    );
  }
}

String _$errorDialogActionHash() => r'73258552024314f1475a2f7259ffff1df2c330a8';
