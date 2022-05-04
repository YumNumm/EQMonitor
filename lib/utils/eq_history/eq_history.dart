import 'eq_history_content.dart';

class EqHistory {
  EqHistory({required this.contents});

  factory EqHistory.fromJson(Map<String, dynamic> j) {
    return EqHistory(
      contents: (j['content'] == null)
          ? <EqHistoryContent>[]
          : List<EqHistoryContent>.generate(
              (j['content'] as List<dynamic>).length,
              (index) => EqHistoryContent.fromJson(
                (j['content'] as List<dynamic>)[index] as Map<String, dynamic>,
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': contents,
      };

  final List<EqHistoryContent> contents;
}
