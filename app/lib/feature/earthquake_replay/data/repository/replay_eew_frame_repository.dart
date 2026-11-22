import 'dart:convert';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_exception.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_eew_frame_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ReplayEewFrameRepository> replayEewFrameRepository(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  return ReplayEewFrameRepository(eew: apiClient.eew);
}

class const ReplayEewFrameRepository({required final api.EewApiClient eew}) {
  static const pageLimit = 50;
  static const maxPages = 20;
  // 一覧 API は発生日でしか絞り込めず、第1報は発生時刻より後に発表される。
  static const originTimeMargin = Duration(minutes: 10);
  static const _jstOffset = Duration(hours: 9);

  Future<List<EqMonitorEewReplayData>> fetch({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      final eventIds = await fetchEventIds(
        startTime: startTime,
        endTime: endTime,
      );
      final frames = <EqMonitorEewReplayData>[];
      for (final eventId in eventIds) {
        final response = await eew.getV2EewEventId(eventId: eventId);
        frames.addAll([
          for (final item in response.data.items)
            if (!item.reportTime.isBefore(startTime) &&
                !item.reportTime.isAfter(endTime))
              EqMonitorEewReplayData(
                type: .eqMonitorEew,
                time: item.reportTime.toUtc(),
                json: jsonEncode(item.toJson()),
              ),
        ]);
      }
      return frames;
    } on Object catch (error, stackTrace) {
      talker.error('[ReplayCreation] EEW fetch failed', error, stackTrace);
      throw const ReplayCreationException(.eewFetchFailed);
    }
  }

  Future<Set<String>> fetchEventIds({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final earliest = startTime.subtract(originTimeMargin);
    final eventIds = <String>{};
    String? cursor;
    for (var page = 0; page < maxPages; page++) {
      final response = await eew.getV2Eew(
        statuses: api.TelegramStatus.values,
        limit: pageLimit.toString(),
        cursor: cursor,
        originTimeGte: formatDate(earliest.subtract(const Duration(days: 1))),
        originTimeLte: formatDate(endTime.add(const Duration(days: 1))),
      );
      eventIds.addAll([
        for (final item in response.data.items)
          if (isCandidate(item: item, earliest: earliest, endTime: endTime))
            item.eventId,
      ]);
      cursor = response.data.nextToken;
      if (cursor == null) {
        break;
      }
    }
    return eventIds;
  }

  bool isCandidate({
    required api.EewItemWithRelations item,
    required DateTime earliest,
    required DateTime endTime,
  }) {
    final time = item.originTime ?? item.reportTime;
    return !time.isBefore(earliest) && !time.isAfter(endTime);
  }

  String formatDate(DateTime time) {
    final jst = time.toUtc().add(_jstOffset);
    return '${jst.year.toString().padLeft(4, '0')}-'
        '${jst.month.toString().padLeft(2, '0')}-'
        '${jst.day.toString().padLeft(2, '0')}';
  }
}
