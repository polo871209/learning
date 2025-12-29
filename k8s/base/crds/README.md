# CRDs

This directory contains CUE type definitions for Kubernetes Custom Resource Definitions (CRDs).

## What's Here

- **`istio/`** - Istio service mesh CRDs (VirtualService, Gateway, DestinationRule, etc.)
- **`promethues_operator/`** - Prometheus Operator CRDs (ServiceMonitor, PodMonitor, etc.)

## Usage

Import CRD types in your CUE configurations:

```cue
import istio "github.com/polo871209/learning/base/crds/istio/v1"
import servicemonitor "github.com/polo871209/learning/base/crds/promethues_operator/v1"
```

## Updating CRDs

Run the import script to fetch the latest CRD definitions from upstream:

```bash
cd k8s/base/crds
./import-crds.sh
```

This downloads and imports the latest Istio and Prometheus Operator CRDs into CUE format.
