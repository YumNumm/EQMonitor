import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelegramListTile extends StatelessWidget {
  const TelegramListTile({
    required this.telegram,
    this.onTap,
    super.key,
  });

  final TelegramItem telegram;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

    final isEew = switch (telegram.type) {
      TelegramType.vxse43 || TelegramType.vxse44 || TelegramType.vxse45 => true,
      _ => false,
    };
    final serialNo = telegram.serialNo;

    return ListTile(
      dense: true,
      visualDensity: .compact,
      onTap: onTap,
      title: Text(
        telegram.title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          _InfoRow(
            label: '電文種別',
            value: telegram.type.name.toUpperCase(),
          ),
          if (isEew && serialNo != null)
            _InfoRow(
              label: '報数',
              value: '第$serialNo報',
            ),
          _InfoRow(
            label: '発表時刻',
            value: dateFormat.format(telegram.pressAt.toLocal()),
          ),
          _InfoRow(
            label: '発表元',
            value: telegram.publishingOffice.join(', '),
          ),
          if (telegram.headline != null) ...[
            const SizedBox(height: 4),
            Text(
              telegram.headline!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onTap != null) ...[
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ],
      ),
      isThreeLine: true,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
