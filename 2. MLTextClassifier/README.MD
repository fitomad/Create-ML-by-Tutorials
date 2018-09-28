# Create ML. Tutorial − MLTextClassifier

![Xcode](https://img.shields.io/badge/xcode-10-blue.svg) ![Swift](https://img.shields.io/badge/swift-4.2-red.svg) ![Mojave](https://img.shields.io/badge/Mojave-10.14-yellow.svg)

Segundo artículo de la serie dedicada a Create ML. En este caso generamos un clasificador de texto y lo importamos a una app iOS que clasifica las reseñas que escribe un usuario.

Este repositorio está dividio en tres carpetas

1. **Data** Contiene los archivos `json` con los que entrenar el modelo
2. **Playground** Al descargar el respositorio a disco veremos que es un Playground de Swift
3. **Python ETL** El proceso de extracción de datos con los que alimentar el modelo.

## Los Datos

Para entrenar el modelo en esta segunda entrega he *aligerado* el juego de datos y también balanceado la cantidad de reseñas por categoría. Ahora el archivo tiene **40.000** reseñas, 8.000 para cada categoría.

Las entidades `json` tienen los siguiente campos

|Campo|Tipo|Descripción|
|---|---|---|
|content|`String`|Contenido completo de la reseña|
|rating|`String`|Valoración de la app. Entre 1 y 5|

## El Playground

Debe ejecutarse sobre **Xcode 10** en un Mac con macOS Mojave instalado. Al abrir el playground se verá que está compuesto por 2 *páginas*, una tiene la creación por defecto de un `MLTextClassifier` y el otro su creación pero con `MLTextClassifier.ModelParameters`

## La App iOS

Para simplificar la lectura y seguimiento de código no he añadido la lógica de negocio en un target aparte, por lo que está todo dentro del target de la app. 

* La carpeta **Model** contiene el archivo .mlmodel generado con Create ML.
* En **Entities** está la enumeración `Rate` que usaremos para facilitar la presentación de la clasficación de la reseña

El resto contiene las vistas y controladores además de archivos de recursos habituales de cualquier aplicación iOS.

## Contacto

Si tienes dudas o preguntas seguro que me encuentras en mi cuenta de twitter [@fitomad](https://twitter.com/fitomad)


