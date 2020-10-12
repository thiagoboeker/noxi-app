import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noxi/app/modules/authentication/authentication_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //if (snapshot.data.providerData.length == 1) {
          //return TabsScreen(
          // index: 0,
          //);
          //}
          return AuthenticationPage();
        } else {
          return AuthenticationPage();
        }
      },
    );
  }
}
