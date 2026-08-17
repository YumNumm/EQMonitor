import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef LatLngRange = ({
  double? latitudeGte,
  double? latitudeLte,
  double? longitudeGte,
  double? longitudeLte,
});

class LatLngFilterChip extends StatelessWidget {
  const new({
    this.latitudeGte,
    this.latitudeLte,
    this.longitudeGte,
    this.longitudeLte,
    this.onChanged,
    super.key,
  });

  final double? latitudeGte;
  final double? latitudeLte;
  final double? longitudeGte;
  final double? longitudeLte;
  final ValueChanged<LatLngRange?>? onChanged;

  bool get _isActive =>
      latitudeGte != null ||
      latitudeLte != null ||
      longitudeGte != null ||
      longitudeLte != null;

  static const _presets = <({String label, LatLngRange range})>[
    (
      label: '日本周辺',
      range: (
        latitudeGte: 20.0,
        latitudeLte: 50.0,
        longitudeGte: 122.0,
        longitudeLte: 154.0,
      ),
    ),
    (
      label: '日本本土',
      range: (
        latitudeGte: 30.0,
        latitudeLte: 46.0,
        longitudeGte: 128.0,
        longitudeLte: 146.0,
      ),
    ),
    (
      label: '南海トラフ周辺',
      range: (
        latitudeGte: 30.0,
        latitudeLte: 36.0,
        longitudeGte: 131.0,
        longitudeLte: 141.0,
      ),
    ),
    (
      label: '首都圏直下',
      range: (
        latitudeGte: 34.5,
        latitudeLte: 36.5,
        longitudeGte: 139.0,
        longitudeLte: 141.0,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<LatLngRange?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          isScrollControlled: true,
          builder: (context) => _LatLngFilterModal(
            latitudeGte: latitudeGte,
            latitudeLte: latitudeLte,
            longitudeGte: longitudeGte,
            longitudeLte: longitudeLte,
          ),
        );
        if (result != null) {
          final hasValue =
              result.latitudeGte != null ||
              result.latitudeLte != null ||
              result.longitudeGte != null ||
              result.longitudeLte != null;
          onChanged?.call(hasValue ? result : null);
        }
      },
      label: _isActive
          ? Text(
              _buildLabel(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : const Text('緯度経度'),
      onDeleted: _isActive ? () => onChanged?.call(null) : null,
      selected: _isActive,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }

  String _buildLabel() {
    for (final preset in _presets) {
      if (preset.range.latitudeGte == latitudeGte &&
          preset.range.latitudeLte == latitudeLte &&
          preset.range.longitudeGte == longitudeGte &&
          preset.range.longitudeLte == longitudeLte) {
        return preset.label;
      }
    }
    return '緯度経度';
  }
}

class _LatLngFilterModal extends HookWidget {
  const new({
    this.latitudeGte,
    this.latitudeLte,
    this.longitudeGte,
    this.longitudeLte,
  });

  final double? latitudeGte;
  final double? latitudeLte;
  final double? longitudeGte;
  final double? longitudeLte;

  @override
  Widget build(BuildContext context) {
    final latGte = useState<double?>(latitudeGte);
    final latLte = useState<double?>(latitudeLte);
    final lngGte = useState<double?>(longitudeGte);
    final lngLte = useState<double?>(longitudeLte);

    final lgv = latGte.value;
    final llv = latLte.value;
    final ngv = lngGte.value;
    final nlv = lngLte.value;

    var latGteErr = (lgv != null && (lgv < -90 || lgv > 90))
        ? '-90〜90の範囲'
        : null;
    var latLteErr = (llv != null && (llv < -90 || llv > 90))
        ? '-90〜90の範囲'
        : null;
    var lngGteErr = (ngv != null && (ngv < -180 || ngv > 180))
        ? '-180〜180の範囲'
        : null;
    var lngLteErr = (nlv != null && (nlv < -180 || nlv > 180))
        ? '-180〜180の範囲'
        : null;
    if (lgv != null &&
        llv != null &&
        latGteErr == null &&
        latLteErr == null &&
        lgv > llv) {
      latGteErr = '南≦北の順で入力';
      latLteErr = '南≦北の順で入力';
    }
    if (ngv != null &&
        nlv != null &&
        lngGteErr == null &&
        lngLteErr == null &&
        ngv > nlv) {
      lngGteErr = '西≦東の順で入力';
      lngLteErr = '西≦東の順で入力';
    }
    final isValid =
        latGteErr == null &&
        latLteErr == null &&
        lngGteErr == null &&
        lngLteErr == null;

    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: designSystem.colorTheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    void applyPreset(LatLngRange range) {
      latGte.value = range.latitudeGte;
      latLte.value = range.latitudeLte;
      lngGte.value = range.longitudeGte;
      lngLte.value = range.longitudeLte;
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: sheetBar),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  '緯度経度範囲',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (final preset in LatLngFilterChip._presets)
                      ActionChip(
                        label: Text(preset.label),
                        onPressed: () => applyPreset(preset.range),
                      ),
                    ActionChip(
                      label: const Text('クリア'),
                      onPressed: () {
                        latGte.value = null;
                        latLte.value = null;
                        lngGte.value = null;
                        lngLte.value = null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _CoordField(
                        label: '緯度(南)',
                        value: latGte.value,
                        errorText: latGteErr,
                        onChanged: (v) => latGte.value = v,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('~'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _CoordField(
                        label: '緯度(北)',
                        value: latLte.value,
                        errorText: latLteErr,
                        onChanged: (v) => latLte.value = v,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _CoordField(
                        label: '経度(西)',
                        value: lngGte.value,
                        errorText: lngGteErr,
                        onChanged: (v) => lngGte.value = v,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('~'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _CoordField(
                        label: '経度(東)',
                        value: lngLte.value,
                        errorText: lngLteErr,
                        onChanged: (v) => lngLte.value = v,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('キャンセル'),
                  ),
                  TextButton(
                    onPressed: isValid
                        ? () => Navigator.of(context).pop((
                            latitudeGte: latGte.value,
                            latitudeLte: latLte.value,
                            longitudeGte: lngGte.value,
                            longitudeLte: lngLte.value,
                          ))
                        : null,
                    child: const Text('完了'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoordField extends HookWidget {
  const new({
    required this.label,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final String label;
  final double? value;
  final ValueChanged<double?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(
      text: value == null ? '' : value.toString(),
    );

    useEffect(() {
      final current = double.tryParse(controller.text);
      if (value != current) {
        controller.text = value == null ? '' : value.toString();
      }
      return null;
    }, [value]);

    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
        suffixText: '°',
        errorText: errorText,
      ),
      onChanged: (text) {
        final parsed = double.tryParse(text);
        onChanged(parsed);
      },
    );
  }
}
