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
  deviceProvisioned('device_provisioned'),
  lastFcmTokenHash('last_fcm_token_hash'),
  lastApnsTokenHash('last_apns_token_hash'),
  lastApnsPushToStartTokenHash('last_apns_push_to_start_token_hash'),
  adsOptOut('ads_opt_out'),
  autoReturnToRealtime('auto_return_to_realtime'),
  ;

  const SharedPreferencesKey(this.key);
  final String key;
}
