import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map_utility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_map_utility.g.dart';

@Riverpod(keepAlive: true)
JmaMapUtility jmaMapUtility(Ref ref) => JmaMapUtility();
