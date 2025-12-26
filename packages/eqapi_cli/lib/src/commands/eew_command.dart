import 'package:args/command_runner.dart';
import 'package:eqapi_cli/src/api_client.dart';
import 'package:eqapi_cli/src/formatters/eew_formatter.dart';

class EewCommand extends Command<void> {
  EewCommand() {
    addSubcommand(EewListCommand());
    addSubcommand(EewLatestCommand());
    addSubcommand(EewDetailCommand());
  }

  @override
  String get name => 'eew';

  @override
  String get description => '緊急地震速報を取得します';
}

class EewListCommand extends Command<void> {
  EewListCommand() {
    argParser
      ..addOption(
        'limit',
        abbr: 'l',
        help: '取得件数 (1-100)',
        defaultsTo: '10',
      )
      ..addOption(
        'cursor',
        abbr: 'c',
        help: 'ページングカーソル',
      )
      ..addFlag(
        'json',
        abbr: 'j',
        help: 'JSON形式で出力',
        negatable: false,
      );
  }

  @override
  String get name => 'list';

  @override
  String get description => '緊急地震速報一覧を取得します（最終報のみ）';

  @override
  Future<void> run() async {
    final limit = int.tryParse(argResults!['limit'] as String) ?? 10;
    final cursor = argResults!['cursor'] as String?;
    final jsonOutput = argResults!['json'] as bool;

    try {
      final response = await ApiClient.api.eew.getList(
        limit: limit,
        cursor: cursor,
      );

      if (jsonOutput) {
        print(EewFormatter.toJsonList(response));
      } else {
        print(EewFormatter.formatList(response));
      }

      if (response.nextToken != null) {
        print('\n次のページ: --cursor ${response.nextToken}');
      }
    } catch (e) {
      print('エラー: $e');
    }
  }
}

class EewLatestCommand extends Command<void> {
  EewLatestCommand() {
    argParser.addFlag(
      'json',
      abbr: 'j',
      help: 'JSON形式で出力',
      negatable: false,
    );
  }

  @override
  String get name => 'latest';

  @override
  String get description => '最新の緊急地震速報を取得します（発表から5分以内）';

  @override
  Future<void> run() async {
    final jsonOutput = argResults!['json'] as bool;

    try {
      final response = await ApiClient.api.eew.getLatest();

      if (jsonOutput) {
        print(EewFormatter.toJsonLatest(response));
      } else {
        print(EewFormatter.formatLatest(response));
      }
    } catch (e) {
      print('エラー: $e');
    }
  }
}

class EewDetailCommand extends Command<void> {
  EewDetailCommand() {
    argParser
      ..addOption(
        'event-id',
        abbr: 'e',
        help: 'イベントID (yyyyMMddHHmmss形式)',
        mandatory: true,
      )
      ..addOption(
        'serial-no',
        abbr: 's',
        help: 'シリアル番号（指定しない場合は全件取得）',
      )
      ..addFlag(
        'json',
        abbr: 'j',
        help: 'JSON形式で出力',
        negatable: false,
      );
  }

  @override
  String get name => 'detail';

  @override
  String get description => '緊急地震速報の詳細を取得します';

  @override
  Future<void> run() async {
    final eventId = argResults!['event-id'] as String;
    final serialNoStr = argResults!['serial-no'] as String?;
    final jsonOutput = argResults!['json'] as bool;

    try {
      if (serialNoStr != null) {
        final serialNo = int.parse(serialNoStr);
        final response = await ApiClient.api.eew.getByEventIdAndSerialNo(
          eventId: eventId,
          serialNo: serialNo,
        );

        if (jsonOutput) {
          print(EewFormatter.toJsonItem(response));
        } else {
          print(EewFormatter.formatItem(response));
        }
      } else {
        final response = await ApiClient.api.eew.getByEventId(
          eventId: eventId,
        );

        if (jsonOutput) {
          print(EewFormatter.toJsonArray(response));
        } else {
          print(EewFormatter.formatArray(response));
        }
      }
    } catch (e) {
      print('エラー: $e');
    }
  }
}
