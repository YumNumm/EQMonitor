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
    {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.TsunamiParameterHeader',
      '10': 'header'
    },
    {
      '1': 'items',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.TsunamiParameterItem',
      '10': 'items'
    },
  ],
};

/// Descriptor for `TsunamiParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tsunamiParameterDescriptor = $convert.base64Decode(
    'ChBUc3VuYW1pUGFyYW1ldGVyEi8KBmhlYWRlchgBIAEoCzIXLlRzdW5hbWlQYXJhbWV0ZXJIZW'
    'FkZXJSBmhlYWRlchIrCgVpdGVtcxgCIAMoCzIVLlRzdW5hbWlQYXJhbWV0ZXJJdGVtUgVpdGVt'
    'cw==');

@$core.Deprecated('Use tsunamiParameterHeaderDescriptor instead')
const TsunamiParameterHeader$json = {
  '1': 'TsunamiParameterHeader',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    {'1': 'changeTime', '3': 2, '4': 1, '5': 9, '10': 'changeTime'},
  ],
};

/// Descriptor for `TsunamiParameterHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tsunamiParameterHeaderDescriptor =
    $convert.base64Decode(
        'ChZUc3VuYW1pUGFyYW1ldGVySGVhZGVyEhgKB3ZlcnNpb24YASABKAlSB3ZlcnNpb24SHgoKY2'
        'hhbmdlVGltZRgCIAEoCVIKY2hhbmdlVGltZQ==');

@$core.Deprecated('Use tsunamiParameterItemDescriptor instead')
const TsunamiParameterItem$json = {
  '1': 'TsunamiParameterItem',
  '2': [
    {'1': 'area', '3': 1, '4': 1, '5': 9, '10': 'area'},
    {'1': 'prefecture', '3': 2, '4': 1, '5': 9, '10': 'prefecture'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nameKana', '3': 5, '4': 1, '5': 9, '10': 'nameKana'},
    {'1': 'owner', '3': 6, '4': 1, '5': 9, '10': 'owner'},
    {'1': 'latitude', '3': 7, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 8, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `TsunamiParameterItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tsunamiParameterItemDescriptor = $convert.base64Decode(
    'ChRUc3VuYW1pUGFyYW1ldGVySXRlbRISCgRhcmVhGAEgASgJUgRhcmVhEh4KCnByZWZlY3R1cm'
    'UYAiABKAlSCnByZWZlY3R1cmUSEgoEY29kZRgDIAEoCVIEY29kZRISCgRuYW1lGAQgASgJUgRu'
    'YW1lEhoKCG5hbWVLYW5hGAUgASgJUghuYW1lS2FuYRIUCgVvd25lchgGIAEoCVIFb3duZXISGg'
    'oIbGF0aXR1ZGUYByABKAFSCGxhdGl0dWRlEhwKCWxvbmdpdHVkZRgIIAEoAVIJbG9uZ2l0dWRl');
