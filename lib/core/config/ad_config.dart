class AdConfig {
  // IDs de la aplicación de AdMob
  static const String androidAppId = 'ca-app-pub-1688703174684930~1974575921';
  static const String iosAppId = 'ca-app-pub-1688703174684930~1974575921';
  
  // IDs de unidades de anuncios de producción - TODOS REALES
  // REEMPLAZAR los placeholders de banner/rewarded por los reales en AdMob
  static const String productionBannerAdUnitId = 'ca-app-pub-1688703174684930/1234567890'; // TODO: Reemplazar por Banner real
  static const String productionInterstitialAdUnitId = 'ca-app-pub-1688703174684930/7586011167'; // Interstitial real
  static const String productionRewardedAdUnitId = 'ca-app-pub-1688703174684930/0987654321'; // TODO: Reemplazar por Rewarded real
  
  // IDs de prueba para desarrollo
  static const String testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const String testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
  
  // Determinar si estamos en modo de desarrollo
  static bool get isDevelopment {
    // Configurado para usar anuncios reales
    const bool isDebug = false; // false = usar anuncios reales
    return isDebug;
  }
  
  // Obtener IDs según el entorno
  static String get bannerAdUnitId => isDevelopment ? testBannerAdUnitId : productionBannerAdUnitId;
  static String get interstitialAdUnitId => isDevelopment ? testInterstitialAdUnitId : productionInterstitialAdUnitId;
  static String get rewardedAdUnitId => isDevelopment ? testRewardedAdUnitId : productionRewardedAdUnitId;
  
  // Configuración para dispositivos de prueba
  static List<String> get testDeviceIds => [
    // Agregar aquí los IDs de dispositivos de prueba
    // Para obtener el ID del emulador, revisar los logs de AdMob
    'EMULATOR', // ID genérico para emuladores
  ];
}
