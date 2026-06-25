// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_launch_recorder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appLaunchRecorder)
final appLaunchRecorderProvider = AppLaunchRecorderProvider._();

final class AppLaunchRecorderProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppLaunchRecorder>,
          AppLaunchRecorder,
          FutureOr<AppLaunchRecorder>
        >
    with
        $FutureModifier<AppLaunchRecorder>,
        $FutureProvider<AppLaunchRecorder> {
  AppLaunchRecorderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLaunchRecorderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLaunchRecorderHash();

  @$internal
  @override
  $FutureProviderElement<AppLaunchRecorder> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppLaunchRecorder> create(Ref ref) {
    return appLaunchRecorder(ref);
  }
}

String _$appLaunchRecorderHash() => r'671dc1d01d1c57b3c442ba79b6f41bc72791d253';
