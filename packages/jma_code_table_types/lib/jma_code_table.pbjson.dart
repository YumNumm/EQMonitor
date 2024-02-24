//
//  Generated code. Do not modify.
//  source: jma_code_table.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use jmaCodeTableDescriptor instead')
const JmaCodeTable$json = {
  '1': 'JmaCodeTable',
  '2': [
    {'1': 'areaEpicenter', '3': 41, '4': 1, '5': 11, '6': '.AreaEpicenter', '10': 'areaEpicenter'},
    {'1': 'areaEpicenterAbbreviation', '3': 42, '4': 1, '5': 11, '6': '.AreaEpicenterAbbreviation', '10': 'areaEpicenterAbbreviation'},
    {'1': 'areaEpicenterDetail', '3': 43, '4': 1, '5': 11, '6': '.AreaEpicenterDetail', '10': 'areaEpicenterDetail'},
  ],
};

/// Descriptor for `JmaCodeTable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jmaCodeTableDescriptor = $convert.base64Decode(
    'CgxKbWFDb2RlVGFibGUSNAoNYXJlYUVwaWNlbnRlchgpIAEoCzIOLkFyZWFFcGljZW50ZXJSDW'
    'FyZWFFcGljZW50ZXISWAoZYXJlYUVwaWNlbnRlckFiYnJldmlhdGlvbhgqIAEoCzIaLkFyZWFF'
    'cGljZW50ZXJBYmJyZXZpYXRpb25SGWFyZWFFcGljZW50ZXJBYmJyZXZpYXRpb24SRgoTYXJlYU'
    'VwaWNlbnRlckRldGFpbBgrIAEoCzIULkFyZWFFcGljZW50ZXJEZXRhaWxSE2FyZWFFcGljZW50'
    'ZXJEZXRhaWw=');

@$core.Deprecated('Use areaEpicenterDescriptor instead')
const AreaEpicenter$json = {
  '1': 'AreaEpicenter',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaEpicenter.AreaEpicenterItem', '10': 'items'},
  ],
  '3': [AreaEpicenter_AreaEpicenterItem$json],
};

@$core.Deprecated('Use areaEpicenterDescriptor instead')
const AreaEpicenter_AreaEpicenterItem$json = {
  '1': 'AreaEpicenterItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaEpicenter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaEpicenterDescriptor = $convert.base64Decode(
    'Cg1BcmVhRXBpY2VudGVyEjYKBWl0ZW1zGAEgAygLMiAuQXJlYUVwaWNlbnRlci5BcmVhRXBpY2'
    'VudGVySXRlbVIFaXRlbXMaOwoRQXJlYUVwaWNlbnRlckl0ZW0SEgoEY29kZRgBIAEoCVIEY29k'
    'ZRISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use areaEpicenterAbbreviationDescriptor instead')
const AreaEpicenterAbbreviation$json = {
  '1': 'AreaEpicenterAbbreviation',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaEpicenterAbbreviation.AreaEpicenterAbbreviationItem', '10': 'items'},
  ],
  '3': [AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem$json],
};

@$core.Deprecated('Use areaEpicenterAbbreviationDescriptor instead')
const AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem$json = {
  '1': 'AreaEpicenterAbbreviationItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaEpicenterAbbreviation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaEpicenterAbbreviationDescriptor = $convert.base64Decode(
    'ChlBcmVhRXBpY2VudGVyQWJicmV2aWF0aW9uEk4KBWl0ZW1zGAEgAygLMjguQXJlYUVwaWNlbn'
    'RlckFiYnJldmlhdGlvbi5BcmVhRXBpY2VudGVyQWJicmV2aWF0aW9uSXRlbVIFaXRlbXMaRwod'
    'QXJlYUVwaWNlbnRlckFiYnJldmlhdGlvbkl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW'
    '1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use areaEpicenterDetailDescriptor instead')
const AreaEpicenterDetail$json = {
  '1': 'AreaEpicenterDetail',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaEpicenterDetail.AreaEpicenterDetailItem', '10': 'items'},
  ],
  '3': [AreaEpicenterDetail_AreaEpicenterDetailItem$json],
};

@$core.Deprecated('Use areaEpicenterDetailDescriptor instead')
const AreaEpicenterDetail_AreaEpicenterDetailItem$json = {
  '1': 'AreaEpicenterDetailItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaEpicenterDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaEpicenterDetailDescriptor = $convert.base64Decode(
    'ChNBcmVhRXBpY2VudGVyRGV0YWlsEkIKBWl0ZW1zGAEgAygLMiwuQXJlYUVwaWNlbnRlckRldG'
    'FpbC5BcmVhRXBpY2VudGVyRGV0YWlsSXRlbVIFaXRlbXMaQQoXQXJlYUVwaWNlbnRlckRldGFp'
    'bEl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW1lGAIgASgJUgRuYW1l');

