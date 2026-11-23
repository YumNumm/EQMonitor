// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_library_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayLibraryNotifier)
final replayLibraryProvider = ReplayLibraryNotifierProvider._();

final class ReplayLibraryNotifierProvider
    extends
        $AsyncNotifierProvider<ReplayLibraryNotifier, ReplayLibraryContents> {
  ReplayLibraryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayLibraryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayLibraryNotifierHash();

  @$internal
  @override
  ReplayLibraryNotifier create() => ReplayLibraryNotifier();
}

String _$replayLibraryNotifierHash() =>
    r'a8c37dd9574dea269f426be90dc2438a37c9a044';

abstract class _$ReplayLibraryNotifier
    extends $AsyncNotifier<ReplayLibraryContents> {
  FutureOr<ReplayLibraryContents> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ReplayLibraryContents>, ReplayLibraryContents>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ReplayLibraryContents>,
                ReplayLibraryContents
              >,
              AsyncValue<ReplayLibraryContents>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
