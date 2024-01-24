import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({super.key});

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  //logout user
  logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
              ],
            ));
          }
          //error
          else if (snapshot.hasError) {
            return Text("error ${snapshot.error}");
          }
          //data received
          else if (snapshot.hasData) {
            //extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                children: [
                  //log out
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: logOut, icon: Icon(Icons.logout), iconSize: 30,),
                    ],
                  ),

                  SizedBox(
                    height: 130,
                  ),

                  //profile pic
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, size: 120),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //username
                  Text(
                    user!['userName'],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  //user email
                  Text(user['email']),

                  //add space button

                  //spaces list

                ],
              ),
            );
          } else {
            return Text('no data');
          }
        },
      ),
    );
  }
}
