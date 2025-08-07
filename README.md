# MotiApp - Aplicación de Frases Motivadoras

Una aplicación Flutter premium de frases motivadoras con monetización a través de publicidad, diseñada para iOS y Android con una paleta de colores luxury.

## 🎨 Características de Diseño

### Paleta de Colores Luxury
- **Negro Primario**: #0A0A0A
- **Negro Secundario**: #1A1A1A
- **Gris Oscuro**: #2A2A2A
- **Gris Medio**: #3A3A3A
- **Gris Claro**: #4A4A4A
- **Gris Plateado**: #8A8A8A
- **Blanco**: #FFFFFF
- **Dorado**: #FFD700
- **Dorado Premium**: #FFB347

### Principios de Diseño
- ✨ **Premium y Luxury**: Diseño elegante y sofisticado
- 📱 **Responsive**: Adaptable a diferentes tamaños de pantalla
- ♿ **Accessible**: Cumplir con estándares de accesibilidad
- 🎯 **Consistent**: Mantener consistencia en toda la app

## 🚀 Funcionalidades Principales

### 📖 Frases Motivadoras
- **Frase del día** destacada con diseño premium
- **Lista de frases** organizadas por categorías
- **Sistema de favoritos** para guardar frases
- **Compartir frases** en redes sociales
- **Imágenes de fondo** opcionales para cada frase

### 💰 Monetización
- **Google Mobile Ads** integrado
- **Banners publicitarios** en páginas principales
- **Anuncios intersticiales** cada 3 frases vistas
- **Anuncios recompensados** opcionales
- **Estrategia no intrusiva** para experiencia premium

### 👤 Autenticación
- **Login/Registro** con Firebase Auth
- **Persistencia de sesión**
- **Validación de formularios**
- **Manejo de errores** user-friendly

### 🛠️ Panel de Administrador
- **Agregar nuevas frases** desde la app
- **Subir imágenes** de fondo
- **Gestión de categorías**
- **Estadísticas básicas**
- **Acceso restringido** (admin@motiapp.com)

## 🏗️ Arquitectura del Proyecto

### Estructura de Carpetas
```
lib/
├── core/
│   ├── models/          # Modelos de datos
│   ├── providers/       # Providers de estado
│   ├── theme/          # Configuración de temas
│   └── routes/         # Configuración de navegación
├── features/
│   ├── auth/           # Autenticación
│   ├── home/           # Página principal
│   ├── quotes/         # Gestión de frases
│   ├── favorites/      # Favoritos
│   ├── profile/        # Perfil de usuario
│   └── admin/          # Panel de administrador
└── main.dart
```

### Patrón de Arquitectura
- **Clean Architecture** con separación de capas
- **Provider** para gestión de estado
- **Feature-based** organización de carpetas

## 🛠️ Tecnologías Utilizadas

### Backend
- **Firebase Firestore**: Base de datos en tiempo real
- **Firebase Storage**: Almacenamiento de imágenes
- **Firebase Auth**: Autenticación de usuarios

### Publicidad
- **Google Mobile Ads**: Monetización
- IDs de prueba configurados para desarrollo
- Estrategia de anuncios cada 3 frases vistas

### Estado y Navegación
- **Provider**: Gestión de estado reactivo
- **Go Router**: Navegación declarativa
- **Shared Preferences**: Almacenamiento local

### UI/UX
- **Google Fonts**: Tipografía Poppins
- **Cached Network Image**: Carga optimizada de imágenes
- **Shimmer**: Efectos de carga elegantes
- **Lottie**: Animaciones fluidas

## 📱 Páginas Principales

### 🏠 Home
- Frase del día destacada
- Categorías de frases
- Frases recientes
- Banner publicitario

### 📖 Frases
- Lista completa de frases
- Filtros por categoría
- Búsqueda de frases
- Compartir y favoritos

### ❤️ Favoritos
- Frases guardadas por el usuario
- Gestión de favoritos
- Vista optimizada

