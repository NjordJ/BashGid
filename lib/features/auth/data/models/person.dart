import 'package:firebase_auth/firebase_auth.dart';

class Person{
  String? id;
  String? name;

  Person.fromFireBase(User? user){
    id = user!.uid;
    name = user.displayName!;
  }
}