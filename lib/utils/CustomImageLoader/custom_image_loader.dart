import 'dart:io';

import 'package:eqmonitor/utils/earthquake.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class CustomImageLoader extends GetxController {
  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();

  late Directory root;
  final RxBool hasImages = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    root = await getApplicationDocumentsDirectory();
    if (Directory('${root.path}/eqImages').existsSync()) {
      hasImages.value = true;
    }
  }

  Future<File?> chooseFile() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: '地震の画像ZIP集を選択',
      lockParentWindow: true,
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (result != null) {
      final file = result.files.first;
      logger.i(file.path);
      final fileBytes = File(file.path!).readAsBytesSync();
      final savedFile = File('${root.path}/archive.zip');
      if (savedFile.existsSync()) savedFile.deleteSync();
      savedFile
        ..createSync()
        ..writeAsBytesSync(fileBytes);
      // 解凍
      final destinationDir = Directory('${root.path}/eqImages')..createSync();
      try {
        await ZipFile.extractToDirectory(
          zipFile: savedFile,
          destinationDir: destinationDir,
          onExtracting: (zipEntry, progress) {
            if (kDebugMode) print('progress: ${progress.toStringAsFixed(1)}%');
            return ZipFileOperation.includeItem;
          },
        );
        Get.snackbar(
          'ファイル読み込み完了',
          '${destinationDir.listSync().length}のファイルを読み込みました。',
        );
        earthQuake.imageQueue.value.remove(true);
        final l = destinationDir.listSync()
          ..sort((a, b) => a.path.compareTo(b.path))
          ..forEach((e) {
            if (e.path.contains('.png')) {
              earthQuake.imageQueue.value
                  .addLast(File(e.path).readAsBytesSync());
            }
          });
      } on Exception catch (e) {
        logger.w(e);
      }
    } else {
      Get.snackbar('ファイル取得に失敗', 'ファイルを選択してください');
    }
    return null;
  }
}
