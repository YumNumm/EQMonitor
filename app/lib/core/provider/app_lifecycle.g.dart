// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'app_lifecycle.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// ref: https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle
@ProviderFor(AppLifecycle)
const appLifecycleProvider = AppLifecycleProvider._();

/// ref: https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle
final class AppLifecycleProvider
    extends $NotifierProvider<AppLifecycle, AppLifecycleState> {
  /// ref: https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle
  const AppLifecycleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLifecycleHash();

  @$internal
  @override
  AppLifecycle create() => AppLifecycle();

  @$internal
  @override
  $NotifierProviderElement<AppLifecycle, AppLifecycleState> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLifecycleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<AppLifecycleState>(value),
    );
  }
}

String _$appLifecycleHash() => r'9e357a2c4983fa88f3ed65162de86ce5813fb838';

abstract class _$AppLifecycle extends $Notifier<AppLifecycleState> {
  AppLifecycleState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppLifecycleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLifecycleState>,
              AppLifecycleState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
