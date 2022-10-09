import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {super.key});
  final Exception error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('エラーが発生しました')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(error.toString()),
              ElevatedButton.icon(
                onPressed: () => context.push('/'),
                label: const Text('戻る'),
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      );
}