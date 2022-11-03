import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FcmTokenWidget extends ConsumerWidget {
  const FcmTokenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    return const ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
