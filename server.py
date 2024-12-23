import os
import nest_asyncio

import uvicorn
from fastapi import FastAPI

app = FastAPI(
    title="UltBackHF",
    version="1.0.2",
    contact={
        "name": "🌀ʊʄ⊕ք🌀",
        "url": "https://github.com/shivamkr0037/amimusic.git",
    },
    docs_url=None,
    redoc_url="/"
)

@app.get("/status")
def status():
    return {"message": "running"}

if name == "main":
    nest_asyncio.apply()
    uvicorn.run(app, host="0.0.0.0", port=7860)
