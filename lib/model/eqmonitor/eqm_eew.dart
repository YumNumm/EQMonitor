import 'dart:convert';

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:messagepack/messagepack.dart';

import '../../provider/telegram_service.dart';
import '../../utils/extension/japanese_string.dart';

class EqmEew {
  EqmEew({
    required this.eventId,
    required this.serialNo,
    required this.infoType,
    required this.status,
    this.hypoName,
    this.hypo,
    this.magnitude,
    this.depth,
    this.depthCondition,
    this.accuracy,
    this.isWarning,
    required this.isCanceled,
    required this.isLastInfo,
    this.isPlum,
    this.headline,
    this.text,
    this.forecastMaxInt,
    this.forecastMaxLgInt,
    this.regions = const [],
  });

  factory EqmEew.fromJson(Map<String, dynamic> json) => EqmEew(
        eventId: json['eventId'] as int,
        serialNo: json['serialNo'] as int,
        infoType: TelegramInfoType.values[json['infoType'] as int],
        status: TelegramStatus.values[json['status'] as int],
        hypoName: json['hypoName'] as String?,
        hypo: (json['hypoLatitude'] != null && json['hypoLongitude'] != null)
            ? LatLng(
                json['hypoLatitude'] as double,
                json['hypoLongitude'] as double,
              )
            : null,
        magnitude: json['magnitude'] as double?,
        depth: json['depth'] as int?,
        depthCondition: EewDepthCondition.values[json['depthCondition'] as int],
        accuracy: json['accuracy'] != null
            ? EewAccuracy.fromJson(json['accuracy'] as Map<String, dynamic>)
            : null,
        isWarning: json['isWarning'] as bool?,
        isCanceled: json['isCanceled'] as bool,
        isLastInfo: json['isLastInfo'] as bool,
        isPlum: json['isPlum'] as bool?,
        headline: json['headline'] as String?,
        text: json['text'] as String?,
        forecastMaxInt: (json['forecastMaxInt'] != null)
            ? EewIntensityForecastMaxInt.fromJson(
                json['forecastMaxInt'] as Map<String, dynamic>,
              )
            : null,
        forecastMaxLgInt: (json['forecastMaxLgInt'] != null)
            ? EewIntensityForecastMaxLgInt.fromJson(
                json['forecastMaxLgInt'] as Map<String, dynamic>,
              )
            : null,
        regions: (json['regions'] as List<dynamic>)
            .map((e) => EewIntensityRegion.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  factory EqmEew.fromMessagePack(Uint8List bytes) {
    final u = Unpacker.fromList(bytes);
    final eventId = u.unpackInt()!;
    final serialNo = u.unpackInt()!;
    final telegramInfoTypeIndex = u.unpackInt();
    final telegramStatusIndex = u.unpackInt();
    final hypoName = u.unpackString();
    final hypoLatitude = u.unpackDouble();
    final hypoLongitude = u.unpackDouble();
    final hypo = (hypoLatitude != null && hypoLongitude != null)
        ? LatLng(hypoLatitude, hypoLongitude)
        : null;
    final magnitude = u.unpackDouble();
    final depth = u.unpackInt();
    final depthConditionIndex = u.unpackInt();
    final accuracyBinary = u.unpackBinary();
    final accuracy = (accuracyBinary.isNotEmpty)
        ? Uint8List.fromList(accuracyBinary).toEewAccuracy()
        : null;
    final isWarning = u.unpackBool();
    final isCanceled = u.unpackBool()!;
    final isLastInfo = u.unpackBool()!;
    final isPlum = u.unpackBool();
    final headline = u.unpackString();
    final text = u.unpackString();
    final maxIntFrom = u.unpackInt();
    final maxIntTo = u.unpackInt();
    final maxInt = (maxIntFrom != null && maxIntTo != null)
        ? EewIntensityForecastMaxInt(
            from: JmaIntensity.values[maxIntFrom],
            to: JmaIntensity.values[maxIntTo],
          )
        : null;
    final maxLgIntFrom = u.unpackInt();
    final maxLgIntTo = u.unpackInt();
    final maxLgInt = (maxLgIntFrom != null && maxLgIntTo != null)
        ? EewIntensityForecastMaxLgInt(
            from: JmaLgIntensity.values[maxLgIntFrom],
            to: JmaLgIntensity.values[maxLgIntTo],
          )
        : null;
    final regions = u
        .unpackList()
        .map((e) => Uint8List.fromList(e! as List<int>).toEewIntensityRegion())
        .toList();

    return EqmEew(
      eventId: eventId,
      serialNo: serialNo,
      infoType: TelegramInfoType.values[telegramInfoTypeIndex!],
      status: TelegramStatus.values[telegramStatusIndex!],
      hypoName: hypoName,
      hypo: hypo,
      magnitude: magnitude,
      depth: depth,
      depthCondition: (depthConditionIndex != null)
          ? EewDepthCondition.values[depthConditionIndex]
          : null,
      accuracy: accuracy,
      isWarning: isWarning,
      isCanceled: isCanceled,
      isLastInfo: isLastInfo,
      isPlum: isPlum,
      headline: headline,
      text: text,
      forecastMaxInt: maxInt,
      forecastMaxLgInt: maxLgInt,
      regions: regions,
    );
  }

  factory EqmEew.fromMessagePackFcm(Uint8List bytes) {
    final u = Unpacker.fromList(bytes);
    final eventId = u.unpackInt()!;
    final serialNo = u.unpackInt()!;
    final telegramInfoTypeIndex = u.unpackInt();
    final telegramStatusIndex = u.unpackInt();
    final hypoName = u.unpackString();
    final hypoLatitude = u.unpackDouble();
    final hypoLongitude = u.unpackDouble();
    final hypo = (hypoLatitude != null && hypoLongitude != null)
        ? LatLng(hypoLatitude, hypoLongitude)
        : null;
    final magnitude = u.unpackDouble();
    final depth = u.unpackInt();
    final depthConditionIndex = u.unpackInt();
    final accuracyBinary = u.unpackBinary();
    final accuracy = (accuracyBinary.isNotEmpty)
        ? Uint8List.fromList(accuracyBinary).toEewAccuracy()
        : null;
    final isWarning = u.unpackBool();
    final isCanceled = u.unpackBool()!;
    final isLastInfo = u.unpackBool()!;
    final isPlum = u.unpackBool();
    final headline = u.unpackString();
    final text = u.unpackString();
    final maxIntFrom = u.unpackInt();
    final maxIntTo = u.unpackInt();
    final maxInt = (maxIntFrom != null && maxIntTo != null)
        ? EewIntensityForecastMaxInt(
            from: JmaIntensity.values[maxIntFrom],
            to: JmaIntensity.values[maxIntTo],
          )
        : null;
    final maxLgIntFrom = u.unpackInt();
    final maxLgIntTo = u.unpackInt();
    final maxLgInt = (maxLgIntFrom != null && maxLgIntTo != null)
        ? EewIntensityForecastMaxLgInt(
            from: JmaLgIntensity.values[maxLgIntFrom],
            to: JmaLgIntensity.values[maxLgIntTo],
          )
        : null;
    final regions = u
        .unpackList()
        .map(
          (e) => Uint8List.fromList(e! as List<int>).toEewIntensityRegionFcm(),
        )
        .toList();

    return EqmEew(
      eventId: eventId,
      serialNo: serialNo,
      infoType: TelegramInfoType.values[telegramInfoTypeIndex!],
      status: TelegramStatus.values[telegramStatusIndex!],
      hypoName: hypoName,
      hypo: hypo,
      magnitude: magnitude,
      depth: depth,
      depthCondition: (depthConditionIndex != null)
          ? EewDepthCondition.values[depthConditionIndex]
          : null,
      accuracy: accuracy,
      isWarning: isWarning,
      isCanceled: isCanceled,
      isLastInfo: isLastInfo,
      isPlum: isPlum,
      headline: headline,
      text: text,
      forecastMaxInt: maxInt,
      forecastMaxLgInt: maxLgInt,
      regions: regions,
    );
  }

  factory EqmEew.fromEew(EewTelegram telegram) => EqmEew(
        eventId: int.parse(telegram.head.eventId!),
        serialNo: int.parse(telegram.head.serialNo!),
        infoType: telegram.head.infoType,
        status: telegram.head.status,
        hypoName: telegram.eew.earthquake?.hypocenter.name,
        hypo: (telegram.eew.earthquake?.hypocenter.coordinate.latitude?.value !=
                    null &&
                telegram.eew.earthquake?.hypocenter.coordinate.longitude
                        ?.value !=
                    null)
            ? LatLng(
                telegram.eew.earthquake!.hypocenter.coordinate.latitude!.value,
                telegram.eew.earthquake!.hypocenter.coordinate.longitude!.value,
              )
            : null,
        magnitude: telegram.eew.earthquake?.magnitude.value,
        depth: telegram.eew.earthquake?.hypocenter.depth.value,
        depthCondition: telegram.eew.earthquake?.hypocenter.depth.condition,
        accuracy: telegram.eew.earthquake?.hypocenter.accuracy,
        isWarning: telegram.eew.isWarning,
        isCanceled: telegram.eew.isCanceled,
        isLastInfo: telegram.eew.isLastInfo,
        isPlum: telegram.eew.earthquake?.condition == '仮定震源要素',
        headline: telegram.head.headline,
        text: '${(telegram.eew.text != null) ? '${telegram.eew.text}\n' : ''}'
            '${telegram.eew.comments?.free ?? ''}',
        forecastMaxInt: telegram.eew.intensity?.forecastMaxInt,
        forecastMaxLgInt: telegram.eew.intensity?.forecastMaxLgInt,
        regions: telegram.eew.intensity?.regions ?? [],
      );

  final int eventId;
  final int serialNo;
  final TelegramInfoType infoType;
  final TelegramStatus status;
  final String? hypoName;
  final LatLng? hypo;
  final double? magnitude;
  final int? depth;
  final EewDepthCondition? depthCondition;
  final EewAccuracy? accuracy;
  final bool? isWarning;
  final bool isCanceled;
  final bool isLastInfo;
  final bool? isPlum;
  final String? headline;
  final String? text;
  final EewIntensityForecastMaxInt? forecastMaxInt;
  final EewIntensityForecastMaxLgInt? forecastMaxLgInt;
  final List<EewIntensityRegion> regions;

  Uint8List toMessagePack() {
    final p = Packer()
      ..packInt(eventId)
      ..packInt(serialNo)
      ..packInt(infoType.index)
      ..packInt(status.index)
      ..packString(hypoName)
      ..packDouble(hypo?.latitude)
      ..packDouble(hypo?.longitude)
      ..packDouble(magnitude)
      ..packInt(depth)
      ..packInt(depthCondition?.index)
      ..packBinary(accuracy?.toMessagePack())
      ..packBool(isWarning)
      ..packBool(isCanceled)
      ..packBool(isLastInfo)
      ..packBool(isPlum)
      ..packString(headline)
      ..packString(text)
      ..packInt(forecastMaxInt?.from.index)
      ..packInt(forecastMaxInt?.to.index)
      ..packInt(forecastMaxLgInt?.from.index)
      ..packInt(forecastMaxLgInt?.to.index)
      ..packListLength(regions.length);
    for (final region in regions) {
      p.packBinary(region.toMessagePack());
    }
    return p.takeBytes();
  }

  Uint8List toMessagePackFcm() {
    final p = Packer()
      ..packInt(eventId)
      ..packInt(serialNo)
      ..packInt(infoType.index)
      ..packInt(status.index)
      ..packString(hypoName)
      ..packDouble(hypo?.latitude)
      ..packDouble(hypo?.longitude)
      ..packDouble(magnitude)
      ..packInt(depth)
      ..packInt(depthCondition?.index)
      ..packBinary(accuracy?.toMessagePack())
      ..packBool(isWarning)
      ..packBool(isCanceled)
      ..packBool(isLastInfo)
      ..packBool(isPlum)
      ..packString(headline)
      ..packString(text)
      ..packInt(forecastMaxInt?.from.index)
      ..packInt(forecastMaxInt?.to.index)
      ..packInt(forecastMaxLgInt?.from.index)
      ..packInt(forecastMaxLgInt?.to.index)
      ..packListLength(regions.length);
    for (final region in regions) {
      p.packBinary(region.toMessagePackFcm());
    }
    return p.takeBytes();
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'serialNo': serialNo,
        'infoType': infoType.index,
        'status': status.index,
        'hypoName': hypoName,
        'hypoLatitude': hypo?.latitude,
        'hypoLongitude': hypo?.longitude,
        'magnitude': magnitude,
        'depth': depth,
        'depthCondition': depthCondition?.index,
        'accuracy': accuracy?.toJson(),
        'isWarning': isWarning,
        'isCanceled': isCanceled,
        'isLastInfo': isLastInfo,
        'isPlum': isPlum,
        'headline': headline,
        'text': text,
        'forecastMaxInt': forecastMaxInt?.toJson(),
        'forecastMaxLgInt': forecastMaxLgInt?.toJson(),
        'regions': regions.map((e) => e.toJson()).toList(),
      };

  String get notificationTitle {
    switch (infoType) {
      case TelegramInfoType.announcement:
        return "${(status != TelegramStatus.normal) ? '[${jsonEncode(status.name)}] ' : ''}"
            '緊急地震速報(${(isWarning ?? false) ? '警報' : '予報'}'
            '${(isPlum ?? false) ? ' - PLUM法' : ''}'
            ' '
            '${isLastInfo ? '最終' : ''}第$serialNo報)';

      case TelegramInfoType.correction:
        return (headline != null) ? '先ほどの緊急地震速報は訂正されました' : headline!;
      case TelegramInfoType.delay:
        throw StateError('Delay is not supported.');
      case TelegramInfoType.cancel:
        return (headline != null) ? '先ほどの緊急地震速報は取消されました' : headline!;
    }
  }

  String get notificationBody {
    if (infoType == TelegramInfoType.cancel) {
      return text ?? '';
    }
    return (StringBuffer()
          ..writeAll(
            <String>[
              '$hypoNameで地震発生 ',
              if (forecastMaxInt != null) ...[
                '予想最大震度',
                ((forecastMaxInt!.to == JmaIntensity.over)
                        ? '${forecastMaxInt!.from.name}程度以上'
                        : (forecastMaxInt!.from == forecastMaxInt!.to)
                            ? '${forecastMaxInt?.from.name}'
                            : '${forecastMaxInt?.from.name}〜${forecastMaxInt?.to.name}')
                    .replaceAll('+', '強')
                    .replaceAll('-', '弱'),
                ' \n'
              ],
              if (forecastMaxLgInt != null) ...[
                '予想最大',
                ((forecastMaxLgInt!.to == JmaLgIntensity.over)
                        ? '${forecastMaxLgInt!.from.longName}程度以上'
                        : (forecastMaxLgInt!.from == forecastMaxLgInt!.to)
                            ? '${forecastMaxLgInt?.from.longName}'
                            : '${forecastMaxLgInt?.from.longName}〜'
                                '${forecastMaxLgInt?.to.longName.replaceAll('長周期地震動階級', '')}')
                    .replaceAll('+', '強')
                    .replaceAll('-', '弱'),
                ' \n'
              ],
              '',
              if (isPlum ?? false)
                'PLUM法による予測 '
              else ...[
                'M$magnitude ',
                if (depthCondition != null)
                  '深さ${jsonEncode(depthCondition).alphanumericToHalfLength} '
                else if (depth != null)
                  '深さ${depth}km ',
              ],
              text ?? '',
            ],
          ))
        .toString();
  }
}

extension EewAccuracyPacker on EewAccuracy {
  Uint8List toMessagePack() {
    final p = Packer()
      ..packInt(depth)
      ..packInt(magnitudeCalculation)
      ..packInt(numberOfMagnitudeCalculation)
      ..packListLength(2)
      ..packInt(epicenters[0])
      ..packInt(epicenters[1]);
    return p.takeBytes();
  }
}

extension EewAccuracyUnpacker on Uint8List {
  EewAccuracy toEewAccuracy() {
    final u = Unpacker.fromList(this);
    final depth = u.unpackInt()!;
    final magnitudeCalculation = u.unpackInt()!;
    final numberOfMagnitudeCalculation = u.unpackInt()!;
    final epicenters = u.unpackList().map((e) => e! as int).toList();
    return EewAccuracy(
      depth: depth,
      magnitudeCalculation: magnitudeCalculation,
      numberOfMagnitudeCalculation: numberOfMagnitudeCalculation,
      epicenters: epicenters,
    );
  }
}

extension EewIntensityRegionPacker on EewIntensityRegion {
  Uint8List toMessagePack() {
    final p = Packer()
      ..packInt(code)
      ..packString(name)
      ..packBool(isPlum)
      ..packBool(isWarning)
      ..packInt(forecastMaxInt.from.index)
      ..packInt(forecastMaxInt.to.index)
      ..packInt(forecastMaxLgInt?.from.index)
      ..packInt(forecastMaxLgInt?.to.index)
      ..packInt(int.parse(kind.code.code))
      ..packBool(condition == '既に主要動到達と推測')
      ..packStringEmptyIsNull(arrivalTime?.toIso8601String());
    return p.takeBytes();
  }

  Uint8List toMessagePackFcm() {
    final p = Packer()
      ..packInt(code)
      ..packString(name)
      ..packBool(isPlum)
      ..packBool(isWarning)
      ..packInt(forecastMaxInt.from.index)
      ..packInt(forecastMaxInt.to.index)
      ..packInt(forecastMaxLgInt?.from.index)
      ..packInt(forecastMaxLgInt?.to.index);
    return p.takeBytes();
  }
}

extension EewIntensityRegionUnpacker on Uint8List {
  EewIntensityRegion toEewIntensityRegion() {
    final u = Unpacker(this);
    final code = u.unpackInt()!;
    final name = u.unpackString()!;
    final isPlum = u.unpackBool()!;
    final isWarning = u.unpackBool()!;
    final forecastMaxIntFrom = u.unpackInt()!;
    final forecastMaxIntTo = u.unpackInt()!;
    final forecastMaxInt = EewIntensityForecastMaxInt(
      from: JmaIntensity.values[forecastMaxIntFrom],
      to: JmaIntensity.values[forecastMaxIntTo],
    );
    final forecastMaxLgIntFrom = u.unpackInt();
    final forecastMaxLgIntTo = u.unpackInt();
    final forecastMaxLgInt = forecastMaxLgIntFrom != null &&
            forecastMaxLgIntTo != null &&
            forecastMaxLgIntFrom >= 0 &&
            forecastMaxLgIntTo >= 0
        ? EewIntensityForecastMaxLgInt(
            from: JmaLgIntensity.values[forecastMaxLgIntFrom],
            to: JmaLgIntensity.values[forecastMaxLgIntTo],
          )
        : null;
    final kindCodeTmp = u.unpackInt();
    final kindCode = EarthquakeForecastCode.values
        .firstWhere((e) => e.code == kindCodeTmp.toString().padLeft(2, '0'));
    final kind = EewIntensityKind(
      code: kindCode,
      name: kindCode.description,
    );
    final condition = (u.unpackBool() ?? false) ? '既に主要動到達と推測' : null;
    final arrivalTimeTmp = u.unpackString();
    final arrivalTime =
        arrivalTimeTmp != null ? DateTime.parse(arrivalTimeTmp) : null;
    return EewIntensityRegion(
      code: code,
      name: name,
      isPlum: isPlum,
      isWarning: isWarning,
      forecastMaxInt: forecastMaxInt,
      forecastMaxLgInt: forecastMaxLgInt,
      kind: kind,
      condition: condition,
      arrivalTime: arrivalTime,
    );
  }

  EewIntensityRegion toEewIntensityRegionFcm() {
    final u = Unpacker(this);
    final code = u.unpackInt()!;
    final name = u.unpackString()!;
    final isPlum = u.unpackBool()!;
    final isWarning = u.unpackBool()!;
    final forecastMaxIntFrom = u.unpackInt()!;
    final forecastMaxIntTo = u.unpackInt()!;
    final forecastMaxInt = EewIntensityForecastMaxInt(
      from: JmaIntensity.values[forecastMaxIntFrom],
      to: JmaIntensity.values[forecastMaxIntTo],
    );
    final forecastMaxLgIntFrom = u.unpackInt();
    final forecastMaxLgIntTo = u.unpackInt();
    final forecastMaxLgInt = forecastMaxLgIntFrom != null &&
            forecastMaxLgIntTo != null &&
            forecastMaxLgIntFrom >= 0 &&
            forecastMaxLgIntTo >= 0
        ? EewIntensityForecastMaxLgInt(
            from: JmaLgIntensity.values[forecastMaxLgIntFrom],
            to: JmaLgIntensity.values[forecastMaxLgIntTo],
          )
        : null;

    return EewIntensityRegion(
      code: code,
      name: name,
      isPlum: isPlum,
      isWarning: isWarning,
      forecastMaxInt: forecastMaxInt,
      forecastMaxLgInt: forecastMaxLgInt,
      kind: EewIntensityKind(
        code: EarthquakeForecastCode.warningNotPredicted,
        name: EarthquakeForecastCode.warningNotPredicted.description,
      ),
    );
  }
}
