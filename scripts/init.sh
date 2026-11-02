#!/usr/bin/env bash
# Arranca el entorno local: la app y, si la hay, una base de datos local con datos semilla, nunca producción.
# Se puede ejecutar varias veces sin romper nada. El comando vive en .claude/harness.json (init).
set -u
cd "$(dirname "$0")/.." || exit 1
cmd="$(python3 .claude/hooks/harness_config.py init)"
case "$cmd" in
  __null__) exit 0 ;;
  "") echo "· init sin configurar (rellena 'init' en .claude/harness.json en /bootstrap, o pon null)."; exit 0 ;;
esac
echo "▶ $cmd"
bash -c "$cmd"
