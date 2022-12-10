import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:messagepack/messagepack.dart';

import '../../provider/telegram_service.dart';

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
    this.isWarning = false,
    this.isCanceled = false,
    this.isLastInfo = false,
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
        isWarning: json['isWarning'] as bool,
        isCanceled: json['isCanceled'] as bool,
        isLastInfo: json['isLastInfo'] as bool,
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
    final isWarning = u.unpackBool()!;
    final isCanceled = u.unpackBool()!;
    final isLastInfo = u.unpackBool()!;
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
    final isWarning = u.unpackBool()!;
    final isCanceled = u.unpackBool()!;
    final isLastInfo = u.unpackBool()!;
    final regions = u
        .unpackList()
        .map((e) => Uint8List.fromList(e! as List<int>).toEewIntensityRegionFcm())
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
  final bool? isCanceled;
  final bool? isLastInfo;
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
      };
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
