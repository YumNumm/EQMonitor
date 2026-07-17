import 'package:eqmonitor/feature/earthquake_history/ui/components/url_text_segment_splitter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const splitter = UrlTextSegmentSplitter();

  group('UrlTextSegmentSplitter', () {
    test('URLがない場合は全体をプレーンテキストとして返す', () {
      final segments = splitter.split(text: 'この地震による津波の心配はありません。');

      expect(segments, [
        isA<PlainUrlTextSegment>().having(
          (s) => s.text,
          'text',
          'この地震による津波の心配はありません。',
        ),
      ]);
    });

    test('URLのみの場合はリンクセグメントを返す', () {
      final segments = splitter.split(
        text: 'https://www.data.jma.go.jp/svd/eqev/data/index.html',
      );

      expect(segments, [
        isA<LinkUrlTextSegment>().having(
          (s) => s.url,
          'url',
          'https://www.data.jma.go.jp/svd/eqev/data/index.html',
        ),
      ]);
    });

    test('前後の文言とURLを分割する', () {
      final segments = splitter.split(
        text: '詳細は https://www.jma.go.jp/ を参照',
      );

      expect(segments, [
        isA<PlainUrlTextSegment>().having((s) => s.text, 'text', '詳細は '),
        isA<LinkUrlTextSegment>().having(
          (s) => s.url,
          'url',
          'https://www.jma.go.jp/',
        ),
        isA<PlainUrlTextSegment>().having((s) => s.text, 'text', ' を参照'),
      ]);
    });

    test('末尾の句読点はURLに含めない', () {
      final segments = splitter.split(
        text: '詳細はhttps://www.jma.go.jp/jma/press/。',
      );

      expect(segments, [
        isA<PlainUrlTextSegment>().having((s) => s.text, 'text', '詳細は'),
        isA<LinkUrlTextSegment>().having(
          (s) => s.url,
          'url',
          'https://www.jma.go.jp/jma/press/',
        ),
        isA<PlainUrlTextSegment>().having((s) => s.text, 'text', '。'),
      ]);
    });

    test('空文字は空リストを返す', () {
      expect(splitter.split(text: ''), isEmpty);
    });
  });
}
