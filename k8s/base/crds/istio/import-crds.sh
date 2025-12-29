#!/usr/bin/env bash

# Istio CRD Import Script
# This script imports all Istio CRDs from the official repository
# Run this script from the k8s/base/crds/istio directory

set -e

# Get latest Istio release
ISTIO_LATEST=$(curl -sL https://api.github.com/repos/istio/istio/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
echo "Latest Istio version: $ISTIO_LATEST"

CRD_URL="https://raw.githubusercontent.com/istio/istio/refs/heads/master/manifests/charts/base/files/crd-all.gen.yaml"

echo "Downloading Istio CRDs and importing into CUE..."

# Remove existing CRD files to force update
echo "Removing existing CRD files..."
rm -rf v1 v1alpha1 v1alpha3 v1beta1

# Import networking.istio.io CRDs
echo "Importing networking.istio.io..."
curl -sL "$CRD_URL" | cue get crd --group networking.istio.io yaml: -

# Import security.istio.io CRDs
echo "Importing security.istio.io..."
curl -sL "$CRD_URL" | cue get crd --group security.istio.io yaml: -

# Import extensions.istio.io CRDs
echo "Importing extensions.istio.io..."
curl -sL "$CRD_URL" | cue get crd --group extensions.istio.io yaml: -

# Import telemetry.istio.io CRDs
echo "Importing telemetry.istio.io..."
curl -sL "$CRD_URL" | cue get crd --group telemetry.istio.io yaml: -

echo "All Istio CRDs imported successfully!"
