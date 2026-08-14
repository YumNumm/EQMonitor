// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'error_details_sheet.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(errorDetailsSheetAction)
final errorDetailsSheetActionProvider = ErrorDetailsSheetActionProvider._();

final class ErrorDetailsSheetActionProvider
    extends
        $FunctionalProvider<
          ErrorDetailsSheetAction,
          ErrorDetailsSheetAction,
          ErrorDetailsSheetAction
        >
    with $Provider<ErrorDetailsSheetAction> {
  ErrorDetailsSheetActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorDetailsSheetActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorDetailsSheetActionHash();

  @$internal
  @override
  $ProviderElement<ErrorDetailsSheetAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ErrorDetailsSheetAction create(Ref ref) {
    return errorDetailsSheetAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorDetailsSheetAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorDetailsSheetAction>(value),
    );
  }
}

String _$errorDetailsSheetActionHash() =>
    r'bab5f3eab39139ff6aa13930425167e4fa615a9d';
