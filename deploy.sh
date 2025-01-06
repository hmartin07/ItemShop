#!/bin/bash

# Instalar Flutter en el entorno de Netlify
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Asegurarse de que Flutter esté listo para la compilación
flutter doctor

# Construir la web
flutter build web
