import 'package:eqapi_types/eqapi_types.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class InformationHistoryDetailsPage extends HookConsumerWidget {
  const InformationHistoryDetailsPage({
    required this.data,
    super.key,
  });
  final InformationV3 data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final onSecondaryContainer = theme.colorScheme.onSecondaryContainer;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Card(
              color: theme.colorScheme.secondaryContainer,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: onSecondaryContainer,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('発表時刻: yyyy/MM/dd HH:mm頃')
                              .format(data.createdAt.toLocal()),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: onSecondaryContainer,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '発表機関: ${data.author.name}',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (data.body.contains('配信試験'))
            SliverToBoxAdapter(
              child: Card(
                color: theme.colorScheme.errorContainer,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: theme.colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '本アプリでは、気象庁による試験電文の通知配信を行っていません。',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                top: false,
                child: MarkdownBody(
                  data: data.body
                      .split('\n本件問い合わせ先\n')
                      .first
                      .split('\n本件に関する問い合わせ先\n')
                      .first
                      .toHalfWidth
                      .replaceAll('* ', '*')
                      .replaceAll(' *', '*')
                      .replaceAll('○', '- ')
                      .replaceAll('・', '  - '),
                  softLineBreak: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
