import numpy as np
import onnxruntime as ort
from scipy.special import softmax
import torch

from utils import timer_func
from data import DataModule


class ColaONNXPredictor:
    def __init__(self, model_path):
        # create a onnx inference session, which take model path to load the model
        self.ort_session = ort.InferenceSession(model_path)

        # get the dataset class 
        self.processor = DataModule()
        self.lables = ["unacceptable", "acceptable"]

    @timer_func
    def predict(self, text):
        # get the input sentence and tokenize it
        inference_sample = {"sentence": text}
        processed = self.processor.tokenize_data(inference_sample)

        ort_inputs = {
            "input_ids": np.expand_dims(torch.tensor(processed["input_ids"], dtype=torch.int64), axis=0),
            "attention_mask": np.expand_dims(torch.tensor(processed["attention_mask"], dtype=torch.int64), axis=0),
        }
        ort_outs = self.ort_session.run(None, ort_inputs)  # which output is required, None tells to return all outputs
        scores = softmax(ort_outs[0])[0]
        predictions = []
        for score, label in zip(scores, self.lables):
            predictions.append({"label": label, "score": score})
        return predictions


if __name__ == "__main__":
    sentence = "The boy is sitting on a bench"
    predictor = ColaONNXPredictor("./models/model.onnx")
    print(predictor.predict(sentence))
    sentences = ["The boy is sitting on a bench"] * 10
    for sentence in sentences:
        predictor.predict(sentence)