# Self-Hosting AI Models ([Ollama](https://github.com/jmorganca/ollama), [Stable Diffusion](https://github.com/AUTOMATIC1111/stable-diffusion-webui), [Foocus](https://github.com/lllyasviel/Fooocus)) with [Traefik](https://github.com/traefik/traefik) on Home Network

In an era where cloud-based GPU services are costly, self-hosting AI models on a home network emerges as a savvy alternative. GPUs, once primarily the domain of gaming and graphics, have become crucial in fields like machine learning and data science. By leveraging your own GPU, you can bypass expensive cloud services like AWS or Google Cloud, gaining both cost efficiency and control.

## Prerequisites

- A registered domain name.
- A home network with internet access.
- A PC or server with Docker and Docker Compose installed.

## Understanding Traefik

[Traefik](https://doc.traefik.io/traefik/) is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik plays a pivotal role in managing web traffic, directing requests to the appropriate Docker container based on the host's domain. By leveraging Traefik in our AI model hosting setup, we gain a robust, efficient, and secure system for managing web access to services like LLMS, Stable Diffusion, and Foocus hosted on a home network. This approach ensures optimal resource utilization, security, and ease of management, making it an ideal choice for self-hosting sophisticated AI models.

## Step-by-Step Setup

### 1. Domain and DNS Configuration
- Purchase a domain from a provider.
- Configure DNS settings to point to your home network's IP address.
- Set A records for subdomains like `ollama.yourdomain.com`, `diffusion.yourdomain.com`, and `fooocus.yourdomain.com`.

### 2. Router Configuration
- Open ports/0irewall 80 and 443. This step varies based on your router's brand and model.

### 3. Docker and Traefik Setup
- Install Docker and Docker Compose.
- Clone this repository to get the necessary configuration files.
- chmod 600 acme.json for automatic SSL

#### Understanding the `docker-compose.yml`:
- Defines services for Traefik, LLMS (ollama), Stable Diffusion, and Foocus.
- Configures Traefik to listen on ports 80 (HTTP) and 443 (HTTPS).
- Sets up necessary volumes and networks for inter-container communication.

#### Configuring Traefik (`traefik.toml` and `traefik_dynamic.toml`):
- `traefik.toml`: Sets entry points and certificate resolvers for HTTPS.
- `traefik_dynamic.toml`: Contains detailed router, middleware, and service configurations. 
- Update `email` under `[certificatesResolvers.lets-encrypt.acme]` with your email.
- Customize router rules to match your domain names.

### 4. Running the Services
- Execute `docker-compose up -d` to start all services.
- Traefik dashboard is accessible for monitoring and management.
- Ensure that your AI models (Ollama, Stable Diffusion, Foocus) are running

### 5. Accessing AI Models
- Access the services using the respective subdomains set in your DNS configuration.
- Ensure HTTPS is working correctly for secure connections.

## Customizing and Security

- **Change Basic Authentication Credentials**: Update the hashed password in `http.middlewares.simpleAuth.basicAuth` of `traefik_dynamic.toml` (htpasswd).
- **Adjust Service Settings**: Modify Docker image tags and labels in `docker-compose.yml` as needed.
- **Network Security**: Ensure your home network is secured and monitor open ports.

## Troubleshooting

- Check Traefik logs if services are not reachable.
- Verify port forwarding and DNS settings on your router.
- Ensure Docker containers are running with `docker ps`.