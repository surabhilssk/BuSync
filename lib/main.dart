import 'package:busync/auth/auth.dart';
import 'package:busync/firebase_options.dart';
import 'package:busync/pages/admin_homepage.dart';
import 'package:busync/pages/admin_notification_page.dart';
import 'package:busync/pages/feedback_page.dart';
import 'package:busync/pages/student_registration_page.dart';
import 'package:busync/pages/user_feedback_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/user_feepayment_page.dart';
import 'pages/user_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuSync',
      // home: const AuthPageAdmin(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const AuthPageAdmin(),
        '/admin_home': (context) => const AdminHomePage(),
        '/admin_notification': (context) => const AdminNotificationPage(),
        '/student_registration': (context) => const StudentRegistration(),
        '/feedback_review': (context) => FeedBackPage(),
        '/user_home': (context) => const UserHomePage(),
        '/user_feedback': (context) => UserFeedBackPage(),
        '/user_feepayment': (context) => const UserFeePaymentPage(),
      },
      home: const AuthPageAdmin(),
    );
  }
}
