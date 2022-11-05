import 'package:flutter/material.dart';

class LicenseWidget extends StatelessWidget {
  const LicenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: const Text(
        'ライセンス情報',
        style: titleTextStyle,
      ),
      subtitle: Text('MIT License\n${DateTime.now().year} YumNumm'),
      onTap: () => showLicensePage(
        context: context,
        applicationName: 'EQMonitor',
        applicationIcon: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/icon.png',
            height: 120,
            width: 120,
          ),
        ),
        applicationLegalese: 'MIT License\n${DateTime.now().year} YumNumm',
        useRootNavigator: true,
      ),
    );
  }
}
