import 'package:eqmonitor/feature/earthquake_history/ui/components/url_text_segment_splitter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// URL 部分をタップ可能なリンクとして表示するテキスト
class LinkifiedText extends StatelessWidget {
  const LinkifiedText({
    required this.text,
    this.style,
    this.linkStyle,
    this.textAlign,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLinkStyle =
        linkStyle ??
        style?.copyWith(
          color: theme.colorScheme.primary,
          decoration: TextDecoration.underline,
          decorationColor: theme.colorScheme.primary,
        );
    final segments = const UrlTextSegmentSplitter().split(text: text);

    return Text.rich(
      TextSpan(
        children: [
          for (final segment in segments)
            switch (segment) {
              PlainUrlTextSegment(:final text) => TextSpan(
                text: text,
                style: style,
              ),
              LinkUrlTextSegment(:final url) => WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: GestureDetector(
                  onTap: () async {
                    final uri = Uri.tryParse(url);
                    if (uri == null) {
                      return;
                    }
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(url, style: effectiveLinkStyle),
                ),
              ),
            },
        ],
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
