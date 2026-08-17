// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TelegramDetails)
final telegramDetailsProvider = TelegramDetailsFamily._();

final class TelegramDetailsProvider
    extends
        $AsyncNotifierProvider<
          TelegramDetails,
          Map<String, TelegramDetailResponse>
        > {
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
  TelegramDetails create() => TelegramDetails();

  @override
  bool operator ==(Object other) {
    return other is TelegramDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$telegramDetailsHash() => r'06dc56f071844f39caf8e2297237a84e7864799a';

final class TelegramDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          TelegramDetails,
          AsyncValue<Map<String, TelegramDetailResponse>>,
          Map<String, TelegramDetailResponse>,
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

abstract class _$TelegramDetails
    extends $AsyncNotifier<Map<String, TelegramDetailResponse>> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<Map<String, TelegramDetailResponse>> build(String eventId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, TelegramDetailResponse>>,
              Map<String, TelegramDetailResponse>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, TelegramDetailResponse>>,
                Map<String, TelegramDetailResponse>
              >,
              AsyncValue<Map<String, TelegramDetailResponse>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
