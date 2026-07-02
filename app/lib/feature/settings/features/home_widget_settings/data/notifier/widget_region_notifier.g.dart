// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'widget_region_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ホーム画面ウィジェットの「任意地域」表示に使う地域選択を永続化する。
///
/// 未選択のときは null。Pro 専用機能だが、解約後も設定自体は保持し、
/// 再購読時にそのまま復元できるようにする（App Group への反映は writer 側で
/// isPro に応じてガードする）。

@ProviderFor(WidgetRegionNotifier)
final widgetRegionProvider = WidgetRegionNotifierProvider._();

/// ホーム画面ウィジェットの「任意地域」表示に使う地域選択を永続化する。
///
/// 未選択のときは null。Pro 専用機能だが、解約後も設定自体は保持し、
/// 再購読時にそのまま復元できるようにする（App Group への反映は writer 側で
/// isPro に応じてガードする）。
final class WidgetRegionNotifierProvider
    extends
        $AsyncNotifierProvider<WidgetRegionNotifier, WidgetRegionSelection?> {
  /// ホーム画面ウィジェットの「任意地域」表示に使う地域選択を永続化する。
  ///
  /// 未選択のときは null。Pro 専用機能だが、解約後も設定自体は保持し、
  /// 再購読時にそのまま復元できるようにする（App Group への反映は writer 側で
  /// isPro に応じてガードする）。
  WidgetRegionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetRegionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetRegionNotifierHash();

  @$internal
  @override
  WidgetRegionNotifier create() => WidgetRegionNotifier();
}

String _$widgetRegionNotifierHash() =>
    r'3e867dc2e08ca5c84ccfe34493fa88ff8e9e872b';

/// ホーム画面ウィジェットの「任意地域」表示に使う地域選択を永続化する。
///
/// 未選択のときは null。Pro 専用機能だが、解約後も設定自体は保持し、
/// 再購読時にそのまま復元できるようにする（App Group への反映は writer 側で
/// isPro に応じてガードする）。

abstract class _$WidgetRegionNotifier
    extends $AsyncNotifier<WidgetRegionSelection?> {
  FutureOr<WidgetRegionSelection?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<WidgetRegionSelection?>, WidgetRegionSelection?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<WidgetRegionSelection?>,
                WidgetRegionSelection?
              >,
              AsyncValue<WidgetRegionSelection?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
