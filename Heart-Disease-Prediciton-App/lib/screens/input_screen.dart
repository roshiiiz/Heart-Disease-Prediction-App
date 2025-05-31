import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/history_service.dart';
import 'result_screen.dart';
import '../services/api_service.dart';

class InputScreen extends StatefulWidget {
  final String modelName;
  const InputScreen({required this.modelName, super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final Map<String, TextEditingController> controllers = {
    'age': TextEditingController(),
    'sex': TextEditingController(),
    'cp': TextEditingController(),
    'trestbps': TextEditingController(),
    'chol': TextEditingController(),
    'fbs': TextEditingController(),
    'restecg': TextEditingController(),
    'thalach': TextEditingController(),
    'exang': TextEditingController(),
    'oldpeak': TextEditingController(),
    'slope': TextEditingController(),
    'ca': TextEditingController(),
    'thal': TextEditingController(),
  };

  final Map<String, String> fieldDescriptions = {
    'age': 'Enter your age (between 1 and 120)',
    'sex': '1 = male, 0 = female',
    'cp': 'Chest pain type (0-3)',
    'trestbps': 'Resting blood pressure (in mm Hg)',
    'chol': 'Serum cholesterol (mg/dl)',
    'fbs': 'Fasting blood sugar > 120 mg/dl (1 = true; 0 = false)',
    'restecg': 'Resting electrocardiographic results (0-2)',
    'thalach': 'Maximum heart rate achieved',
    'exang': 'Exercise induced angina (1 = yes; 0 = no)',
    'oldpeak': 'ST depression induced by exercise relative to rest',
    'slope': 'Slope of the peak exercise ST segment (0-2)',
    'ca': 'Number of major vessels colored by fluoroscopy (0-3)',
    'thal': '3 = normal; 6 = fixed defect; 7 = reversible defect',
  };

  Map<String, String> errorMessages = {};

  bool isValidInput() {
    bool valid = true;
    errorMessages.clear();

    controllers.forEach((key, controller) {
      String value = controller.text;
      if (value.isEmpty) {
        errorMessages[key] = '$key cannot be empty';
        valid = false;
      } else {
        switch (key) {
          case 'age':
            if (int.tryParse(value) == null || int.parse(value) < 1 || int.parse(value) > 120) {
              errorMessages[key] = 'Please enter a valid age between 1 and 120';
              valid = false;
            }
            break;
          case 'sex':
            if (int.tryParse(value) == null || !(value == '0' || value == '1')) {
              errorMessages[key] = 'Please enter 1 for male, 0 for female';
              valid = false;
            }
            break;
          case 'cp':
            if (int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 3) {
              errorMessages[key] = 'Please enter a value between 0 and 3 for chest pain type';
              valid = false;
            }
            break;
          case 'trestbps':
            if (int.tryParse(value) == null || int.parse(value) < 90 || int.parse(value) > 200) {
              errorMessages[key] = 'Please enter valid resting blood pressure between 90 and 200';
              valid = false;
            }
            break;
          case 'chol':
            if (int.tryParse(value) == null || int.parse(value) < 100 || int.parse(value) > 300) {
              errorMessages[key] = 'Please enter valid cholesterol value between 100 and 600';
              valid = false;
            }
            break;
          case 'fbs':
            if (int.tryParse(value) == null || !(value == '0' || value == '1')) {
              errorMessages[key] = 'Please enter 1 for fasting blood sugar > 120, 0 for below';
              valid = false;
            }
            break;
          case 'restecg':
            if (int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 2) {
              errorMessages[key] = 'Please enter valid resting electrocardiographic result between 0 and 2';
              valid = false;
            }
            break;
          case 'thalach':
            if (int.tryParse(value) == null || int.parse(value) < 70 || int.parse(value) > 200) {
              errorMessages[key] = 'Please enter valid heart rate achieved between 70 and 200';
              valid = false;
            }
            break;
          case 'exang':
            if (int.tryParse(value) == null || !(value == '0' || value == '1')) {
              errorMessages[key] = 'Please enter 1 for exercise induced angina, 0 for no';
              valid = false;
            }
            break;
          case 'oldpeak':
            if (double.tryParse(value) == null || double.parse(value) < 0.0 || double.parse(value) > 6.0) {
              errorMessages[key] = 'Please enter valid ST depression value between 0.0 and 6.0';
              valid = false;
            }
            break;
          case 'slope':
            if (int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 2) {
              errorMessages[key] = 'Please enter a valid slope value between 0 and 2';
              valid = false;
            }
            break;
          case 'ca':
            if (int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 3) {
              errorMessages[key] = 'Please enter valid number of vessels between 0 and 3';
              valid = false;
            }
            break;
          case 'thal':
            if (int.tryParse(value) == null || !(value == '3' || value == '6' || value == '7')) {
              errorMessages[key] = 'Please enter 3 for normal, 6 for fixed defect, 7 for reversible defect';
              valid = false;
            }
            break;
        }
      }
    });

    setState(() {});
    return valid;
  }

  void submit() async {
    if (!isValidInput()) {
      Get.snackbar('Error', 'Please correct the errors', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Map<String, dynamic> inputData = {};
    controllers.forEach((key, controller) {
      if (key == 'oldpeak') {
        inputData[key] = double.tryParse(controller.text) ?? 0.0;
      } else {
        inputData[key] = int.tryParse(controller.text) ?? 0;
      }
    });

    final apiService = ApiService();
    final response = await apiService.predict(inputData);

    if (response == null || response.isEmpty) {
      Get.snackbar('Error', 'API returned no data', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Map<String, dynamic> logistic = response['logistic_regression'] ?? {};
    Map<String, dynamic> decisionTree = response['decision_tree'] ?? {};

    if (logistic['prediction'] == null || decisionTree['prediction'] == null) {
      Get.snackbar('Error', 'Invalid API response: Missing prediction data', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Map<String, dynamic> predictionData = {
      'logistic_prediction': logistic['prediction'] as int? ?? 0,
      'logistic_probability': logistic['probability'] as double? ?? 0.0,
      'decision_tree_prediction': decisionTree['prediction'] as int? ?? 0,
      'decision_tree_probability': decisionTree['probability'] as double? ?? 0.0,
      'date': DateTime.now().toIso8601String(),
    };

    final historyService = HistoryService();
    await historyService.savePrediction(predictionData);

    Get.to(ResultScreen(
      inputData: inputData,
      logisticPrediction: logistic['prediction'] as int? ?? 0,
      logisticProbability: logistic['probability'] as double? ?? 0.0,
      decisionTreePrediction: decisionTree['prediction'] as int? ?? 0,
      decisionTreeProbability: decisionTree['probability'] as double? ?? 0.0,
    ));
  }

  Widget buildInputField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controllers[label],
              keyboardType: label == 'oldpeak'
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.3),
                labelText: label.toUpperCase(),
                labelStyle: const TextStyle(color: Colors.orange),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorMessages.containsKey(label) ? Colors.red : Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorMessages.containsKey(label) ? Colors.red : Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: errorMessages[label],
                errorStyle: const TextStyle(color: Colors.red),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                isValidInput();
              },
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.black.withOpacity(0.7),
                  title: Text(label.toUpperCase(), style: const TextStyle(color: Colors.orange)),
                  content: Text(
                    fieldDescriptions[label] ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Close', style: TextStyle(color: Colors.orange)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
            child: Icon(Icons.help_outline, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        centerTitle: true,
        title: const Text(
          'Input for Prediction',
          style: TextStyle(color: Colors.orange),
        ),
        iconTheme: const IconThemeData(color: Colors.orange),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...controllers.keys.map(buildInputField).toList(),
              const SizedBox(height: 30),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: submit,
                    child: const Text('Predict'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}