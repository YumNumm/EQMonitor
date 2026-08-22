import 'package:eqmonitor/feature/eew/data/logic/eew_forecast_region_warning_filter_updater.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/util/map/fake_style_controller.dart';

void main() {
  test('報切替ごとに警報あり・なしを含むfillとlineのfilterを更新する', () async {
    const updater = EewForecastRegionWarningFilterUpdater();
    final styleController = RecordingStyleController();

    await updater.update(
      styleController: styleController,
      warningCodes: const ['9011'],
    );
    await updater.update(
      styleController: styleController,
      warningCodes: const [],
    );
    await updater.update(
      styleController: styleController,
      warningCodes: const ['9020', '9030'],
    );

    expect(styleController.filterUpdates, const [
      'eew-details-warning-fill:9011',
      'eew-details-warning-line:9011',
      'eew-details-warning-fill:',
      'eew-details-warning-line:',
      'eew-details-warning-fill:9020,9030',
      'eew-details-warning-line:9020,9030',
    ]);
  });
}

class RecordingStyleController extends FakeStyleController {
  final filterUpdates = <String>[];

  @override
  Future<void> updateFilter({
    required String id,
    required List<Object>? filter,
  }) async {
    final codes = switch (filter) {
      ['in', ['get', 'code'], ['literal', final List<String> values]] => values,
      _ => const <String>[],
    };
    filterUpdates.add('$id:${codes.join(',')}');
  }
}
