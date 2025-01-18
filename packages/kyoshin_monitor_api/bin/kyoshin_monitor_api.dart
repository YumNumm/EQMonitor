import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

void main(List<String> args) async {
  final runner = CommandRunner<void>(
    'kmoni',
    '強震モニタのデータをダウンロードするCLIツール',
  )..addCommand(DownloadCommand());

  await runner.run(args);
}

class DownloadCommand extends Command<void> {
  DownloadCommand() {
    argParser
      ..addOption(
        'type',
        abbr: 't',
        help: 'データの種類を指定します',
        allowed: RealtimeDataType.values.map((e) => e.urlString).toList(),
        mandatory: true,
      )
      ..addOption(
        'layer',
        abbr: 'l',
        help: 'レイヤーを指定します',
        allowed: RealtimeLayer.values.map((e) => e.urlString).toList(),
        mandatory: true,
      )
      ..addOption(
        'datetime',
        abbr: 'd',
        help: '日時を指定します (yyyyMMddHHmmss形式)',
        defaultsTo: DateTime.now()
            .subtract(
              const Duration(seconds: 10),
            )
            .toIso8601String(),
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: '出力ファイル名を指定します',
        mandatory: true,
      );
  }

  @override
  String get name => 'download';

  @override
  String get description => '強震モニタのデータをダウンロードします';

  @override
  Future<void> run() async {
    final type = RealtimeDataType.values.firstWhere(
      (e) => e.urlString == argResults!['type'] as String,
    );
    final layer = RealtimeLayer.values.firstWhere(
      (e) => e.urlString == argResults!['layer'] as String,
    );
    final datetime = DateTime.parse(
      argResults!['datetime'] as String,
    );
    final output = argResults!['output'] as String;

    final dio = Dio();
    final lpgmKyoshinMonitorWebApiDataSource =
        LpgmKyoshinMonitorWebApiDataSource(
      client: LpgmKyoshinMonitorWebApiClientApiClient(dio),
    );
    final kyoshinMonitorWebApiDataSource = KyoshinMonitorWebApiDataSource(
      client: KyoshinMonitorWebApiClient(dio),
    );
    try {
      final data = type.isLpgm
          ? await lpgmKyoshinMonitorWebApiDataSource.getRealtimeImageData(
              type,
              layer,
              datetime,
            )
          : await kyoshinMonitorWebApiDataSource.getRealtimeImageData(
              type,
              layer,
              datetime,
            );
      await File(output).writeAsBytes(data);
      print('ダウンロードが完了しました: $output');
    } catch (e) {
      print('エラーが発生しました: $e');
      if (e is DioException) {
        final url = e.requestOptions.uri.toString();
        print('リクエストURL: $url');
      }
      exit(1);
    } finally {
      dio.close();
    }
  }
}
