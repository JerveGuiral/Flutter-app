import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _predictionsCollection = 'predictions';

  static Future<void> savePrediction({
    required String label,
    required double confidence,
    required String timestamp,
  }) async {
    try {
      print('Saving prediction: $label - $confidence');
      await _db.collection(_predictionsCollection).add({
        'label': label,
        'confidence': confidence,
        'timestamp': timestamp,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Prediction saved successfully');
    } catch (e) {
      print('Firestore error: $e');
      throw Exception('Failed to save prediction: $e');
    }
  }

  static Stream<QuerySnapshot> getPredictions() {
    return _db
        .collection(_predictionsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Future<int> getPredictionCount() async {
    try {
      final snapshot = await _db.collection(_predictionsCollection).count().get();
      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }
}