import 'package:bash_gid/features/auth/presentation/screens/auth.dart';
import 'package:bash_gid/features/home/presentation/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/models/person.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   final Person? user = Provider.of<Person?>(context);
  //   final bool isLoggedIn = user != null;
  //
  //   return isLoggedIn ? HomePage() : AuthorizationPage();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const AuthorizationPage();
          }
          return HomePage(user: snapshot.data!);
        },
    );
  }

}
