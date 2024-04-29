import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_uat_asistencia/utils/ciclo.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> getCollection(String collection) {
    return _firestore.collection('ciclos').doc(ciclo).collection(collection);
  }

  DocumentReference<Map<String, dynamic>> getDocument(
      String collection, String document) {
    return _firestore
        .collection('ciclos')
        .doc(ciclo)
        .collection(collection)
        .doc(document);
  }

  Query<Map<String, dynamic>> getCollectionGroup(String collection) {
    return _firestore.collectionGroup(collection);
  }
}
