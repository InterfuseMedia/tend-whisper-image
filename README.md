# tend-whisper-image

GPU worker image for Tend sermon journeys on RunPod serverless: RunPod's Flash
GPU runtime plus ffmpeg, faster-whisper 1.2.1 and the Whisper medium model
(CTranslate2, from Systran/faster-whisper-medium) at `/models/faster-whisper-medium`.

No Tend code lives here; it ships in the Flash deploy bundle. Every push to
`main` builds and publishes `ghcr.io/<owner>/tend-whisper-image:latest` and
`:<commit sha>`. Pin RunPod to the sha tag.
