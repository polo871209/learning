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

[working-directory: 'cue']
apply app:
    @cue export ./{{app}}/. --out text --expression stream | kubectl apply -f -

[working-directory: 'cue']
delete app:
    @cue export ./{{app}}/. --out text --expression stream | kubectl delete -f -
