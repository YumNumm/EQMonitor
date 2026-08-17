import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeHistoryListConfigView extends StatelessWidget {
  const new({
    required this.config,
    required this.onChanged,
    super.key,
  });

  final EarthquakeHistoryListConfig config;
  final Future<void> Function(EarthquakeHistoryListConfig) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('最大震度ごとの背景塗りつぶし'),
          trailing: AppSwitch(
            value: config.isFillBackground,
            onChanged: (value) async =>
                onChanged(config.copyWith(isFillBackground: value)),
          ),
          onTap: () async => onChanged(
            config.copyWith(isFillBackground: !config.isFillBackground),
          ),
        ),
        const ListTile(title: Text('日付見出し')),
        RadioGroup<DateHeaderDisplayMode>(
          groupValue: config.dateHeaderDisplayMode,
          onChanged: (value) async {
            if (value == null) {
              return;
            }
            await onChanged(config.copyWith(dateHeaderDisplayMode: value));
          },
          child: const Column(
            children: [
              RadioListTile<DateHeaderDisplayMode>.adaptive(
                title: Text('常に表示'),
                value: DateHeaderDisplayMode.always,
              ),
              RadioListTile<DateHeaderDisplayMode>.adaptive(
                title: Text('発生時刻順のときのみ'),
                value: DateHeaderDisplayMode.onlyWhenDateSort,
              ),
              RadioListTile<DateHeaderDisplayMode>.adaptive(
                title: Text('表示しない'),
                value: DateHeaderDisplayMode.never,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
