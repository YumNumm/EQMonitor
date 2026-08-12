// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_app_group_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugAppGroupAction)
final debugAppGroupActionProvider = DebugAppGroupActionProvider._();

final class DebugAppGroupActionProvider
    extends
        $FunctionalProvider<
          DebugAppGroupAction,
          DebugAppGroupAction,
          DebugAppGroupAction
        >
    with $Provider<DebugAppGroupAction> {
  DebugAppGroupActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAppGroupActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAppGroupActionHash();

  @$internal
  @override
  $ProviderElement<DebugAppGroupAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAppGroupAction create(Ref ref) {
    return debugAppGroupAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAppGroupAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAppGroupAction>(value),
    );
  }
}

String _$debugAppGroupActionHash() =>
    r'b5acbf3eaa88b5595840f4ccfbb2a8091f973009';
