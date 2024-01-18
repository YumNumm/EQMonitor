//
//  Generated code. Do not modify.
//  source: tsunami_param.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use tsunamiParameterDescriptor instead')
const TsunamiParameter$json = {
  '1': 'TsunamiParameter',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.TsunamiParameterItem', '10': 'items'},
  ],
};

/// Descriptor for `TsunamiParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tsunamiParameterDescriptor = $convert.base64Decode(
    'ChBUc3VuYW1pUGFyYW1ldGVyEisKBWl0ZW1zGAEgAygLMhUuVHN1bmFtaVBhcmFtZXRlckl0ZW'
    '1SBWl0ZW1z');

@$core.Deprecated('Use tsunamiParameterItemDescriptor instead')
const TsunamiParameterItem$json = {
  '1': 'TsunamiParameterItem',
  '2': [
    {'1': 'prefecture', '3': 1, '4': 1, '5': 9, '10': 'prefecture'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'latitude', '3': 3, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 4, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `TsunamiParameterItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tsunamiParameterItemDescriptor = $convert.base64Decode(
    'ChRUc3VuYW1pUGFyYW1ldGVySXRlbRIeCgpwcmVmZWN0dXJlGAEgASgJUgpwcmVmZWN0dXJlEh'
    'IKBGNvZGUYAiABKAlSBGNvZGUSGgoIbGF0aXR1ZGUYAyABKAFSCGxhdGl0dWRlEhwKCWxvbmdp'
    'dHVkZRgEIAEoAVIJbG9uZ2l0dWRl');

