import 'package:death_counter/pages/auth_page.dart';
import 'package:death_counter/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Listens to auth state and routes users accordingly
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        // Loading
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // User is signed in
        if(snapshot.hasData) {
          return const MainPage();
        } 

        // User is not signed in
        return const AuthPage();
      },
    );
  }
}