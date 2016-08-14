#!/bin/bash

set -euo pipefail

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  ln -s "${f}" ${HOME}/
done
