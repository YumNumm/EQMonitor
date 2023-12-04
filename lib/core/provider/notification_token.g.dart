// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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
          fcmToken: $checkedConvert('fcmToken', (v) => v as String?),
          apnsToken: $checkedConvert('apnsToken', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$NotificationTokenModelImplToJson(
        _$NotificationTokenModelImpl instance) =>
    <String, dynamic>{
      'fcmToken': instance.fcmToken,
      'apnsToken': instance.apnsToken,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationTokenHash() => r'5b68207ebeb2f303b2c33482387e16324e80479a';

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

typedef NotificationTokenRef
    = AutoDisposeFutureProviderRef<NotificationTokenModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
