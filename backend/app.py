from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np

app = FastAPI()

# Load models
log_model = joblib.load('models/logistic_model.pkl')
tree_model = joblib.load('models/decision_tree.pkl')

# Input data schema for FastAPI request
class InputData(BaseModel):
    age: int
    sex: int
    cp: int
    trestbps: int
    chol: int
    fbs: int
    restecg: int
    thalach: int
    exang: int
    oldpeak: float
    slope: int
    ca: int
    thal: int

@app.post("/predict")
async def predict(data: InputData):
    features = np.array([
        data.age, data.sex, data.cp, data.trestbps, data.chol,
        data.fbs, data.restecg, data.thalach, data.exang,
        data.oldpeak, data.slope, data.ca, data.thal
    ]).reshape(1, -1)

    # Make predictions
    log_pred = log_model.predict(features)[0]
    log_prob = log_model.predict_proba(features)[0][1]

    tree_pred = tree_model.predict(features)[0]
    tree_prob = tree_model.predict_proba(features)[0][1]

    result = {
        "logistic_regression": {
            "prediction": int(log_pred),
            "probability": round(float(log_prob), 2)
        },
        "decision_tree": {
            "prediction": int(tree_pred),
            "probability": round(float(tree_prob), 2)
        }
    }

    return result
