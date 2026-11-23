// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_creation_entry_available_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayCreationEntryAvailable)
final replayCreationEntryAvailableProvider =
    ReplayCreationEntryAvailableFamily._();

final class ReplayCreationEntryAvailableProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  ReplayCreationEntryAvailableProvider._({
    required ReplayCreationEntryAvailableFamily super.from,
    required DateTime? super.argument,
  }) : super(
         retry: null,
         name: r'replayCreationEntryAvailableProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$replayCreationEntryAvailableHash();

  @override
  String toString() {
    return r'replayCreationEntryAvailableProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as DateTime?;
    return replayCreationEntryAvailable(ref, originTime: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReplayCreationEntryAvailableProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$replayCreationEntryAvailableHash() =>
    r'7472137b2408c7c7ae3c806a443975c574b0c10c';

final class ReplayCreationEntryAvailableFamily extends $Family
    with $FunctionalFamilyOverride<bool, DateTime?> {
  ReplayCreationEntryAvailableFamily._()
    : super(
        retry: null,
        name: r'replayCreationEntryAvailableProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReplayCreationEntryAvailableProvider call({required DateTime? originTime}) =>
      ReplayCreationEntryAvailableProvider._(argument: originTime, from: this);

  @override
  String toString() => r'replayCreationEntryAvailableProvider';
}
