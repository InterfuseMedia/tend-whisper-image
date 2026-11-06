# GPU worker image for Tend sermon journeys: RunPod's own Flash GPU runtime
# (Python 3.12, PyTorch with CUDA 12.8, cuBLAS and cuDNN 9) plus everything
# transcription needs, so a cold start has nothing to download or install.
# The Tend code itself still ships in the Flash deploy bundle, not here.
FROM runpod/queue-gpu:py3.12-latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "faster-whisper==1.2.1" "pydantic>=2.7" "huggingface_hub>=0.25"

# Whisper medium in CTranslate2 format (MIT licence), baked in at a fixed path.
ARG WHISPER_REPO=Systran/faster-whisper-medium
RUN python -c "from huggingface_hub import snapshot_download; \
snapshot_download('${WHISPER_REPO}', local_dir='/models/faster-whisper-medium')" \
 && test -f /models/faster-whisper-medium/model.bin

ENV TEND_WHISPER_MODEL=/models/faster-whisper-medium
