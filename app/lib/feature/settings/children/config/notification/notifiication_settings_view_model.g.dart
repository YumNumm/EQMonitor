// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'notifiication_settings_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsStateImpl _$$NotificationSettingsStateImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NotificationSettingsStateImpl',
      json,
      ($checkedConvert) {
        final val = _$NotificationSettingsStateImpl(
          isNotificatioonPermissionAllowed: $checkedConvert(
              'isNotificatioonPermissionAllowed', (v) => v as bool),
          isVzse40Subscribed:
              $checkedConvert('isVzse40Subscribed', (v) => v as bool),
          isNoticeSubscribed:
              $checkedConvert('isNoticeSubscribed', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$NotificationSettingsStateImplToJson(
        _$NotificationSettingsStateImpl instance) =>
    <String, dynamic>{
      'isNotificatioonPermissionAllowed':
          instance.isNotificatioonPermissionAllowed,
      'isVzse40Subscribed': instance.isVzse40Subscribed,
      'isNoticeSubscribed': instance.isNoticeSubscribed,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationSettingsViewModelHash() =>
    r'd1daaa3edbf24a7e476a15035f21e8b1c5d18ff9';

/// See also [NotificationSettingsViewModel].
@ProviderFor(NotificationSettingsViewModel)
final notificationSettingsViewModelProvider = AutoDisposeNotifierProvider<
    NotificationSettingsViewModel, NotificationSettingsState>.internal(
  NotificationSettingsViewModel.new,
  name: r'notificationSettingsViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationSettingsViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationSettingsViewModel
    = AutoDisposeNotifier<NotificationSettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
