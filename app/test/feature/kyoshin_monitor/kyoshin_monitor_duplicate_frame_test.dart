import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_frame_policy.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sample.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_delay_calibration_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_settings_model.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart' hide Result;
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  final first = DateTime.utc(2026, 11, 17, 3, 0, 10);
  final second = first.add(const Duration(seconds: 1));

  group('KyoshinMonitorFramePolicy', () {
    const policy = KyoshinMonitorFramePolicy();

    test('取得済みのフレームと同じ対象時刻なら取得済みとする', () {
      expect(
        policy.isAlreadyFetched(
          current: KyoshinMonitorState(lastImageFetchTargetTime: first),
          targetTime: first.toLocal(),
        ),
        isTrue,
      );
    });

    test('対象時刻が違う・まだ取得していない場合は取得済みとしない', () {
      expect(
        policy.isAlreadyFetched(
          current: KyoshinMonitorState(lastImageFetchTargetTime: first),
          targetTime: second,
        ),
        isFalse,
      );
      expect(
        policy.isAlreadyFetched(
          current: const KyoshinMonitorState(),
          targetTime: first,
        ),
        isFalse,
      );
      expect(
        policy.isAlreadyFetched(current: null, targetTime: first),
        isFalse,
      );
    });
  });

  group('KyoshinMonitorNotifier', () {
    test('遅延の見積もりが変わってタイマーが作り直されても、同じ対象時刻の画像を取り直さない', () async {
      final harness = await _Harness.create();

      await harness.emit(first);
      expect(harness.repository.fetched, [first]);
      expect(harness.state.value?.lastImageFetchTargetTime, first);

      // 公開遅延の見積もりが変わると provider が再構築され、即時に 1 枚発行する。
      await harness.rebuildTimerAndEmit(first);
      await harness.rebuildTimerAndEmit(first);

      expect(harness.repository.fetched, [first]);
      expect(harness.state.value?.lastImageFetchTargetTime, first);

      await harness.rebuildTimerAndEmit(second);

      expect(harness.repository.fetched, [first, second]);
      expect(harness.state.value?.lastImageFetchTargetTime, second);
    });

    test('未公開 (404) だった対象時刻は、作り直されたタイマーで取り直す', () async {
      final harness = await _Harness.create();
      await harness.emit(first);
      harness.repository.notPublished.add(second);

      await harness.rebuildTimerAndEmit(second);
      expect(harness.repository.fetched, [first, second]);
      expect(harness.state.value?.status, KyoshinMonitorStatus.delayed);
      expect(harness.state.value?.lastImageFetchTargetTime, first);

      harness.repository.notPublished.clear();
      await harness.rebuildTimerAndEmit(second);

      expect(harness.repository.fetched, [first, second, second]);
      expect(harness.state.value?.lastImageFetchTargetTime, second);
    });
  });
}

final class _Harness._({
  required final ProviderContainer container,
  required final _Repository repository,
  required final List<StreamController<DateTime>> timers,
}) {
  AsyncValue<KyoshinMonitorState> get state =>
      container.read(kyoshinMonitorProvider);

  Future<void> emit(DateTime target) async {
    timers.last.add(target);
    await settle();
  }

  /// 公開遅延の見積もりが変わったときと同じく、依存の変化でタイマーを作り直す。
  Future<void> rebuildTimerAndEmit(DateTime target) async {
    final timerCount = timers.length;
    container.read(_delayRevisionProvider.notifier).bump();
    await settle();
    expect(timers, hasLength(timerCount + 1));
    await emit(target);
  }

  /// 画像の解析は別 Isolate で行うため、取得中の状態が終わるまで待つ。
  Future<void> settle() async {
    for (var i = 0; i < 200; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 5));
      if (!state.isLoading && i > 2) {
        return;
      }
    }
    fail('KyoshinMonitorNotifier did not settle');
  }

  static Future<_Harness> create() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = _Repository(
      image: img.encodeGif(img.Image(width: 352, height: 400)),
    );
    final timers = <StreamController<DateTime>>[];
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(preferences),
        ),
        ntpProvider.overrideWith(_Ntp.new),
        kyoshinMonitorRepositoryProvider.overrideWithValue(repository),
        kyoshinMonitorDelayCalibrationProvider.overrideWith(_Calibration.new),
        kyoshinMonitorAnalyzerIsolateProvider.overrideWith((ref) async {
          final analyzer = await KyoshinMonitorAnalyzerIsolate.spawn(
            points: const [],
          );
          ref.onDispose(analyzer.dispose);
          return analyzer;
        }),
        shakeDetectionCurrentSettingsProvider.overrideWithValue(
          const ShakeDetectionSettingsModel(),
        ),
        kyoshinMonitorTimerStreamProvider.overrideWith((ref) {
          ref.watch(_delayRevisionProvider);
          final controller = StreamController<DateTime>();
          timers.add(controller);
          ref.onDispose(controller.close);
          return controller.stream;
        }),
      ],
    );
    addTearDown(container.dispose);
    await container.read(kyoshinMonitorSettingsProvider.future);
    await container.read(kyoshinMonitorAnalyzerIsolateProvider.future);
    final subscription = container.listen(kyoshinMonitorProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(kyoshinMonitorProvider.future);
    final harness = _Harness._(
      container: container,
      repository: repository,
      timers: timers,
    );
    expect(
      container.read(kyoshinMonitorSettingsProvider).requireValue,
      isA<KyoshinMonitorSettingsModel>().having(
        (settings) => settings.useKmoni,
        'useKmoni',
        isTrue,
      ),
    );
    return harness;
  }
}

final _delayRevisionProvider = NotifierProvider<_DelayRevision, int>(
  _DelayRevision.new,
);

class _DelayRevision extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state += 1;
}

class _Ntp extends Ntp {
  @override
  Future<NtpState> build() async =>
      NtpState(offset: Duration.zero, updatedAt: DateTime.utc(2026, 11, 17));
}

class _Calibration extends KyoshinMonitorDelayCalibration {
  @override
  KyoshinMonitorDelayCalibrationStatus build() =>
      KyoshinMonitorDelayCalibrationStatus.idle;
}

final class _Repository({required final List<int> image})
    implements KyoshinMonitorRepository {
  final fetched = <DateTime>[];
  final notPublished = <DateTime>{};

  @override
  Future<List<int>> fetchRealtimeImage({
    required KyoshinMonitorSource source,
    required RealtimeDataType type,
    required RealtimeLayer layer,
    required DateTime dateTime,
  }) async {
    fetched.add(dateTime);
    if (notPublished.contains(dateTime)) {
      final options = RequestOptions(path: '/image');
      throw DioException(
        requestOptions: options,
        response: Response<void>(requestOptions: options, statusCode: 404),
      );
    }
    return image;
  }

  @override
  Future<Result<KyoshinMonitorTimeSample, Exception>> fetchLatestTime({
    required KyoshinMonitorSource source,
  }) => throw UnimplementedError();

  @override
  Future<Result<bool, Exception>> isRealtimeImagePublished({
    required KyoshinMonitorSource source,
    required RealtimeDataType type,
    required RealtimeLayer layer,
    required DateTime dateTime,
  }) => throw UnimplementedError();

  @override
  Future<MaintenanceMessage> fetchMaintenanceMessage() =>
      throw UnimplementedError();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
