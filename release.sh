#!/usr/bin/env bash

set -euo pipefail

# cd to script directory
cd "$(dirname "${BASH_SOURCE[0]}")"

PROJECT="external-module-artifact"
VERSION=$(cat VERSION)
FILE="${PROJECT}-${VERSION}.zip"
URL="https://nexus.i.lo3energy.net/repository/terraform-modules/${PROJECT}/${FILE}"

if [[ -z "${LO3_NEXUS_LOGIN:-}" || -z "${LO3_NEXUS_PASSWORD:-}" ]]; then
  echo LO3_NEXUS_LOGIN and LO3_NEXUS_PASSWORD environment variables must be set to release. >&2
  exit 1
fi

if [[ ! -f "${FILE}" ]]; then
  echo Project must be packaged at ${FILE} prior to releasing. >&2
  exit 1
fi

echo Releasing to ${URL} >&2
curl -u "${LO3_NEXUS_LOGIN}:${LO3_NEXUS_PASSWORD}" --upload-file "${FILE}" "${URL}"
