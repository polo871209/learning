# Grafana Dashboard as Code

Manage Grafana dashboards using Terraform and Jsonnet with Grafonnet library.


## Initialize Jsonnet dependencies

```bash
cd jsonnet
jb init
jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main
```

## Project Structure

```
├── jsonnet/
│   ├── dashboards/          # Dashboard definitions
│   ├── lib/                 # Reusable libraries
│   ├── output/              # Generated JSON dashboards
│   ├── vendor/              # Jsonnet dependencies (auto-generated)
│   └── jsonnetfile.json     # Dependency manifest
├── main.tf                  # Terraform resources
├── data.tf                  # Data sources for Jsonnet rendering
└── provider.tf              # Provider configurations
```

## Development

### Build dashboards locally

```bash
cd jsonnet
jsonnet -J vendor dashboards/api-golden-signals.jsonnet -o output/api-golden-signals.json
```

