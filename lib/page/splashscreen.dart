import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color:
              (context.isDarkMode) ? Colors.grey[900] : const Color(0xFFF1F4F9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              (context.isDarkMode) ? 'assets/dark1.gif' : 'assets/light1.gif',
              fit: BoxFit.contain,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset(
                    (context.isDarkMode)
                        ? 'assets/dark2.gif'
                        : 'assets/light2.gif',
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
