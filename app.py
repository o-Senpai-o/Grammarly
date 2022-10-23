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

    
    
handler = Mangum(app)
