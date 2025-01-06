#!/bin/bash

# Instalar Flutter
git clone https://github.com/flutter/flutter.git /opt/flutter
export PATH="$PATH:/opt/flutter/bin"

# Verificar que Flutter se haya instalado correctamente
flutter --version

# Instalar dependencias de Flutter
flutter doctor
flutter pub get

# Construir el proyecto Flutter para la web
flutter build web
