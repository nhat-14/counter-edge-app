
#!/bin/bash
#
# Copyright (c) 2026 Duc Nhat Luong
#
# Licensed under the MIT License.
# See the LICENSE file in this repository for details.

# Global configuration
REGISTRY="ghcr.io"
IMAGE_NAME=counter-app
IMAGE_TAG="v1.0.0"
MULTI_ARCH_BUILD="true"

REGISTRY_TOKEN_NAME="nhat-14"
# REGISTRY_TOKEN_PASSWD="" # GitHub PAT for the ghcr.io registry


# Application package name: "<app-name>-app-package"
APP_PACKAGE_NAME="counter-app-compose-app-package" 

# # Paths
# PROJECT_ROOT="/home/azureuser/workspace/my-project"
# CONFIG_DIR="${PROJECT_ROOT}/config"