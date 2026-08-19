// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'forced_update_dialog_presenter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(forcedUpdateDialogPresenter)
final forcedUpdateDialogPresenterProvider =
    ForcedUpdateDialogPresenterProvider._();

final class ForcedUpdateDialogPresenterProvider
    extends
        $FunctionalProvider<
          ForcedUpdateDialogPresenter,
          ForcedUpdateDialogPresenter,
          ForcedUpdateDialogPresenter
        >
    with $Provider<ForcedUpdateDialogPresenter> {
  ForcedUpdateDialogPresenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forcedUpdateDialogPresenterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forcedUpdateDialogPresenterHash();

  @$internal
  @override
  $ProviderElement<ForcedUpdateDialogPresenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ForcedUpdateDialogPresenter create(Ref ref) {
    return forcedUpdateDialogPresenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForcedUpdateDialogPresenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForcedUpdateDialogPresenter>(value),
    );
  }
}

String _$forcedUpdateDialogPresenterHash() =>
    r'e946e0a062471ab88a1ee08e97b903109ef5f625';
