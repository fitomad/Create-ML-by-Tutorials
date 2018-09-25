# Create ML. Tutorial − Introducción

![](https://img.shields.io/badge/xcode-10-blue.svg) ![Swift](https://img.shields.io/badge/swift-4.2-red.svg) ![](https://img.shields.io/badge/python-2.7-yellow.svg) ![](https://img.shields.io/badge/python-3.6-yellow.svg)

En este primer artículo de la serie se presenta el nuevo framework de Machine Learning diseñado para la creación y entrenamiento de modelos.

Este repositorio está dividio en tres carpetas

1. **Data** Contiene los archivos `json` con los que entrenar el modelo
2. **Playground** Al descargar el respositorio a disco veremos que es un Playground de Swift
3. **Python ETL** El proceso de extracción de datos con los que alimentar el modelo.

## Los Datos

Para entrenar al modelo que servirá de hilo conductor de los 2 primeros artículos he descargado **90.000 reseñas de aplicaciones de la más de 30 apps en 8 países** de habla inglesa.

Las entidades `json` tienen los siguiente campos

|Campo|Tipo|Descripción|
|---|---|---|
|appID|`Int`|El identificar de la app dentro de la App Store|
|name|`String`|Nombre de la App|
|title|`String`|Título de la reseña|
|content|`String`|Contenido completo de la reseña|
|rating|`String`|Valoración de la app. Entre 1 y 5|

El archivo `reviews_canada.json` tiene algún nombre de campo diferente pero ha sido para poder mostrar determinada características de `Create ML` durante el artículo.

Como el artículo está centrado en Create ML no se ha **limpiado** el juego de datos, pero se incluye funciones para eliminar las **stopwords** a un nivel básico por si quieres profundizar en el tema por tu cuenta.

## El Playground

Debe ejecutarse sobre Xcode 10 en un Mac con macOS Mojave instalado. Al abrir el playground se verá que está compuesto por 2 *páginas*, una con el ejemplo para `Create ML` y otro con una muestra del uso de `Create ML UI`

## El Script

Está disponible para las versiones 2.7 y 3.6 de Python. Tiene un diccionario con las apps y los países en los que queremos descargar sus reseñas.

Las reseñas están disponibles mediante un servicio RSS para cada app que se encuentra en la App Store y está operado por Apple.

Se limita a un máxmo de 10 páginas del feed de reseñas y cada petición se hace cada 15 segundos para evitar ser *baneados* por el servidor.

Existe un archivo archivo `stopwords.py` que contiene una lista de *stopwords* en inglés y funciones que limpian el texto para dejarlo preparado para modelos de clasificación de texto por si quieres probarlo por tu cuenta.

## Contacto

Si tienes dudas o preguntas seguro que me encuentras en mi cuenta de twitter [@fitomad](https://twitter.com/fitomad)
