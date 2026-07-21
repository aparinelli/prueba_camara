# Pantalla Unica Design

## Objetivo

Convertir el proyecto en una pantalla unica de comienzo, eliminando la escena anterior de camara, SVG, patron, estrellas, espirales, HUD y controles.

## Requisitos

- Resolucion base: `1024x768`, igual que `/Users/alejoparinelli/facu/AM2/timber_parte_2/05_incremento_barra_tiempo`.
- Titulo: `Prueba Cámara`.
- Fuente del titulo: `bin/data/fonts/CaslonCPswash.otf`.
- La pantalla inicial usa un boton clickeable `Empezar`.
- Fuente secundaria del prompt: `bin/data/fonts/Arial.ttf`.
- Las fuentes se cargan con `ofTrueTypeFontSettings` y `ofAlphabet::Latin` para renderizar tildes.
- Despues de empezar hay tres escenas con texto inferior.
- Las escenas mantienen tamanos tipograficos constantes.
- La animacion de letras separa codepoints con `ofUTF8Iterator` y aplica un movimiento `pulse`/wave por letra.
- El repo original `aparinelli/prueba_camara` no despliega `demo` a su Pages anterior.
- La version nueva se publica en un sitio Pages separado.

## Diseno

`ofApp` queda reducido a cargar dos fuentes y dibujar la pantalla inicial escalada dentro de una superficie logica de `1024x768`. El boton `Empezar` desactiva la pantalla inicial. Luego se recorren tres escenas con click o Enter; cada una muestra un titulo centrado y una bajada al pie.

El workflow del repo original vuelve a escuchar solo `main`. La publicacion de esta version usa otro repo de Pages para evitar pisar `https://aparinelli.github.io/prueba_camara/`.

## Pruebas

`tests/start_screen_test.sh` verifica resolucion, fuentes, texto, carga Latin, boton `Empezar`, animacion por letra, tres escenas, texto inferior, ausencia de la escena vieja y workflow sin `demo`. `tests/gh_pages_workflow_test.sh` conserva la cobertura del workflow.
