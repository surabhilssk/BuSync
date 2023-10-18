import 'package:busync/components/data_list_tile_admin.dart';
import 'package:busync/database/firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/drawer.dart';
import '../themes/colors.dart';

class FeedBackPage extends StatelessWidget {
  FeedBackPage({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Feedback',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: primaryGradient,
          ),
        ),
      ),
      drawer: const DrawerIcon(),
      body: Column(
        children: [
          //FEEDBACKS
          StreamBuilder(
              stream: database.getFeedbacksStream(),
              builder: (context, snapshot) {
                //laoding circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                //get all feedbacks
                final posts = snapshot.data!.docs;

                //no data?
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No feedbacks yet!!"),
                    ),
                  );
                }

                //return a list
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, int index) {
                        //get individual feedbacks
                        final feedback = posts[index];
                        //get data from each feedback
                        String post = feedback['PostFeedback'];
                        String userEmail = feedback['UserEmail'];
                        // Timestamp timeStamp = feedback['Timestamp'];

                        //return as a list tile
                        return DataListTileAdmin(
                            title: post, subtitle: userEmail);
                      },
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
