---
name: build
description: Construcción de una funcionalidad con plan aprobado. QA escribe los tests de aceptación, el developer resuelve las tareas una a una, se para en los puntos de validación para que la persona pruebe, QA verifica y se abre un PR para la puerta G3. Nunca hace merge.
argument-hint: "[nombre-de-la-funcionalidad]"
disable-model-invocation: true
model: sonnet
effort: medium
---

# /build · Construcción

Orquestas la construcción de **$ARGUMENTS** hasta dejar un PR listo para **G3**, parando en los puntos de validación que la persona aprobó en G2. Tú no programas: coordinas subagentes y compruebas.

## Disciplina de contexto (es lo que más tokens ahorra)

- **No leas código, diffs ni informes completos**: eso lo hacen los subagentes. Tú miras `tasks.json`, la salida de `scripts/check.sh` y los resúmenes que te devuelven.
- Pide a cada subagente que responda en **5 líneas como mucho**.
- Pásales el nombre de la funcionalidad y el id de la tarea; ellos leen los archivos.

## Requisitos (si falta algo, para y dilo)

- Rama `feature/$ARGUMENTS` con los documentos aprobados ya en un commit, y `tasks.json` con `"approved"` relleno (G2).
- `.claude/harness.json` con `checks.test` y los comandos de `acceptance` de los niveles que use `tasks.json` (o `null` si no aplican).

## Límites

- Como mucho **3 vueltas** developer ⇄ QA y **3 invocaciones del developer** por tarea; después, la tarea queda `blocked`.
- Si más de un tercio de las tareas quedan bloqueadas, **para**: es un problema de spec o de plan, no de código.

## Pasos

1. **Rama y entorno**: cámbiate a `feature/$ARGUMENTS` y lee `progress.md` para retomar si ya se empezó. `scripts/init.sh` y `scripts/check.sh`; si ya falla antes de empezar, para y dilo.
2. **Tests de aceptación** (si `tasks.json` aún no los tiene): subagente **qa-evaluator** en modo **tests de aceptación**. Comprueba que están anotados en `tasks.json` y que, ejecutados aparte, fallan. `check.sh` debe seguir en verde: no ejecuta los de tareas sin terminar. Commit: `test: tests de aceptación de $ARGUMENTS`.
3. **Tareas**, en orden de dependencias, solo las `failing`:
   - Subagente **developer** con la funcionalidad y el id de la tarea. Con `"difficulty": "hard"`, lánzalo con el modelo `opus` y esfuerzo alto.
   - Al volver, **comprueba**: `scripts/check.sh` en verde (ya incluye los tests de aceptación de las tareas en `passing` y la suite e2e configurada), el estado en `tasks.json` y que hay commit. Si algo no cuadra, la tarea vuelve a `failing` con una nota.
   - Si queda `blocked`, sigue con las tareas que no dependan de ella.
4. **Punto de validación** (tarea con `"checkpoint": true` terminada): para. Haz push de la rama, explica a la persona en 3–5 pasos cómo probar lo construido (vista previa o local, con datos de ejemplo) y espera su respuesta. Si pide cambios dentro del alcance, conviértelos en notas para el developer; si cambian la spec, apúntalos como bloqueo y vuelve a G1 o G2.
5. **Verificación de QA**, subagente **qa-evaluator** en modo **verificación final**, según la talla:

   | Talla | Verificaciones | Modelo para QA |
   |---|---|---|
   | S | Solo al final | `sonnet` |
   | M | Una a mitad (o en el primer punto de validación) y otra al final | `opus` al final |
   | L | Cada 4 tareas y al final | `opus` |

   Cada fallo devuelve su tarea a `failing` y el developer la retoma con el fallo concreto.
6. **Revisión visual** (solo talla L, o pantallas nuevas que la persona pidió revisar): subagente **ui-reviewer**. Lo de gravedad alta vuelve al developer.
7. **Coherencia** (M y L): subagente **architect** en modo **revisar coherencia** sobre `git diff main...HEAD`. Lo de gravedad alta vuelve al developer.
8. **Comprobación final**: `scripts/check.sh` en verde y `qa-report.md` actualizado.
9. **PR**: `git push -u origin feature/$ARGUMENTS` y abre un PR hacia `main` (con `gh`, con la herramienta de GitHub disponible o, si no hay, deja el texto en `docs/delivery/$ARGUMENTS/pr.md`). Si el repositorio tiene plantilla de PR, úsala. Contenido: qué hace (enlace al PRD) y talla, tabla de CA con su resultado, bloqueos y cómo probarlo paso a paso.
10. **Nunca hagas merge** ni marques el PR como aprobado.

## Al terminar, a la persona (G3)

Breve: enlace al PR, CA que pasan y fallan, bloqueos que necesitan una decisión suya (con opción recomendada) y los 3–5 pasos para probarlo. Termina con: "Cuando hagas el merge, abre una sesión nueva (o `/clear`) y escribe **en este chat** `/close $ARGUMENTS`."
