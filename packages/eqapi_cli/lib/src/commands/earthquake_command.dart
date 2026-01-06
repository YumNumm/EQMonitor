import 'package:args/command_runner.dart';
import 'package:eqapi_cli/src/api_client.dart';
import 'package:eqapi_cli/src/formatters/earthquake_formatter.dart';

class EarthquakeCommand extends Command<void> {
  EarthquakeCommand() {
    addSubcommand(EarthquakeListCommand());
    addSubcommand(EarthquakeDetailCommand());
  }

  @override
  String get name => 'earthquake';

  @override
  String get description => '地震情報を取得します';
}

class EarthquakeListCommand extends Command<void> {
  EarthquakeListCommand() {
    argParser
      ..addOption('limit', abbr: 'l', help: '取得件数 (1-100)', defaultsTo: '10')
      ..addOption('cursor', abbr: 'c', help: 'ページングカーソル')
      ..addOption('magnitude-gte', help: 'マグニチュード下限')
      ..addOption('magnitude-lte', help: 'マグニチュード上限')
      ..addOption(
        'intensity-gte',
        help: '最大震度下限 (1, 2, 3, 4, 5-, 5+, 6-, 6+, 7)',
      )
      ..addOption(
        'intensity-lte',
        help: '最大震度上限 (1, 2, 3, 4, 5-, 5+, 6-, 6+, 7)',
      )
      ..addFlag('json', abbr: 'j', help: 'JSON形式で出力', negatable: false);
  }

  @override
  String get name => 'list';

  @override
  String get description => '地震情報一覧を取得します';

  @override
  Future<void> run() async {
    final limit = int.tryParse(argResults!['limit'] as String) ?? 10;
    final cursor = argResults!['cursor'] as String?;
    final magnitudeGte = double.tryParse(
      argResults!['magnitude-gte'] as String? ?? '',
    );
    final magnitudeLte = double.tryParse(
      argResults!['magnitude-lte'] as String? ?? '',
    );
    final intensityGte = argResults!['intensity-gte'] as String?;
    final intensityLte = argResults!['intensity-lte'] as String?;
    final jsonOutput = argResults!['json'] as bool;

    try {
      final response = await ApiClient.api.earthquake.getList(
        limit: limit,
        cursor: cursor,
        magnitudeGte: magnitudeGte,
        magnitudeLte: magnitudeLte,
        intensityGte: intensityGte,
        intensityLte: intensityLte,
      );

      if (jsonOutput) {
        print(EarthquakeFormatter.toJsonList(response));
      } else {
        print(EarthquakeFormatter.formatList(response));
      }

      if (response.nextToken != null) {
        print('\n次のページ: --cursor ${response.nextToken}');
      }
    } catch (e) {
      print('エラー: $e');
    }
  }
}

class EarthquakeDetailCommand extends Command<void> {
  EarthquakeDetailCommand() {
    argParser
      ..addOption(
        'event-id',
        abbr: 'e',
        help: 'イベントID (yyyyMMddHHmmss形式)',
        mandatory: true,
      )
      ..addFlag('json', abbr: 'j', help: 'JSON形式で出力', negatable: false);
  }

  @override
  String get name => 'detail';

  @override
  String get description => '地震情報の詳細を取得します';

  @override
  Future<void> run() async {
    final eventId = argResults!['event-id'] as String;
    final jsonOutput = argResults!['json'] as bool;

    try {
      final response = await ApiClient.api.earthquake.getDetail(
        eventId: eventId,
      );

      if (jsonOutput) {
        print(EarthquakeFormatter.toJsonDetail(response));
      } else {
        print(EarthquakeFormatter.formatDetail(response));
      }
    } catch (e) {
      print('エラー: $e');
    }
  }
}
