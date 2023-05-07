import 'package:eqmonitor/common/component/button/action_button.dart';
import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:eqmonitor/feature/setup/component/earthquake_restriction.dart';
import 'package:flutter/material.dart';

class QuickGuideAboutEew extends StatelessWidget {
  const QuickGuideAboutEew({required this.onNext, super.key});
  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急地震速報の限界について'),
      ),
      body: SetupBackgroundImageWidget(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: EarthquakeRestrictionWidget(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ActionButton(
                isEnabled: true,
                onPressed: onNext,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox( 
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        '次へ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
