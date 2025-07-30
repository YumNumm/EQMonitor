// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'firebase_crashlytics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(firebaseCrashlytics)
const firebaseCrashlyticsProvider = FirebaseCrashlyticsProvider._();

final class FirebaseCrashlyticsProvider
    extends
        $FunctionalProvider<
          FirebaseCrashlytics,
          FirebaseCrashlytics,
          FirebaseCrashlytics
        >
    with $Provider<FirebaseCrashlytics> {
  const FirebaseCrashlyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseCrashlyticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseCrashlyticsHash();

  @$internal
  @override
  $ProviderElement<FirebaseCrashlytics> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseCrashlytics create(Ref ref) {
    return firebaseCrashlytics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseCrashlytics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseCrashlytics>(value),
    );
  }
}

String _$firebaseCrashlyticsHash() =>
    r'b676b545954cfaab78c5f4cfd7d774d97c96dcad';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
