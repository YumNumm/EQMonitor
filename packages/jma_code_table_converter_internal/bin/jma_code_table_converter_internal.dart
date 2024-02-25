import "dart:io";

import "package:jma_code_table_converter_internal/jma_code_table_converter_internal.dart";
import "package:jma_code_table_types/jma_code_table.pb.dart";

Future<void> main(List<String> arguments) async {
  print("Converting JMA code table...");
  final converter = JmaCodeTableConverter();
  final table = JmaCodeTable(
    areaEpicenter: await converter.convert41(),
    areaEpicenterAbbreviation: await converter.convert42(),
    areaEpicenterDetail: await converter.convert43(),
  );

  // mkdir output
  final outputDir = Directory("output");
  if (!outputDir.existsSync()) {
    outputDir.createSync();
  }
  // delete old files
  for (final file in outputDir.listSync()) {
    file.deleteSync();
  }
  // json
  final jsonFile = File("output/jma_code_table.json");
  await jsonFile.writeAsString(table.toBuilder().writeToJson());

  // binary
  final binaryPath = "output/jma_code_table.pb";
  final binaryFile = File(binaryPath);
  await binaryFile.writeAsBytes(table.writeToBuffer());
  print("Done.");
  print("Output: ${binaryPath}");
}
