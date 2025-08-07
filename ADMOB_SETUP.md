# Configuración de AdMob para MotiApp

## 📱 IDs de Producción Configurados

### ID de la Aplicación
- **Android:** `ca-app-pub-1688703174684930~1974575921`
- **iOS:** `ca-app-pub-1688703174684930~1974575921`

### IDs de Unidades de Anuncios
- **Interstitial (Real):** `ca-app-pub-1688703174684930/7586011167`
- **Banner (Temporal):** `ca-app-pub-3940256099942544/6300978111` (ID de prueba)
- **Rewarded (Temporal):** `ca-app-pub-3940256099942544/5224354917` (ID de prueba)

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
- ID: `ca-app-pub-3940256099942544/6300978111` (Temporal: ID de prueba)
- **Estado:** ⚠️ Necesita crear unidad real en AdMob

### Interstitial Ads
- Ubicación: Entre navegaciones
- Frecuencia: Cada 3 frases vistas
- ID: `ca-app-pub-1688703174684930/7586011167`
- **Estado:** ✅ Configurado con ID real

### Rewarded Ads
- Ubicación: Opcional para usuarios
- Frecuencia: A petición del usuario
- ID: `ca-app-pub-3940256099942544/5224354917` (Temporal: ID de prueba)
- **Estado:** ⚠️ Necesita crear unidad real en AdMob

## 🚀 Próximos Pasos Recomendados

### 1. Crear Unidades de Anuncios Específicas
En AdMob, crear unidades separadas para cada tipo de anuncio:

1. **Banner Ad Unit** ⚠️ **PENDIENTE**
   - Tipo: Banner
   - Nombre: "MotiApp Banner"
   - ID: Crear nuevo
   - **Estado:** Usando ID de prueba temporalmente

2. **Interstitial Ad Unit** ✅ **CONFIGURADO**
   - Tipo: Interstitial
   - Nombre: "MotiApp Interstitial"
   - ID: `ca-app-pub-1688703174684930/7586011167`
   - **Estado:** Funcionando con ID real

3. **Rewarded Ad Unit** ⚠️ **PENDIENTE**
   - Tipo: Rewarded
   - Nombre: "MotiApp Rewarded"
   - ID: Crear nuevo
   - **Estado:** Usando ID de prueba temporalmente

### 2. Actualizar Configuración
Una vez creadas las unidades específicas para Banner y Rewarded, actualizar `lib/core/config/ad_config.dart`:

```dart
// IDs de unidades de anuncios de producción
static const String productionBannerAdUnitId = 'tu-banner-id-aqui'; // Reemplazar con ID real
static const String productionInterstitialAdUnitId = 'ca-app-pub-1688703174684930/7586011167'; // ✅ Ya configurado
static const String productionRewardedAdUnitId = 'tu-rewarded-id-aqui'; // Reemplazar con ID real
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
- [x] Configuración centralizada implementada
- [x] Manejo de entornos implementado
- [x] **Interstitial Ad configurado con ID real**
- [ ] Crear unidad Banner específica en AdMob
- [ ] Crear unidad Rewarded específica en AdMob
- [ ] Actualizar IDs de Banner y Rewarded
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
