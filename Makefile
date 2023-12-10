#ssh tunelling
# ssh -L 7860:127.0.0.1:7860 -L 7865:127.0.0.1:7865 -L 11434:127.0.0.1:11434 -p 2222 root@localhost

.PHONY: run down install-fooocus
.PHONY: run down install-diffusion

run:
	@echo Starting traefik reverse proxy & Ollama Web-UI
	@docker compose up -d

down:
	@echo Shutdown everything
	@docker compose down

install-fooocus:
	@if [ ! -d "Fooocus" ]; then \
        git clone https://github.com/lllyasviel/Fooocus.git; \
    else \
        echo "Fooocus directory already exists, skipping git clone."; \
    fi; \
	CONDA_SH_PATH="/anaconda/etc/profile.d/conda.sh"; \
	if [ ! -f "$$CONDA_SH_PATH" ]; then \
	    echo "conda.sh not found, ensure Conda is installed and re-run"; \
	    exit 1; \
	fi; \
	cd Fooocus && \
	/bin/bash -c "source $$CONDA_SH_PATH && conda env create -f environment.yaml && conda init bash && conda activate fooocus && pip install -r requirements_versions.txt && cd .."

run-fooocus:
	@cd Fooocus && \
	/bin/bash -c "source /anaconda/etc/profile.d/conda.sh && conda activate fooocus && python launch.py"

install-ollama:
	@curl https://ollama.ai/install.sh | sh

run-ollama:
	@ollama serve &
	@sleep 5
	@ollama pull llama2-uncensored:7b
	@ollama pull openhermes2.5-mistral:7b

install-diffusion:
	@if [ ! -d "stable-diffusion-webui" ]; then \
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git; \
    else \
        echo "stable-diffusion-webui directory already exists, skipping git clone."; \
    fi; \
	CONDA_SH_PATH="/anaconda/etc/profile.d/conda.sh"; \
	if [ ! -f "$$CONDA_SH_PATH" ]; then \
	    echo "conda.sh not found, ensure Conda is installed and re-run"; \
	    exit 1; \
	fi; \
	cd stable-diffusion-webui && \
	/bin/bash -c "source $$CONDA_SH_PATH && conda env create -f environment-wsl2.yaml && conda init bash && conda activate automatic && pip install -r requirements_versions.txt && cd .."

run-diffusion:
	@cd stable-diffusion-webui && \
	/bin/bash -c "source /anaconda/etc/profile.d/conda.sh && conda activate automatic && python3 webui.py"


run-all-models: #runnung models as background processes
	@nohup make run-fooocus > /tmp/fooocus_run_output.log 2>&1 &
	@nohup make run-ollama > /tmp/ollama_run_output.log 2>&1 &
	@nohup make run-diffusion > /tmp/diffusion_run_output.log 2>&1 &

