#!/bin/sh

# script/_lint: Run our code linters
# This should be run within the docker container, not on your on laptop

set -e

cd "$(dirname "$0")/.."

if [ "$LINT_ALL" = "true" ]; then
  git config --global http.proxy http://kraken02.oit.umn.edu:3128
  git config --global https.proxy https://kraken02.oit.umn.edu:3128
  echo "==> Checking Gems..."
  bundle audit check --update
  echo "==> Running Brakeman..."
  brakeman
  echo "==> Running Reek..."
  reek
  echo "==> Running Standard..."
  standardrb --no-fix
else
  echo "==> Running Reek..."
  reek $(git diff --name-only --ignore-submodules=all --cached) --force-exclusion
  echo "==> Running Standard..."
  standardrb --no-fix
fi
