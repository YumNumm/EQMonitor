import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_live_activity_json_parser.g.dart';

@riverpod
DebugLiveActivityJsonParser debugLiveActivityJsonParser(Ref ref) =>
    DebugLiveActivityJsonParser();

class DebugLiveActivityJsonParser {
  Result<Map<String, dynamic>?, FormatException> parseOptionalObjectJson({
    required String raw,
  }) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const Success(null);
    }

    try {
      final decoded = jsonDecode(trimmed);
      return switch (decoded) {
        final Map<String, dynamic> json => Success(json),
        _ => Failure(
          FormatException('JSON root must be an object', trimmed),
        ),
      };
    } on FormatException catch (exception, stackTrace) {
      return Failure(exception, stackTrace);
    }
  }

  Result<api.Alert?, FormatException> parseOptionalAlertJson({
    required String raw,
  }) {
    final result = parseOptionalObjectJson(raw: raw);
    return switch (result) {
      Success(value: null) => const Success(null),
      Success(value: final Map<String, dynamic> value) => switch ((
        value['title'],
        value['body'],
      )) {
        (final String title, final String body) => Success(
          api.Alert(title: title, body: body),
        ),
        _ => Failure(
          FormatException(
            'Alert JSON must include title and body as strings',
            raw,
          ),
        ),
      },
      Failure(:final exception, :final stackTrace) => Failure(
        exception,
        stackTrace,
      ),
    };
  }
}
