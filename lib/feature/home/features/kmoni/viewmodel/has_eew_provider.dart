import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_eew_provider.g.dart';

@riverpod
bool hasEew(HasEewRef ref) => ref.watch(eewNormalTelegramProvider).isNotEmpty;
