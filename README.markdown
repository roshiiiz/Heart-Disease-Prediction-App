# Heart Disease Prediction App

## Overview
The Heart Disease Prediction App is designed to predict the likelihood of heart disease based on user-provided health parameters. It includes a Flask-based web application powered by a Random Forest Classification model and a Flutter-based mobile application for cross-platform access. The project leverages the UCI Heart Disease dataset to train the model, offering both web and mobile interfaces for user interaction.

## Dataset
The model is trained on the UCI Heart Disease Dataset, featuring 14 attributes:
- Age
- Sex (0 for female, 1 for male)
- Chest Pain Type (0-3)
- Resting Blood Pressure
- Serum Cholesterol
- Fasting Blood Sugar
- Resting Electrocardiographic Results
- Maximum Heart Rate Achieved
- Exercise-Induced Angina
- Oldpeak (ST depression)
- Slope of the Peak Exercise ST Segment
- Number of Major Vessels (0-3)
- Thalassemia (3 = normal; 6 = fixed defect; 7 = reversible defect)
- Target (0 = no heart disease, 1 = heart disease)

## Installation

### Web App (Flask)
1. Clone the repository:
   ```bash
   git clone https://github.com/roshiiiz/Heart-Disease-Prediction-App.git
   cd Heart-Disease-Prediction-App
   ```
2. Install dependencies (Python 3.8+ required):
   ```bash
   pip install -r requirements.txt
   ```
3. Run the app:
   ```bash
   python app.py
   ```
4. Access at `http://127.0.0.1:8000/predict`

### Mobile App (Flutter)
1. Install Flutter: Follow [Flutter installation guide](https://flutter.dev/docs/get-started/install).
2. Navigate to the Flutter app folder (e.g., `flutter_app`):
   ```bash
   cd flutter_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Usage

### Web App
1. Open `http://127.0.0.1:8000/predict` in Postman or any other API testing service.
2. Enter health parameters in the form. E.g.:
   ```json
   {
       "age": 90,
       "sex": 1,
       "cp": 3,
       "trestbps": 145,
       "chol": 233,
       "fbs": 1,
       "restecg": 0,
       "thalach": 150,
       "exang": 0,
       "oldpeak": 2.3,
       "slope": 0,
       "ca": 0,
       "thal": 3
   }
   ```
3. Click "Predict" to see the result.

### Mobile App
1. Launch the app on your device.
2. Input health parameters.
3. Tap "Predict" for the prediction.

## Contact
Open an issue on GitHub for questions or feedback.
