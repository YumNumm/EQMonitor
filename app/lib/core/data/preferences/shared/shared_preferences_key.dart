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
  startEtag('start_etag'),
  startBody('start_body'),
  changelogEtag('changelog_etag'),
  changelogBody('changelog_body'),
  whatsNewSeenVersion('whats_new_seen_version'),

  /// v2.6アプリがSupabase device IDの保存に使用していたキー（移行用）
  legacyDeviceId('device_id'),
  deviceProvisioned('device_provisioned'),
  lastFcmTokenHash('last_fcm_token_hash'),
  lastApnsTokenHash('last_apns_token_hash'),
  lastApnsPushToStartTokenHash('last_apns_push_to_start_token_hash'),
  deviceMigratedFromLegacy('device_migrated_from_legacy'),
  adsOptOut('ads_opt_out'),
  autoReturnToRealtime('auto_return_to_realtime'),
  earthquakeHistoryMapLayerParameter('earthquake_history_map_layer_parameter'),
  homeMapLabelParameter('home_map_label_parameter'),
  estimatedIntensityNoticeShown('estimated_intensity_notice_shown'),
  ;

  const SharedPreferencesKey(this.key);
  final String key;
}
