#!/bin/bash
set -e

# Видаляємо server.pid, якщо він залишився від попереднього запуску
rm -f /app/tmp/pids/server.pid

# Виконуємо головний процес контейнера (CMD)
exec "$@"