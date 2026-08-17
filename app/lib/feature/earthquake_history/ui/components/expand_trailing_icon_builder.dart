import 'package:material_ui/material_ui.dart';

/// 展開可能なタイルの末尾に表示する開閉アイコンを組み立てる。
class ExpandTrailingIconBuilder {
  const ExpandTrailingIconBuilder();

  Widget? build({required bool hasChildren, required bool isExpanded}) {
    if (!hasChildren) {
      return null;
    }
    return AnimatedRotation(
      turns: isExpanded ? 0.5 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: const Icon(Icons.expand_more),
    );
  }
}
