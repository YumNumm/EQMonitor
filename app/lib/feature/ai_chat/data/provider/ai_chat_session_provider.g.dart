// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ai_chat_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiChatSession)
final aiChatSessionProvider = AiChatSessionFamily._();

final class AiChatSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<AiChatSession>,
          AiChatSession,
          FutureOr<AiChatSession>
        >
    with $FutureModifier<AiChatSession>, $FutureProvider<AiChatSession> {
  AiChatSessionProvider._({
    required AiChatSessionFamily super.from,
    required ({String? initialMessage, String? extraSystemPrompt})
    super.argument,
  }) : super(
         retry: null,
         name: r'aiChatSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aiChatSessionHash();

  @override
  String toString() {
    return r'aiChatSessionProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<AiChatSession> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AiChatSession> create(Ref ref) {
    final argument =
        this.argument as ({String? initialMessage, String? extraSystemPrompt});
    return aiChatSession(
      ref,
      initialMessage: argument.initialMessage,
      extraSystemPrompt: argument.extraSystemPrompt,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AiChatSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aiChatSessionHash() => r'f30a48b1236820a775a1afd8d1cf9269a73ba6d8';

final class AiChatSessionFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<AiChatSession>,
          ({String? initialMessage, String? extraSystemPrompt})
        > {
  AiChatSessionFamily._()
    : super(
        retry: null,
        name: r'aiChatSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AiChatSessionProvider call({
    String? initialMessage,
    String? extraSystemPrompt,
  }) => AiChatSessionProvider._(
    argument: (
      initialMessage: initialMessage,
      extraSystemPrompt: extraSystemPrompt,
    ),
    from: this,
  );

  @override
  String toString() => r'aiChatSessionProvider';
}
