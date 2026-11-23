import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const HypocenterArchiveSelectorSheet({
  required final List<HypocenterArchive> archives,
  required final Set<HypocenterArchiveId> selected,
  required final ValueChanged<Set<HypocenterArchiveId>> onApply,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final draft = useState({...selected});
    final years =
        archives
            .where(
              (archive) =>
                  archive.id.partition == HypocenterArchivePartition.year,
            )
            .toList()
          ..sort((a, b) => b.id.jstLabel.compareTo(a.id.jstLabel));
    final days =
        archives
            .where(
              (archive) =>
                  archive.id.partition == HypocenterArchivePartition.day,
            )
            .toList()
          ..sort((a, b) => b.id.jstLabel.compareTo(a.id.jstLabel));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            Text('表示する震源データ', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  Text('年', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final archive in years)
                        FilterChip(
                          label: Text(archive.id.jstLabel),
                          selected: draft.value.contains(archive.id),
                          onSelected: (enabled) => HapticUtil.selection(() {
                            final next = {...draft.value};
                            enabled
                                ? next.add(archive.id)
                                : next.remove(archive.id);
                            draft.value = next;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('日', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final archive in days)
                        FilterChip(
                          label: Text(archive.id.jstLabel),
                          selected: draft.value.contains(archive.id),
                          onSelected: (enabled) => HapticUtil.selection(() {
                            final next = {...draft.value};
                            enabled
                                ? next.add(archive.id)
                                : next.remove(archive.id);
                            draft.value = next;
                          }),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            M3EFilledButton(
              onPressed: draft.value.isEmpty
                  ? null
                  : () => HapticUtil.light(() {
                      onApply(draft.value);
                      Navigator.of(context).pop();
                    }),
              child: const Text('適用'),
            ),
          ],
        ),
      ),
    );
  }
}
