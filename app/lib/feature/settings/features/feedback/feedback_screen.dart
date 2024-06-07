import 'package:eqmonitor/feature/settings/features/feedback/data/custom_feedback.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomFeedbackForm extends HookConsumerWidget {
  const CustomFeedbackForm({
    super.key,
    required this.onSubmit,
    required this.scrollController,
  });

  final OnSubmit onSubmit;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customFeedback = useState(const CustomFeedback());
    final feedbackText = useState('');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (scrollController != null) const FeedbackSheetDragHandle(),
                ListView(
                  controller: scrollController,
                  // Pad the top by 20 to match the corner radius if drag enabled.
                  padding: EdgeInsets.fromLTRB(
                    16,
                    scrollController != null ? 20 : 16,
                    16,
                    0,
                  ),
                  children: [
                    const MarkdownBody(
                      data: '''
### フィードバックを送信する

アプリの改善にご協力いただき、ありがとうございます。フィードバックを送信することで、アプリの品質向上に貢献することができます。
''',
                      softLineBreak: true,
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text('フィードバックカテゴリ'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownMenu<FeedbackType>(
                        dropdownMenuEntries: FeedbackType.values
                            .map(
                              (type) => DropdownMenuEntry(
                                value: type,
                                label: type.label,
                              ),
                            )
                            .toList(),
                        onSelected: (type) => customFeedback.value =
                            customFeedback.value.copyWith(
                          feedbackType: type,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('フィードバック内容'),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'フィードバック内容を入力してください',
                      ),
                      // 改行OK
                      maxLines: null,
                      onChanged: (value) => feedbackText.value = value,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      value: customFeedback.value.isReplyRequested ?? false,
                      onChanged: (value) =>
                          customFeedback.value = customFeedback.value.copyWith(
                        isReplyRequested: value,
                      ),
                      title: const Text('返信を希望する'),
                      visualDensity: VisualDensity.compact,
                    ),
                    CheckboxListTile(
                      value: customFeedback.value.isScreenshotAttached,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        customFeedback.value = customFeedback.value.copyWith(
                          isScreenshotAttached: value,
                        );
                      },
                      title: const Text('スクリーンショットを添付する'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FilledButton.tonalIcon(
            // disable this button until the user has specified a feedback type
            onPressed: customFeedback.value.feedbackType != null
                ? () => onSubmit(
                      feedbackText.value,
                      extras: customFeedback.value.toJson(),
                    )
                : null,
            label: const Text('メール送信画面を開く'),
            icon: Icon(
              (customFeedback.value.isScreenshotAttached)
                  ? Icons.attach_email_rounded
                  : Icons.email,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: MediaQuery.paddingOf(context).bottom,
          ),
        ],
      ),
    );
  }
}
