import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_map_filter.g.dart';

@riverpod
NotificationRegionMapFilter notificationRegionMapFilter(Ref ref) =>
    const NotificationRegionMapFilter();

final class NotificationRegionMapFilter {
  const new();

  List<Object> buildRegion(String? regionCode) => regionCode == null
      ? buildMatchNothing('code')
      : <Object>[
          '==',
          <Object>['get', 'code'],
          regionCode,
        ];

  List<Object> buildRegionCities(List<String> cityCodes) => cityCodes.isEmpty
      ? buildMatchNothing('regioncode')
      : <Object>[
          'in',
          <Object>['get', 'regioncode'],
          <Object>['literal', cityCodes],
        ];

  List<Object> buildSelectedCity(String? cityCode) => cityCode == null
      ? buildMatchNothing('regioncode')
      : <Object>[
          '==',
          <Object>['get', 'regioncode'],
          cityCode,
        ];

  List<Object> buildMatchNothing(String property) => <Object>[
    '==',
    <Object>['get', property],
    '__eqmonitor_no_match__',
  ];
}
