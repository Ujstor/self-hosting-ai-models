# Self-Hosting AI Models ([Ollama](https://github.com/jmorganca/ollama), [Stable Diffusion](https://github.com/AUTOMATIC1111/stable-diffusion-webui), [Foocus](https://github.com/lllyasviel/Fooocus)) with [Traefik](https://github.com/traefik/traefik) on Home Network

Self-host your AI models like Ollama, Stable Diffusion and Foocus using Traefik on your home network. This method offers cost-effective and efficient management of AI services, bypassing expensive cloud solutions.

## Prerequisites
- Registered domain name.
- Home network with internet.
- PC or server with Docker and Docker Compose.

## Traefik Overview
Traefik, an HTTP reverse proxy and load balancer, simplifies deploying microservices. It routes web traffic to the correct Docker container, enhancing resource utilization and security.

## Setup Steps

### 1. Domain and DNS
- Buy a domain and set DNS to your home IP.
- Configure A records for your services’ subdomains.

### 2. Router Setup
- Open ports 80 and 443.

### 3. Docker and Traefik Configuration
- Install Docker and Docker Compose.
- Clone this repository for configuration files.
- Set `chmod 600 acme.json` for SSL.
- Use `docker-compose.yml` to define services and configure Traefik.
- Update `traefik.toml` and `traefik_dynamic.toml` for HTTPS, router, middleware, and service settings.

### 4. Launching Services
- Run `docker-compose up -d`.
- Access Traefik dashboard for monitoring.

### 5. Accessing AI Models
- Use respective subdomains for secure HTTPS access.

## Customization and Security
- Change authentication in `traefik_dynamic.toml`.
- Adjust Docker settings in `docker-compose.yml`.
- Ensure network security.

## Troubleshooting
- Check Traefik logs, router settings, and Docker container status.

### Docker and Traefik Code Snippet
Includes configurations for services like Traefik, Ollama, and others, detailing ports, volumes, and networks for smooth operation. Adjustments can be made to the Traefik settings (`traefik.toml`, `traefik_dynamic.toml`) and Docker (`docker-compose.yml`) as needed, ensuring personalized and secure service deployment.