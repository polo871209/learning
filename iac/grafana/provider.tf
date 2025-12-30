terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">=4.21.0"
    }
    jsonnet = {
      source  = "alxrem/jsonnet"
      version = ">=2.5.0"
    }
  }
}

provider "grafana" {
  url  = "http://kube-prometheus-stack-grafana.observability.svc.cluster.local"
  auth = "glsa_4rb4rkX7o3bBRS1czSmyNClUaEoBPDEX_facab463"
}

provider "jsonnet" {
  jsonnet_path = "${path.module}/jsonnet/vendor"
}

