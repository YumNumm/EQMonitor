import 'package:eqapi_types/eqapi_types.dart' as api;
import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_models.dart';

/// API型からアプリ型への変換ユーティリティ
class TsunamiConverter {
  const TsunamiConverter._();

  /// TsunamiGroupedByEventからTsunamiEventに変換
  static TsunamiEvent fromApiGroupedByEvent(api.TsunamiGroupedByEvent apiData) {
    // 最新の情報を取得（優先度: vtse41 > vtse51 > vtse52）
    final baseInfo = _getLatestBaseInfo(apiData);

    // VTSE41とVTSE51をマージしてTsunamiInfoを作成
    TsunamiInfo? info;
    if (apiData.vtse41 != null || apiData.vtse51 != null) {
      info = _mergeTsunamiInfo(apiData.vtse41, apiData.vtse51);
    }

    // VTSE52をTsunamiObservationInfoに変換
    TsunamiObservationInfo? observationInfo;
    if (apiData.vtse52 != null) {
      observationInfo = _convertVtse52ToObservationInfo(apiData.vtse52!);
    }

    return TsunamiEvent(
      eventId: apiData.eventId,
      pressAt: baseInfo.pressAt,
      reportAt: baseInfo.reportAt,
      status: baseInfo.status,
      infoType: baseInfo.infoType,
      headline: baseInfo.headline,
      validAt: baseInfo.validAt,
      info: info,
      observationInfo: observationInfo,
    );
  }

  /// 最新のベース情報を取得
  static ({
    DateTime pressAt,
    DateTime reportAt,
    String status,
    String infoType,
    String? headline,
    DateTime? validAt,
  })
  _getLatestBaseInfo(api.TsunamiGroupedByEvent apiData) {
    if (apiData.vtse41 != null) {
      final data = apiData.vtse41!;
      return (
        pressAt: data.pressAt,
        reportAt: data.reportAt,
        status: data.status,
        infoType: data.infoType,
        headline: data.headline,
        validAt: data.validAt,
      );
    }
    if (apiData.vtse51 != null) {
      final data = apiData.vtse51!;
      return (
        pressAt: data.pressAt,
        reportAt: data.reportAt,
        status: data.status,
        infoType: data.infoType,
        headline: data.headline,
        validAt: data.validAt,
      );
    }
    if (apiData.vtse52 != null) {
      final data = apiData.vtse52!;
      return (
        pressAt: DateTime.now(), // VTSE52では現在時刻
        reportAt: DateTime.now(), // VTSE52では現在時刻
        status: data.status,
        infoType: '発表', // VTSE52では固定値
        headline: data.headline,
        validAt: null, // VTSE52ではnull
      );
    }
    throw Exception('No tsunami data found');
  }

  /// VTSE41とVTSE51をマージしてTsunamiInfoを作成
  static TsunamiInfo _mergeTsunamiInfo(
    api.TsunamiDataVTSE41? vtse41,
    api.TsunamiDataVTSE51? vtse51,
  ) {
    final areas = <TsunamiArea>[];
    List<TsunamiObservation>? observations;
    String? text;
    TsunamiComments? comment;

    // VTSE41（津波警報・注意報・予報）の処理
    if (vtse41 != null) {
      final body = vtse41.bodyVtse41;
      areas.addAll(
        body.tsunami.forecasts.map(_convertForecastToArea),
      );
      text = body.text;
      comment = _convertComment(body.comment);
    }

    // VTSE51（津波情報）の処理
    if (vtse51 != null) {
      final body = vtse51.bodyVtse51;

      // VTSE51の予報データをマージ（重複する地域は後から追加されるVTSE51を優先）
      final vtse51Areas = body.tsunami.forecasts
          .map(_convertForecastToArea)
          .toList();
      for (final vtse51Area in vtse51Areas) {
        final existingIndex = areas.indexWhere(
          (area) => area.code == vtse51Area.code,
        );
        if (existingIndex >= 0) {
          areas[existingIndex] = vtse51Area;
        } else {
          areas.add(vtse51Area);
        }
      }

      // 観測データはVTSE51から取得
      if (body.tsunami.observations != null) {
        observations = body.tsunami.observations!
            .map(_convertApiObservationToObservation)
            .toList();
      }

      // テキストとコメントはVTSE51を優先
      text = body.text ?? text;
      comment = _convertComment(body.comment) ?? comment;
    }

    return TsunamiInfo(
      areas: areas,
      observations: observations,
      text: text,
      comments: comment,
    );
  }

