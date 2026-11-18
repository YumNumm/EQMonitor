part of '../page/onboarding_page.dart';

class const _OnboardingBottomBar({
  required final int currentPage,
  required final int totalPages,
  required final String buttonLabel,
  required final String processingLabel,
  required final bool isNextEnabled,
  required final bool isBackEnabled,
  required final bool isProcessing,
  required final Future<void> Function() onNext,
  required final Future<void> Function()? onPrevious,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        designSystem.spacing.lg,
        designSystem.spacing.xl,
        designSystem.spacing.lg,
        designSystem.spacing.xxl,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .center,
            children: List.generate(
              totalPages,
              (index) => _PageDot(
                isActive: index == currentPage,
                color: designSystem.colorTheme.primary,
                inactiveColor: designSystem.colorTheme.outlineVariant,
              ),
            ),
          ),
          SizedBox(height: designSystem.spacing.xl),
          Row(
            mainAxisAlignment: .spaceBetween,
            spacing: designSystem.spacing.sm,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                alignment: Alignment.centerLeft,
                child: (onPrevious != null)
                    ? IconButton.filledTonal(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: isBackEnabled ? onPrevious : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: context
                              .designSystem
                              .colorTheme
                              .secondaryContainer,
                          foregroundColor: context
                              .designSystem
                              .colorTheme
                              .onSecondaryContainer,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(
                              designSystem.shape.button,
                            ),
                          ),
                          padding: EdgeInsets.all(designSystem.spacing.md),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: M3EFilledButton(
                  onPressed: isNextEnabled && !isProcessing ? onNext : null,
                  decoration: M3EButtonDecoration.styleFrom(
                    backgroundColor: isProcessing
                        ? designSystem.colorTheme.surfaceContainer
                        : designSystem.colorTheme.primary,
                    foregroundColor: isProcessing
                        ? designSystem.colorTheme.onSurface
                        : designSystem.colorTheme.onInverseSurface,
                    borderRadius: designSystem.shape.button,
                    padding: EdgeInsets.symmetric(
                      vertical: designSystem.spacing.md,
                    ),
                  ),
                  child: isProcessing
                      ? Row(
                          mainAxisAlignment: .center,
                          spacing: designSystem.spacing.sm,
                          children: [
                            SizedBox.square(
                              dimension: 16,
                              child: AccessibleCircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  designSystem.colorTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Text(
                              processingLabel,
                              style: designSystem.typography.titleSmall
                                  .copyWith(
                                    color: designSystem
                                        .colorTheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        )
                      : Text(
                          buttonLabel,
                          style: designSystem.typography.titleSmall.copyWith(
                            color: isNextEnabled
                                ? designSystem.colorTheme.onInverseSurface
                                : designSystem.colorTheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            alignment: Alignment.bottomCenter,
            child: (currentPage == 0)
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(
                          horizontal: designSystem.spacing.md,
                        ) +
                        EdgeInsets.only(top: designSystem.spacing.md),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: '次へ をタップすることで '),
                          WidgetSpan(
                            alignment: .baseline,
                            baseline: .alphabetic,
                            child: _OnboardingBottomBarInlineLink(
                              label: '利用規約',
                              onTap: () => const TermOfServiceRoute()
                                  .push<void>(context),
                            ),
                          ),
                          const TextSpan(text: ' と '),
                          WidgetSpan(
                            alignment: .baseline,
                            baseline: .alphabetic,
                            child: _OnboardingBottomBarInlineLink(
                              label: 'プライバシーポリシー',
                              onTap: () => const PrivacyPolicyRoute()
                                  .push<void>(context),
                            ),
                          ),
                          const TextSpan(text: ' に同意したとみなされます'),
                        ],
                        style: designSystem.typography.bodySmall.copyWith(
                          color: context.designSystem.colorTheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class const _OnboardingBottomBarInlineLink({
  required final String label,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: designSystem.typography.bodySmall.copyWith(
          color: designSystem.colorTheme.onSurface.withValues(alpha: 0.6),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class const _PageDot({
  required final bool isActive,
  required final Color color,
  required final Color inactiveColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? color : inactiveColor,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
