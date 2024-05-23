//
//  Generated code. Do not modify.
//  source: notification_payload.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use jmaIntensityDescriptor instead')
const JmaIntensity$json = {
  '1': 'JmaIntensity',
  '2': [
    {'1': 'JMA_INTENSITY_UNSPECIFIED', '2': 0},
    {'1': 'JMA_INTENSITY_0', '2': 10},
    {'1': 'JMA_INTENSITY_1', '2': 20},
    {'1': 'JMA_INTENSITY_2', '2': 30},
    {'1': 'JMA_INTENSITY_3', '2': 40},
    {'1': 'JMA_INTENSITY_4', '2': 45},
    {'1': 'JMA_INTENSITY_5_MINUS', '2': 50},
    {'1': 'JMA_INTENSITY_5_PLUS', '2': 55},
    {'1': 'JMA_INTENSITY_6_MINUS', '2': 60},
    {'1': 'JMA_INTENSITY_6_PLUS', '2': 65},
    {'1': 'JMA_INTENSITY_7', '2': 70},
  ],
};

/// Descriptor for `JmaIntensity`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List jmaIntensityDescriptor = $convert.base64Decode(
    'CgxKbWFJbnRlbnNpdHkSHQoZSk1BX0lOVEVOU0lUWV9VTlNQRUNJRklFRBAAEhMKD0pNQV9JTl'
    'RFTlNJVFlfMBAKEhMKD0pNQV9JTlRFTlNJVFlfMRAUEhMKD0pNQV9JTlRFTlNJVFlfMhAeEhMK'
    'D0pNQV9JTlRFTlNJVFlfMxAoEhMKD0pNQV9JTlRFTlNJVFlfNBAtEhkKFUpNQV9JTlRFTlNJVF'
    'lfNV9NSU5VUxAyEhgKFEpNQV9JTlRFTlNJVFlfNV9QTFVTEDcSGQoVSk1BX0lOVEVOU0lUWV82'
    'X01JTlVTEDwSGAoUSk1BX0lOVEVOU0lUWV82X1BMVVMQQRITCg9KTUFfSU5URU5TSVRZXzcQRg'
    '==');

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload$json = {
  '1': 'NotificationPayload',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.eqmonitor.NotificationPayload.Type', '10': 'type'},
    {'1': 'eew_information', '3': 3, '4': 1, '5': 11, '6': '.eqmonitor.NotificationPayload.EewInformation', '9': 0, '10': 'eewInformation'},
    {'1': 'earthquake_information', '3': 4, '4': 1, '5': 11, '6': '.eqmonitor.NotificationPayload.EarthquakeInformation', '9': 0, '10': 'earthquakeInformation'},
  ],
  '3': [NotificationPayload_EewInformation$json, NotificationPayload_EarthquakeInformation$json, NotificationPayload_RegionIntensity$json, NotificationPayload_EewRegionIntensity$json, NotificationPayload_HypoInformation$json],
  '4': [NotificationPayload_Type$json],
  '8': [
    {'1': 'information'},
  ],
};

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload_EewInformation$json = {
  '1': 'EewInformation',
  '2': [
    {'1': 'hypo_information', '3': 1, '4': 1, '5': 11, '6': '.eqmonitor.NotificationPayload.HypoInformation', '10': 'hypoInformation'},
    {'1': 'max_intensity', '3': 2, '4': 1, '5': 14, '6': '.eqmonitor.JmaIntensity', '9': 0, '10': 'maxIntensity', '17': true},
    {'1': 'region_intensities', '3': 3, '4': 3, '5': 11, '6': '.eqmonitor.NotificationPayload.EewRegionIntensity', '10': 'regionIntensities'},
  ],
  '8': [
    {'1': '_max_intensity'},
  ],
};

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload_EarthquakeInformation$json = {
  '1': 'EarthquakeInformation',
  '2': [
    {'1': 'hypo_information', '3': 1, '4': 1, '5': 11, '6': '.eqmonitor.NotificationPayload.HypoInformation', '10': 'hypoInformation'},
    {'1': 'max_intensity', '3': 2, '4': 1, '5': 14, '6': '.eqmonitor.JmaIntensity', '9': 0, '10': 'maxIntensity', '17': true},
    {'1': 'region_intensities', '3': 3, '4': 3, '5': 11, '6': '.eqmonitor.NotificationPayload.RegionIntensity', '10': 'regionIntensities'},
  ],
  '8': [
    {'1': '_max_intensity'},
  ],
};

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload_RegionIntensity$json = {
  '1': 'RegionIntensity',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'intensity', '3': 2, '4': 1, '5': 14, '6': '.eqmonitor.JmaIntensity', '10': 'intensity'},
  ],
};

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload_EewRegionIntensity$json = {
  '1': 'EewRegionIntensity',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'intensity', '3': 2, '4': 1, '5': 14, '6': '.eqmonitor.JmaIntensity', '10': 'intensity'},
    {'1': 'arrival_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '9': 0, '10': 'arrivalTime', '17': true},
  ],
  '8': [
    {'1': '_arrival_time'},
  ],
};

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload_HypoInformation$json = {
  '1': 'HypoInformation',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'latitude', '3': 3, '4': 1, '5': 2, '10': 'latitude'},
    {'1': 'longitude', '3': 4, '4': 1, '5': 2, '10': 'longitude'},
    {'1': 'depth', '3': 5, '4': 1, '5': 5, '10': 'depth'},
    {'1': 'magnitude', '3': 6, '4': 1, '5': 2, '10': 'magnitude'},
  ],
};

