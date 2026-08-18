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

# Upgrade pip and install hermes-agent package
RUN pip install --upgrade pip --no-cache-dir && \
    pip install --no-cache-dir hermes-agent

# Expose Hermes API/Gateway port
EXPOSE 9119

# Ensure Python logs are output in real-time
ENV PYTHONUNBUFFERED=1

# Default entrypoint command
CMD ["hermes", "gateway"]
