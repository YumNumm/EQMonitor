import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pmtiles_renderer/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
