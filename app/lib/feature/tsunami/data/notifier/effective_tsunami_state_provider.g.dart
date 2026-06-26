// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'effective_tsunami_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(effectiveTsunamiState)
final effectiveTsunamiStateProvider = EffectiveTsunamiStateFamily._();

final class EffectiveTsunamiStateProvider
    extends $FunctionalProvider<TsunamiState?, TsunamiState?, TsunamiState?>
    with $Provider<TsunamiState?> {
  EffectiveTsunamiStateProvider._({
    required EffectiveTsunamiStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'effectiveTsunamiStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$effectiveTsunamiStateHash();

  @override
  String toString() {
    return r'effectiveTsunamiStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<TsunamiState?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TsunamiState? create(Ref ref) {
    final argument = this.argument as String;
    return effectiveTsunamiState(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TsunamiState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TsunamiState?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EffectiveTsunamiStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$effectiveTsunamiStateHash() =>
    r'7e966c79fc5390a6655ceaeb1c06cb735a37db89';

final class EffectiveTsunamiStateFamily extends $Family
    with $FunctionalFamilyOverride<TsunamiState?, String> {
  EffectiveTsunamiStateFamily._()
    : super(
        retry: null,
        name: r'effectiveTsunamiStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EffectiveTsunamiStateProvider call(String tsunamiId) =>
      EffectiveTsunamiStateProvider._(argument: tsunamiId, from: this);

  @override
  String toString() => r'effectiveTsunamiStateProvider';
}
