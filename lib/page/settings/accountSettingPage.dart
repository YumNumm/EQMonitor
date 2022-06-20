// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../private/keys.dart';
import '../../utils/auth.dart';

final AuthStateUtils authStateUtils = Get.find<AuthStateUtils>();
final Logger logger = Get.find<Logger>();
final FlutterSecureStorage fss = Get.find<FlutterSecureStorage>();

bool _isProcessing = false;

Widget accountSettingPage() {
  if (!authStateUtils.isLoggedin.value) {
    //? Login
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('アカウント設定'),
          tiles: <AbstractSettingsTile>[
            SettingsTile.navigation(
              title: const Text('Twitter ログイン'),
              description:
                  const Text('Twitterでログインすることにより、すべての地震に関する通知がツイートされます'),
              leading: const Icon(Icons.people),
              onPressed: (e) async {
                final isAllowed = await Get.dialog<bool>(
                      AlertDialog(
                        title: const Text(
                          '本当に続行しますか?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color.fromARGB(255, 142, 0, 0),
                        content: const Text(
                          'アプリで受け取ったすべての通知を自動的にツイートします。\n'
                          'そのため、フォロワーさんに迷惑をかけてしまう場合があります。\n'
                          '十分注意してご利用ください。',
                          style: TextStyle(color: Colors.white),
                        ),
                        scrollable: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Get.back<bool>(result: false);
                            },
                            child: const Text(
                              'キャンセル',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back<bool>(result: true);
                            },
                            child: const Text(
                              '続行',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ) ??
                    true;
                if (isAllowed) {
                  _isProcessing = true;
                  final platform = oauth1.Platform(
                    'https://api.twitter.com/oauth/request_token',
                    'https://api.twitter.com/oauth/authorize',
                    'https://api.twitter.com/oauth/access_token',
                    oauth1.SignatureMethods.hmacSha1,
                  );

                  final auth =
                      oauth1.Authorization(clientCredentials, platform);
                  oauth1.Credentials? tokenCredentials;
                  final res = await auth.requestTemporaryCredentials('oob');
                  tokenCredentials = res.credentials;
                  // launch() で ログイン用URLを開く
                  await launch(
                    auth.getResourceOwnerAuthorizationURI(
                      tokenCredentials.token,
                    ),
                  );

                  final pinCodeController = TextEditingController();
                  await Get.dialog<void>(
                    AlertDialog(
                      title: const Text('PINコードを入力'),
                      content: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: pinCodeController,
                        decoration: const InputDecoration(
                          hintText: 'PINコード',
                        ),
                        validator: (e) {
                          if (int.tryParse(e.toString()) == null) {
                            return '正しいPINコードを入力してください';
                          }
                          return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.always,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Get.back<void>();
                          },
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () async {
                            logger.d(pinCodeController.text);
                            if (int.tryParse(pinCodeController.text) != null) {
                              Get.snackbar('ログイン中...', 'しばらくお待ちください。');
                              await Get.showOverlay(
                                loadingWidget: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                asyncFunction: () async {
                                  //OK Next Step
                                  final res =
                                      await auth.requestTokenCredentials(
                                    tokenCredentials!,
                                    pinCodeController.text,
                                  );
                                  if (res.credentials.token == null) {
                                    //ERROR
                                    Get.back<void>();
                                    return;
                                  }
                                  await fss.write(
                                    key: 'AT',
                                    value: res.credentials.token,
                                  );
                                  await fss.write(
                                    key: 'AS',
                                    value: res.credentials.tokenSecret,
                                  );
                                  final credential =
                                      TwitterAuthProvider.credential(
                                    accessToken: res.credentials.token,
                                    secret: res.credentials.tokenSecret,
                                  );
                                  await FirebaseAuth.instance
                                      .signInWithCredential(credential);
                                  await authStateUtils.onInit();
                                },
                              );
                              Get.closeAllSnackbars();
                              Get.snackbar(
                                'ログイン成功',
                                'ようこそ ${authStateUtils.user.value!.displayName}さん!',
                              );
                            } else {
                              Get.snackbar(
                                'PINコードを入力してください',
                                '',
                                backgroundColor: Colors.redAccent,
                              );
                            }
                            Get.back<void>();
                          },
                          child: const Text('次に進む'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  } else {
    return SettingsList(
      sections: [
        //? Info
        SettingsSection(
          title: const Text('ユーザ情報'),
          tiles: [
            SettingsTile.navigation(
              title: const Text('ユーザ名'),
              /*leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: '${authStateUtils.user.value!.photoURL}',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                  errorWidget: (context, url, dynamic error) =>
                      const Icon(Icons.error),
                ),
              ),*/
              description: Text('${authStateUtils.user.value!.displayName}'),
            ),
            SettingsTile.navigation(
              title: const Text('UID(ユーザ識別ID)'),
              description: Text(authStateUtils.user.value!.uid),
            ),
            SettingsTile.navigation(
              title: const Text('ログアウト'),
              leading: const Icon(Icons.logout),
              onPressed: (_) async {
                await Get.showOverlay<void>(
                  loadingWidget: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  asyncFunction: () async {
                    // Secure StorageのAT,ASを抹消!!
                    await fss.delete(key: 'AT');
                    await fss.delete(key: 'AS');
                    await authStateUtils.firebaseauth.signOut();
                    logger
                        .w(authStateUtils.firebaseauth.currentUser.toString());
                    await authStateUtils.updateStatus();
                  },
                );
                await Get.offNamed<void>('/setting');
              },
            ),
          ],
        ),
      ],
    );
  }
}
