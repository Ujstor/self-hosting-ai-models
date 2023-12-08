.PHONY: run down install-fooocus

run:
	@echo Starting traefik reverse proxy & Ollama Web-UI
	@docker compose up -d

down:
	@echo Shutdown everything
	@docker compose down

install-fooocus:
	@echo Installing Fooocus...
	@git clone https://github.com/lllyasviel/Fooocus.git
	@CONDA_SH_PATH=$$(find ~ -name conda.sh | head -n 1); \
	if [ -z "$$CONDA_SH_PATH" ]; then \
		echo "conda.sh not found, ensure Conda is installed and re-run"; \
		exit 1; \
	fi; \
	cd fooocus && \
	/bin/bash -c "source $$CONDA_SH_PATH && conda env create -f environment.yaml && conda activate fooocus && pip install -r requirements_versions.txt && python launch.py"

install-ollama:
	@curl https://ollama.ai/install.sh | sh

install-diffusion:
	@sudo apt install wget git python3 python3-venv libgl1 libglib2.0-0
	@wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

