import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFF1F4F9),
              Color(0xFFF1F4F9),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                /*Image.network(
                    'https://pbs.twimg.com/profile_images/1455531489790251014/ZtHyZ3RQ_400x400.jpg'),*/
                Image.asset(
                  'assets/light1.gif',
                  fit: BoxFit.contain,
                ),
                /*Text(
                  'eqmonitor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.textTheme.displaySmall!.fontSize,
                  ),
                ),*/
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset(
                    'assets/light2.gif',
                    fit: BoxFit.contain,
                  ),
                ),
                const CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
