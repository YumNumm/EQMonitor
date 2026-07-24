// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_vxse_debug_editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeVxseDebugEditorController)
final earthquakeVxseDebugEditorControllerProvider =
    EarthquakeVxseDebugEditorControllerFamily._();

final class EarthquakeVxseDebugEditorControllerProvider
    extends
        $NotifierProvider<
          EarthquakeVxseDebugEditorController,
          EarthquakeVxseDebugEditorState
        > {
  EarthquakeVxseDebugEditorControllerProvider._({
    required EarthquakeVxseDebugEditorControllerFamily super.from,
    required Earthquake super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeVxseDebugEditorControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeVxseDebugEditorControllerHash();

  @override
  String toString() {
    return r'earthquakeVxseDebugEditorControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeVxseDebugEditorController create() =>
      EarthquakeVxseDebugEditorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeVxseDebugEditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeVxseDebugEditorState>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeVxseDebugEditorControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeVxseDebugEditorControllerHash() =>
    r'dac6b0a3605937be755853ffbe854bc2a1717cf1';

final class EarthquakeVxseDebugEditorControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeVxseDebugEditorController,
          EarthquakeVxseDebugEditorState,
          EarthquakeVxseDebugEditorState,
          EarthquakeVxseDebugEditorState,
          Earthquake
        > {
  EarthquakeVxseDebugEditorControllerFamily._()
    : super(
        retry: null,
        name: r'earthquakeVxseDebugEditorControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeVxseDebugEditorControllerProvider call(Earthquake current) =>
      EarthquakeVxseDebugEditorControllerProvider._(
        argument: current,
        from: this,
      );

  @override
  String toString() => r'earthquakeVxseDebugEditorControllerProvider';
}

abstract class _$EarthquakeVxseDebugEditorController
    extends $Notifier<EarthquakeVxseDebugEditorState> {
  late final _$args = ref.$arg as Earthquake;
  Earthquake get current => _$args;

  EarthquakeVxseDebugEditorState build(Earthquake current);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              EarthquakeVxseDebugEditorState,
              EarthquakeVxseDebugEditorState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                EarthquakeVxseDebugEditorState,
                EarthquakeVxseDebugEditorState
              >,
              EarthquakeVxseDebugEditorState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
