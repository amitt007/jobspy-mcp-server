# Stage 1: Use an official Python base image with Node.js support
FROM python:3.11-slim

# Install Node.js 20.x
RUN apt-get update && apt-get install -y curl gnupg \
  && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get install -y nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and install Python dependencies (jobspy scraper)
COPY jobspy/requirements.txt ./jobspy-requirements.txt
RUN pip install --no-cache-dir -r jobspy-requirements.txt

# Copy the Python jobspy script
COPY jobspy/main.py ./jobspy-main.py

# Copy and install Node.js dependencies (MCP server)
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy all source files
COPY src/ ./src/

# Environment defaults
ENV PORT=9423
ENV HOST=0.0.0.0
ENV ENABLE_SSE=1
# Tell the MCP server to call python directly instead of docker
ENV DOCKER_CMD=python
ENV JOBSPY_SCRIPT=./jobspy-main.py

EXPOSE 9423

CMD ["node", "src/index.js"]
