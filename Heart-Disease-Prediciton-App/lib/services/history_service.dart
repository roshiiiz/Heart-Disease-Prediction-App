import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> savePrediction(Map<String, dynamic> predictionData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('history')
          .add(predictionData);
    }
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('history')
          .get();
      return snapshot.docs.map((doc) {
        return {
          'docId': doc.id,
          'logistic_prediction': doc['logistic_prediction'],
          'logistic_probability': doc['logistic_probability'],
          'decision_tree_prediction': doc['decision_tree_prediction'],
          'decision_tree_probability': doc['decision_tree_probability'],
          'date': doc['date'],
        };
      }).toList();
    }
    return [];
  }

  Future<void> deleteHistory(String docId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('history')
          .doc(docId)
          .delete();
    }
  }
}
