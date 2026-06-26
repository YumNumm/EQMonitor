import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';

final plugin = _EqmonitorLintsPlugin();

class _EqmonitorLintsPlugin extends Plugin {
  @override
  String get name => 'eqmonitor_lints_plugin';

  @override
  Future<void> register(PluginRegistry registry) async {
    <AnalysisRule>[
      AvoidStatefulWidget(),
      AvoidNullAssertionOperator(),
      AvoidTopLevelFunctions(),
      AvoidPrintCall(),
      AvoidEqmonitorApiInUi(),
      AvoidMixedDeclarationCategories(),
    ].forEach(registry.registerLintRule);
  }
}
