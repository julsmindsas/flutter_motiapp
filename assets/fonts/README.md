# Fuentes de MotiApp

Esta carpeta debe contener las fuentes Poppins utilizadas en la aplicación.

## Fuentes Requeridas

Para que la aplicación funcione correctamente, necesitas descargar las siguientes fuentes de Google Fonts:

1. **Poppins-Regular.ttf** - Peso 400
2. **Poppins-Medium.ttf** - Peso 500
3. **Poppins-SemiBold.ttf** - Peso 600
4. **Poppins-Bold.ttf** - Peso 700

## Descarga de Fuentes

Puedes descargar las fuentes desde:
- [Google Fonts - Poppins](https://fonts.google.com/specimen/Poppins)

O usar el siguiente comando para descargarlas automáticamente:

```bash
# Crear directorio temporal
mkdir -p temp_fonts

# Descargar fuentes Poppins
curl -o temp_fonts/Poppins-Regular.ttf "https://fonts.gstatic.com/s/poppins/v20/pxiEyp8kv8JHgFVrJJfecg.woff2"
curl -o temp_fonts/Poppins-Medium.ttf "https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLGT9Z1xlFQ.woff2"
curl -o temp_fonts/Poppins-SemiBold.ttf "https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLEj6Z1xlFQ.woff2"
curl -o temp_fonts/Poppins-Bold.ttf "https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLCz7Z1xlFQ.woff2"

# Mover a la carpeta de assets
mv temp_fonts/*.ttf ./
rmdir temp_fonts
```

## Verificación

Después de descargar las fuentes, verifica que la estructura sea:

```
assets/fonts/
├── Poppins-Regular.ttf
├── Poppins-Medium.ttf
├── Poppins-SemiBold.ttf
├── Poppins-Bold.ttf
└── README.md
```

## Nota

Las fuentes están configuradas en `pubspec.yaml` y se utilizan en `lib/core/theme/app_theme.dart`. 