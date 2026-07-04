class FakeDesignSystem {
  const FakeDesignSystem();
  Object get colorTheme => const Object();
}

class OkWidget {
  const OkWidget(this.designSystem);

  final FakeDesignSystem designSystem;

  Object get resolvedColor => designSystem.colorTheme;
}
