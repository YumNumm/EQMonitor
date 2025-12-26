import 'package:eqapi_types/eqapi_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelegramListTile extends StatelessWidget {
  const TelegramListTile({
    required this.telegram,
    this.onTap,
    super.key,
  });

  final Telegram telegram;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

    final isEew = _isEewTelegram(telegram.type);
    final serialNo = telegram.serialNo;

    return ListTile(
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
            value: telegram.type.value,
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
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
      trailing: _StatusBadge(status: telegram.status),
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
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

bool _isEewTelegram(TelegramType type) {
  return switch (type) {
    TelegramType.vxse43 ||
    TelegramType.vxse44 ||
    TelegramType.vxse45 =>
      true,
    _ => false,
  };
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final TelegramStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (label, color) = switch (status) {
      TelegramStatus.normal => ('通常', colorScheme.primary),
      TelegramStatus.training => ('訓練', colorScheme.tertiary),
      TelegramStatus.test => ('試験', colorScheme.secondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
