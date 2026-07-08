part of '../page/onboarding_page.dart';

class _OnboardingAppIconHero extends StatelessWidget {
  const _OnboardingAppIconHero();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.asset(Assets.images.icon.path, height: 128),
    );
  }
}

class _OnboardingCompleteHero extends StatelessWidget {
  const _OnboardingCompleteHero({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(Icons.check_rounded, color: color, size: 80),
    );
  }
}
