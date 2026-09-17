#!/bin/bash
#
# Copyright (c) 2026 Duc Nhat Luong
#
# This file is based on and adapted from:
# https://github.com/oomichi-melco/try-margo
#
# Original work:
# Copyright (c) 2026 Kenichi Omichi
#
# Licensed under the MIT License.
# See the LICENSE file in this repository for details.

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}/.."

# Load configuration
source "${SCRIPT_DIR}/config.sh"

IMAGE_NAME=${IMAGE_NAME:-"my-image"}
IMAGE_TAG=${IMAGE_TAG:-"develop"}
REGISTRY=${REGISTRY:-"ghcr.io"}
REGISTRY_TOKEN_NAME=${REGISTRY_TOKEN_NAME:-"your-github-acc"}
REGISTRY_TOKEN_PASSWD=${REGISTRY_TOKEN_PASSWD:-""}
MULTI_ARCH_BUILD=${MULTI_ARCH_BUILD:-"false"}

LOCAL_IMAGE_REF="${IMAGE_NAME}:${IMAGE_TAG}"
NEW_REGISTRY_IMAGE="${REGISTRY}/${REGISTRY_TOKEN_NAME}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "${REGISTRY_TOKEN_NAME}"

if [ "${REGISTRY}" == "" ]; then
	echo "REGISTRY needs to be specified."
	exit 1
fi
if [ "${REGISTRY_TOKEN_NAME}" == "" ]; then
	echo "REGISTRY_TOKEN_NAME needs to be specified."
	exit 1
fi
if [ "${REGISTRY_TOKEN_PASSWD}" == "" ]; then
	echo "REGISTRY_TOKEN_PASSWD needs to be specified."
	exit 1
fi

set -e
podman login -u "${REGISTRY_TOKEN_NAME}" -p "${REGISTRY_TOKEN_PASSWD}" "${REGISTRY}"
set +e

set -e
if [ "${MULTI_ARCH_BUILD}" == "true" ]; then
	echo "Pushing the multi-arch image ${LOCAL_IMAGE_REF} to ${NEW_REGISTRY_IMAGE}.."
	podman manifest push --all "${LOCAL_IMAGE_REF}" "docker://${NEW_REGISTRY_IMAGE}"
else
	echo "Pushing the image ${LOCAL_IMAGE_REF} to ${NEW_REGISTRY_IMAGE}.."
	podman tag "${LOCAL_IMAGE_REF}" "${NEW_REGISTRY_IMAGE}"
	podman push "${NEW_REGISTRY_IMAGE}"
fi
set +e

echo "Succeeded to push container images."
