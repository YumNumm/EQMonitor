import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:eqmonitor_lints_plugin/rules/avoid_stateful_widget.dart';
import 'package:eqmonitor_lints_plugin/rules/avoid_null_assertion_operator.dart';
import 'package:eqmonitor_lints_plugin/rules/avoid_top_level_functions.dart';
import 'package:eqmonitor_lints_plugin/rules/avoid_print_call.dart';
import 'package:eqmonitor_lints_plugin/rules/avoid_eqmonitor_api_in_ui.dart';
import 'package:eqmonitor_lints_plugin/rules/avoid_mixed_declaration_categories.dart';

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
