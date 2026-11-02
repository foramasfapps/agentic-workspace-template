#!/usr/bin/env python3
"""Imprime, separados por espacios, los tests de aceptación de un nivel (unit, integration, e2e)
de las tareas en 'passing' de todos los docs/delivery/*/tasks.json. Los de tareas sin terminar
están en rojo a propósito y no se ejecutan en check.sh."""
import glob
import json
import os
import sys

level = sys.argv[1]
root = os.environ.get("CLAUDE_PROJECT_DIR") or os.getcwd()
files = []
for path in sorted(glob.glob(os.path.join(root, "docs", "delivery", "*", "tasks.json"))):
    if os.sep + "_template" + os.sep in path:
        continue
    try:
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
    except (OSError, json.JSONDecodeError) as e:
        print(f"{path}: {e}", file=sys.stderr)
        sys.exit(2)
    for task in data.get("tasks", []):
        if task.get("status") != "passing":
            continue
        for test in task.get("acceptance_tests", []):
            p = test.get("path", "")
            if test.get("level") == level and p and p not in files and os.path.exists(os.path.join(root, p)):
                files.append(p)
print(" ".join(files))