  /// TsunamiForecastをTsunamiAreaに変換
  static TsunamiArea _convertForecastToArea(api.TsunamiForecast forecast) {
    return TsunamiArea(
      code: forecast.code,
      name: forecast.name,
      warning: TsunamiWarning.fromCode(forecast.kind),
      lastWarning: TsunamiWarning.fromCode(forecast.lastKind),
      firstHeight: forecast.firstHeight != null
          ? TsunamiHeight(
              arrivalTime: forecast.firstHeight!.arrivalTime,
              situation: forecast.firstHeight!.condition?.value,
            )
          : null,
      maxHeight: forecast.maxHeight != null
          ? TsunamiHeight(
              value: forecast.maxHeight!.value,
              isOver: forecast.maxHeight!.isOver,
              condition: forecast.maxHeight!.condition?.value,
            )
          : null,
      stations: forecast.stations
          ?.map(_convertForecastStationToAreaStation)
          .toList(),
    );
  }

  /// TsunamiForecastStationをTsunamiAreaStationに変換
  static TsunamiAreaStation _convertForecastStationToAreaStation(
    api.TsunamiForecastStation station,
  ) {
    return TsunamiAreaStation(
      code: station.code,
      name: station.name,
      highTideTime: station.highTideTime,
      firstHeightTime: station.firstHeightTime,
      condition: station.condition?.value,
    );
  }

  /// API TsunamiObservationをTsunamiObservationに変換
  static TsunamiObservation _convertApiObservationToObservation(
    api.TsunamiObservation apiObservation,
  ) {
    return TsunamiObservation(
      code: apiObservation.code,
      name: apiObservation.name,
      stations: apiObservation.stations
          .map(_convertApiObservationStationToObservationStation)
          .toList(),
    );
  }

  /// API TsunamiObservationStationをTsunamiObservationStationに変換
  static TsunamiObservationStation
  _convertApiObservationStationToObservationStation(
    api.TsunamiObservationStation apiStation,
  ) {
    return TsunamiObservationStation(
      code: apiStation.code,
      name: apiStation.name,
      firstHeight:
          apiStation.firstHeightArrivalTime != null ||
              apiStation.firstHeightInitial != null
          ? TsunamiStationFirstHeight(
              arrivalTime: apiStation.firstHeightArrivalTime,
              initial: apiStation.firstHeightInitial?.value,
            )
          : null,
      maxHeight:
          apiStation.maxHeightTime != null || apiStation.maxHeightValue != null
          ? TsunamiStationMaxHeight(
              dateTime: apiStation.maxHeightTime,
              value: apiStation.maxHeightValue,
              isOver: apiStation.maxHeightIsOver,
              isRising: apiStation.maxHeightIsRising,
            )
          : null,
      condition: apiStation.condition?.value,
    );
  }

  /// VTSE52をTsunamiObservationInfoに変換
  static TsunamiObservationInfo _convertVtse52ToObservationInfo(
    api.TsunamiDataVTSE52 vtse52,
  ) {
    final body = vtse52.bodyVtse52;

    return TsunamiObservationInfo(
      observations: body.tsunami.observations
          ?.map(_convertApiObservationToObservation)
          .toList(),
      estimations: body.tsunami.estimations
          .map(_convertApiEstimationToEstimation)
          .toList(),
      text: body.text,
      comments: _convertComment(body.comment),
    );
  }

  /// API TsunamiEstimationをTsunamiEstimationに変換
  static TsunamiEstimation _convertApiEstimationToEstimation(
    api.TsunamiEstimation apiEstimation,
  ) {
    return TsunamiEstimation(
      code: apiEstimation.code,
      name: apiEstimation.name,
      firstHeight:
          apiEstimation.firstHeightTime != null ||
              apiEstimation.firstHeightCondition != null
          ? TsunamiHeight(
              arrivalTime: apiEstimation.firstHeightTime,
              condition: apiEstimation.firstHeightCondition?.value,
            )
          : null,
      maxHeight:
          apiEstimation.maxHeightTime != null ||
              apiEstimation.maxHeightValue != null
          ? TsunamiHeight(
              value: apiEstimation.maxHeightValue,
              isOver: apiEstimation.maxHeightIsOver,
              condition: apiEstimation.maxHeightCondition?.value,
              arrivalTime: apiEstimation.maxHeightTime,
            )
          : null,
    );
  }

  /// API CommentをTsunamiCommentsに変換
  static TsunamiComments? _convertComment(api.Comment? apiComment) {
    if (apiComment == null) {
      return null;
    }

    return TsunamiComments(
      free: apiComment.free,
      warning: apiComment.warning != null
          ? TsunamiWarningComment(
              text: apiComment.warning!.text,
              codes: apiComment.warning!.codes,
            )
          : null,
    );
  }
}
