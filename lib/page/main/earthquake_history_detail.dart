import 'package:eqmonitor/extension/relative_luminance.dart';
import 'package:eqmonitor/model/setting/jma_intensity_color_model.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../../const/kmoni/jma_intensity.dart';
import '../../const/prefecture/area_forecast_local_eew.model.dart';
import '../../provider/init/map_area_forecast_local_e.dart';
import '../../schema/dmdata/commonHeader.dart';
import '../../schema/dmdata/eq-information/earthquake-information.dart';
import '../../schema/dmdata/eq-information/earthquake-information/intensity/region.dart';
import '../../schema/dmdata/eq-information/earthquake-information/intensity/station.dart';
import '../../schema/dmdata/eq-information/earthquake.dart';
import '../../schema/supabase/telegram.dart';
import '../../utils/map/map_global_offset.dart';
import '../../widget/intensity/intensity_widget.dart';
import 'kmoni_map.dart';

class EarthquakeHistoryDetailPage extends HookConsumerWidget {
  EarthquakeHistoryDetailPage({
    super.key,
    required this.telegrams,
  });

  List<Telegram> telegrams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(jmaIntensityColorProvider);
    // 地震情報を解析していきます
    final vxse51Telegrams = <CommonHead>[];
    final vxse52Telegrams = <CommonHead>[];
    final vxse53Telegrams = <CommonHead>[];
    final vxse61Telegrams = <CommonHead>[];
    for (final e in telegrams) {
      switch (e.type) {
        case 'VXSE51':
          vxse51Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        case 'VXSE52':
          vxse52Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        case 'VXSE53':
          vxse53Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        case 'VXSE61':
          vxse61Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        default:
      }
    }

    final latestVxse51Head =
        (vxse51Telegrams.isEmpty) ? null : vxse51Telegrams.last;
    final latestVxse51Info = (latestVxse51Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse51Head.body);
    final latestVxse52Head =
        (vxse52Telegrams.isEmpty) ? null : vxse52Telegrams.last;
    final latestVxse52Info = (latestVxse52Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse52Head.body);
    final latestVxse53Head =
        (vxse53Telegrams.isEmpty) ? null : vxse53Telegrams.last;
    final latestVxse53Info = (latestVxse53Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse53Head.body);
    final latestVxse61Head =
        (vxse61Telegrams.isEmpty) ? null : vxse61Telegrams.last;
    final latestVxse61Info = (latestVxse61Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse61Head.body);

    // 速報かどうか
    final isSokuhou = latestVxse61Head == null && latestVxse53Head == null;

    /// ## 震源要素
    /// VXSE61 -> VXSE53 -> VXSE52
    final component = latestVxse61Info?.earthquake ??
        latestVxse53Info?.earthquake ??
        latestVxse52Info?.earthquake;

    /// ## 各地の震度
    /// VXSE53 -> VXSE51
    final intensity =
        latestVxse53Info?.intensity ?? latestVxse51Info?.intensity;
    final maxInt = JmaIntensity.values.firstWhere(
      (e) => e.name == (intensity?.maxInt ?? ''),
      orElse: () => JmaIntensity.Unknown,
    );

    /// ## 最新のComment
    /// VXSE61 -> VXSE53 -> VXSE52 -> VXSE51
    final comment = latestVxse61Info?.comments ??
        latestVxse53Info?.comments ??
        latestVxse52Info?.comments ??
        latestVxse51Info?.comments;

