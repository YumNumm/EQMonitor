// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'custom_notification_sounds_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomNotificationSoundsNotifier)
final customNotificationSoundsProvider =
    CustomNotificationSoundsNotifierProvider._();

final class CustomNotificationSoundsNotifierProvider
    extends
        $AsyncNotifierProvider<
          CustomNotificationSoundsNotifier,
          List<CustomNotificationSound>
        > {
  CustomNotificationSoundsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customNotificationSoundsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customNotificationSoundsNotifierHash();

  @$internal
  @override
  CustomNotificationSoundsNotifier create() =>
      CustomNotificationSoundsNotifier();
}

String _$customNotificationSoundsNotifierHash() =>
    r'8adc46c9d644267caf4f7fd0730b41df4b058b09';

abstract class _$CustomNotificationSoundsNotifier
    extends $AsyncNotifier<List<CustomNotificationSound>> {
  FutureOr<List<CustomNotificationSound>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CustomNotificationSound>>,
              List<CustomNotificationSound>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CustomNotificationSound>>,
                List<CustomNotificationSound>
              >,
              AsyncValue<List<CustomNotificationSound>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
