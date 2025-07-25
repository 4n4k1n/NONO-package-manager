# Use Ubuntu as base image
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install essential tools
RUN apt-get update && apt-get install -y \
    # Build essentials
    build-essential \
    gcc \
    g++ \
    # Python and pip for Meson
    python3 \
    python3-pip \
    # Version control
    git \
    # Package config helper
    pkg-config \
    # Common development libraries
    libgtk-3-dev \
    libsqlite3-dev \
    libjansson-dev \
    libsdl2-dev \
    # Utilities
    curl \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install Meson and Ninja via pip
RUN pip3 install meson ninja

# Create a working directory
WORKDIR /workspace

# Create a non-root user for development
RUN useradd -m -s /bin/bash developer && \
    chown -R developer:developer /workspace

# Switch to non-root user
USER developer

# Set environment variables
ENV PATH="/home/developer/.local/bin:${PATH}"

# Copy example project structure (optional)
# COPY --chown=developer:developer . /workspace

# Default command
CMD ["/bin/bash"]
