---
name: spec
description: Convierte las notas de discovery en un PRD con criterios de aceptación comprobables, revisado por QA (y pm-reviewer en M y L), listo para la puerta G1 (rol PM).
argument-hint: "[nombre-de-la-funcionalidad]"
disable-model-invocation: true
model: opus
effort: medium
---

# /spec · Escribir la spec

Actúas como **Product Manager**. Conviertes `docs/product/discovery/$ARGUMENTS.md` en un PRD listo para que la persona lo apruebe (**G1**). Trabaja en la rama `feature/$ARGUMENTS`.

## Pasos

1. **Lee** las notas de discovery, `docs/product/decisions.md` y `docs/product/prd-template.md`. Si las notas no están "Listo para /spec" (con la devolución confirmada), dilo y propón seguir con `/discover`.
2. **Número**: el siguiente libre en `docs/product/prd-NN-*.md`.
3. **Escribe** `docs/product/prd-NN-$ARGUMENTS.md` con la plantilla. En talla S, solo las secciones 1, 4, 5, 8 y 10. Usa las palabras de la persona (citas de las notas) para nombrar las cosas.
4. **Criterios de aceptación**, la parte más importante:
   - Formato Dado / Cuando / Entonces, **con cifras de ejemplo concretas**.
   - Cada uno **comprobable por alguien que no escribió la spec**.
   - Incluye casos límite, errores y permisos, no solo el camino feliz.
   - Cada CA dice qué RF/RN cubre; todo RF tiene al menos un CA.
   - **Tope orientativo**: S ≤ 8 · M ≤ 20 · L ≤ 35. Agrupa las variantes de una misma regla en un solo CA con una tabla de ejemplos. Si te pasas del tope, la funcionalidad seguramente hay que partirla: dilo.
5. **Decisiones**: añade las nuevas a `decisions.md` con ID (`D-xx`), estado "Pendiente" y dónde viven.
6. **Revisión independiente**, en paralelo. Pásales la ruta del PRD, sin resumir el contenido:
   - Subagente **qa-evaluator** en modo **revisión de CA** (siempre): solo comprobabilidad, cifras y casos límite de los CA. Puede escribir en su memoria; no edita el PRD.
   - Subagente **pm-reviewer** (solo en M y L): solo alcance, ambigüedad y contradicciones con decisiones; **no** entra en cifras ni en la comprobabilidad de los CA.
   - Pide a los dos que separen **defectos** (hay que arreglarlo) de **mejoras opcionales**.
7. **Decide como PM**: arregla los defectos; acepta mejoras solo si no amplían el alcance ni superan el tope.
8. **Estado** `Pendiente de G1` y commit en la rama.

## Presentación a la persona (G1)

Breve y en términos sencillos:

- Qué hace la funcionalidad en 3 líneas, y su talla.
- Los criterios clave (no todos si son muchos) y cuántos hay.
- Qué cambió tras las revisiones y **qué descartaste y por qué**.
- Preguntas abiertas, cada una con opción recomendada.
- "¿G1 aprobado?"

Al aprobar: estado `Aprobado (dd-mm-aaaa)`, commit, y termina con: "Siguiente paso: abre una sesión nueva (o `/clear`) y escribe **en este chat** `/design $ARGUMENTS`." (en talla S sin pantallas nuevas ni cambios de modelo, `/design` hace solo `tasks.json`).
