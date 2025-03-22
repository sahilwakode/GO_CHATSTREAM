# --- Build React Frontend ---
FROM node:20 AS frontend
WORKDIR /app
COPY frontend/package*.json ./

# Use OpenSSL legacy provider
ENV NODE_OPTIONS="--openssl-legacy-provider"

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

RUN apk --no-cache add ca-certificates
COPY --from=backend /app/main .
COPY --from=frontend /app/build ./public

EXPOSE 9000
CMD ["./main"]
