import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_directory_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

typedef ReplayFileLocation = ({String name, String directory});

class const ReplayFileLocationDialog({
  required final SavedReplayFile file,
  required final List<String> directories,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController(text: file.name);
    final directory = useTextEditingController(text: file.directory);
    final nameValue = useValueListenable(name);
    return AlertDialog(
      title: const Text('名前とフォルダを変更'),
      content: Column(
        mainAxisSize: .min,
        children: [
          TextField(
            controller: name,
            autofocus: true,
            decoration: const InputDecoration(labelText: '名前'),
          ),
          SizedBox(height: context.designSystem.spacing.md),
          ReplayDirectoryField(
            controller: directory,
            directories: directories,
            helperText: '「/」で区切ります。無いフォルダは作成します。空欄にすると最上位に置きます',
          ),
        ],
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        M3EFilledButton(
          onPressed: nameValue.text.trim().isEmpty
              ? null
              : () => Navigator.of(
                  context,
                ).pop((name: name.text, directory: directory.text)),
          child: const Text('保存'),
        ),
      ],
    );
  }
}
