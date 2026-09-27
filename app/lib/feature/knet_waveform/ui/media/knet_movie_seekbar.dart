import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class KnetMovieSeekbar extends StatelessWidget {
  const new({
    required this.position,
    required this.duration,
    required this.onChanged,
    super.key,
  });

  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onChanged;

  @override
  Widget build(BuildContext context) {
    final total = duration.inMilliseconds;
    final current = position.inMilliseconds.clamp(0, total);
    final next = (current + 10000).clamp(0, total);
    final previous = (current - 10000).clamp(0, total);
    final label = '${current ~/ 60000}分${current ~/ 1000 % 60}秒';
    final nextLabel = '${next ~/ 60000}分${next ~/ 1000 % 60}秒';
    final previousLabel = '${previous ~/ 60000}分${previous ~/ 1000 % 60}秒';

    return Semantics(
      label: '再生位置',
      slider: true,
      enabled: total > 0,
      value: label,
      increasedValue: current < total ? nextLabel : null,
      decreasedValue: current > 0 ? previousLabel : null,
      onIncrease: current < total
          ? () => onChanged(Duration(milliseconds: next))
          : null,
      onDecrease: current > 0
          ? () => onChanged(Duration(milliseconds: previous))
          : null,
      child: M3ESeekbar(
        value: total > 0 ? current / total : 0,
        enabled: total > 0,
        onChanged: (value) =>
            onChanged(Duration(milliseconds: (total * value).toInt())),
      ),
    );
  }
}
