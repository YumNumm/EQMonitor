import 'package:material_ui/material_ui.dart';

class const EarthquakeArchiveErrorView({
  required final String message,
  required final VoidCallback onRetry,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(message, textAlign: .center),
          const SizedBox(height: 16),
          FilledButton.tonal(onPressed: onRetry, child: const Text('再試行')),
        ],
      ),
    ),
  );
}
