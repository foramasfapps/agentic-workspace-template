---
name: design
description: Fase de diseño y plan de una funcionalidad con el PRD aprobado - entrevista de UX con la persona, bocetos (ux-designer) y plan con tareas (architect), hasta la puerta G2.
argument-hint: "[nombre-de-la-funcionalidad]"
disable-model-invocation: true
model: opus
effort: medium
---

# /design · Diseño y plan

Orquestas la fase entre G1 y G2 para **$ARGUMENTS**, en la rama `feature/$ARGUMENTS`.

## Antes de empezar

- Comprueba que `docs/product/prd-*-$ARGUMENTS.md` está `Aprobado`. Si no, para y propón `/spec $ARGUMENTS`.
- Lee la talla del PRD y si tiene pantallas nuevas.

## Paso 1 · Entrevista de UX (en esta conversación, con la persona)

Sigue [ux-interview.md](ux-interview.md) según la talla: explorar cómo se lo imagina, preguntas concretas sacadas de la spec y propuesta de arquitectura de información. Lo que diga la persona es información de entrada, no ley. Guarda el resultado en `docs/design/$ARGUMENTS/ux-brief.md` y confírmalo con la persona antes de seguir.

## Paso 2 · Diseño y plan, en paralelo

Pásales rutas, no resúmenes:

| Talla | ux-designer | architect |
|---|---|---|
| S | No se lanza | Modelo `sonnet`, esfuerzo `low`: solo `tasks.json` y contradicciones que impidan construir |
| M | Brief + `flows.md` + `states.md`; bocetos solo de pantallas nuevas | Modelo `sonnet`, esfuerzo `medium` |
| L | Completo, con bocetos | Modelo `opus`, esfuerzo `high` |

Al arquitecto, recuérdale: las contradicciones que son **detalles de redacción** no van en la lista; se arreglan o se ignoran.

## Paso 3 · Clasificar las dudas

Junta las dudas de los dos, sin duplicados, y clasifícalas:

- **Decididas por defecto**: tienen una respuesta razonable y de poco impacto. Aplícala, y lístalas en una línea cada una para que la persona pueda revertirlas.
- **Para la persona**: cambian lo que se construye, el alcance o algo difícil de deshacer. Solo estas se preguntan.

Si una respuesta cambia el diseño o el plan, pide el ajuste al agente correspondiente antes de presentar.

## Presentación a la persona (G2)

1. Qué se va a construir y en cuántas tareas.
2. Bocetos o estados clave (rutas en `docs/design/$ARGUMENTS/`).
3. **Puntos de validación**: propón en qué tareas parar para que la persona pruebe lo construido antes de seguir (en M y L, al menos uno cuando haya un primer recorrido usable; se marcan con `"checkpoint": true` en `tasks.json`).
4. Preguntas para la persona, numeradas, con opción recomendada. Después, las decididas por defecto.
5. "¿G2 aprobado?"

## Al aprobar

- Aplica las respuestas a `plan.md`, `tasks.json` y al diseño (si cambian el PRD, actualízalo con una sección "Cambios en la vX.Y").
- Marca plan, diseño y `tasks.json` (`"approved": "dd-mm-aaaa"`) como aprobados, y los ADR como "Aprobado".
- **Commit** de todo en la rama antes de construir.
- Termina con: "Siguiente paso: abre una sesión nueva (o `/clear`) y escribe **en este chat** `/build $ARGUMENTS`. Es la fase larga: mejor en una sesión en la nube."
