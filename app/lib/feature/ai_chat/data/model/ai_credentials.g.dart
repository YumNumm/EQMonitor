// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ai_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiCredentials _$AiCredentialsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AiCredentials', json, ($checkedConvert) {
      final val = _AiCredentials(
        provider: $checkedConvert(
          'provider',
          (v) => $enumDecode(_$AiProviderEnumMap, v),
        ),
        model: $checkedConvert('model', (v) => v as String),
        apiKey: $checkedConvert('api_key', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'apiKey': 'api_key'});

Map<String, dynamic> _$AiCredentialsToJson(_AiCredentials instance) =>
    <String, dynamic>{
      'provider': _$AiProviderEnumMap[instance.provider]!,
      'model': instance.model,
      'api_key': instance.apiKey,
    };

const _$AiProviderEnumMap = {
  AiProvider.anthropic: 'anthropic',
  AiProvider.gemini: 'gemini',
  AiProvider.openai: 'openai',
};

_AiCredentialsStore _$AiCredentialsStoreFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_AiCredentialsStore',
      json,
      ($checkedConvert) {
        final val = _AiCredentialsStore(
          selectedProvider: $checkedConvert(
            'selected_provider',
            (v) => $enumDecode(_$AiProviderEnumMap, v),
          ),
          credentials: $checkedConvert(
            'credentials',
            (v) =>
                (v as Map<String, dynamic>?)?.map(
                  (k, e) => MapEntry(
                    $enumDecode(_$AiProviderEnumMap, k),
                    AiCredentials.fromJson(e as Map<String, dynamic>),
                  ),
                ) ??
                const {},
          ),
        );
        return val;
      },
      fieldKeyMap: const {'selectedProvider': 'selected_provider'},
    );

Map<String, dynamic> _$AiCredentialsStoreToJson(_AiCredentialsStore instance) =>
    <String, dynamic>{
      'selected_provider': _$AiProviderEnumMap[instance.selectedProvider]!,
      'credentials': instance.credentials.map(
        (k, e) => MapEntry(_$AiProviderEnumMap[k]!, e),
      ),
    };
