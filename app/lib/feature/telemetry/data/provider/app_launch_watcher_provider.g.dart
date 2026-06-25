// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_launch_watcher_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Watches the app lifecycle and records [AppLaunchRecorder] events.
///
/// On cold start (`build`), records a `cold_start` event immediately.
/// When the app resumes from background, records a `resume` event
/// (subject to the 30-second debounce inside [AppLaunchRecorder]).
///
/// Register this provider in `main.dart` by calling
/// `container.read(appLaunchWatcherProvider)`.

@ProviderFor(AppLaunchWatcher)
final appLaunchWatcherProvider = AppLaunchWatcherProvider._();

/// Watches the app lifecycle and records [AppLaunchRecorder] events.
///
/// On cold start (`build`), records a `cold_start` event immediately.
/// When the app resumes from background, records a `resume` event
/// (subject to the 30-second debounce inside [AppLaunchRecorder]).
///
/// Register this provider in `main.dart` by calling
/// `container.read(appLaunchWatcherProvider)`.
final class AppLaunchWatcherProvider
    extends $NotifierProvider<AppLaunchWatcher, void> {
  /// Watches the app lifecycle and records [AppLaunchRecorder] events.
  ///
  /// On cold start (`build`), records a `cold_start` event immediately.
  /// When the app resumes from background, records a `resume` event
  /// (subject to the 30-second debounce inside [AppLaunchRecorder]).
  ///
  /// Register this provider in `main.dart` by calling
  /// `container.read(appLaunchWatcherProvider)`.
  AppLaunchWatcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLaunchWatcherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLaunchWatcherHash();

  @$internal
  @override
  AppLaunchWatcher create() => AppLaunchWatcher();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$appLaunchWatcherHash() => r'e95cf5059d471b51f1417e9ec5b7f7dfc59bb584';

/// Watches the app lifecycle and records [AppLaunchRecorder] events.
///
/// On cold start (`build`), records a `cold_start` event immediately.
/// When the app resumes from background, records a `resume` event
/// (subject to the 30-second debounce inside [AppLaunchRecorder]).
///
/// Register this provider in `main.dart` by calling
/// `container.read(appLaunchWatcherProvider)`.

abstract class _$AppLaunchWatcher extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
