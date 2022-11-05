import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../provider/utils/fcm_token_provider.dart';

class FcmTokenWidget extends ConsumerWidget {
  const FcmTokenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fcmToken = ref.watch(fcmTokenFutureProvider);
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: const Text(
        'FCMトークン',
        style: titleTextStyle,
      ),
      subtitle: fcmToken.when<Widget>(
        loading: () => const Text('Loading...'),
        error: (error, stackTrace) => Text(error.toString()),
        data: (data) => Text(
          data.toString(),
          style: descriptionTextStyle,
        ),
      ),
      onTap: () async {
        await Clipboard.setData(
          ClipboardData(
            text: () {
              return fcmToken.asData?.value.toString();
            }(),
          ),
        );
        await Fluttertoast.showToast(msg: 'クリップボードにコピーしました');
      },
    );
  }
}
