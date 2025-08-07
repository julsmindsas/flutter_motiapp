class AdConfig {
  // IDs de la aplicación de AdMob
  static const String androidAppId = 'ca-app-pub-1688703174684930~1974575921';
  static const String iosAppId = 'ca-app-pub-1688703174684930~1974575921';
  
  // IDs de unidades de anuncios de producción
  // TODO: Crear unidades específicas para Banner y Rewarded en AdMob
  static const String productionBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Temporal: ID de prueba
  static const String productionInterstitialAdUnitId = 'ca-app-pub-1688703174684930/7586011167'; // Real
  static const String productionRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917'; // Temporal: ID de prueba
  
  // IDs de prueba para desarrollo
  static const String testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const String testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
  
  // Determinar si estamos en modo de desarrollo
  static bool get isDevelopment {
    // Puedes cambiar esto según tu configuración de build
    const bool isDebug = true; // Cambiar a false para producción
    return isDebug;
  }
  
  // Obtener IDs según el entorno
  static String get bannerAdUnitId => isDevelopment ? testBannerAdUnitId : productionBannerAdUnitId;
  static String get interstitialAdUnitId => isDevelopment ? testInterstitialAdUnitId : productionInterstitialAdUnitId;
  static String get rewardedAdUnitId => isDevelopment ? testRewardedAdUnitId : productionRewardedAdUnitId;
}
