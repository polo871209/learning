# List available commands
default:
    @just --list

# Validate all CUE configurations
vet:
    @cd cue && cue vet ./...
    @echo "✓ All configurations valid"

# Validate specific app
vet-app app:
    @cd cue && cue vet ./apps/{{app}}/...
    @echo "✓ {{app}} configuration valid"

# Export specific app to YAML with --- separators
[working-directory: 'cue']
export app:
    @cue export ./{{app}}/. --out text --expression stream

# Export all apps to YAML
export-all:
    @just export infra
    @echo "---"
    @just export api

# Format all CUE files
fmt:
    @cd cue && cue fmt ./...

# Initialize CUE dependencies
mod-tidy:
    @cd cue && cue mod tidy
