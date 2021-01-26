import 'package:firebase_auth/firebase_auth.dart';
class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<AuthResult> register(String email, String password)async{
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return result;
  }

  Future<AuthResult> signIn(String email, String password)async{
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result;
  }

  Future<void> signOut() async{
     await _auth.signOut();
  }

 Future<FirebaseUser> getCurrentUser()async{
 final  _currentUser= await _auth.currentUser();
  return _currentUser;
  }
}