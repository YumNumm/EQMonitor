import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayDirectoryField({
  required final TextEditingController controller,
  required final List<String> directories,
  required final String helperText,
  final String labelText = 'フォルダ',
  final bool autofocus = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        TextField(
          controller: controller,
          autofocus: autofocus,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: '2026/11',
            helperText: helperText,
            helperMaxLines: 2,
          ),
        ),
        if (directories.isNotEmpty) ...[
          SizedBox(height: spacing.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 120),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: spacing.xs,
                children: [
                  for (final directory in directories)
                    ActionChip(
                      avatar: const Icon(Icons.folder_outlined, size: 18),
                      label: Text(directory),
                      onPressed: () => controller.text = directory,
                    ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