    return Scaffold(
      appBar: AppBar(
        title: Text('地震${isSokuhou ? "速報" : "情報"}'),
      ),
      body: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: (maxInt != JmaIntensity.Int1)
                  ? maxInt.fromUser(colors).withOpacity(0.3)
                  : null,
            ),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: maxInt.fromUser(colors),
                  border: Border.all(
                    color: maxInt.fromUser(colors).onPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IntensityWidget(
                  intensity: maxInt,
                  size: 42,
                ),
              ),
              enableFeedback: true,
              title: Text(
                component?.hypoCenter.name ?? '震源調査中',
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Wrap(
                children: [
                  Text(
                    (StringBuffer()
                          ..writeAll(
                            <String>[
                              if (component?.originTime != null)
                                "${DateFormat('yyyy/MM/dd HH:mm').format(component!.originTime.toLocal())}頃 ",
                              // マグニチュード
                              if (component?.magnitude != null)
                                (component!.magnitude.condition != null)
                                    ? component.magnitude.condition!.description
                                    : (component.magnitude.value != null)
                                        ? 'M${component.magnitude.value!}'
                                        : 'M不明',
                              ' ',
                              // 震源の深さ
                              if (component?.hypoCenter.depth != null)
                                (component?.hypoCenter.depth.condition != null)
                                    ? component!
                                        .hypoCenter.depth.condition!.description
                                    : (component!.hypoCenter.depth.value !=
                                            null)
                                        ? '深さ${component.hypoCenter.depth.value}km'
                                        : '不明',
                            ],
                          ))
                        .toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  // 速報かどうか
                  if (isSokuhou)
                    const Chip(
                      padding: EdgeInsets.zero,
                      label: Text(
                        '速報',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  // 顕著な地震の震源要素更新のお知らせ かどうか
                  if (latestVxse61Head != null)
                    const Chip(
                      padding: EdgeInsets.zero,
                      label: Text(
                        '顕著な地震の震源要素更新のお知らせ ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Text(
            (StringBuffer()
                  ..writeAll(
                    <String>[
                      if (comment?.forecast?.text != null)
                        '${comment!.forecast!.text}\n',
                      if (comment?.comments?.text != null)
                        '${comment!.comments!.text}\n',
                      if (comment?.free != null) comment!.free!,
                    ],
                  ))
                .toString(),
            style: const TextStyle(fontSize: 12),
          ),
          Expanded(
            child: Stack(
              children: [
                InteractiveViewer(
                  maxScale: 20,
                  child: Stack(
                    children: [
                      // マップベース
                      const BaseMapWidget(),
                      // Region毎の震度
                      MapRegionIntensityWidget(
                        regions: intensity?.regions ?? <Region>[],
                      ),
                      // 震央位置
                      MapHypoCenterMapWidget(
                        component: component,
                      ),
                      //  観測点ごとの震度
                      // TODO(YumNumm): 観測点震度描画をCustomPainterに移植する
                      // MapStationIntensityWidget(
                      //   stations: intensity?.stations ?? [],
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        for (final i in JmaIntensity.values)
                          if (i == JmaIntensity.over)
                            const SizedBox.shrink()
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IntensityWidget(
                                  intensity: i,
                                  size: 25,
                                  opacity: 1,
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MapRegionIntensityWidget extends ConsumerWidget {
  const MapRegionIntensityWidget({
    super.key,
    required this.regions,
  });
  final List<Region> regions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    return CustomPaint(
      painter: MapRegionIntensityPainter(
        mapPolygons: mapSource,
        regions: regions,
        colors: ref.watch(jmaIntensityColorProvider),
      ),
      size: Size.infinite,
    );
  }
}

class MapRegionIntensityPainter extends CustomPainter {
  MapRegionIntensityPainter({
    required this.mapPolygons,
    required this.regions,
    required this.colors,
  });
  final List<MapPolygon> mapPolygons;
  final List<Region> regions;
  final JmaIntensityColorModel colors;

  @override
  void paint(Canvas canvas, Size size) {
    for (final region in regions) {
      // region.codeが一致するMapPolygonを探す
      try {
        final mapRegionPolygons = mapPolygons.where(
          (element) => element.code == region.code,
        );
        for (final mapPolygon in mapRegionPolygons) {
          canvas
            ..drawPath(
              mapPolygon.path,
              Paint()
                ..color = JmaIntensity.values
                    .firstWhere(
                      (e) => e.name == region.maxInt.toString(),
                      orElse: () => JmaIntensity.Error,
                    )
                    .fromUser(colors)
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            )
            ..drawPath(
              mapPolygon.path,
              Paint()
                ..color = const Color.fromARGB(255, 255, 255, 255)
                ..isAntiAlias = true
                ..style = PaintingStyle.stroke,
            );
        }
      } on Exception catch (e) {
        Logger().e(e, region.code);
      }
    }
  }

  @override
  bool shouldRepaint(MapRegionIntensityPainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons ||
        oldDelegate.regions != regions;
  }
}

class MapHypoCenterMapWidget extends StatelessWidget {
  const MapHypoCenterMapWidget({
    super.key,
    required this.component,
  });
  final EarthQuakeInformationComponent? component;

  @override
  Widget build(BuildContext context) {
    if (component == null) {
      return const SizedBox.shrink();
    }
    return CustomPaint(
      painter: MapHypoCenterPainter(
        component: component!,
      ),
      size: Size.infinite,
    );
  }
}

class MapHypoCenterPainter extends CustomPainter {
  MapHypoCenterPainter({
    required this.component,
  });

  final EarthQuakeInformationComponent component;

  @override
  void paint(Canvas canvas, Size size) {
    {
      final offset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(
          component.hypoCenter.coordinateComponent.latitude!.value,
          component.hypoCenter.coordinateComponent.longitude!.value,
        ),
      ).toLocalOffset(const Size(476, 927.4));
      // ×印を描く
      {
        final textPainter = TextPainter(
          text: TextSpan(
            children: [
              TextSpan(
                text: '×',
                style: TextStyle(
                  fontSize: 14,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeCap = StrokeCap.round
                    ..strokeJoin = StrokeJoin.round
                    ..strokeWidth = 1
                    ..color = const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(
            offset.dx - (textPainter.width / 2),
            offset.dy - (textPainter.height / 2),
          ),
        );
      }
      {
        final textPainter = TextPainter(
          text: TextSpan(
            children: [
              TextSpan(
                text: '×',
                style: TextStyle(
                  fontSize: 14,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeCap = StrokeCap.round
                    ..strokeJoin = StrokeJoin.round
                    ..strokeWidth = 0.3
                    ..color = const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(
            offset.dx - (textPainter.width / 2),
            offset.dy - (textPainter.height / 2),
          ),
        );
      }
      {
        final textPainter = TextPainter(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '×',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(
            offset.dx - (textPainter.width / 2),
            offset.dy - (textPainter.height / 2),
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant MapHypoCenterPainter oldDelegate) =>
      oldDelegate.component != component;
}

class MapStationIntensityWidget extends ConsumerWidget {
  const MapStationIntensityWidget({
    super.key,
    required this.stations,
  });
  final List<Station> stations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final allParameterEarthquakeItem = ref.watch(parameterEarthquakeProvider);

    final widgets = <Widget>[];

    // 各観測点の処理
    for (final station in stations) {
      try {
        // 緯度経度を取得
        //final param = allParameterEarthquakeItem.items
        //    .firstWhere((e) => e.code == station.code);
        // final offset = MapGlobalOffset.latLonToGlobalPoint(
        //   LatLng(param.latitude, param.longitude),
        // ).toLocalOffset(const Size(476, 927.4));
        // widgets.add(
        //   DecoratedBox(
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         color: Colors.red,
        //       ),
        //     ),
        //     child: Positioned(
        //       left: offset.dx,
        //       top: offset.dy,
        //       child: IntensityWidget(
        //         intensity: JmaIntensity.values
        //             .firstWhere((e) => e.name == station.intensity),
        //         size: 2,
        //         opacity: 1,
        //       ),
        //     ),
        //   ),
        // );
      } on Exception catch (_) {}
    }

    return Stack(
      children: widgets,
    );
  }
}
