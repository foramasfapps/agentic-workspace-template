# Guía de entrevista de UX

La usa `/design` (y `/design-system` para la parte global). La conversación con la persona la lleva la sesión principal; el subagente `ux-designer` recibe el resultado como **brief**. Lo que diga la persona es **información de entrada, no ley**: el diseño puede proponer otra cosa, siempre explicando por qué.

## 1 · Explorar cómo se lo imagina (abierta, una pregunta por mensaje)

| Tema | Preguntas que abren |
|---|---|
| Recorrido | "Cuéntame cómo lo usarías, paso a paso, la primera vez y un día normal." |
| Organización | "¿Cómo agruparías esta información? ¿Dónde esperarías encontrarla dentro de la app?" |
| Lo primero | "Al abrir esta pantalla, ¿qué tiene que saltar a la vista? ¿Qué decisión vas a tomar con ella?" |
| Referencias | "¿Hay alguna app o web que haga algo parecido y te guste? ¿Qué te gusta exactamente?" |
| Contexto de uso | "¿Desde dónde lo usarás (móvil, ordenador), con qué frecuencia y con cuánta prisa?" |
| Lo que no | "¿Algo que te moleste de otras apps y no quieras ver aquí?" |

Repregunta sobre lo que responda y pide ejemplos. Si dibuja o describe una pantalla, apúntala tal cual.

## 2 · Preguntas concretas sacadas de la spec (cerradas, con opción recomendada)

Recorre las historias y los CA del PRD y pregunta solo lo que el diseño necesita decidir y la spec no resuelve. Ejemplos de tipo:

- **Dónde vive**: ¿sección propia, dentro de otra pantalla o en un panel?
- **Acción principal** de cada pantalla, y qué acciones quedan en segundo plano.
- **Qué se muestra primero** y qué se esconde tras un "ver más".
- **Densidad**: lista compacta o tarjetas; resumen o detalle.
- **Estados**: qué ver cuando no hay datos, cuando algo falla, cuando falta un dato externo.
- **Confirmaciones**: qué acciones piden confirmación y cuáles se pueden deshacer.
- **Formularios**: en página propia, en un diálogo o en la propia fila.

Como mucho 4 por bloque, con la opción recomendada primero y su porqué.

## 3 · Devolución y propuesta

Resume en un **brief de UX** lo entendido y propón la **arquitectura de información** (secciones, navegación y lugar de esta funcionalidad), con **una alternativa** y sus pros y contras cuando la idea de la persona tenga inconvenientes. La persona elige antes de que se hagan los bocetos.

## Brief resultante (`docs/design/<feature>/ux-brief.md`)

```markdown
# Brief de UX – <funcionalidad>
> Fecha · Estado: Confirmado

## Cómo se lo imagina la persona (con sus palabras)
## Referencias y qué tomar de cada una
## Contexto de uso (dispositivos, frecuencia, prisa)
## Arquitectura de información elegida (y alternativa descartada, con su porqué)
## Decisiones concretas (dónde vive, acción principal, densidad, estados, confirmaciones)
## Libertades del diseñador (lo que la persona deja a su criterio)
```

## Profundidad según la talla

| Talla | Entrevista |
|---|---|
| S sin pantallas nuevas | No hay |
| S o M que reutiliza patrones | Solo el bloque 2, breve |
| M con pantallas nuevas, L | Los tres bloques |
