// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationTokenModelImpl _$$NotificationTokenModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NotificationTokenModelImpl',
      json,
      ($checkedConvert) {
        final val = _$NotificationTokenModelImpl(
          fcmToken: $checkedConvert('fcm_token', (v) => v as String?),
          apnsToken: $checkedConvert('apns_token', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'fcmToken': 'fcm_token', 'apnsToken': 'apns_token'},
    );

Map<String, dynamic> _$$NotificationTokenModelImplToJson(
        _$NotificationTokenModelImpl instance) =>
    <String, dynamic>{
      'fcm_token': instance.fcmToken,
      'apns_token': instance.apnsToken,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationTokenHash() => r'1d7efa28d4e4401069a1a4426fdbbd4b04239c5e';

/// See also [notificationToken].
@ProviderFor(notificationToken)
final notificationTokenProvider =
    AutoDisposeFutureProvider<NotificationTokenModel>.internal(
  notificationToken,
  name: r'notificationTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationTokenRef
    = AutoDisposeFutureProviderRef<NotificationTokenModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