### 👤 Perfil
- Información del usuario
- Configuración de notificaciones
- Historial de frases vistas
- Opciones de la aplicación

### 🛠️ Admin
- Panel de administración
- Agregar nuevas frases
- Subir imágenes
- Estadísticas básicas

## 🚀 Configuración Inicial

### Prerrequisitos
- Flutter SDK 3.0.0 o superior
- Dart SDK 2.17.0 o superior
- Android Studio / VS Code
- Cuenta de Firebase
- Cuenta de Google AdMob

### Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/moti_app.git
cd moti_app
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Firebase**
```bash
# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar Firebase
flutterfire configure
```

4. **Configurar Google Mobile Ads**
- Crear cuenta en Google AdMob
- Obtener IDs de anuncios para producción
- Reemplazar IDs de prueba en `lib/core/providers/ads_provider.dart`

5. **Ejecutar la aplicación**
```bash
flutter run
```

## 🔧 Configuración de Firebase

### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /quotes/{quoteId} {
      allow read: if true;
      allow write: if request.auth != null && 
        (request.auth.token.email == 'admin@motiapp.com' || 
         resource.data.author == request.auth.uid);
    }
    match /users/{userId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == userId;
    }
  }
}
```

### Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /quotes/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null && 
        request.auth.token.email == 'admin@motiapp.com';
    }
  }
}
```

## 📊 Configuración de Publicidad

### IDs de Anuncios (Desarrollo)
- **Banner**: `ca-app-pub-3940256099942544/6300978111`
- **Interstitial**: `ca-app-pub-3940256099942544/1033173712`
- **Rewarded**: `ca-app-pub-3940256099942544/5224354917`

### Estrategia de Monetización
- Anuncios cada 3 frases vistas
- Banners en páginas principales
- Anuncios recompensados opcionales
- Experiencia premium sin ser intrusiva

## 🧪 Testing

### Ejecutar Tests
```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/
```

### Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📦 Build y Deployment

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

### iOS
```bash
# Build para iOS
flutter build ios --release
```

## 🔒 Seguridad

### Consideraciones
- Validación de datos en frontend y backend
- Sanitización de inputs
- Reglas de Firebase configuradas
- Protección de datos sensibles
- Autenticación requerida para funciones críticas

## 📈 Monitoreo y Analytics

### Firebase Analytics
- Tracking de eventos de usuario
- Métricas de engagement
- Análisis de comportamiento

### Crashlytics
- Reporte automático de errores
- Stack traces detallados
- Priorización de bugs

## 🤝 Contribución

### Guías de Contribución
1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

### Estándares de Código
- Seguir las reglas de Cursor (`.cursorrules`)
- Mantener consistencia en nomenclatura
- Documentar funciones complejas
- Escribir tests para nuevas funcionalidades

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 📞 Soporte

### Contacto
- **Email**: soporte@motiapp.com
- **Documentación**: [docs.motiapp.com](https://docs.motiapp.com)
- **Issues**: [GitHub Issues](https://github.com/tu-usuario/moti_app/issues)

### FAQ
- **¿Cómo configurar Firebase?** Ver sección de configuración inicial
- **¿Cómo cambiar los IDs de anuncios?** Editar `lib/core/providers/ads_provider.dart`
- **¿Cómo agregar nuevas categorías?** Modificar la lista en `lib/features/admin/presentation/pages/admin_page.dart`

## 🎯 Roadmap

### Versión 1.1
- [ ] Notificaciones push
- [ ] Modo offline
- [ ] Temas personalizables
- [ ] Más categorías de frases

### Versión 1.2
- [ ] Widgets para home screen
- [ ] Compartir en WhatsApp
- [ ] Estadísticas avanzadas
- [ ] Sistema de logros

### Versión 2.0
- [ ] Modo premium sin anuncios
- [ ] Frases personalizadas
- [ ] Comunidad de usuarios
- [ ] API pública

---

**Desarrollado con ❤️ usando Flutter** 