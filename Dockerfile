# Use Node.js 18 LTS (Buster) with npm pre-installed
FROM node:18.18.2-buster-slim

# Install Go 1.21
RUN apt-get update && apt-get install -y wget
RUN wget https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.21.7.linux-amd64.tar.gz \
    && rm go1.21.7.linux-amd64.tar.gz
ENV PATH="$PATH:/usr/local/go/bin"

# Set up workspace
WORKDIR /app

# Copy backend dependencies first
COPY backend/go.mod backend/go.sum ./backend/
RUN cd backend && go mod download

# Copy frontend dependencies
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install --force

# Copy all source files
COPY . .

# Build Go binary
RUN cd backend && go build -o main .

# Expose required ports
EXPOSE 3000 9000

# Start services using PM2 process manager
RUN npm install -g pm2
CMD ["pm2-runtime", "ecosystem.config.js"]
