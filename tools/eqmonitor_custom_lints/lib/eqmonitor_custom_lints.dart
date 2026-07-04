import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'rules/avoid_direct_color_scheme.dart';

PluginBase createPlugin() => _EqmonitorCustomLintsPlugin();

class _EqmonitorCustomLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
        AvoidDirectColorScheme(),
      ];
}
