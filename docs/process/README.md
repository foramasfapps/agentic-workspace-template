# Cómo trabajamos

Este proyecto se construye con un **arnés agéntico**: varios agentes de Claude Code con roles distintos, que se pasan el trabajo mediante documentos y que están vigilados por controles automáticos. Tú decides en cuatro momentos; el resto lo hacen ellos.

## La idea en tres capas

| Capa | Qué es | Ejemplo |
|---|---|---|
| **Documentos** | La memoria compartida. Lo que no está escrito, no existe para los agentes | El PRD, el plan, la lista de tareas |
| **Agentes** | Roles con su propia tarea, herramientas y memoria | El PM que te entrevista; el QA que intenta romper lo construido |
| **Controles** | Reglas que se cumplen siempre, decida lo que decida el modelo | No se puede terminar un turno con tests en rojo; nadie toca la base de datos de producción |

Por qué tres capas: las instrucciones escritas (como `CLAUDE.md`) son **consejos** que el modelo suele seguir; los controles son **obligatorios**. Lo que no admite excepciones va en controles.

## Los roles

| Rol | Qué hace | Qué no hace |
|---|---|---|
| **PM** (Product Manager) | Te entrevista, escribe la spec (PRD) con criterios de aceptación y lleva el registro de decisiones | Decidir por ti |
| **UX/UI** | Diseña recorridos, estados y bocetos de cada pantalla antes de programar; luego compara lo construido con los bocetos | Programar |
| **Arquitecto** | Cruza la spec con el modelo de datos y el código, detecta contradicciones, escribe el plan y la lista de tareas; guarda la coherencia | Editar el código |
| **Developer** | Construye una tarea cada vez, con tests, en su rama | Cambiar la spec o los tests de aceptación |
| **QA** | Revisa que los criterios se puedan comprobar, escribe los tests de aceptación antes del código y verifica al final, en el código y en la app | Editar el código de la app; aprobar por buena voluntad |

Principio central: **quien hace no evalúa**. Un agente que revisa su propio trabajo tiende a aprobarlo.

## Las fases y sus puertas

```text
G0  /bootstrap (una vez por app)    visión, reglas de oro, stack, sistema de diseño   ✋ apruebas

Por cada funcionalidad:
    /discover + /spec    PM te entrevista; QA revisa los criterios    → PRD                 ✋ G1
    /design              Entrevista UX → UX y Arquitecto en paralelo  → diseño, plan, tareas ✋ G2
    /build               QA escribe tests → Developer → QA verifica   → PR + informe QA     ✋ G3
                         (para en los puntos de validación para que pruebes)
    /close               PM y Arquitecto ponen al día la documentación y las lecciones
```

| Puerta | Qué apruebas |
|---|---|
| **G0** | Que la visión, las reglas de oro y el stack son los correctos |
| **G1** | Que la spec describe lo que quieres, con ejemplos concretos |
| **G2** | Los bocetos, y las dudas y contradicciones (te llegan todas juntas, con una opción recomendada) |
| **G3** | El resultado: lo pruebas en la vista previa, lees el informe de QA y haces el merge |

Entre G2 y G3 los agentes trabajan solos, salvo en los **puntos de validación** que apruebas en G2: ahí paran para que pruebes lo construido. Los agentes **nunca** hacen merge.

## Una funcionalidad cada vez

El mapa de funcionalidades de `vision.md` está hecho de **rebanadas pequeñas**: cada una da algo que puedes usar y probar de principio a fin. Se construye una, la validas (en sus puntos de validación y en G3) y solo entonces se empieza la siguiente. Nunca se construye la app entera para enseñarla al final.

## Las entrevistas

El PM (`/bootstrap`, `/discover`) y UX (`/design`, `/design-system`) **conversan** antes de concretar: primero preguntas abiertas para entender el problema y cómo te lo imaginas, después una devolución ("lo que he entendido") que tú corriges, y solo entonces preguntas cerradas para los detalles. Lo que propones sobre organización o pantallas es información de entrada, no ley: el diseño puede proponer otra cosa explicando por qué.

## Tallas

No todo merece el proceso completo. En `/discover` el PM propone una talla y tú la confirmas. Una funcionalidad L se parte antes de empezar.

| | S | M | L (se parte) |
|---|---|---|---|
| Ejemplo | Un campo, un texto, un fallo pequeño | Una pantalla o un recorrido nuevo | Un módulo con modelo de datos nuevo y varias pantallas |
| Entrevista de producto | Solo reglas y casos límite | Breve exploración + detalles | A fondo |
| Criterios de aceptación (tope orientativo) | ≤ 8 | ≤ 20 | ≤ 35 |
| Revisión de la spec | QA | QA + pm-reviewer | QA + pm-reviewer |
| UX | Nada (o solo estados) | Entrevista breve, recorridos y estados; bocetos solo de pantallas nuevas | Entrevista completa y bocetos |
| Arquitecto | Modelo medio, solo tareas | Modelo medio | Modelo grande |
| Puntos de validación en `/build` | No | Al menos uno | Varios |
| Verificaciones de QA | Al final | Una a mitad y otra al final | Cada 4 tareas y al final |
| Revisión visual y de coherencia | No | Coherencia | Las dos |

## Modelos y sesiones

El mayor gasto del ensayo fue la conversación principal releyendo un historial cada vez más largo, no los subagentes. Por eso:

- **Una sesión nueva (o `/clear`) por fase.** Cada fase lee los documentos que necesita y nada más.
- **Cada fase usa el modelo que necesita**, fijado en su skill:

| Fase | Modelo | Por qué |
|---|---|---|
| `/bootstrap`, `/discover`, `/spec`, `/design`, `/design-system` | Grande | Conversar contigo y entender bien es lo que más valor aporta |
| `/build` (orquestación) | Medio | Coordina y comprueba; no escribe código ni lee diffs |
| `/close` | Medio | Ordenar documentación |
| `/feature` | Pequeño | Solo mira estados |
| Developer | Medio (grande en tareas difíciles) | |
| QA | Medio (grande en la verificación final de M y L) | |
| Arquitecto | Medio (grande en L) | |
| Revisores (`pm-reviewer`, `ui-reviewer`) | Medio | |

## Dónde vive cada cosa

| Carpeta | Contenido |
|---|---|
| `docs/process/` | Este documento, los controles, las lecciones aprendidas y el playbook |
| `docs/product/` | Visión, registro de decisiones, notas de entrevistas (`discovery/`) y PRD |
| `docs/design/` | Sistema de diseño y, por funcionalidad, recorridos, estados y bocetos |
| `docs/architecture/` | Arquitectura, modelo de datos y decisiones técnicas difíciles de revertir (ADR) |
| `docs/delivery/<feature>/` | Plan, lista de tareas (`tasks.json`), progreso e informe de QA |
| `.claude/` | Agentes, skills (procedimientos), reglas por carpeta y controles |

## Cómo se mantiene bajo el consumo

Lo que más gasta es rehacer. Por eso: criterios revisados antes de programar, comprobaciones automáticas en lugar de revisiones del modelo, ceremonia según la talla, contexto corto y el modelo justo para cada rol. En cada cierre se anotan el consumo y los fallos que se escaparon; si un recorte hace subir los fallos, se deshace. Detalle en el [playbook](playbook.md), sección 1.9.
