from fastapi import FastAPI
from predict_onnx import ColaONNXPredictor
from mangum import Mangum

app = FastAPI(title="MLOps App")

predictor = ColaONNXPredictor("./models/model.onnx")

@app.get("/")
async def home_page():
    return "<h2>Sample prediction API</h2>"


@app.get("/predict")
async def get_prediction(text):
    result =  predictor.predict(text)
    return f"<h2>output : {result}</h2>"
    # return result


if __name__ == "__main__":
    uvicorn.run("myapp:app", host="127.0.0.1", port=8000, log_level="info")
else:
    handler = Mangum(app)
