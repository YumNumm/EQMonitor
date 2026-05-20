import 'package:eqmonitor/feature/ai_chat/data/model/ai_credentials.dart';
import 'package:eqmonitor/feature/ai_chat/data/model/ai_provider.dart';
import 'package:eqmonitor/feature/ai_chat/data/tool/eq_tool_runner.dart';
import 'package:genkit/genkit.dart';
import 'package:genkit/plugin.dart' show GenkitPlugin;
import 'package:genkit_anthropic/genkit_anthropic.dart';
import 'package:genkit_google_genai/genkit_google_genai.dart';
import 'package:genkit_openai/genkit_openai.dart';
import 'package:schemantic/schemantic.dart';

/// 1 つのプロバイダー + モデル + ツール定義をまとめた Genkit 実体。
class GenkitClient {
  GenkitClient({
    required this.genkit,
    required this.model,
    required this.toolNames,
  });

  final Genkit genkit;
  final ModelRef<Object?> model;
  final List<String> toolNames;
}

/// 認証情報からプロバイダーごとの Genkit インスタンスを構築する。
GenkitClient createGenkitClient({
  required AiCredentials credentials,
  required EqToolRunner toolRunner,
}) {
  final genkit = Genkit(
    plugins: [_buildPlugin(credentials)],
  );
  _registerEqTools(genkit, toolRunner);
  return GenkitClient(
    genkit: genkit,
    model: _resolveModel(credentials),
    toolNames: _eqToolNames,
  );
}

GenkitPlugin _buildPlugin(AiCredentials credentials) {
  return switch (credentials.provider) {
    AiProvider.anthropic => anthropic(apiKey: credentials.apiKey),
    AiProvider.gemini => googleAI(apiKey: credentials.apiKey),
    AiProvider.openai => openAI(apiKey: credentials.apiKey),
  };
}

ModelRef<Object?> _resolveModel(AiCredentials credentials) {
  return switch (credentials.provider) {
    AiProvider.anthropic => anthropic.model(credentials.model),
    AiProvider.gemini => googleAI.gemini(credentials.model),
    AiProvider.openai => openAI.model(credentials.model),
  };
}

const _eqToolNames = <String>[
  'search_earthquakes',
  'get_earthquake_detail',
  'search_by_epicenter',
];

void _registerEqTools(Genkit ai, EqToolRunner runner) {
  ai.defineTool<Map<String, Object?>, Map<String, Object?>>(
    name: 'search_earthquakes',
    description:
        '気象庁が発表した日本の地震情報を絞り込み検索する。'
        'マグニチュード、震度、深さなどの条件で過去の地震を見つけたいときに使う。'
        'パラメータはすべて任意。返却は新しい順、最大30件。',
    inputSchema: _searchEarthquakesSchema,
    fn: (input, _) => runner.searchEarthquakes(
      magnitudeGte: (input['magnitudeGte'] as num?)?.toDouble(),
      magnitudeLte: (input['magnitudeLte'] as num?)?.toDouble(),
      intensityGte: input['intensityGte'] as String?,
      intensityLte: input['intensityLte'] as String?,
      depthGte: (input['depthGte'] as num?)?.toInt(),
      depthLte: (input['depthLte'] as num?)?.toInt(),
      limit: (input['limit'] as num?)?.toInt(),
    ),
  );

  ai.defineTool<Map<String, Object?>, Map<String, Object?>>(
    name: 'get_earthquake_detail',
    description: '特定の地震イベントID (eventId) の詳細情報を取得する。',
    inputSchema: _getEarthquakeDetailSchema,
    fn: (input, _) =>
        runner.getEarthquakeDetail(eventId: input['eventId']! as String),
  );

  ai.defineTool<Map<String, Object?>, Map<String, Object?>>(
    name: 'search_by_epicenter',
    description:
        '同じ震央 (epicenterCode) で過去に発生した地震を一覧する。ある地震の詳細から取得した hypocenter.code を整数化して渡すこと。',
    inputSchema: _searchByEpicenterSchema,
    fn: (input, _) => runner.searchByEpicenter(
      epicenterCode: (input['epicenterCode']! as num).toInt(),
      limit: (input['limit'] as num?)?.toInt(),
    ),
  );
}

SchemanticType<Map<String, Object?>> get _searchEarthquakesSchema =>
    SchemanticType.from<Map<String, Object?>>(
      jsonSchema: const {
        'type': 'object',
        'properties': {
          'magnitudeGte': {
            'type': 'number',
            'description': 'マグニチュードの下限 (0〜10程度)。',
          },
          'magnitudeLte': {
            'type': 'number',
            'description': 'マグニチュードの上限。',
          },
          'intensityGte': {
            'type': 'string',
            'description': '最大震度の下限。例: "5-", "5+", "6-", "6+", "7"。',
          },
          'intensityLte': {
            'type': 'string',
            'description': '最大震度の上限。',
          },
          'depthGte': {
            'type': 'integer',
            'description': '震源の深さの下限 (km)。',
          },
          'depthLte': {
            'type': 'integer',
            'description': '震源の深さの上限 (km)。',
          },
          'limit': {
            'type': 'integer',
            'description': '取得件数。デフォルト 10、最大 30。',
          },
        },
      },
      parse: (json) => Map<String, Object?>.from(json as Map),
    );

SchemanticType<Map<String, Object?>> get _getEarthquakeDetailSchema =>
    SchemanticType.from<Map<String, Object?>>(
      jsonSchema: const {
        'type': 'object',
        'properties': {
          'eventId': {
            'type': 'string',
            'description': '地震イベントID。',
          },
        },
        'required': ['eventId'],
      },
      parse: (json) => Map<String, Object?>.from(json as Map),
    );

SchemanticType<Map<String, Object?>> get _searchByEpicenterSchema =>
    SchemanticType.from<Map<String, Object?>>(
      jsonSchema: const {
        'type': 'object',
        'properties': {
          'epicenterCode': {
            'type': 'integer',
            'description': '震央地コード。hypocenter.code を整数化したもの。',
          },
          'limit': {
            'type': 'integer',
            'description': '取得件数。デフォルト 10、最大 30。',
          },
        },
        'required': ['epicenterCode'],
      },
      parse: (json) => Map<String, Object?>.from(json as Map),
    );
