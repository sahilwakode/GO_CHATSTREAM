# Use official Node.js 12 image with npm pre-installed
FROM node:12.22.12-buster-slim

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
RUN cd frontend && npm install

# Copy all source files
COPY . .

# Build Go binary
RUN cd backend && go build -o main .

# Expose ports
EXPOSE 3000 9000

# Start services
CMD ["sh", "-c", "cd frontend && npm start & cd backend && ./main"]
