# --- Build React Frontend ---
FROM node:20 AS frontend
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# --- Build Go Backend ---
FROM golang:1.21 AS backend
WORKDIR /app
COPY backend/go.mod backend/go.sum ./
RUN go mod download
COPY backend/ ./
RUN go build -o main .

# --- Final Container ---
FROM alpine:latest
WORKDIR /app

# Install SSL certs and copy both builds
RUN apk --no-cache add ca-certificates
COPY --from=backend /app/main .
COPY --from=frontend /app/build ./public

# Expose the backend port
EXPOSE 9000

# Start the Go backend server
CMD ["./main"]



