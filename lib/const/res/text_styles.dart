import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle eewTitleStyle({
    bool? isTextBlack,
  }) =>
      TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: (isTextBlack != null)
            ? isTextBlack
                ? Colors.black
                : Colors.white
            : null,
      );
}
