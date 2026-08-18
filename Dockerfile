FROM python:3.11-slim

# Install system dependencies required by skills/tools (git, curl, ffmpeg, build tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    ffmpeg \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set workspace directory inside the container
WORKDIR /opt/data

# Upgrade pip and install hermes-agent package and aiohttp for API Server support
RUN pip install --upgrade pip --no-cache-dir && \
    pip install --no-cache-dir hermes-agent aiohttp

# Expose Hermes API/Gateway port
EXPOSE 9119

# Ensure Python logs are output in real-time and HERMES_HOME points to workspace
ENV PYTHONUNBUFFERED=1
ENV HERMES_HOME=/opt/data

# Default entrypoint command
CMD ["hermes", "gateway"]
