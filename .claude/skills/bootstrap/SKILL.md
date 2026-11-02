---
name: bootstrap
description: Arranque de una app nueva creada desde la plantilla - entrevista exploratoria de visión, reglas de oro, mapa de funcionalidades pequeñas, arquitectura, puesta en marcha técnica y sistema de diseño, hasta la puerta G0.
disable-model-invocation: true
model: opus
effort: high
---

# /bootstrap · Arrancar una app (G0)

Conviertes este repositorio, recién creado desde la plantilla, en el punto de partida de una app concreta. Son tres bloques, con una pausa para la persona al final de cada uno. Retoma donde se quedó si ya hay partes hechas (mira el estado de cada documento). La línea de `CLAUDE.md` que dice "no rellenes nada" **no aplica durante `/bootstrap`**: rellenar la plantilla es justo este trabajo.

## Antes de empezar

- Comprueba que estás **dentro del repositorio clonado** (`git rev-parse --show-toplevel`) y que existe `.claude/settings.json`. Si no, para: los controles del arnés no estarían activos. Pide a la persona que abra Claude Code dentro del repositorio.
- Comprueba la identidad de git (`git config user.name` y `user.email`). Si falta, pídela antes del primer commit.
- Trabaja en una rama `chore/bootstrap`: `main` está protegida.

## Bloque 1 · Visión (entrevista exploratoria)

Es la base de todo, así que sin prisa. Sigue [../discover/interview-guide.md](../discover/interview-guide.md) en profundidad completa:

1. **Explorar**, con preguntas abiertas y una por mensaje: cómo es hoy, una historia real reciente, por qué le importa, qué cambiaría si la app existiera, cómo se la imagina ("ábrela: ¿qué ves?, ¿qué haces?"), qué sería éxito y qué no debe ser nunca. Repregunta y pide ejemplos. Si el encargo ya responde algo, confírmalo en vez de preguntarlo.
2. **Reflejar**: escribe "Lo que he entendido" en prosa (problema, usuarios, hoy, futuro deseado, cómo se lo imagina, éxito, qué no es) y corrígelo con la persona hasta que diga que es eso.
3. **Concretar** lo justo para el alcance del MVP.
4. **Desafiar**: qué se puede dejar fuera de la primera versión.

Con eso:

- Escribe `docs/product/vision.md` con sus palabras (las secciones que no aporten en esta app se marcan "No aplica").
- Propón las **reglas de oro** (invariantes no negociables) y rellena "Qué es la app" y las reglas en `CLAUDE.md`. Quita la línea que avisa de que es la plantilla.
- Propón el **mapa de funcionalidades** como **rebanadas pequeñas que se construyen y validan una a una**:
  - Cada una da algo que la persona puede **usar y probar** de principio a fin (no "la base de datos" o "las pantallas").
  - La primera es la versión más fina posible del recorrido principal.
  - Ninguna es L: si sale L, se parte.
  - Orden por valor y por dependencias, con su porqué.
- Primeras decisiones en `decisions.md`.

**Pausa**: presenta visión, reglas y mapa, y espera el ok.

## Bloque 2 · Arquitectura base

Hazlo tú en la conversación (o con el subagente **architect** si la persona prefiere no participar). Propón, con alternativas, una recomendación y en términos sencillos:

- Stack, librería de componentes y despliegue: **lo más sencillo que sirva** para el mapa de funcionalidades.
- Modelo de datos v0 en `docs/architecture/data-model.md`.
- Entornos: local para los agentes y, **si aplica**, base de datos local con datos semilla (nunca datos reales), vista previa para G3 y producción (solo la persona aplica migraciones).
- Tests por nivel, solo los que apliquen (unitario, integración, aceptación, e2e).
- Un ADR por cada decisión difícil de revertir.

Lo que no aplique en esta app (base de datos, migraciones, vista previa…) se escribe como **"No aplica" con su porqué**: es una decisión, no un olvido.

**Pausa**: presenta y espera el ok antes de crear código.

## Bloque 3 · Puesta en marcha técnica

1. Crea el proyecto con el stack aprobado.
2. Rellena `.claude/harness.json` (necesitarás la aprobación de la persona para editarlo):
   - `checks` (typecheck, lint, test sin `tests/acceptance/`, e2e de humo) y `acceptance` (cómo ejecutar archivos concretos con `{files}`).
   - `init`, y `production_command_patterns` si hay producción.
   - Lo que no aplique, `null`; nunca lo dejes en `""`.
3. Convierte en comprobaciones de `scripts/check-invariants.sh` las reglas de oro que se puedan comprobar con un script, y **prueba cada una con un incumplimiento temporal** para ver que salta (luego deshazlo).
4. Rellena la preparación del stack en `.github/workflows/ci.yml`.
5. Añade reglas por carpeta en `.claude/rules/` para las partes críticas, con `paths:`.
6. Completa los comandos de `CLAUDE.md`.
7. `scripts/test-harness.sh` y `scripts/check.sh` en verde.
8. Dale a la persona, paso a paso, lo que tiene que hacer fuera de aquí: proteger `main` en GitHub (exigir PR y el check `check`), vistas previas si aplica, secretos.
9. Ejecuta `/design-system` (o pide a la persona que lo escriba en el chat si no puedes lanzarlo).
10. Un "hola mundo" en el PR de `chore/bootstrap` con la CI en verde y, si aplica, vista previa desplegada.

## Al final (G0)

- Resumen de 5 líneas y "¿G0 aprobado?". **G0 exige la CI terminada en verde**; si sigue en curso, espera.
- Al aprobar, marca visión, arquitectura y sistema de diseño como `Aprobado (dd-mm-aaaa)` en el PR. **El merge del PR cierra G0.**
- Termina con: "Cuando hagas el merge, abre una sesión nueva (o `/clear`) y escribe **en este chat** `/feature` para empezar por la primera funcionalidad del mapa."
