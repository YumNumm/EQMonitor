import 'dart:convert';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/eew/data/converter/eew_api_converter.dart';
import 'package:eqmonitor/feature/eew/data/converter/jma_eew_xml_converter.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show EewItemWithRelations;
import 'package:jma_eew_xml/jma_eew_xml.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_eew_report_resolver.g.dart';

@riverpod
ReplayEewReportResolver replayEewReportResolver(Ref ref) =>
    ReplayEewReportResolver(
      jmaEewXmlConverter: ref.watch(jmaEewXmlConverterProvider),
    );

/// 同じ地震に複数の形式の EEW があるときは、優先度の最も高い形式だけを使う。
/// 警報電文（VXSE43）は予報電文と情報番号の系列が異なるため、混ぜると報の前後関係が崩れる。
enum ReplayEewFrameSource {
  jmaWarning,
  jmaForecast,
  jmaSeismicMotionForecast,
  eqmonitor;

  static ReplayEewFrameSource fromJmaKind(JmaEewTelegramKind kind) =>
      switch (kind) {
        .warning => jmaWarning,
        .forecast => jmaForecast,
        .seismicMotionForecast => jmaSeismicMotionForecast,
      };
}

typedef ReplayEewReport = ({ReplayEewFrameSource source, EewTelegramItem eew});

class const ReplayEewReportResolver({
  required final JmaEewXmlConverter jmaEewXmlConverter,
}) {
  static const _parser = JmaEewXmlParser();

  /// フレームの位置から、そのフレームで適用する EEW を引けるようにする。
  Map<int, EewTelegramItem> resolve(List<ReplayData> frames) {
    final reports = <int, ReplayEewReport>{};
    final preferred = <String, ReplayEewFrameSource>{};
    for (var index = 0; index < frames.length; index++) {
      final report = decode(frames[index]);
      if (report == null) {
        continue;
      }
      reports[index] = report;
      final current = preferred[report.eew.eventId];
      if (current == null || current.index < report.source.index) {
        preferred[report.eew.eventId] = report.source;
      }
    }
    return {
      for (final MapEntry(key: index, value: report) in reports.entries)
        if (preferred[report.eew.eventId] == report.source) index: report.eew,
    };
  }

  ReplayEewReport? decode(ReplayData frame) {
    try {
      switch (frame) {
        case EqMonitorEewReplayData(:final json):
          return (
            source: .eqmonitor,
            eew: EewItemWithRelations.fromJson(
              jsonDecode(json) as Map<String, dynamic>,
            ).toEewTelegramItem,
          );
        case JmaXmlTelegramReplayData(:final title, :final telegram)
            when JmaEewTelegramKind.fromTitle(title) != null:
          final parsed = _parser.parse(telegram);
          return (
            source: .fromJmaKind(parsed.kind),
            eew: jmaEewXmlConverter.convert(parsed),
          );
        default:
          return null;
      }
      // 1 フレームの読み取り失敗で再生全体を止めない。
    } on Object catch (error, stackTrace) {
      talker.warning(
        '[Replay] EEW frame skipped: ${frame.time}',
        error,
        stackTrace,
      );
      return null;
    }
  }
}
