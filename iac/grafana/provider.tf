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
  auth = "glsa_PQtotVlALknEV6HSuVjZPq49tfbTOhtb_744aa198"
}

provider "jsonnet" {
  jsonnet_path = "${path.module}/jsonnet/vendor"
}

