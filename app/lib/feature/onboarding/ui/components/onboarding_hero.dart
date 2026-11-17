part of '../page/onboarding_page.dart';

class const _OnboardingAppIconHero() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.asset(Assets.images.icon.path, height: 128),
    );
  }
}

class const _OnboardingCompleteHero({
  required final Color color,
  required final Color backgroundColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(color: backgroundColor, shape: .circle),
      child: Icon(Icons.check_rounded, color: color, size: 80),
    );
  }
}
