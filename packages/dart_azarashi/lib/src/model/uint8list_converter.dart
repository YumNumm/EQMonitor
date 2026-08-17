import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

/// Converter for Uint8List to/from base64 encoded String.
class Uint8ListConverter implements JsonConverter<Uint8List, String> {
  const new();

  @override
  Uint8List fromJson(String json) => base64Decode(json);

  @override
  String toJson(Uint8List object) => base64Encode(object);
}

/// Helper function to convert Uint8List from JSON (base64 string).
Uint8List uint8ListFromJson(String json) => base64Decode(json);

/// Helper function to convert Uint8List to JSON (base64 string).
String uint8ListToJson(Uint8List data) => base64Encode(data);
