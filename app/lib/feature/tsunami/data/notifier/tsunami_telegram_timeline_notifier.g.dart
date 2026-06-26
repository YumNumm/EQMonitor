// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_timeline_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tsunamiTelegramTimeline)
final tsunamiTelegramTimelineProvider = TsunamiTelegramTimelineFamily._();

final class TsunamiTelegramTimelineProvider
    extends
        $FunctionalProvider<
          AsyncValue<TsunamiTimeline>,
          TsunamiTimeline,
          FutureOr<TsunamiTimeline>
        >
    with $FutureModifier<TsunamiTimeline>, $FutureProvider<TsunamiTimeline> {
  TsunamiTelegramTimelineProvider._({
    required TsunamiTelegramTimelineFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tsunamiTelegramTimelineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tsunamiTelegramTimelineHash();

  @override
  String toString() {
    return r'tsunamiTelegramTimelineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TsunamiTimeline> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TsunamiTimeline> create(Ref ref) {
    final argument = this.argument as String;
    return tsunamiTelegramTimeline(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TsunamiTelegramTimelineProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tsunamiTelegramTimelineHash() =>
    r'4619e898ff3a589c317c73e6ce32ec2229526b16';

final class TsunamiTelegramTimelineFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TsunamiTimeline>, String> {
  TsunamiTelegramTimelineFamily._()
    : super(
        retry: null,
        name: r'tsunamiTelegramTimelineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TsunamiTelegramTimelineProvider call(String tsunamiId) =>
      TsunamiTelegramTimelineProvider._(argument: tsunamiId, from: this);

  @override
  String toString() => r'tsunamiTelegramTimelineProvider';
}
