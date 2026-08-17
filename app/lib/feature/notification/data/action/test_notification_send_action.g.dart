// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_notification_send_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testNotificationSendAction)
final testNotificationSendActionProvider =
    TestNotificationSendActionProvider._();

final class TestNotificationSendActionProvider
    extends
        $FunctionalProvider<
          TestNotificationSendAction,
          TestNotificationSendAction,
          TestNotificationSendAction
        >
    with $Provider<TestNotificationSendAction> {
  TestNotificationSendActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testNotificationSendActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testNotificationSendActionHash();

  @$internal
  @override
  $ProviderElement<TestNotificationSendAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TestNotificationSendAction create(Ref ref) {
    return testNotificationSendAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TestNotificationSendAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TestNotificationSendAction>(value),
    );
  }
}

String _$testNotificationSendActionHash() =>
    r'07019f39ba08f449ac533f1e7f5532c04600a002';
