import fastapi
import uvicorn


app = fastapi.FastAPI(title="MLOps app")

@app.get("/")
async def home():
    return "</h2> This is a basic MLOps app <h2>"


