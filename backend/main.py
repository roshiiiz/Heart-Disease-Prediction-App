from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np

app = FastAPI()

# Load models
log_model = joblib.load('models/logistic_model.pkl')
tree_model = joblib.load('models/decision_tree.pkl')

# Input data schema for FastAPI request
class HeartData(BaseModel):
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

# Response model schema
class PredictionResponse(BaseModel):
    logistic_prediction: int
    logistic_probability: float
    decision_tree_prediction: int
    decision_tree_probability: float

@app.post("/predict", response_model=PredictionResponse)
async def predict(data: HeartData):
    # Extract input features from the request
    features = [
        data.age, data.sex, data.cp, data.trestbps, data.chol,
        data.fbs, data.restecg, data.thalach, data.exang,
        data.oldpeak, data.slope, data.ca, data.thal
    ]
    
    # Reshape the features array for model prediction
    features_array = np.array(features).reshape(1, -1)

    # Make predictions using both models
    log_pred = log_model.predict(features_array)[0]
    log_prob = log_model.predict_proba(features_array)[0][1]

    tree_pred = tree_model.predict(features_array)[0]
    tree_prob = tree_model.predict_proba(features_array)[0][1]

    # Return the predictions and probabilities for both models
    return {
        "logistic_prediction": int(log_pred),
        "logistic_probability": round(float(log_prob), 2),
        "decision_tree_prediction": int(tree_pred),
        "decision_tree_probability": round(float(tree_prob), 2),
    }
