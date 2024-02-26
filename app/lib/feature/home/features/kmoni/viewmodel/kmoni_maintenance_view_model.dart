import 'package:eqmonitor/feature/home/features/kmoni/model/kmoni_maintenance_message_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/use_case/kmoni_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_maintenance_view_model.g.dart';

@riverpod
Future<KmoniMaintenanceMessageModel> kmoniMaintenanceViewModel(
  KmoniMaintenanceViewModelRef ref,
) async =>
    ref.read(kmoniUseCaseProvider).getMaintenanceMessage();
