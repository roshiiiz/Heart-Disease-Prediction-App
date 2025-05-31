import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
import joblib
import os

# Load dataset
df = pd.read_csv('heart.csv')  # Ensure correct path to your CSV file
X = df.drop('condition', axis=1)
y = df['condition']

# Train/test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train logistic regression
log_model = LogisticRegression(max_iter=1000)
log_model.fit(X_train, y_train)

# Train decision tree
tree_model = DecisionTreeClassifier()
tree_model.fit(X_train, y_train)

# Save models
os.makedirs('models', exist_ok=True)
joblib.dump(log_model, 'models/logistic_model.pkl')
joblib.dump(tree_model, 'models/decision_tree.pkl')

print("Models trained and saved.")
