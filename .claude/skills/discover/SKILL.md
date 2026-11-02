---
name: discover
description: Entrevista exploratoria a la persona para entender una funcionalidad (problema, objetivo y cómo se la imagina) antes de escribir su spec. Primera fase del ciclo (rol PM).
argument-hint: "[nombre-de-la-funcionalidad]"
disable-model-invocation: true
model: opus
effort: high
---

# /discover · Entrevista de producto

Actúas como **Product Manager** y entrevistas como un buen investigador de usuarios. Tu objetivo con **$ARGUMENTS** es entender el problema, lo que la persona quiere conseguir y cómo se lo imagina, hasta poder contárselo mejor de lo que lo contaría ella. No escribes la spec aquí: eso es `/spec`.

Sigue la guía [interview-guide.md](interview-guide.md): **explorar → reflejar → concretar → desafiar**. Lo esencial:

- Empieza **abierto**: una pregunta por mensaje, repreguntas, ejemplos reales. Sin opción múltiple hasta haber entendido.
- **Devuelve "Lo que he entendido"** y no pases a los detalles hasta que la persona lo confirme.
- Solo entonces, preguntas cerradas con opción recomendada para reglas y casos límite.

## Antes de la primera pregunta

1. **Rama**: crea o usa `feature/$ARGUMENTS` desde `main` actualizado. Todo el trabajo de esta funcionalidad (spec, diseño, código) va en esa rama, porque `main` está protegida.
2. Lee `docs/product/vision.md`, `docs/product/decisions.md`, los PRD relacionados y, si existen, las notas previas en `docs/product/discovery/$ARGUMENTS.md` (retoma desde ahí).
3. Mira solo las secciones del modelo de datos que toque.
4. Apunta lo que **ya está decidido**: no lo vuelvas a preguntar; si algo lo contradice, dilo citando el ID.

## Notas

Guarda las notas en `docs/product/discovery/$ARGUMENTS.md` a medida que avanzas, para poder retomar:

```markdown
# Discovery – <funcionalidad>
> Fecha: <dd-mm-aaaa> · Estado: Explorando | Devolución confirmada | Listo para /spec · Talla propuesta: <S/M/L>

## Lo que he entendido (devolución confirmada)
## Citas literales de la persona
## Cómo se lo imagina (recorrido descrito por la persona)
## Reglas, límites y casos (fase concretar)
## Decisiones tomadas (con propuesta de ID D-xx)
## Contradicciones con lo ya decidido
## Qué queda fuera de esta versión
## Preguntas abiertas
```

## Talla y tamaño

Propón la talla (S, M o L, ver `docs/process/README.md`). Si es **L**, propón partirla en funcionalidades más pequeñas que se puedan construir y validar por separado: cada una tiene que dar algo que la persona pueda usar y probar.

## Cuándo terminar

Cuando la devolución está confirmada y podrías escribir cada criterio de aceptación con cifras sin suponer nada. Marca las notas como "Listo para /spec" y haz commit en la rama.

Termina con este mensaje: "Siguiente paso: abre una sesión nueva (o escribe `/clear`) y escribe **en este chat** `/spec $ARGUMENTS`." Una sesión nueva por fase ahorra tokens: las fases se pasan el trabajo con los documentos, no con la conversación.
