#!/bin/bash

# Asegúrate de que Flutter esté instalado
if ! command -v flutter &> /dev/null
then
    echo "Flutter no encontrado. Instalando..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
    export PATH="$PATH:`pwd`/flutter/bin"
fi

# Verifica que Flutter esté listo para usar
flutter doctor

# Construye la aplicación Flutter para la web
flutter build web
