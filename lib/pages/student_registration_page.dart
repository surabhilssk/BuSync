import 'package:busync/components/access_button.dart';
import 'package:busync/components/textfield_component.dart';
import 'package:busync/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/drawer.dart';
import '../themes/colors.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //match passwords
    if (passwordController.text != confirmPwController.text) {
      //pop loading circle
      Navigator.pop(context);

      //display error message
      displayMessageToUser('Password doesn\'t match!', context);
    }

    //try creating users
    else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //create user document and add it to firestore
        createUserDocument(userCredential);

        if (context.mounted) Navigator.pop(context);
        displayMessageToUser('Registration Successfull', context);
      } on FirebaseAuthException catch (e) {
        //pop loading circle
        Navigator.pop(context);

        //display error message
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'userName': userNameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Registration',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: primaryGradient,
          ),
        ),
      ),
      drawer: const DrawerIcon(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 80, 25, 0),
          child: Column(
            children: [
              //header icon
              Image.asset(
                'images/user_registration.png',
                height: 140,
              ),
              const SizedBox(height: 20),
              //header text
              Text(
                'Enter Student Details',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 19),
              //enter username
              TextFieldComponent(
                hintText: 'Username',
                obscureText: false,
                controller: userNameController,
                icon: const Icon(Icons.person),
              ),

              const SizedBox(height: 10),

              //enter email
              TextFieldComponent(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
                icon: const Icon(Icons.alternate_email),
              ),

              const SizedBox(height: 10),

              //confirm email
              TextFieldComponent(
                hintText: 'Password',
                obscureText: false,
                controller: passwordController,
                icon: const Icon(Icons.lock),
              ),

              const SizedBox(height: 10),

              //enter password
              TextFieldComponent(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPwController,
                icon: const Icon(Icons.lock_outline_rounded),
              ),

              const SizedBox(height: 20),

              //register button
              AccessButton(
                text: 'Register',
                onTap: registerUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
