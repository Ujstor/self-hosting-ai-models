#ssh tunelling
# ssh -L 7860:127.0.0.1:7860 -L 7865:127.0.0.1:7865 -L 11434:127.0.0.1:11434 -p 2222 models@localhost

.PHONY: run down install-fooocus install-diffusion install-ollama run-fooocus run-ollama run-diffusion run-fooocus-q run-ollama-q run-diffusion-q

run:
	@echo Starting traefik reverse proxy, Ollama Web-UI & VPS for models
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
	@/bin/bash -c "source /anaconda/etc/profile.d/conda.sh && conda activate fooocus && python3 /home/models/Fooocus/launch.py"

run-fooocus-q:
	@nohup make run-fooocus > /tmp/fooocus_run_output.log 2>&1 &

install-ollama: #runnung model as background processes
	@curl https://ollama.ai/install.sh | sh

run-ollama:
	@ollama serve &
	@sleep 5
	@ollama pull llama2-uncensored:7b
	@ollama pull openhermes2.5-mistral:7b
	@ollama pull codellama:7b
	@ollama pull deepseek-coder:6.7b

run-ollama-q: #runnung models as background processes
	@nohup make run-ollama > /tmp/ollama_run_output.log 2>&1 &

install-diffusion:
	@wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh -O /home/models/webui.sh
	@chmod 777 /home/models/webui.sh
	@sudo -u models /bin/bash /home/models/webui.sh

run-diffusion:
	@. /home/models/stable-diffusion-webui/venv/bin/activate && \
	python3 /home/models/stable-diffusion-webui/webui.py

#pip install --force-reinstall --no-deps --pre xformers &&

run-diffusion-q: #runnung model as background processes
	@nohup make run-diffusion > /tmp/diffusion_run_output.log 2>&1 &