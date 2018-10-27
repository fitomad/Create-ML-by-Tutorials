# Create ML. MLImageClassifier

![Xcode](https://img.shields.io/badge/xcode-10-blue.svg) ![Swift](https://img.shields.io/badge/swift-4.2-red.svg) ![Mojave](https://img.shields.io/badge/Mojave-10.14-yellow.svg)

En este nuevo [artículo](http://desappstre.com/create-ml-tutorial-mlimageclassifier) de la [serie](http://desappstre.com/tag/create-ml/) sobre Create ML exploramos los modelos de clasificación de imágenes.

Como siempre necesitaremos Xcode 10 y un Mac con la Mojave.

## Estructura

El repositorio cuenta con una carpeta llamada **Data** que contiene las imágenes para *entrenar* y *evaluar* el modelo de clasificación y con el **Playground** con el código para generar dicho modelo.

La carpeta de datos tiene la siguiente estructura:

* **Training**
	* Penny
	* Leonard
	* Sheldon
	* Raj
	* Howard
* **Evaluation**
	* Penny
	* Leonard
	* Sheldon
	* Raj
	* Howard

## El Playground

Debe ejecutarse sobre **Xcode 10** en un Mac con macOS Mojave instalado. Al abrir el playground se verá que está compuesto por 2 *páginas*, una tiene la creación del modelo con el interface gracias a `MLImageClassifierBuilder` y la otra página tiene la creación del modelo mediante código.

## Contacto

Si tienes dudas o preguntas seguro que me encuentras en mi cuenta de twitter [@fitomad](https://twitter.com/fitomad)
