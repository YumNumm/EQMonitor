// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// OS の通知許可状態(granted)を保持する。
/// アプリがフォアグラウンド復帰した時に自動で再取得する。

@ProviderFor(isNotificationPermissionGranted)
final isNotificationPermissionGrantedProvider =
    IsNotificationPermissionGrantedProvider._();

/// OS の通知許可状態(granted)を保持する。
/// アプリがフォアグラウンド復帰した時に自動で再取得する。

final class IsNotificationPermissionGrantedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// OS の通知許可状態(granted)を保持する。
  /// アプリがフォアグラウンド復帰した時に自動で再取得する。
  IsNotificationPermissionGrantedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isNotificationPermissionGrantedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isNotificationPermissionGrantedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isNotificationPermissionGranted(ref);
  }
}

String _$isNotificationPermissionGrantedHash() =>
    r'77c905b5144e3918ce4d3c88e5dcc4dd39495d2c';
