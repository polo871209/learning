#!/bin/bash

# Istio CRD Import Script
# This script imports all Istio CRDs from the official repository
# Run this script from the definitions/istio directory

set -e

CRD_URL="https://raw.githubusercontent.com/istio/istio/refs/heads/master/manifests/charts/base/files/crd-all.gen.yaml"

echo "Downloading Istio CRDs and importing into CUE..."

# Import networking.istio.io CRDs
echo "Importing networking.istio.io..."
curl -s "$CRD_URL" | cue get crd --group networking.istio.io yaml: -

# Import security.istio.io CRDs
echo "Importing security.istio.io..."
curl -s "$CRD_URL" | cue get crd --group security.istio.io yaml: -

# Import extensions.istio.io CRDs
echo "Importing extensions.istio.io..."
curl -s "$CRD_URL" | cue get crd --group extensions.istio.io yaml: -

# Import telemetry.istio.io CRDs
echo "Importing telemetry.istio.io..."
curl -s "$CRD_URL" | cue get crd --group telemetry.istio.io yaml: -

echo "All Istio CRDs imported successfully!"
