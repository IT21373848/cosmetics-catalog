## Running with Docker

This project includes a Docker setup for the `cosmetics-catalog` service. The application runs on Node.js version `22.13.1-slim` and exposes port `3000`.

### Requirements
- Docker and Docker Compose installed
- (Optional) `.env` file in `./cosmetics-catalog/` for environment variables

### Build and Run

To build and start the service:

```sh
docker compose up --build
```

This will:
- Build the `cosmetics-catalog` image using the provided `Dockerfile` (Node.js 22.13.1-slim)
- Start the service and expose it on [http://localhost:3000](http://localhost:3000)
- Use environment variables from `./cosmetics-catalog/.env` if the file exists

### Configuration
- The service runs as a non-root user for securit
- Environment variables can be set in `./cosmetics-catalog/.env`
- The service is attached to the `app-net` Docker network

### Ports
- `cosmetics-catalog`: **3000** (host:container)

---
