# cmd-exclude-prefixes-k8s
Prefix service is designed to collect the local IP address ranges. Additionally, user defined address ranges could be configured to be treated as local.

## Multi-Architecture Support

This project supports multi-architecture Docker builds for the following platforms:
- `linux/amd64`
- `linux/arm64`

The Docker images are built using Docker Buildx with cross-compilation support, enabling deployment on ARM-based environments such as Raspberry Pi, AWS Graviton instances, and Apple M-series processors.

Multi-architecture images are automatically built and pushed to GitHub Container Registry (GHCR) at `ghcr.io/sanjay7178/ci/cmd-exclude-prefixes-k8s` on every push to the main branch.

### Building Multi-Architecture Images

To build multi-architecture images locally:

```bash
# Build for both amd64 and arm64
docker buildx build --platform linux/amd64,linux/arm64 .

# Build for specific platform
docker buildx build --platform linux/arm64 .
```

### Using Pre-built Images

You can pull the multi-architecture images from GHCR:

```bash
# Pull the latest image (automatically selects the correct architecture)
docker pull ghcr.io/sanjay7178/ci/cmd-exclude-prefixes-k8s:latest

# Pull a specific commit
docker pull ghcr.io/sanjay7178/ci/cmd-exclude-prefixes-k8s:<commit-sha>
```
