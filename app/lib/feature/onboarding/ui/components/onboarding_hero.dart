part of '../page/onboarding_page.dart';

class _OnboardingAppIconHero extends StatelessWidget {
  const _OnboardingAppIconHero();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.asset(
        Assets.images.icon.path,
        height: 128,
      ),
    );
  }
}

class _OnboardingPermissionsHero extends StatelessWidget {
  const _OnboardingPermissionsHero({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _OnboardingPulseRing(color: color, radius: 90, opacity: 0.08),
          _OnboardingPulseRing(color: color, radius: 70, opacity: 0.12),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active_rounded,
                  color: color,
                  size: 32,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.location_on_rounded,
                  color: color,
                  size: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPulseRing extends StatelessWidget {
  const _OnboardingPulseRing({
    required this.color,
    required this.radius,
    required this.opacity,
  });

  final Color color;
  final double radius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: opacity), width: 2),
      ),
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
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        color: color,
        size: 80,
      ),
    );
  }
}
