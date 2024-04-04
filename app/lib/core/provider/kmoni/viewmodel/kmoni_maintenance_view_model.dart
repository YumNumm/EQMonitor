import 'package:eqmonitor/core/provider/kmoni/model/kmoni_maintenance_message_model.dart';
import 'package:eqmonitor/core/provider/kmoni/use_case/kmoni_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_maintenance_view_model.g.dart';

@riverpod
Future<KmoniMaintenanceMessageModel> kmoniMaintenanceViewModel(
  KmoniMaintenanceViewModelRef ref,
) async =>
    ref.read(kmoniUseCaseProvider).getMaintenanceMessage();
