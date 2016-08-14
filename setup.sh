#!/bin/bash

set -euo pipefail

BASE_DIR=$(cd $(dirname $0);pwd)
cd ${BASE_DIR}

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  ln -s "${BASE_DIR}/${f}" ${HOME}/
done
