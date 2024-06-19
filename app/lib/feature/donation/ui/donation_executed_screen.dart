import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/feature/donation/data/donation_notifier.dart';
import 'package:eqmonitor/feature/donation/ui/donation_choice_modal.dart';
import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DonationExecutedScreen extends HookConsumerWidget {
  const DonationExecutedScreen({
    required this.result,
    super.key,
  });
  final (StoreProduct, CustomerInfo) result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final product = result.$1;
    final customer = result.$2;
    final productEnum = Products.values.firstWhere(
      (e) => e.id == product.identifier,
    );
    final controller = useMemoized(
      ScreenshotController.new,
    );
    final body = Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Screenshot(
                controller: controller,
                child: Material(
                  child: ColoredBox(
                    color: const Color.fromARGB(255, 1, 32, 78),
                    child: _Detail(
                      productEnum: productEnum,
                      product: product,
                      textTheme: textTheme,
                      customer: customer,
                      isScreenshot: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SetupBackgroundImageWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: _ScrollView(
                      productEnum: productEnum,
                      product: product,
                      textTheme: textTheme,
                      customer: customer,
                      controller: controller,
                    ),
                  ),
                  ActionButton.text(
                    context: context,
                    text: 'アプリストアでレビューを書く',
                    onPressed: () => InAppReview.instance.openStoreListing(
                      appStoreId: '6447546703',
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton.text(
                          context: context,
                          text: '画像を保存する',
                          onPressed: () async {
                            final image = await controller.capture();
                            await Share.shareXFiles([
                              XFile.fromData(
                                image!,
                                mimeType: 'image/png',
                              ),
                            ]);
                          },
                          accentColor: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    return body;
  }
}

class _ScrollView extends StatelessWidget {
  const _ScrollView({
    required this.productEnum,
    required this.product,
    required this.textTheme,
    required this.customer,
    required this.controller,
  });

  final Products productEnum;
  final StoreProduct product;
  final ScreenshotController controller;
  final TextTheme textTheme;
  final CustomerInfo customer;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _Detail(
                productEnum: productEnum,
                product: product,
                textTheme: textTheme,
                customer: customer,
              ),
              const SizedBox(height: 8),
              BorderedContainer(
                accentColor: Colors.blueGrey.shade900,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                          children: [
                            const TextSpan(
                              text: 'ご支援頂きありがとうございます!\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: 'あなたのご支援のお陰で、より良いアプリを作ることができます。\n\n',
                            ),
                            const TextSpan(
                              text: '皆様の声が励みになります!\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: 'Twitter(X)やメールで私へ連絡いただけると嬉しいです!'
                                  'もしくは、アプリストアへのレビューもお待ちしております\n\n'
                                  'ご意見やご要望があれば、お気軽にお知らせください!\n\n'
                                  '- Ryotaro Onoue (Twitter: ',
                            ),
                            for (final account in ['YumNumm', 'EQMonitorApp'])
                              TextSpan(
                                text: '@$account',
                                style: TextStyle(
                                  color: Colors.blue.shade400,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrlString(
                                        'https://twitter.com/$account',
                                      ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({
    required this.productEnum,
    required this.product,
    required this.textTheme,
    required this.customer,
    this.isScreenshot = false,
  });

  final Products productEnum;
  final StoreProduct product;
  final TextTheme textTheme;
  final CustomerInfo customer;
  final bool isScreenshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              isScreenshot ? 'EQMonitorを支援しました✌' : 'ありがとうございます! 💖',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        BorderedContainer(
          accentColor: Colors.blueGrey.shade900,
          elevation: 16,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Row(),
              Text(
                '${productEnum.emoji} ${productEnum.productName}',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                product.priceString,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                "Tipped at ${DateFormat('yyyy/MM/dd HH:mm').format(
                  DateTime.parse(
                    customer.requestDate,
                  ).toLocal(),
                )}",
                style: textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
