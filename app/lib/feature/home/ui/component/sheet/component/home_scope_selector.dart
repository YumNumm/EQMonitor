import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:flutter/material.dart';

String scopeShortLabel(HomeEarthquakeHistoryScope scope) => switch (scope) {
  .nationwide => '全国',
  .currentLocation => '現在地',
  .designatedRegion => '指定地域',
};

class HomeScopeSelector extends StatelessWidget {
  const HomeScopeSelector({
    required this.scope,
    required this.onScopeChanged,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownMenuFormField(
        initialSelection: scope,
        dropdownMenuEntries: [
          for (final s in HomeEarthquakeHistoryScope.values)
            DropdownMenuEntry(value: s, label: scopeShortLabel(s)),
        ],
        onSelected: (value) {
          if (value != null) {
            onScopeChanged(value);
          }
        },
        menuStyle: MenuStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        decorationBuilder: (context, controller) => InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
