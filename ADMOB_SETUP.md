# Configuración de AdMob para MotiApp

## 📱 IDs de Producción Configurados

### ID de la Aplicación
- **Android:** `ca-app-pub-1688703174684930~1974575921`
- **iOS:** `ca-app-pub-1688703174684930~1974575921`

### ID de Unidad de Anuncios
- **Unidad actual:** `ca-app-pub-1688703174684930/7586011167`

## 🔧 Configuración Implementada

### 1. Android (AndroidManifest.xml)
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-1688703174684930~1974575921"/>
```

### 2. iOS (Info.plist)
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-1688703174684930~1974575921</string>
```

### 3. Flutter (AdsProvider)
- Configuración centralizada en `lib/core/config/ad_config.dart`
- Manejo automático de entornos (desarrollo vs producción)
- IDs de prueba para desarrollo
- IDs de producción para release

## 📊 Tipos de Anuncios Configurados

### Banner Ads
- Ubicación: Páginas principales
- Frecuencia: Siempre visible
- ID: `ca-app-pub-1688703174684930/7586011167`

### Interstitial Ads
- Ubicación: Entre navegaciones
- Frecuencia: Cada 3 frases vistas
- ID: `ca-app-pub-1688703174684930/7586011167`

### Rewarded Ads
- Ubicación: Opcional para usuarios
- Frecuencia: A petición del usuario
- ID: `ca-app-pub-1688703174684930/7586011167`

## 🚀 Próximos Pasos Recomendados

### 1. Crear Unidades de Anuncios Específicas
En AdMob, crear unidades separadas para cada tipo de anuncio:

1. **Banner Ad Unit**
   - Tipo: Banner
   - Nombre: "MotiApp Banner"
   - ID: Crear nuevo

2. **Interstitial Ad Unit**
   - Tipo: Interstitial
   - Nombre: "MotiApp Interstitial"
   - ID: Crear nuevo

3. **Rewarded Ad Unit**
   - Tipo: Rewarded
   - Nombre: "MotiApp Rewarded"
   - ID: Crear nuevo

### 2. Actualizar Configuración
Una vez creadas las unidades específicas, actualizar `lib/core/config/ad_config.dart`:

```dart
// IDs de unidades de anuncios de producción
static const String productionBannerAdUnitId = 'tu-banner-id-aqui';
static const String productionInterstitialAdUnitId = 'tu-interstitial-id-aqui';
static const String productionRewardedAdUnitId = 'tu-rewarded-id-aqui';
```

### 3. Configurar Entornos
Para cambiar entre desarrollo y producción, modificar en `ad_config.dart`:

```dart
static bool get isDevelopment {
  const bool isDebug = false; // true para desarrollo, false para producción
  return isDebug;
}
```

## 📈 Estrategia de Monetización

### Frecuencia de Anuncios
- **Banner:** Siempre visible en páginas principales
- **Interstitial:** Cada 3 frases vistas
- **Rewarded:** Opcional, a petición del usuario

### Experiencia de Usuario
- Anuncios no intrusivos
- Experiencia premium mantenida
- Recompensas por ver anuncios opcionales

## 🔍 Testing

### Desarrollo
- Usar IDs de prueba de Google
- Verificar funcionamiento en emulador/dispositivo
- Testear todos los tipos de anuncios

### Producción
- Usar IDs reales de AdMob
- Monitorear métricas en AdMob Console
- Optimizar según rendimiento

## 📋 Checklist de Implementación

- [x] ID de aplicación configurado en Android
- [x] ID de aplicación configurado en iOS
- [x] IDs de unidades de anuncios configurados
- [x] Configuración centralizada implementada
- [x] Manejo de entornos implementado
- [ ] Crear unidades específicas en AdMob
- [ ] Actualizar IDs específicos
- [ ] Testing en producción
- [ ] Monitoreo de métricas

## 🆘 Troubleshooting

### Problemas Comunes

1. **Anuncios no se cargan**
   - Verificar conexión a internet
   - Verificar IDs correctos
   - Verificar configuración de AdMob

2. **Anuncios de prueba en producción**
   - Cambiar `isDevelopment` a `false`
   - Verificar IDs de producción

3. **Anuncios no aparecen**
   - Verificar permisos de internet
   - Verificar configuración de AdMob
   - Verificar políticas de AdMob

### Contacto
Para problemas específicos con AdMob, consultar:
- [AdMob Help Center](https://support.google.com/admob)
- [Google Mobile Ads Documentation](https://developers.google.com/admob/flutter/quick-start)
