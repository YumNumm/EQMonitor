// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eqmonitor/feature/debug/earthquake_parameter/ui/earthquake_parameter_list_screen.dart'
    as _i6;
import 'package:eqmonitor/widgetbook/core/component/chip/date_range_filter_chip.dart'
    as _i2;
import 'package:eqmonitor/widgetbook/core/component/chip/depth_filter_chip.dart'
    as _i3;
import 'package:eqmonitor/widgetbook/core/component/chip/intensity_filter_chip.dart'
    as _i4;
import 'package:eqmonitor/widgetbook/core/component/chip/magnitude_filter_chip.dart'
    as _i5;
import 'package:eqmonitor/widgetbook/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart'
    as _i8;
import 'package:eqmonitor/widgetbook/feature/earthquake_history/ui/earthquake_history_screen.dart'
    as _i7;
import 'package:eqmonitor/widgetbook/feature/earthquake_history_details/components/earthquake_hypo_info_widget.dart'
    as _i9;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'core',
    children: [
      _i1.WidgetbookFolder(
        name: 'component',
        children: [
          _i1.WidgetbookFolder(
            name: 'chip',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'DateRangeFilterChip',
                useCase: _i1.WidgetbookUseCase(
                  name: 'DateRangeFilterChip',
                  builder: _i2.dateRangeFilterChip,
                ),
              ),
              _i1.WidgetbookLeafComponent(
                name: 'DepthFilterChip',
                useCase: _i1.WidgetbookUseCase(
                  name: 'DepthFilterChip',
                  builder: _i3.depthFilterChip,
                ),
              ),
              _i1.WidgetbookLeafComponent(
                name: 'IntensityFilterChip',
                useCase: _i1.WidgetbookUseCase(
                  name: 'IntensityFilterChip',
                  builder: _i4.intensityFilterChip,
                ),
              ),
              _i1.WidgetbookLeafComponent(
                name: 'MagnitudeFilterChip',
                useCase: _i1.WidgetbookUseCase(
                  name: 'MagnitudeFilterChip',
                  builder: _i5.intensityFilterChip,
                ),
              ),
            ],
          )
        ],
      )
    ],
  ),
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
                      builder: _i6.earthquakeParameterListScreen,
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
              _i1.WidgetbookLeafComponent(
                name: 'EarthquakeHistoryScreen',
                useCase: _i1.WidgetbookUseCase(
                  name: 'EarthquakeHistoryScreen',
                  builder: _i7.earthquakeHistoryScreen,
                ),
              ),
              _i1.WidgetbookFolder(
                name: 'components',
                children: [
                  _i1.WidgetbookLeafComponent(
                    name: 'EarthquakeHistoryListTile',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Earthquake History List Tile',
                      builder: _i8.earthquakeHistoryListTile,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'earthquake_history_details',
        children: [
          _i1.WidgetbookFolder(
            name: 'component',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'EarthquakeHypoInfoWidget',
                useCase: _i1.WidgetbookUseCase(
                  name: 'EarthquakeHypoInfoWidget',
                  builder: _i9.earthquakeHypoInfoWidget,
                ),
              )
            ],
          )
        ],
      ),
    ],
  ),
];
