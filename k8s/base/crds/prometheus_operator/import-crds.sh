#!/usr/bin/env bash

# Prometheus Operator CRD Import Script
# This script imports all Prometheus Operator CRDs from the official repository
# Run this script from the k8s/base/crds/promethues_operator directory

set -e

# Get latest Prometheus Operator release
PROM_OP_LATEST=$(curl -sL https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
echo "Latest Prometheus Operator version: $PROM_OP_LATEST"

CRD_URL="https://github.com/prometheus-operator/prometheus-operator/releases/download/${PROM_OP_LATEST}/stripped-down-crds.yaml"

echo "Downloading Prometheus Operator CRDs and importing into CUE..."

# Remove existing CRD files to force update
echo "Removing existing CRD files..."
rm -rf v1 v1alpha1 

# Import monitoring.coreos.com CRDs
echo "Importing monitoring.coreos.com..."
curl -sL "$CRD_URL" | cue get crd --group monitoring.coreos.com yaml: -

echo "All Prometheus Operator CRDs imported successfully!"
