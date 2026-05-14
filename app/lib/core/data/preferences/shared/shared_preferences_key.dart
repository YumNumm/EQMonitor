enum SharedPreferencesKey {
  secureStorageInitialized('SECURE_STORAGE_INITIALIZED'),
  ntpConfig('ntp_config'),
  earthquakeHistoryConfig('earthquake_history_config'),
  telegramUrl('telegram_url'),
  debug('debug'),
  kmoniSettings('_kmoni_settings'),
  themeMode('theme_mode'),
  mapConfiguration('map_configuration'),
  intensityColor('intensity_color'),
  locationTrackingMode('location_tracking_mode'),
  homeConfiguration('home_configuration'),
  onboardingCompleted('onboarding_completed'),
  betaTestingAgreed('beta_testing_agreed'),
  /// v2.6アプリがSupabase device IDの保存に使用していたキー（移行用）
  legacyDeviceId('device_id'),
  ;

  const SharedPreferencesKey(this.key);
  final String key;
}
