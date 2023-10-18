import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  //current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  //get collection of posts from firebase
  final CollectionReference feedbacks =
      FirebaseFirestore.instance.collection('Feedbacks');

  //post a feedback
  Future<void> addFeedback(String feedback) {
    return feedbacks.add({
      'UserEmail': user!.email,
      'PostFeedback': feedback,
      'Timestamp': Timestamp.now(),
    });
  }

  //read feedback from database
  Stream<QuerySnapshot> getFeedbacksStream() {
    final feedbacksStream = FirebaseFirestore.instance
        .collection('Feedbacks')
        .orderBy('Timestamp', descending: true)
        .snapshots();
    return feedbacksStream;
  }
}
