import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final _firestoreInstance = FirebaseFirestore.instance;

  FirebaseFirestore get firestoreInstance => _firestoreInstance;
  
  CollectionReference<Map<String, dynamic>> gamesCollection(String uid) {
    return _firestoreInstance.collection('users').doc(uid).collection('games');
  }

  CollectionReference<Map<String, dynamic>> bossesCollection(String uid, String gameId) {
    return _firestoreInstance.collection('users').doc(uid).collection('games').doc(gameId).collection('bosses');
  }

}