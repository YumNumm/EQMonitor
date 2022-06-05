import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';
import 'package:eqmonitor/widget/pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../schema/dmdata/alphabet_extension.dart';
import '../schema/dmdata/commonHeader.dart';
import '../schema/dmdata/eq-information/earthquake-information.dart';
import '../schema/earthquake-history/telegram.dart';

class EqInfoPage extends StatelessWidget {
  EqInfoPage({super.key});
  final GlobalKey shareKey = GlobalKey();

  final Logger logger = Get.find<Logger>();
  final Schema schema =
      (Get.arguments as Map<String, dynamic>)['eqLog'] as Schema;
  final payload =
      (Get.arguments as Map<String, dynamic>)['payload'] as CommonHead;
  final data = EarthquakeInformation.fromJson(
    ((Get.arguments as Map<String, dynamic>)['payload'] as CommonHead).body,
  );

  @override
  Widget build(BuildContext context) {
    final prefectureIntensity = <JmaIntensity, List<String>>{};
    if (data.intensity?.prefectures != null) {
      for (final element in data.intensity!.prefectures) {
        final jmaInt = JmaIntensity.values.firstWhere(
          (e) => element.maxInt == e.name,
          orElse: () => JmaIntensity.Unknown,
        );
        if (prefectureIntensity[jmaInt] != null) {
          // 追加
          prefectureIntensity[jmaInt]!.add(element.name);
        } else {
          prefectureIntensity.addAll({
            jmaInt: [element.name]
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          schema.headline.alphanumericToHalfLength().replaceAll(' ', ''),
        ),
        actions: [
          IconButton(
            onPressed: () async => Get.showOverlay(
              asyncFunction: () async => shareImageAndText('text', shareKey),
              loadingWidget: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: RepaintBoundary(
            key: shareKey,
            child: Column(
              children: [
                if (schema.imageUrl != null)
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: schema.imageUrl.toString(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                      errorWidget: (context, url, dynamic error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                Card(
                  margin: const EdgeInsets.all(7),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(),
                        AutoSizeText(
                          '深さ: ${(data.earthquake?.hypoCenter.depth.value != null) ? "${data.earthquake?.hypoCenter.depth.value}km" : '不明'}\n'
                          'マグニチュード: ${schema.magnitude ?? schema.magnitudeCondition ?? '不明'}\n'
                          '震源地: ${schema.hypoName ?? "不明"}\n'
                          '${(data.earthquake != null) ? '発生時刻: '
                              '${DateFormat("yyyy/MM/dd HH:mm頃").format(data.earthquake!.arrivalTime.toLocal())}' : '発生時刻 不明'}',
                          style: context.textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(data.comments?.forecast?.text ?? ''),
                const Divider(),
                if (data.comments?.free != null)
                  Text((data.comments?.free ?? '').alphanumericToHalfLength()),
                if (data.comments?.free != null) const Divider(),
                if (data.intensity != null)
                  for (JmaIntensity ji in prefectureIntensity.keys)
                    Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child:
                                Image.asset('assets/intensity/${ji.name}.PNG'),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final String pref
                                  in prefectureIntensity[ji]!)
                                PrefWidget(
                                  pref: pref,
                                  data: data,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ByteData> _exportToImage(GlobalKey globalKey) async {
    final boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(
      pixelRatio: 3,
    );
    final byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!;
  }

  Future<void> shareImageAndText(String text, GlobalKey globalKey) async {
    //shareする際のテキスト
    try {
      //byte dataに
      final bytes = await _exportToImage(globalKey);
      final widgetImageData =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //App directoryファイルに保存
      final applicationDocumentsFile =
          await _getApplicationDocumentsFile(text, widgetImageData);

      final path = applicationDocumentsFile.path;
      await Share.shareFiles([path], subject: 'image');
      await applicationDocumentsFile.delete();
    } catch (error) {
      logger.i(error);
    }
  }

  Future<File> _getApplicationDocumentsFile(
    String text,
    List<int> imageData,
  ) async {
    final directory = await getApplicationDocumentsDirectory();

    final exportFile = File('${directory.path}/$text.png');
    if (!await exportFile.exists()) {
      await exportFile.create(recursive: true);
    }
    final file = await exportFile.writeAsBytes(imageData);
    return file;
  }
}
