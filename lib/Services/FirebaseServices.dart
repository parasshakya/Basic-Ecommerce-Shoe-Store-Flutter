import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  //Firebase Auth Services
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Get user ID
  String getUserID() {
    return _firebaseAuth.currentUser.uid;
  }

  //Firebase Cloud Firestore Services

  final CollectionReference productsRef = FirebaseFirestore.instance.collection('Products');
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');

}