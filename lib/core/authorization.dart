import 'package:bash_gid/features/auth/data/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AuthService{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //return Person.fromFireBase(user);
      return user;
    }on FirebaseAuthException catch(e){
      print(e.message);
      switch(e.code){
        case 'invalid-email':
          print('Неверный формат Email');
          SmartDialog.showToast('Неверный формат Email');
          break;
        case 'user-disabled':
          print('Пользователь заблокирован');
          SmartDialog.showToast('Пользователь заблокирован');
          break;
        case 'user-not-found':
            print('Неправильно введен Email или пароль');
            SmartDialog.showToast('Неправильно введен Email или пароль');
        break;
        case 'wrong-password':
          print('Неправильно введен пароль');
          SmartDialog.showToast('Неправильно введен пароль');
          break;
      }
    } catch (e){
      return null;
    }
  }

  Future<User?> registerInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //return Person.fromFireBase(user);
      return user;
    }on FirebaseException catch(e){
      print(e.toString());
      switch(e.code){
        case 'invalid-email':
          print('Неверный формат Email');
          SmartDialog.showToast('Неверный формат Email');
          break;
        case 'weak-password':
          print('Пароль должен содержать мин. 6 знаков');
          SmartDialog.showToast('Пароль должен содержать мин. 6 знаков');
          break;
      }
      return null;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get currentUser{
    return _firebaseAuth.authStateChanges();
        //.map((User? user) => user != null ? Person.fromFireBase(user) : null);
  }

  /*final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Future<String> signInWithEmailAndPassword({String email, String password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    }on FirebaseAuthException catch(e){
      print(e.message);
      switch(e.code){
        case 'user-not-found':
          print('Неправильно введен Email или пароль');
          SmartDialog.showToast('Неправильно введен Email или пароль');
          break;
        case 'wrong-password':
          print('Неправильно введен пароль');
          SmartDialog.showToast('Неправильно введен пароль');
          break;
      }
  }*/

}