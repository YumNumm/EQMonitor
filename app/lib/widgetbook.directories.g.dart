// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eqmonitor/feature/debug/earthquake_parameter/ui/earthquake_parameter_list_screen.dart'
    as _i2;
import 'package:eqmonitor/widgetbook/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart'
    as _i3;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'feature',
    children: [
      _i1.WidgetbookFolder(
        name: 'debug',
        children: [
          _i1.WidgetbookFolder(
            name: 'earthquake_parameter',
            children: [
              _i1.WidgetbookFolder(
                name: 'ui',
                children: [
                  _i1.WidgetbookLeafComponent(
                    name: 'EarthquakeParameterListScreen',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'EarthquakeParameterListScreen',
                      builder: _i2.earthquakeParameterListScreen,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'earthquake_history',
        children: [
          _i1.WidgetbookFolder(
            name: 'ui',
            children: [
              _i1.WidgetbookFolder(
                name: 'components',
                children: [
                  _i1.WidgetbookLeafComponent(
                    name: 'EarthquakeHistoryListTile',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Earthquake History List Tile',
                      builder: _i3.earthquakeHistoryListTile,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ],
  )
];
