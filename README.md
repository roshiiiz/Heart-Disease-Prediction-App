Heart Disease Prediction App
Overview
The Heart Disease Prediction App is a project designed to predict the likelihood of heart disease based on user-provided health parameters. It includes a Flask-based web application powered by a Random Forest Classification model and a Flutter-based mobile application for cross-platform access. The project leverages the UCI Heart Disease dataset from Kaggle to train the model, offering both web and mobile interfaces for user interaction.
Features
Web App (Flask)

User-friendly web interface for inputting health parameters.
Utilizes a Random Forest Classifier for accurate predictions.
Provides interpretable results to assess heart disease risk factors.
Responsive design compatible with various devices.

Mobile App (Flutter)

Cross-platform support for Android and iOS.
Portable heart disease risk predictions on mobile devices.
Intuitive UI for entering health parameters.
(Optional) Offline prediction capability if implemented.

Dataset
The model is trained on the UCI Heart Disease Dataset, featuring 14 attributes:

Age
Sex (0 for female, 1 for male)
Chest Pain Type (0-3)
Resting Blood Pressure
Serum Cholesterol
Fasting Blood Sugar
Resting Electrocardiographic Results
Maximum Heart Rate Achieved
Exercise-Induced Angina
Oldpeak (ST depression)
Slope of the Peak Exercise ST Segment
Number of Major Vessels (0-3)
Thalassemia (3 = normal; 6 = fixed defect; 7 = reversible defect)
Target (0 = no heart disease, 1 = heart disease)

Installation
Web App (Flask)

Clone the repository:git clone https://github.com/roshiiiz/Heart-Disease-Prediction-App.git
cd Heart-Disease-Prediction-App


Install dependencies (Python 3.8+ required):pip install -r requirements.txt


Run the app:python app.py


Access at http://127.0.0.1:8000/predict

Mobile App (Flutter)

Install Flutter: Follow Flutter installation guide.
Navigate to the Flutter app folder (e.g., flutter_app):cd flutter_app


Install dependencies:flutter pub get


Run the app:flutter run



Usage
Web App

Open http://127.0.0.1:8000/predict in Postman or any other API testing service.
Enter health parameters in the form. E.G.:{
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


Click "Predict" to see the result.

Mobile App

Launch the app on your device.
Input health parameters.
Tap "Predict" for the prediction.

Contact
Open an issue on GitHub for questions or feedback.
