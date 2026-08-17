// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TsunamiDetailsNotifier)
final tsunamiDetailsProvider = TsunamiDetailsNotifierFamily._();

final class TsunamiDetailsNotifierProvider
    extends $AsyncNotifierProvider<TsunamiDetailsNotifier, TsunamiState> {
  TsunamiDetailsNotifierProvider._({
    required TsunamiDetailsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tsunamiDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tsunamiDetailsNotifierHash();

  @override
  String toString() {
    return r'tsunamiDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TsunamiDetailsNotifier create() => TsunamiDetailsNotifier();

  @override
  bool operator ==(Object other) {
    return other is TsunamiDetailsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tsunamiDetailsNotifierHash() =>
    r'03dbe200746b1b027ea9bf8009e8b309622e0d08';

final class TsunamiDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TsunamiDetailsNotifier,
          AsyncValue<TsunamiState>,
          TsunamiState,
          FutureOr<TsunamiState>,
          String
        > {
  TsunamiDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'tsunamiDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TsunamiDetailsNotifierProvider call(String tsunamiId) =>
      TsunamiDetailsNotifierProvider._(argument: tsunamiId, from: this);

  @override
  String toString() => r'tsunamiDetailsProvider';
}

abstract class _$TsunamiDetailsNotifier extends $AsyncNotifier<TsunamiState> {
  late final _$args = ref.$arg as String;
  String get tsunamiId => _$args;

  FutureOr<TsunamiState> build(String tsunamiId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TsunamiState>, TsunamiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TsunamiState>, TsunamiState>,
              AsyncValue<TsunamiState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
