import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
  final _authInstance = FirebaseAuth.instance;

  Stream<User?> get authChangeState => _authInstance.authStateChanges();

  User? get currentUser => _authInstance.currentUser;

  String formatError(FirebaseAuthException exc) {
    switch (exc.code) {
      case 'email-already-in-use':
        return 'An account already exists for that email';
      case 'invalid-email':
        return 'That email address looks invalid';
      case 'weak-password':
        return 'Password is too weak — use at least 6 characters';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password';
      case 'too-many-requests':
        return 'Too many attempts. Try again a bit later';
      case 'network-request-failed':
        return 'No internet connection';
      default:
        return 'Something went wrong. Please try again';
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailAndPassword({
    required String email, 
    required String password, 
    required String displayName
  }) async {

    try {
      final credential = await _authInstance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // Update display name after registration
      await credential.user?.updateDisplayName(displayName);

      return credential;
    } 
    on FirebaseAuthException catch(exc){
      throw formatError(exc);
    }

  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {

    try {
      return await _authInstance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
    } on FirebaseAuthException catch(exc) {
      throw formatError(exc);
    }

  }

  // Gust sign up
  Future<UserCredential?> registerAsGuest() async {
    try { 
      final credential = await _authInstance.signInAnonymously(); 
      return credential;
    } on FirebaseAuthException catch (exc) {
      throw formatError(exc);
    }
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
  }

}