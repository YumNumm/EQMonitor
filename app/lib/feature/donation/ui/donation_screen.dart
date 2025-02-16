import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/donation/data/donation_notifier.dart';
import 'package:eqmonitor/feature/donation/ui/donation_choice_modal.dart';
import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SetupBackgroundImageWidget(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: const _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    const messageTextSpan = TextSpan(
      style: TextStyle(fontSize: 16, color: Colors.white),
      children: [
        TextSpan(
          text: 'このアプリケーションは、広告・有料プランなどの収益化を行っていません。\n',
        ),
        TextSpan(
          text:
              '開発者は、このアプリケーションを開発・運用するために、'
              '各種地震情報の入手に関わる費用や情報を配信するためのサーバ費などの費用を支払っています。\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text:
              'もし、このアプリケーションを気に入っていただけた場合、'
              '開発者へのチップをご検討いただけると幸いです。\n\n'
              'チップは、開発者のモチベーション向上に繋がり、'
              'アプリケーションの品質向上に繋がります。',
        ),
      ],
    );
    final theme = Theme.of(context);
    final body = CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            // アプリアイコン
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(800),
                  ),
                  child: Image(
                    image: AssetImage(
                      'assets/images/icon.png',
                    ),
                  ),
                ),
              ),
            ),
            // 画面上部のタイトル
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '🎁 EQMonitorへチップを贈る',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(
              child: CustomScrollView(
                physics: RangeMaintainingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: SafeArea(
                      child: Column(
                        children: [
                          // 画面中部のメッセージ
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text.rich(
                              messageTextSpan,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const _ShowDonationButton(),
          ],
        ),
      ),
    );

    return body;
  }
}

class _ShowDonationButton extends HookConsumerWidget {
  const _ShowDonationButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ActionButton.text(
              context: context,
              accentColor: Colors.grey[800],
              text: 'キャンセル',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: switch (state) {
              AsyncError() => ActionButton.text(
                context: context,
                text: '読み込みに失敗しました',
                onPressed: () {},
              ),
              AsyncData(:final value) => () {
                final cheapest = value.reduce(
                  (a, b) => a.price < b.price ? a : b,
                );
                return Column(
                  children: [
                    ActionButton.text(
                      context: context,
                      text: 'チップを贈る',
                      onPressed: () async {
                        final item =
                            await DonationChoiceModal.show(
                              context,
                              value,
                            );
                        if (item != null &&
                            context.mounted) {
                          unawaited(
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder:
                                  (context) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive(),
                                  ),
                            ),
                          );
                          try {
                            log(
                              '購入処理を開始します: ${item.identifier}',
                            );
                            final purchaseResult = await ref
                                .read(
                                  purchaseProvider(
                                    item,
                                  ).future,
                                );
                            log(
                              '購入処理が完了しました: ${item.identifier}',
                            );

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              // 完了画面へ遷移
                              await DonationExecutedRoute(
                                $extra: (
                                  item,
                                  purchaseResult,
                                ),
                              ).push<void>(context);
                            }
                          } on PlatformException catch (e) {
                            final code =
                                PurchasesErrorHelper.getErrorCode(
                                  e,
                                );
                            final message = switch (code) {
                              PurchasesErrorCode
                                  .purchaseCancelledError =>
                                null,
                              _ => code.name,
                            };
                            if (context.mounted &&
                                message != null) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'エラーが発生しました: $code',
                                  ),
                                ),
                              );
                            }
                          } finally {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      },
                    ),
                    Text(
                      'ワンタイム ${cheapest.priceString}~',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }(),
              _ => ActionButton.text(
                context: context,
                text: '読み込み中...',
                onPressed: () {},
              ),
            },
          ),
        ],
      ),
    );
  }
}
