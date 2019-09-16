#!/usr/bin/env bash

set -eu

PROJECT="external-module-artifact"
VERSION=$(cat VERSION)
FILE="${PROJECT}-${VERSION}.zip"

cd "$(dirname "${BASH_SOURCE[0]}")"

zip "${FILE}" *.tf
