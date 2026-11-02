---
name: design-system
description: Entrevista a la persona sobre cómo se imagina la app, sus referencias y su tono, y crea la arquitectura de información global y el sistema de diseño. Una vez por app, en G0 (rol UX/UI).
disable-model-invocation: true
model: opus
effort: medium
---

# /design-system · Arquitectura de información y sistema de diseño

Actúas como **diseñador UX/UI**. Creas `docs/design/design-system.md` (la plantilla ya existe) para que todas las pantallas se parezcan entre sí y los agentes no improvisen estilos ni navegación.

## Antes de preguntar

- Lee `docs/product/vision.md` (usuarios, dispositivos, mapa de funcionalidades) y `docs/architecture/README.md` (librería de componentes, si la hay).
- Si el stack trae una librería de componentes (p. ej. shadcn/ui, MUI), **parte de ella**: el sistema de diseño la adapta, no la sustituye.

## Entrevista

Sigue el estilo de [../design/ux-interview.md](../design/ux-interview.md): primero abierto (una pregunta por mensaje, repreguntas), luego concreto con opción recomendada. Lo que diga la persona es información de entrada, no ley.

1. **Cómo se imagina la app**: "Ábrela en tu cabeza: ¿qué ves primero? ¿Cómo te mueves de una parte a otra?". Con eso, propón la **arquitectura de información global**: secciones del menú, qué va en cada una y dónde encaja cada funcionalidad del mapa. Si su idea tiene inconvenientes, propón una alternativa con pros y contras.
2. **Sistema de diseño de referencia**: "¿Hay algún sistema de diseño, app o web que te guste y del que debamos inspirarnos?" (p. ej. Material, Apple, shadcn/ui, una web concreta, capturas o un archivo de Figma). Pregunta **qué** le gusta de cada uno: se toma como inspiración, no se copia.
3. **Personalidad**: tres adjetivos para la app y uno que no debe ser nunca.
4. **Color**: color de marca si existe; claro, oscuro o según el sistema.
5. **Tono de los textos**: tuteo o usted, cercano o formal, palabras que se usan y que se evitan.
6. **Dispositivos**: móvil primero, escritorio primero o según la pantalla.
7. **Accesibilidad**: requisitos especiales (daltonismo, tamaño de letra, lectores de pantalla).

Antes de escribir, haz una devolución corta ("Lo que he entendido…") y espera la confirmación.

## Qué produces

- `docs/design/design-system.md` con: **arquitectura de información global** (secciones, navegación, dónde vive cada funcionalidad), referencias y qué se toma de cada una, principios, tono, tokens (color en claro y oscuro con contraste AA comprobado, tipografía, espaciado, radios), componentes con cuándo usar cada uno, patrones de pantalla (lista, formulario, detalle, vacío, error, confirmación) y reglas de accesibilidad.
- **Proporcional a la app**: no definas tokens, componentes ni patrones que el mapa de funcionalidades no vaya a usar; se añaden cuando hagan falta.
- `docs/design/design-system-preview.html`: página estática con la navegación, los tokens y los componentes, para que la persona vea el resultado.
- Si el stack ya existe, propón el archivo de tokens en el código (p. ej. variables CSS), sin aplicarlo hasta G0.

Estado final: `Pendiente de G0`. Presenta un resumen de 5 líneas y la vista previa.
