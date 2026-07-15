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
  deviceMigratedFromLegacy('device_migrated_from_legacy'),
  adsOptOut('ads_opt_out'),
  autoReturnToRealtime('auto_return_to_realtime'),
  earthquakeHistoryMapLayerParameter('earthquake_history_map_layer_parameter'),
  homeMapLabelParameter('home_map_label_parameter'),
  estimatedIntensityNoticeShown('estimated_intensity_notice_shown'),
  isEstimatedIntensityOnEewReplayAllowed(
    'is_estimated_intensity_on_eew_replay_allowed',
  ),
  widgetRegionSelection('widget_region_selection'),
  httpCacheDisabled('http_cache_disabled'),
  locationPermissionBannerDismissed('location_permission_banner_dismissed'),
  notificationPermissionBannerDismissed(
    'notification_permission_banner_dismissed',
  ),
  notificationPreset('notification_preset'),
  appThemeLight('app_theme_light'),
  appThemeDark('app_theme_dark'),

  /// 旧震度カラー設定（移行用）
  estimatedIntensityColor('estimated_intensity_color'),
  bglDebugNotifyLatLng('bgl_debug_latlng'),
  bglDebugNotifyRegion('bgl_debug_region'),
  bglDebugNotifyPrefecture('bgl_debug_prefecture'),
  bglDebugNotifyApiUpdate('bgl_debug_api_update');

  const SharedPreferencesKey(this.key);
  final String key;
}
