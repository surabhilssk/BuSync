import 'package:busync/auth/user_or_admin_login.dart';
//import 'package:busync/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../pages/admin_homepage.dart';
import '../pages/user_homepage.dart';

class AuthPageAdmin extends StatefulWidget {
  const AuthPageAdmin({super.key});

  @override
  State<AuthPageAdmin> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              // return const AdminHomePage();
              final data = snapshot.data;
              const adminEmail = 'surabhil.s.kumar@gmail.com';
              if (data?.email == adminEmail) {
                return const AdminHomePage();
              } else {
                return const UserHomePage();
              }
            }
            //user is not loggen in
            else {
              return const UserOrAdmin();
            }
          }),
    );
  }
}
