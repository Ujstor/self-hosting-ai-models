# Self-Hosting AI Models ([Ollama](https://github.com/jmorganca/ollama), [Stable Diffusion](https://github.com/AUTOMATIC1111/stable-diffusion-webui), [Foocus](https://github.com/lllyasviel/Fooocus)) with [Traefik](https://github.com/traefik/traefik) on Home Network

Self-host your AI models like Ollama, Stable Diffusion and Foocus using Traefik on your home network. This method offers cost-effective and efficient management of AI services, bypassing expensive cloud solutions. If you dont alredy runn models on your maschine, this repo  include downloading, running, and managing these models, including details on SSH tunneling, local and web access configurations.

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
- This step is for accessing models through the web.

### 3. Docker and Traefik Configuration
- Install Docker and Docker Compose.
- Clone this repository for configuration files.
- Set `chmod 600 acme.json` for SSL.
- Use `docker-compose.yml` to define services and configure Traefik.
- Update `traefik.toml` and `traefik_dynamic.toml` for HTTPS, router, middleware, and service settings.
- Change authentication in `traefik_dynamic.toml`.


### 4. Launching Services

- Initiate the services by running the command `docker-compose up -d`. This command starts all the services defined in your `docker-compose.yml` file in detached mode, meaning they run in the background.
- Once the services are up, you can monitor them through the Traefik dashboard. This interface provides a visual representation of your services, their health, and other vital statistics. Access the dashboard using the configured domain or IP address, which is set up to route through Traefik.
- Alongside Traefik, this command also launches the Ollama Web-UI. The Ollama service is now accessible, as defined in your Traefik configuration, typically via a specific subdomain or route localhost URL
- A Virtual Private Server (VPS) environment is also created, configured for installing and deploying AI models.
<br>
<br>

# Download and Run AI Models

### 5. SSH Tunneling for External Communication
- SSH tunneling is utilized to securely forward requests from your local machine to the container running the AI models.
- To establish an SSH tunnel, open a terminal and execute: `ssh -L 7860:127.0.0.1:7860 -L 7865:127.0.0.1:7865 -L 11434:127.0.0.1:11434 -p 2222 models@localhost`. This command will forward the specified ports from your local machine to the corresponding ports on the container.
- After running this command, you will gain access to the makefile commands for managing the AI models.
- It's important to maintain the stability of your SSH connection. If the SSH session is disrupted, the tunnel will close, leading to the inaccessibility of the forwarded ports. Therefore, keep the terminal session active throughout the duration of use.

### 6. Local and Web Access Configurations with Traefik
- The `toml` configuration files are essential as they specify the ports and establish routing rules for each AI model. These configurations ensure secure and efficient web access to each model.
- The `http.middlewares` for basic authentication across all services enhances security. Simultaneously, `http.routers` and `http.services` define the access paths and protocols for each model, providing secure framework for web access.
- Local access to the AI models is facilitated through SSH tunneling. This method creates a secure pathway from the host machine to the containers managed by Traefik, ensuring safe and direct local access.

#### Traefik Configuration for Local Access:
1. **Ollama Service:**
   - Local URL: `http://host.docker.internal:3000`
2. **Diffusion Service:**
   - Local URL: `http://host.docker.internal:7860`
3. **Fooocus Service:**
   - Local URL: `http://host.docker.internal:7865`

## Makefile Commands

### Download and Install Commands
- `make install-fooocus`: Clones the Fooocus repository and sets up its environment.
- `make install-ollama`: Runs the Ollama installation script.
- `make install-diffusion`: Clones the Stable Diffusion WebUI repository and prepares its environment.
- `make install-all-models`: Installs all models.

### Running Models
- `make run`: Starts Traefik reverse proxy & Ollama Web-UI using Docker.
- `make down`: Shuts down all services.
- `make run-fooocus`: Activates the Fooocus environment and launches it.
- `make run-ollama`: Runs the Ollama service.
- `make run-diffusion`: Activates the Diffusion environment and starts the web UI.
- `make run-all-models`: Runs all models as background processes.