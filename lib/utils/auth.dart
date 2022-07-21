import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthStateUtils extends GetxController {
  final RxBool isLoggedin = false.obs;
  final FirebaseAuth firebaseauth = Get.find<FirebaseAuth>();
  final logger = Get.find<Logger>();
  late Rx<User?> user;
  @override
  Future<void> onInit() async {
    super.onInit();
    user = firebaseauth.currentUser.obs;
    if (user.value != null) {
      logger.d('Hello ${user.value!.displayName}');
      isLoggedin.value = true;
    } else {
      logger.d('Not logged in!');
      isLoggedin.value = false;
    }
  }

  Future<void> updateStatus() async {
    user = firebaseauth.currentUser.obs;
    const fss = FlutterSecureStorage();
    if (user.value != null) {
      logger.d('Hello ${user.value!.displayName}');
      await fss.write(key: 'toTweet', value: 'true');
      isLoggedin.value = true;
    } else {
      logger.d('Not logged in!');
      await fss.write(key: 'toTweet', value: 'false');
      isLoggedin.value = false;
    }
  }
}
