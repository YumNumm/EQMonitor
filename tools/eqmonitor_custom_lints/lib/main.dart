import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';

import 'rules/avoid_direct_color_scheme.dart';

final plugin = _EqmonitorCustomLintsPlugin();

class _EqmonitorCustomLintsPlugin extends Plugin {
  @override
  String get name => 'eqmonitor_custom_lints';

  @override
  Future<void> register(PluginRegistry registry) async {
    <AnalysisRule>[
      AvoidDirectColorScheme(),
    ].forEach(registry.registerLintRule);
  }
}
