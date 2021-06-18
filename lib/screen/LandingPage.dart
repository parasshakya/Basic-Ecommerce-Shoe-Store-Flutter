import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/constants.dart';

import 'Login.dart';
import 'home.dart';

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        //connection initialized
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<User>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${streamSnapshot.error}'),
                    ),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  //get the user
                  User user = streamSnapshot.data;

                  //if the user is null, we're not logged in
                  if (user == null) {
                    //user not logged in, head to login
                    return LoginPage();
                  } else {
                    //user is logged in, head to homepage
                    return HomePage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text(
                      'Checking Authentication...',
                      style: Constants.regularHeading,
                    ),
                  ),
                );
              },
            );
          }

        //connecting to firebase - loading
        return Scaffold(
          body: Center(
            child: Text('Initializing App...'),
          ),
        );
      },
    );
  }
}