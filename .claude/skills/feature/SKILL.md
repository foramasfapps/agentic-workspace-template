---
name: feature
description: Guía del ciclo - detecta en qué fase está una funcionalidad por el estado de sus documentos y dice qué escribir a continuación, sin saltarse ninguna puerta. Sin argumento, muestra el estado de todas.
argument-hint: "[nombre-de-la-funcionalidad]"
disable-model-invocation: true
model: haiku
effort: low
---

# /feature · ¿Dónde estamos?

Los comandos del arnés (`/discover`, `/spec`…) se escriben **en el chat de Claude Code**, no en la terminal. Dilo siempre así al proponer el siguiente paso.

## Con argumento: `$ARGUMENTS`

Mira, en este orden, y quédate en la primera condición que se cumpla:

| Si… | Fase | Siguiente paso |
|---|---|---|
| No hay `docs/product/discovery/$ARGUMENTS.md` ni PRD | Sin empezar | `/discover $ARGUMENTS` |
| Discovery "Explorando" o "Devolución confirmada" | Discovery | Seguir con `/discover $ARGUMENTS` |
| Discovery "Listo para /spec" y no hay PRD | Spec | `/spec $ARGUMENTS` |
| PRD "Pendiente de G1" | **Puerta G1** | Que la persona revise y apruebe el PRD |
| PRD aprobado y no hay `docs/delivery/$ARGUMENTS/plan.md` | Diseño | `/design $ARGUMENTS` |
| Plan "Pendiente de G2" | **Puerta G2** | Que la persona resuelva las preguntas y apruebe |
| Plan aprobado y tareas `failing` o `blocked` sin PR | Construcción | `/build $ARGUMENTS` (retoma desde `progress.md`) |
| PR abierto | **Puerta G3** | Que la persona pruebe, lea `qa-report.md` y haga merge |
| PR fusionado y PRD sin "Implementado" | Cierre | `/close $ARGUMENTS` |
| PRD "Implementado" | Terminada | Nada |

Responde en 3 líneas: fase, qué falta y qué escribir en el chat (recomendando una sesión nueva o `/clear` si cambia de fase). Si hay bloqueos en `progress.md`, enuméralos con su opción recomendada.

**Una funcionalidad cada vez**: si otra está empezada y sin cerrar, dilo y recomienda terminarla antes (se construye y valida por spec).

**Nunca saltes una puerta**: G1, G2 y G3 necesitan la aprobación explícita de la persona.

## Sin argumento

Tabla con todas las funcionalidades (del mapa de `vision.md` y de las carpetas existentes): nombre, talla, fase y siguiente paso. Al final, la que recomiendas atacar y por qué (normalmente, la primera del mapa sin cerrar).
