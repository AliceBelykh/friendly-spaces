/*
    This database stores notes that users created in the app.
    It is stored in subcollection called 'Notes' in Firebase. or not

    Each note contains:
    - a text
    - an emotion string
    - timestamp
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  //current logged in user
  User? user;

  FirestoreDatabase(this.user);

  //get collection of users
  // late final CollectionReference users =
  // FirebaseFirestore.instance.collection('Users');

  //get collection of notes from firebase
  // final CollectionReference notes = FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(user!.email)
  //     .collection('Notes');

  //[[text, emotion], [text, emotion]]
  List todayNotesList = [];
  DateTime? startDate;

  //add a note
  // Future<void> addNote(String text, String emotion, DateTime date) {
  //   todayNotesList.add([text, emotion]);
  //   return notes.add({
  //     'noteText': text,
  //     'emotion': emotion,
  //     'timestamp': Timestamp.fromDate(date)
  //   });
  // }

  //delete note

  //edit note

  //read notes from firebase (for a date, for a user)
  // Stream<QuerySnapshot> getNotes() {
  //   final notesStream = FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user!.email)
  //       .collection('Notes')
  //       .snapshots();
  //
  //   return notesStream;
  // }

  // Future<void> getNotes(DateTime date) {
  //   var timestamp = Timestamp.fromDate(date);
  //
  //   return notes.where("timestamp", isEqualTo: timestamp).get().then(
  //     (querySnapshot) {
  //       print("Successfully completed");
  //       todayNotesList.clear();
  //       for (var docSnapshot in querySnapshot.docs) {
  //         todayNotesList
  //             .add([docSnapshot.get('noteText'), docSnapshot.get('emotion')]);
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }

  //read start date from user
  // getStartDate() {
  //   users.doc(user!.email).get().then(
  //     (DocumentSnapshot doc) {
  //       print('getStartDate');
  //       startDate = doc.get('startDate').toDate();
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  // }
}
