#!/usr/bin/env bash

# CRD Import Script
# This script imports all Istio and Prometheus Operator CRDs
# Run this script from the k8s/base/crds directory

set -e

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== CRD Import Script ===${NC}"
echo ""

# =============================================================================
# Istio CRDs
# =============================================================================

echo -e "${GREEN}[1/2] Importing Istio CRDs...${NC}"

# Get latest Istio release
ISTIO_LATEST=$(curl -sL https://api.github.com/repos/istio/istio/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
echo "Latest Istio version: $ISTIO_LATEST"

ISTIO_CRD_URL="https://raw.githubusercontent.com/istio/istio/refs/heads/master/manifests/charts/base/files/crd-all.gen.yaml"

cd istio

# Remove existing CRD files to force update
echo "  → Removing existing CRD files..."
rm -rf v1 v1alpha1 v1alpha3 v1beta1 istio.cue

# Import networking.istio.io CRDs
echo "  → Importing networking.istio.io..."
curl -sL "$ISTIO_CRD_URL" | cue get crd --group networking.istio.io yaml: -

# Import security.istio.io CRDs
echo "  → Importing security.istio.io..."
curl -sL "$ISTIO_CRD_URL" | cue get crd --group security.istio.io yaml: -

# Import extensions.istio.io CRDs
echo "  → Importing extensions.istio.io..."
curl -sL "$ISTIO_CRD_URL" | cue get crd --group extensions.istio.io yaml: -

# Import telemetry.istio.io CRDs
echo "  → Importing telemetry.istio.io..."
curl -sL "$ISTIO_CRD_URL" | cue get crd --group telemetry.istio.io yaml: -

cd ..

echo -e "${GREEN}✓ Istio CRDs imported successfully!${NC}"
echo ""

# =============================================================================
# Prometheus Operator CRDs
# =============================================================================

echo -e "${GREEN}[2/2] Importing Prometheus Operator CRDs...${NC}"

# Get latest Prometheus Operator release
PROM_OP_LATEST=$(curl -sL https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
echo "Latest Prometheus Operator version: $PROM_OP_LATEST"

PROM_OP_CRD_URL="https://github.com/prometheus-operator/prometheus-operator/releases/download/${PROM_OP_LATEST}/stripped-down-crds.yaml"

cd promethues_operator

# Remove existing CRD files to force update
echo "  → Removing existing CRD files..."
rm -rf v1 v1alpha1 promethues-operator.cue

echo "  → Downloading and importing monitoring.coreos.com CRDs..."
curl -sL "$PROM_OP_CRD_URL" | cue get crd --group monitoring.coreos.com yaml: -

cd ..

echo -e "${GREEN}✓ Prometheus Operator CRDs imported successfully!${NC}"
echo ""

# =============================================================================
# Summary
# =============================================================================

echo -e "${BLUE}=== Import Complete ===${NC}"
echo "Istio version: $ISTIO_LATEST"
echo "Prometheus Operator version: $PROM_OP_LATEST"
echo ""
echo "All CRDs have been imported and updated."
echo "You can now use these CRDs in your CUE configurations."