@$core.Deprecated('Use notificationPayloadDescriptor instead')
const NotificationPayload_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'TYPE_UNSPECIFIED', '2': 0},
    {'1': 'TYPE_EARTHQUAKE', '2': 1},
    {'1': 'TYPE_EEW', '2': 2},
  ],
};

/// Descriptor for `NotificationPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationPayloadDescriptor = $convert.base64Decode(
    'ChNOb3RpZmljYXRpb25QYXlsb2FkEhkKCGV2ZW50X2lkGAEgASgJUgdldmVudElkEjcKBHR5cG'
    'UYAiABKA4yIy5lcW1vbml0b3IuTm90aWZpY2F0aW9uUGF5bG9hZC5UeXBlUgR0eXBlElgKD2Vl'
    'd19pbmZvcm1hdGlvbhgDIAEoCzItLmVxbW9uaXRvci5Ob3RpZmljYXRpb25QYXlsb2FkLkVld0'
    'luZm9ybWF0aW9uSABSDmVld0luZm9ybWF0aW9uEm0KFmVhcnRocXVha2VfaW5mb3JtYXRpb24Y'
    'BCABKAsyNC5lcW1vbml0b3IuTm90aWZpY2F0aW9uUGF5bG9hZC5FYXJ0aHF1YWtlSW5mb3JtYX'
    'Rpb25IAFIVZWFydGhxdWFrZUluZm9ybWF0aW9uGqICCg5FZXdJbmZvcm1hdGlvbhJZChBoeXBv'
    'X2luZm9ybWF0aW9uGAEgASgLMi4uZXFtb25pdG9yLk5vdGlmaWNhdGlvblBheWxvYWQuSHlwb0'
    'luZm9ybWF0aW9uUg9oeXBvSW5mb3JtYXRpb24SQQoNbWF4X2ludGVuc2l0eRgCIAEoDjIXLmVx'
    'bW9uaXRvci5KbWFJbnRlbnNpdHlIAFIMbWF4SW50ZW5zaXR5iAEBEmAKEnJlZ2lvbl9pbnRlbn'
    'NpdGllcxgDIAMoCzIxLmVxbW9uaXRvci5Ob3RpZmljYXRpb25QYXlsb2FkLkVld1JlZ2lvbklu'
    'dGVuc2l0eVIRcmVnaW9uSW50ZW5zaXRpZXNCEAoOX21heF9pbnRlbnNpdHkapgIKFUVhcnRocX'
    'Vha2VJbmZvcm1hdGlvbhJZChBoeXBvX2luZm9ybWF0aW9uGAEgASgLMi4uZXFtb25pdG9yLk5v'
    'dGlmaWNhdGlvblBheWxvYWQuSHlwb0luZm9ybWF0aW9uUg9oeXBvSW5mb3JtYXRpb24SQQoNbW'
    'F4X2ludGVuc2l0eRgCIAEoDjIXLmVxbW9uaXRvci5KbWFJbnRlbnNpdHlIAFIMbWF4SW50ZW5z'
    'aXR5iAEBEl0KEnJlZ2lvbl9pbnRlbnNpdGllcxgDIAMoCzIuLmVxbW9uaXRvci5Ob3RpZmljYX'
    'Rpb25QYXlsb2FkLlJlZ2lvbkludGVuc2l0eVIRcmVnaW9uSW50ZW5zaXRpZXNCEAoOX21heF9p'
    'bnRlbnNpdHkaXAoPUmVnaW9uSW50ZW5zaXR5EhIKBGNvZGUYASABKAlSBGNvZGUSNQoJaW50ZW'
    '5zaXR5GAIgASgOMhcuZXFtb25pdG9yLkptYUludGVuc2l0eVIJaW50ZW5zaXR5GrQBChJFZXdS'
    'ZWdpb25JbnRlbnNpdHkSEgoEY29kZRgBIAEoCVIEY29kZRI1CglpbnRlbnNpdHkYAiABKA4yFy'
    '5lcW1vbml0b3IuSm1hSW50ZW5zaXR5UglpbnRlbnNpdHkSQgoMYXJyaXZhbF90aW1lGAMgASgL'
    'MhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEgAUgthcnJpdmFsVGltZYgBAUIPCg1fYXJyaX'
    'ZhbF90aW1lGqcBCg9IeXBvSW5mb3JtYXRpb24SEgoEY29kZRgBIAEoBVIEY29kZRISCgRuYW1l'
    'GAIgASgJUgRuYW1lEhoKCGxhdGl0dWRlGAMgASgCUghsYXRpdHVkZRIcCglsb25naXR1ZGUYBC'
    'ABKAJSCWxvbmdpdHVkZRIUCgVkZXB0aBgFIAEoBVIFZGVwdGgSHAoJbWFnbml0dWRlGAYgASgC'
    'UgltYWduaXR1ZGUiPwoEVHlwZRIUChBUWVBFX1VOU1BFQ0lGSUVEEAASEwoPVFlQRV9FQVJUSF'
    'FVQUtFEAESDAoIVFlQRV9FRVcQAkINCgtpbmZvcm1hdGlvbg==');

