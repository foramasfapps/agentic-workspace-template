# Guía de entrevista de producto

La usan `/bootstrap` (visión de la app) y `/discover` (una funcionalidad). El objetivo no es rellenar una plantilla: es **entender el problema y cómo se imagina la persona la solución**, hasta poder contárselo mejor de lo que lo contaría ella.

## Cuatro fases, en este orden

### 1 · Explorar (abierta)

Preguntas abiertas, **una por mensaje**, y repreguntas sobre lo que responde. **Nada de opción múltiple en esta fase**: las opciones cierran la conversación antes de entender.

Temas, en el orden que salgan con naturalidad:

| Tema | Preguntas que abren |
|---|---|
| Contexto | "Cuéntame cómo es hoy… ¿cómo lo haces ahora?" |
| Historia concreta | "Cuéntame la última vez que te pasó. ¿Qué hiciste? ¿Qué fue lo más molesto?" |
| Problema de fondo | "¿Por qué es importante para ti?" (repregunta "¿por qué?" hasta llegar a la motivación) |
| Resultado esperado | "Si esto funcionara perfecto, ¿qué sería distinto en tu día a día?" |
| Cómo se lo imagina | "Imagina que ya existe. Ábrelo: ¿qué es lo primero que ves? ¿Qué haces después?" |
| Éxito | "¿Cómo sabrías dentro de tres meses que ha merecido la pena?" |
| Límites | "¿Qué no debería hacer nunca? ¿Qué te daría miedo que pasara?" |

Técnicas:

- **Repregunta** antes de cambiar de tema: "¿Por ejemplo?", "¿Qué quieres decir con…?", "¿Y entonces qué pasó?".
- **Pide ejemplos reales con cifras**, no opiniones genéricas.
- **Usa sus palabras.** Apunta frases literales: son la mejor fuente para nombrar cosas en la app.
- **No propongas soluciones todavía.** Si la persona propone una, pregunta qué problema resuelve.
- **Reformula cada 3 o 4 respuestas**: "Lo que entiendo es que…, ¿es así?".

### 2 · Reflejar (devolución)

Antes de entrar en detalles, escribe y enseña **"Lo que he entendido"**, en prosa y en unas 10–15 líneas: problema, para quién, cómo es hoy, qué quiere conseguir, cómo se imagina la solución, qué sería éxito y qué no es. Pide que lo corrija. **Repite hasta que diga que es eso.** Sin esta confirmación no se pasa a la fase 3.

### 3 · Concretar (cerrada)

Ahora sí: reglas, límites, casos límite, datos y permisos. Aquí valen las preguntas de opción múltiple (hasta 4 por bloque), con la **opción recomendada primero** y su porqué. Confirma reglas con ejemplos de cifras ("si hay 100 y se añaden 30, ¿se ven 130?").

### 4 · Desafiar

Haz de challenger: propone simplificaciones, señala contradicciones con lo ya decidido (cita el ID) y riesgos. Pregunta qué se puede dejar fuera de la primera versión.

## Profundidad según el caso

| Caso | Explorar | Concretar |
|---|---|---|
| Visión de una app (`/bootstrap`) | A fondo: es la base de todo | Solo lo necesario para el mapa de funcionalidades |
| Funcionalidad L o con problema nuevo | A fondo | Completo |
| Funcionalidad M | Breve, centrado en cómo se la imagina | Completo |
| Funcionalidad S | Se salta (basta con la devolución en 3 líneas) | Solo reglas y casos límite |

Si el encargo o `vision.md` ya responde algo, no lo vuelvas a preguntar: confírmalo en la devolución.

## Errores que hay que evitar

- Empezar con opciones cerradas o con un formulario de preguntas.
- Varias preguntas abiertas en el mismo mensaje.
- Quedarse con la primera respuesta sin repreguntar.
- Rellenar huecos con suposiciones en vez de preguntar.
- Preguntas que sugieren la respuesta ("¿verdad que sería útil…?").
- Pasar a la spec sin la devolución confirmada.
