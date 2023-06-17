import 'package:freezed_annotation/freezed_annotation.dart';

part 'travel_time_table.freezed.dart';

@freezed
class TravelTimeTable with _$TravelTimeTable {
  const factory TravelTimeTable({
    required double p,
    required double s,
    required int depth,
    required int distance,
  }) = _TravelTimeTable;

  factory TravelTimeTable.fromList(List<dynamic> list) {
    return TravelTimeTable(
      p: double.parse(list[0].toString()),
      s: double.parse(list[1].toString()),
      depth: int.parse(list[2].toString()),
      distance: int.parse(list[3].toString()),
    );
  }
}
