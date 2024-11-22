//
//  Generated code. Do not modify.
//  source: notification_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use notificationSettingsDescriptor instead')
const NotificationSettings$json = {
  '1': 'NotificationSettings',
  '2': [
    {
      '1': 'eew_settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.eqmonitor.NotificationSettings.EewSettings',
      '10': 'eewSettings'
    },
    {
      '1': 'earthquake_settings',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.eqmonitor.NotificationSettings.EarthquakeSettings',
      '10': 'earthquakeSettings'
    },
  ],
  '3': [
    NotificationSettings_EewSettings$json,
    NotificationSettings_EarthquakeSettings$json
  ],
};

@$core.Deprecated('Use notificationSettingsDescriptor instead')
const NotificationSettings_EewSettings$json = {
  '1': 'EewSettings',
  '2': [
    {
      '1': 'emergency_intensity',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '9': 0,
      '10': 'emergencyIntensity',
      '17': true
    },
    {
      '1': 'silent_intensity',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '9': 1,
      '10': 'silentIntensity',
      '17': true
    },
    {
      '1': 'regions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.eqmonitor.NotificationSettings.EewSettings.Region',
      '10': 'regions'
    },
  ],
  '3': [NotificationSettings_EewSettings_Region$json],
  '8': [
    {'1': '_emergency_intensity'},
    {'1': '_silent_intensity'},
  ],
};

@$core.Deprecated('Use notificationSettingsDescriptor instead')
const NotificationSettings_EewSettings_Region$json = {
  '1': 'Region',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'emergency_intensity',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '10': 'emergencyIntensity'
    },
    {
      '1': 'silent_intensity',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '10': 'silentIntensity'
    },
    {'1': 'is_main', '3': 5, '4': 1, '5': 8, '10': 'isMain'},
  ],
};

@$core.Deprecated('Use notificationSettingsDescriptor instead')
const NotificationSettings_EarthquakeSettings$json = {
  '1': 'EarthquakeSettings',
  '2': [
    {
      '1': 'emergency_intensity',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '9': 0,
      '10': 'emergencyIntensity',
      '17': true
    },
    {
      '1': 'silent_intensity',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '9': 1,
      '10': 'silentIntensity',
      '17': true
    },
    {
      '1': 'regions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.eqmonitor.NotificationSettings.EarthquakeSettings.Region',
      '10': 'regions'
    },
  ],
  '3': [NotificationSettings_EarthquakeSettings_Region$json],
  '8': [
    {'1': '_emergency_intensity'},
    {'1': '_silent_intensity'},
  ],
};

@$core.Deprecated('Use notificationSettingsDescriptor instead')
const NotificationSettings_EarthquakeSettings_Region$json = {
  '1': 'Region',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'emergency_intensity',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '10': 'emergencyIntensity'
    },
    {
      '1': 'silent_intensity',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.eqmonitor.JmaIntensity',
      '10': 'silentIntensity'
    },
    {'1': 'is_main', '3': 5, '4': 1, '5': 8, '10': 'isMain'},
  ],
};

/// Descriptor for `NotificationSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationSettingsDescriptor = $convert.base64Decode(
    'ChROb3RpZmljYXRpb25TZXR0aW5ncxJOCgxlZXdfc2V0dGluZ3MYASABKAsyKy5lcW1vbml0b3'
    'IuTm90aWZpY2F0aW9uU2V0dGluZ3MuRWV3U2V0dGluZ3NSC2Vld1NldHRpbmdzEmMKE2VhcnRo'
    'cXVha2Vfc2V0dGluZ3MYAiABKAsyMi5lcW1vbml0b3IuTm90aWZpY2F0aW9uU2V0dGluZ3MuRW'
    'FydGhxdWFrZVNldHRpbmdzUhJlYXJ0aHF1YWtlU2V0dGluZ3Ma+gMKC0Vld1NldHRpbmdzEk0K'
    'E2VtZXJnZW5jeV9pbnRlbnNpdHkYASABKA4yFy5lcW1vbml0b3IuSm1hSW50ZW5zaXR5SABSEm'
    'VtZXJnZW5jeUludGVuc2l0eYgBARJHChBzaWxlbnRfaW50ZW5zaXR5GAIgASgOMhcuZXFtb25p'
    'dG9yLkptYUludGVuc2l0eUgBUg9zaWxlbnRJbnRlbnNpdHmIAQESTAoHcmVnaW9ucxgDIAMoCz'
    'IyLmVxbW9uaXRvci5Ob3RpZmljYXRpb25TZXR0aW5ncy5FZXdTZXR0aW5ncy5SZWdpb25SB3Jl'
    'Z2lvbnMa1wEKBlJlZ2lvbhISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG5hbWUYAiABKAlSBG5hbW'
    'USSAoTZW1lcmdlbmN5X2ludGVuc2l0eRgDIAEoDjIXLmVxbW9uaXRvci5KbWFJbnRlbnNpdHlS'
    'EmVtZXJnZW5jeUludGVuc2l0eRJCChBzaWxlbnRfaW50ZW5zaXR5GAQgASgOMhcuZXFtb25pdG'
    '9yLkptYUludGVuc2l0eVIPc2lsZW50SW50ZW5zaXR5EhcKB2lzX21haW4YBSABKAhSBmlzTWFp'
    'bkIWChRfZW1lcmdlbmN5X2ludGVuc2l0eUITChFfc2lsZW50X2ludGVuc2l0eRqIBAoSRWFydG'
    'hxdWFrZVNldHRpbmdzEk0KE2VtZXJnZW5jeV9pbnRlbnNpdHkYASABKA4yFy5lcW1vbml0b3Iu'
    'Sm1hSW50ZW5zaXR5SABSEmVtZXJnZW5jeUludGVuc2l0eYgBARJHChBzaWxlbnRfaW50ZW5zaX'
    'R5GAIgASgOMhcuZXFtb25pdG9yLkptYUludGVuc2l0eUgBUg9zaWxlbnRJbnRlbnNpdHmIAQES'
    'UwoHcmVnaW9ucxgDIAMoCzI5LmVxbW9uaXRvci5Ob3RpZmljYXRpb25TZXR0aW5ncy5FYXJ0aH'
    'F1YWtlU2V0dGluZ3MuUmVnaW9uUgdyZWdpb25zGtcBCgZSZWdpb24SEgoEY29kZRgBIAEoCVIE'
    'Y29kZRISCgRuYW1lGAIgASgJUgRuYW1lEkgKE2VtZXJnZW5jeV9pbnRlbnNpdHkYAyABKA4yFy'
    '5lcW1vbml0b3IuSm1hSW50ZW5zaXR5UhJlbWVyZ2VuY3lJbnRlbnNpdHkSQgoQc2lsZW50X2lu'
    'dGVuc2l0eRgEIAEoDjIXLmVxbW9uaXRvci5KbWFJbnRlbnNpdHlSD3NpbGVudEludGVuc2l0eR'
    'IXCgdpc19tYWluGAUgASgIUgZpc01haW5CFgoUX2VtZXJnZW5jeV9pbnRlbnNpdHlCEwoRX3Np'
    'bGVudF9pbnRlbnNpdHk=');
