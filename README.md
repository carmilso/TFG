# Diseño de mecanismos basados en traducción automática para la portabilidad entre idiomas en un sistema de comprensión del habla.


## Resumen

En este proyecto se hace uso de herramientas de traducción automática para la creación de un sistema de comprensión del habla en inglés y francés a partir de uno originalmente en castellano. Gracias al uso de estas herramientas se evita la necesidad de una traducción y etiquetado manual para la portabilidad a un nuevo idioma. Se ha seguido la aproximación *train-on-target* para volver a estimar un nuevo modelo de comprensión en estos idiomas. Para ello ha sido necesaria la obtención de un conjunto de entrenamiento en ambos idiomas al que se le ha aplicado un proceso de normalización y otro posterior de segmentación y etiquetado.

#### Palabras clave: Comprensión del habla, multilingüismo, normalización, segmentación, estrategia *train-on-target*

## Resum

En aquest projecte es fa ús d'eines de traducció automàtica per a la creació d'un sistema de comprensió de la parla en anglès i francès a partir d'un obtingut originalment en castellà. Gràcies a l'ús d'aquestes eines s'evita la necessitat d'una traducció i etiquetat manual per a la portabilitat a un nou idioma. S'ha seguit l'aproximació *train-on-target* per a tornar a estimar un nou model de comprensió en aquests idiomes. Per a això ha sigut necessària l'obtenció d'un conjunt d'entrenament en ambdós idiomes al que se li ha aplicat un procés de normalització i altre posterior de segmentació i etiquetatge.

#### Paraules clau: Comprensió de la parla, multilingüisme, normalització, segmentació, estratègia *train-on-target*

## Abstract

In this project machine translation tools are used to create a spoken language understanding system in English and French from one originally in Spanish. By using these tools the need of manual translation and labeling is avoided for its portability to a new language. The train-on-target approach has been followed to re-estimate a new understanding model in these languages. In order to accomplish this, a training set in both languages has been required, and a process of normalization and another one of segmentation and labeling have been applied to these sets.

#### Key words: Spoken language understanding, multilingualism, normalization, segmentation, train-on-target strategy

## Enlace del documento

[Diseño de mecanismos basados en traducción automática para la portabilidad entre idiomas en un sistema de comprensión del habla](http://riunet.upv.es)

## Logs

En la carpeta "logs" se encuentran las traducciones del conjunto de entrenamiento del corpus en inglés y francés.

## Scripts

En la carpeta "scripts" están los *scripts* implementados para el proyecto. Todos deben ser llamados desde la carpeta que los contiene para su correcta ejecución. Dentro de cada uno de ellos hay un ejemplo de uso.

1. prepareSentences.sh -> prepara los ficheros de traducción a partir del fichero del corpus.
2. toHtmlFormat.sh -> convierte el fichero de entrada a formato HTML.
3. treatTranslations.sh -> normaliza las traducciones de inglés y francés.
    1. formatNumbers_{en,fr}.py -> realiza el tratamiento numérico de las traducciones.
4. restartTranslations.sh -> devuelve las traducciones a su estado original.
5. generateCRFTrain.sh -> genera los ficheros de entrenamiento preparados para el *toolkit* CRF++.
    1. computeSegments.py -> realiza la segmentación de las frases de entrenamiento.
    2. computeTags.py -> asigna la etiqueta semántica correspondiente a cada segmento de las frases.
6. prepareTextTest.sh -> normaliza las pruebas de texto.
7. prepareSpeechTest.sh -> normaliza las pruebas de voz.
8. CRFTrainAndTest.sh -> entrena el sistema de comprensión y realiza las pruebas de entrada al sistema.

### Requerimientos

- [num2words](https://pypi.python.org/pypi/num2words) (para la normalización de las traducciones).
- [CRF++](https://taku910.github.io/crfpp/) (para el entrenamiento).

## Notas
Se muestra un subconjunto del *corpus* en todos los casos en los que aparece, por lo que el fichero con las etiquetas semánticas (segment_tags) no se correspode con la realidad de los ficheros con frases del *corpus*.