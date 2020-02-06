#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e3c494a48e27d001f8c7ded/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e3c494a48e27d001f8c7ded 
fi
curl -s -X POST https://api.stackbit.com/project/5e3c494a48e27d001f8c7ded/webhook/build/ssgbuild > /dev/null
hugo

curl -s -X POST https://api.stackbit.com/project/5e3c494a48e27d001f8c7ded/webhook/build/publish > /dev/null
