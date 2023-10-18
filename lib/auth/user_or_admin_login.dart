import 'package:busync/pages/admin_login_page.dart';
import 'package:busync/pages/login_page.dart';
import 'package:flutter/material.dart';

class UserOrAdmin extends StatefulWidget {
  const UserOrAdmin({super.key});

  @override
  State<UserOrAdmin> createState() => _UserOrAdminState();
}

class _UserOrAdminState extends State<UserOrAdmin> {
  //initially show login page for user
  bool showLoginPage = true;

  //toggle between user login and admin login
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return AdminLoginPage(onTap: togglePage);
    }
  }
}
