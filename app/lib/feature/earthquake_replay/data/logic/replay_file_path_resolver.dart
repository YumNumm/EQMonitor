import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_file_path_resolver.g.dart';

@riverpod
ReplayFilePathResolver replayFilePathResolver(Ref ref) =>
    const ReplayFilePathResolver();

class const ReplayFilePathResolver() {
  static const extension = '.eqrp';
  static const maxSegmentBytes = 200;
  static const maxDirectoryDepth = 4;
  static const _jstOffset = Duration(hours: 9);
  static final _forbidden = RegExp(r'[/\\:\x00-\x1f\x7f]');

  String defaultDirectory({required DateTime startTime}) =>
      DateFormat('yyyy/MM').format(startTime.toUtc().add(_jstOffset));

  String defaultFileName({required DateTime startTime, Duration? duration}) {
    final start = DateFormat(
      'yyyyMMdd_HHmmss',
    ).format(startTime.toUtc().add(_jstOffset));
    return 'eqmonitor_$start'
        '${duration == null ? '' : '_${duration.inSeconds}s'}$extension';
  }

  String suggestedName({required String label, required DateTime time}) {
    final stamp = DateFormat(
      'yyyyMMdd_HHmm',
    ).format(time.toUtc().add(_jstOffset));
    final base = label.replaceAll(_forbidden, '').trim();
    return base.isEmpty || base.startsWith('.') ? stamp : '${base}_$stamp';
  }

  String fileName({required String input}) {
    final trimmed = input.trim();
    final base = trimmed.toLowerCase().endsWith(extension)
        ? trimmed.substring(0, trimmed.length - extension.length).trimRight()
        : trimmed;
    if (!isValidSegment(base)) {
      throw const ReplayLibraryException(.invalidName);
    }
    return '$base$extension';
  }

  String directory({required String input}) {
    final segments = [
      for (final segment in input.split('/'))
        if (segment.trim().isNotEmpty) segment.trim(),
    ];
    if (segments.length > maxDirectoryDepth ||
        !segments.every(isValidSegment)) {
      throw const ReplayLibraryException(.invalidDirectory);
    }
    return segments.join('/');
  }

  bool isValidSegment(String segment) =>
      segment.isNotEmpty &&
      !segment.startsWith('.') &&
      !segment.contains(_forbidden) &&
      utf8.encode(segment).length <= maxSegmentBytes;
}
