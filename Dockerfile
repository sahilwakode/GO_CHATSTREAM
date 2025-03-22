# --- Frontend Service ---
FROM node:12.13 AS frontend
WORKDIR /app

# Install dependencies
COPY frontend/package*.json ./
RUN npm install

# Copy the frontend code
COPY frontend/ ./

# Start React dev server
CMD ["nvm", "use", "12.13", "&&", "npm", "start"]

---

# --- Backend Service ---
FROM golang:1.21 AS backend
WORKDIR /app

# Copy Go files
COPY backend/go.mod backend/go.sum ./
RUN go mod download

COPY backend/ ./

# Start Go backend server
CMD ["go", "run", "main.go"]
