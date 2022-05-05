import 'dart:io';
import 'dart:ui' as ui;

import 'package:eqmonitor/utils/dmdata/schemas/commonHeader.dart';
import 'package:eqmonitor/utils/dmdata/schemas/eq-information/earthquake-information.dart';
import 'package:eqmonitor/utils/eq_history/eq_history_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class EqInfoPage extends StatelessWidget {
  EqInfoPage({Key? key}) : super(key: key);
  final GlobalKey shareKey = GlobalKey();

  final payload =
      (Get.arguments as Map<String, dynamic>)['payload'] as CommonHead;
  final data = EarthquakeInformation.fromJson(
    ((Get.arguments as Map<String, dynamic>)['payload'] as CommonHead).body,
  );
  final eqLog =
      (Get.arguments as Map<String, dynamic>)['eqLog'] as EqHistoryContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('震源・震度情報'),
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
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: RepaintBoundary(
            key: shareKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.network(
                    eqLog.imageUrl,
                    cacheWidth: 1024,
                    cacheHeight: 512,
                    errorBuilder:
                        (BuildContext context, Object obj, StackTrace? st) {
                      return Text('エラーが発生しました\n$st');
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: IntrinsicWidth(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/intensity/${(eqLog.maxint.contains("不明")) ? "unknown" : eqLog.maxint}.PNG',
                              height: context.height * 0.12,
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Column(
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        '深さ',
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${data.earthquake!.hypoCenter.depth.value}km',
                                        style: context.textTheme.displaySmall!
                                            .copyWith(
                                          fontFamily: 'CaskaydiaCove',
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'マグニチュード',
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      eqLog.magnitude.toString(),
                                      style: context.textTheme.displaySmall!
                                          .copyWith(
                                        fontFamily: 'CaskaydiaCove',
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "発生時刻: ${DateFormat("yyyy/MM/dd HH:mm頃").format(data.earthquake!.arrivalTime)}",
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      fontFamily: 'CaskaydiaCove',
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(data.comments!.forecast!.text),
                for (final i in data.intensity!.regions)
                  Text('${i.name}: ${i.maxInt}'),
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
      print(error);
    }
  }

  Future<File> _getApplicationDocumentsFile(
      String text, List<int> imageData) async {
    final directory = await getApplicationDocumentsDirectory();

    final exportFile = File('${directory.path}/$text.png');
    if (!await exportFile.exists()) {
      await exportFile.create(recursive: true);
    }
    final file = await exportFile.writeAsBytes(imageData);
    return file;
  }
}
