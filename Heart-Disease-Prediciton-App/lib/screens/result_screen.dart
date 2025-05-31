import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model_selection_screen.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> inputData;
  final int logisticPrediction;
  final double logisticProbability;
  final int decisionTreePrediction;
  final double decisionTreeProbability;

  const ResultScreen({
    required this.inputData,
    required this.logisticPrediction,
    required this.logisticProbability,
    required this.decisionTreePrediction,
    required this.decisionTreeProbability,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        centerTitle: true,
        title: const Text(
          'Results - Logistic vs Decision Tree',
          style: TextStyle(color: Colors.orange),
        ),
        iconTheme: const IconThemeData(color: Colors.orange),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1B1B1B),
              Color(0xFF2E2E2E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Input Values:',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...inputData.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                '${entry.key.toUpperCase()}: ${entry.value}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
            const SizedBox(height: 40),
            Text(
              'Logistic Regression Prediction: $logisticPrediction (Probability: $logisticProbability)',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Decision Tree Prediction: $decisionTreePrediction (Probability: $decisionTreeProbability)',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.off(() => const ModelSelectionScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Back to Selection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}