// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'firebase_crashlytics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseCrashlytics)
final firebaseCrashlyticsProvider = FirebaseCrashlyticsProvider._();

final class FirebaseCrashlyticsProvider
    extends
        $FunctionalProvider<
          FirebaseCrashlytics,
          FirebaseCrashlytics,
          FirebaseCrashlytics
        >
    with $Provider<FirebaseCrashlytics> {
  FirebaseCrashlyticsProvider._()
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
