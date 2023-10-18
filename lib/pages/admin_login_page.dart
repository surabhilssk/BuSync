import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';

import '../components/access_button.dart';
import '../components/textfield_component.dart';
import '../helper/helper_functions.dart';
import '../themes/colors.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({required this.onTap, super.key});

  final void Function()? onTap;

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),

      //try sign in
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      //pop loading circle
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
    //display any error
    on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: primaryGradient,
        ),
        child: Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo & app name
                  Image.asset(
                    'images/logo.png',
                    height: 150,
                  ),
                  // const Icon(
                  //   Icons.person,
                  //   color: buttonColor,
                  //   size: 150,
                  // ),
                  const SizedBox(height: 30),
                  //email textfield
                  TextFieldComponent(
                    hintText: 'Enter you email ID',
                    obscureText: false,
                    controller: emailController,
                    icon: const Icon(Icons.person),
                  ),

                  const SizedBox(height: 13),

                  //password textfield
                  TextFieldComponent(
                    hintText: 'Enter you password',
                    obscureText: true,
                    controller: passwordController,
                    icon: const Icon(Icons.lock),
                  ),

                  const SizedBox(height: 20),
                  //login button
                  AccessButton(
                    text: 'Login',
                    onTap: login,
                  ),

                  const SizedBox(height: 19),

                  //user login direction
                  GestureDetector(
                    onTap: widget.onTap,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: 'User? ',
                          style: GoogleFonts.poppins(),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Sign In',
                              style: GoogleFonts.poppins(
                                color: buttonFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
