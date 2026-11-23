// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_kyoshin_archive_window_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayKyoshinArchiveWindow)
final replayKyoshinArchiveWindowProvider = ReplayKyoshinArchiveWindowFamily._();

final class ReplayKyoshinArchiveWindowProvider
    extends
        $FunctionalProvider<
          ReplayKyoshinArchiveWindow?,
          ReplayKyoshinArchiveWindow?,
          ReplayKyoshinArchiveWindow?
        >
    with $Provider<ReplayKyoshinArchiveWindow?> {
  ReplayKyoshinArchiveWindowProvider._({
    required ReplayKyoshinArchiveWindowFamily super.from,
    required ({DateTime? originTime, OriginTimePrecision precision})
    super.argument,
  }) : super(
         retry: null,
         name: r'replayKyoshinArchiveWindowProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$replayKyoshinArchiveWindowHash();

  @override
  String toString() {
    return r'replayKyoshinArchiveWindowProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<ReplayKyoshinArchiveWindow?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayKyoshinArchiveWindow? create(Ref ref) {
    final argument =
        this.argument
            as ({DateTime? originTime, OriginTimePrecision precision});
    return replayKyoshinArchiveWindow(
      ref,
      originTime: argument.originTime,
      precision: argument.precision,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayKyoshinArchiveWindow? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayKyoshinArchiveWindow?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReplayKyoshinArchiveWindowProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$replayKyoshinArchiveWindowHash() =>
    r'c5f811ffd0148c658730c34119fec7f6cd4f0f8b';

final class ReplayKyoshinArchiveWindowFamily extends $Family
    with
        $FunctionalFamilyOverride<
          ReplayKyoshinArchiveWindow?,
          ({DateTime? originTime, OriginTimePrecision precision})
        > {
  ReplayKyoshinArchiveWindowFamily._()
    : super(
        retry: null,
        name: r'replayKyoshinArchiveWindowProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReplayKyoshinArchiveWindowProvider call({
    required DateTime? originTime,
    required OriginTimePrecision precision,
  }) => ReplayKyoshinArchiveWindowProvider._(
    argument: (originTime: originTime, precision: precision),
    from: this,
  );

  @override
  String toString() => r'replayKyoshinArchiveWindowProvider';
}
