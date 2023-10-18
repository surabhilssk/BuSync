// import 'package:busync/pages/user_feedback_page.dart';
// import 'package:busync/pages/user_homepage.dart';
import 'package:busync/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDrawerIcon extends StatefulWidget {
  const UserDrawerIcon({super.key});

  @override
  State<UserDrawerIcon> createState() => _UserDrawerIconState();
}

class _UserDrawerIconState extends State<UserDrawerIcon> {
  //logout function
  void logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(gradient: primaryGradient),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  //header
                  DrawerHeader(
                    child: Image.asset('images/logo_2.png'),
                  ),

                  const SizedBox(height: 30),
                  //home
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: const Icon(
                        Icons.home,
                        size: 30,
                        color: buttonFontColor,
                      ),
                      title: Text(
                        'H O M E',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: buttonFontColor,
                        ),
                      ),
                      onTap: () {
                        //pop the drawer
                        Navigator.pop(context);
                        //go to the page
                        Navigator.pushNamed(context, '/user_home');
                      },
                    ),
                  ),

                  //student registration
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: const Icon(
                        Icons.group,
                        size: 30,
                        color: buttonFontColor,
                      ),
                      title: Text(
                        'F E E D B A C K',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: buttonFontColor,
                        ),
                      ),
                      onTap: () {
                        //pop the drawer
                        Navigator.pop(context);
                        //go to the registration page
                        Navigator.pushNamed(context, '/user_feedback');
                      },
                    ),
                  ),

                  //feedback review
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: const Icon(
                        Icons.feedback,
                        size: 30,
                        color: buttonFontColor,
                      ),
                      title: Text(
                        'F E E   P A Y M E N T',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: buttonFontColor,
                        ),
                      ),
                      onTap: () {
                        //pop the drawer
                        Navigator.pop(context);
                        //go to the feedback page
                        Navigator.pushNamed(context, '/user_feepayment');
                      },
                    ),
                  ),
                ],
              ),
              //logout
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 20),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    size: 30,
                    color: buttonFontColor,
                  ),
                  title: Text(
                    'L O G O U T',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: buttonFontColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    //logout of account
                    logOut();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
