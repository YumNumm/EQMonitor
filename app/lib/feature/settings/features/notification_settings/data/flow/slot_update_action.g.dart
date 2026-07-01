// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'slot_update_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(slotUpdateAction)
final slotUpdateActionProvider = SlotUpdateActionProvider._();

final class SlotUpdateActionProvider
    extends
        $FunctionalProvider<
          SlotUpdateAction,
          SlotUpdateAction,
          SlotUpdateAction
        >
    with $Provider<SlotUpdateAction> {
  SlotUpdateActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'slotUpdateActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$slotUpdateActionHash();

  @$internal
  @override
  $ProviderElement<SlotUpdateAction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SlotUpdateAction create(Ref ref) {
    return slotUpdateAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SlotUpdateAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SlotUpdateAction>(value),
    );
  }
}

String _$slotUpdateActionHash() => r'3a80049b312a7ef8ebe9114c6b19bf5d8b0f2780';
