// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telegramDetails)
final telegramDetailsProvider = TelegramDetailsFamily._();

final class TelegramDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, TelegramDetailResponse>>,
          Map<String, TelegramDetailResponse>,
          FutureOr<Map<String, TelegramDetailResponse>>
        >
    with
        $FutureModifier<Map<String, TelegramDetailResponse>>,
        $FutureProvider<Map<String, TelegramDetailResponse>> {
  TelegramDetailsProvider._({
    required TelegramDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'telegramDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$telegramDetailsHash();

  @override
  String toString() {
    return r'telegramDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, TelegramDetailResponse>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, TelegramDetailResponse>> create(Ref ref) {
    final argument = this.argument as String;
    return telegramDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TelegramDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$telegramDetailsHash() => r'58bcc5388e64fb23de3974cb46bee18acae5efba';

final class TelegramDetailsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<String, TelegramDetailResponse>>,
          String
        > {
  TelegramDetailsFamily._()
    : super(
        retry: null,
        name: r'telegramDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TelegramDetailsProvider call(String eventId) =>
      TelegramDetailsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'telegramDetailsProvider';
}
