import 'package:bash_gid/core/authorization.dart';
import 'package:bash_gid/core/auth_gate.dart';
import 'package:bash_gid/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'features/auth/data/models/person.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BashGidApp());
}

//void main() => runApp(const BashGidApp());

class BashGidApp extends StatelessWidget {
  const BashGidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /*Provider<AuthService>(
            create: (_) => AuthService(),
        ),*/
        StreamProvider<User?>.value(
            value: AuthService().currentUser,
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: kLightTheme,
        home: const AuthGate(),
          //Smart Dialog
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget{
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw Container();
  }
}



