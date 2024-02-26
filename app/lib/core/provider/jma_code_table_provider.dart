import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:jma_code_table_types/jma_code_table.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_code_table_provider.g.dart';

@Riverpod(keepAlive: true)
JmaCodeTable jmaCodeTable(JmaCodeTableRef ref) => throw UnimplementedError();

Future<JmaCodeTable> loadJmaCodeTable() async => JmaCodeTable.fromBuffer(
      (await rootBundle.load(Assets.jmaCodeTable)).buffer.asUint8List(),
    );
