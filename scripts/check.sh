#!/usr/bin/env bash
# Comprueba todo: tipos, lint, tests, e2e, tests de aceptación de las tareas terminadas e invariantes.
# Lo usan el hook Stop, la CI y las personas. Los comandos viven en .claude/harness.json:
#   ""   = sin configurar (se avisa)     null = no aplica en esta app (no se avisa)
# Los tests de aceptación de tareas sin terminar están en rojo a propósito y no se ejecutan aquí.
# Sale con 0 si todo pasa y con 2 si algo falla.
set -u
cd "$(dirname "$0")/.." || exit 2
export CLAUDE_PROJECT_DIR="$(pwd)"
cfg() { python3 .claude/hooks/harness_config.py "$1"; }

failed=0
run() { # run <nombre> <comando>
  echo "▶ $1: $2"
  if ! bash -c "$2"; then
    echo "✗ $1 ha fallado"
    failed=1
  fi
}

for name in typecheck lint test e2e; do
  cmd="$(cfg "checks.$name")"
  case "$cmd" in
    __null__) ;;
    "") echo "· $name: sin configurar (rellena checks.$name en .claude/harness.json, o pon null si no aplica)" ;;
    *) run "$name" "$cmd" ;;
  esac
done

for level in unit integration e2e; do
  files="$(python3 .claude/hooks/acceptance_files.py "$level")" || { failed=1; continue; }
  [ -z "$files" ] && continue
  cmd="$(cfg "acceptance.$level")"
  case "$cmd" in
    __null__|"") echo "✗ aceptación $level: hay tests de tareas terminadas pero acceptance.$level no está configurado"; failed=1 ;;
    *) run "aceptación $level" "${cmd//\{files\}/$files}" ;;
  esac
done

run "invariantes" "scripts/check-invariants.sh"

if [ "$failed" -ne 0 ]; then
  exit 2
fi
echo "✓ todo en verde"
