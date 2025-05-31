import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.97.21.203:8000";

  Future<Map<String, dynamic>> predict(Map<String, dynamic> inputData) async {
    final url = Uri.parse('$baseUrl/predict');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(inputData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); 
      } else {
        throw Exception('Failed to get prediction');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }
}
