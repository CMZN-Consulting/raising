#!/usr/bin/env bash
# The root's check: builds, no sorry and no axiom in the source, and every theorem depends on
# nothing beyond Lean's own three axioms.
set -euo pipefail
cd "$(dirname "$0")/.."
lake build
if grep -rnE '\bsorry\b|^\s*axiom\b|\badmit\b|\bnative_decide\b' --include='*.lean' Raising Raising.lean; then
  echo "forbidden word in the source"; exit 1
fi
lake env lean Raising/Axioms.lean | tee /tmp/raising-axioms.txt
if grep -v -E "^'[^']+' depends on axioms: \[(propext|Classical\.choice|Quot\.sound)(, (propext|Classical\.choice|Quot\.sound))*\]$|^'[^']+' does not depend on any axioms$" /tmp/raising-axioms.txt | grep -q .; then
  echo "an axiom beyond Lean's three"; exit 1
fi
echo "check passed"
