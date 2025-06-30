// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Debug)
const debugProvider = DebugProvider._();

final class DebugProvider extends $NotifierProvider<Debug, bool> {
  const DebugProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugHash();

  @$internal
  @override
  Debug create() => Debug();

  @$internal
  @override
  $NotifierProviderElement<Debug, bool> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<bool>(value),
    );
  }
}

String _$debugHash() => r'85e7e71c874d4d76bf46d2d03c11826c40319162';

abstract class _$Debug extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
