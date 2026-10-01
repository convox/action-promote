#!/bin/sh
set -e

if [ -z "${INPUT_RACK:-}" ]; then
  echo "::error::Required input 'rack' is missing"
  exit 1
fi
if [ -z "${INPUT_APP:-}" ]; then
  echo "::error::Required input 'app' is missing"
  exit 1
fi

if [ -n "$INPUT_RELEASE" ]
then
 export RELEASE="$INPUT_RELEASE"
fi
if [ -z "$RELEASE" ]
then
  echo "Release must either be passed as input or set by running a build step"
  exit 1
else
  echo "Promoting Release $RELEASE"
  export CONVOX_RACK="$INPUT_RACK"
  convox releases promote "$RELEASE" --app "$INPUT_APP" --wait
fi
