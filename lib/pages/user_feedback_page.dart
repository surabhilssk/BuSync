import 'package:busync/components/data_list_tile.dart';
import 'package:busync/components/feedback_post_button.dart';
import 'package:busync/components/textfield_component.dart';
import 'package:busync/components/user_drawer.dart';
import 'package:busync/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class UserFeedBackPage extends StatelessWidget {
  UserFeedBackPage({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newFeedbackController = TextEditingController();

  void postFeedback() {
    if (newFeedbackController.text.isNotEmpty) {
      String feedback = newFeedbackController.text;
      database.addFeedback(feedback);
    }

    //clear the controller
    newFeedbackController.clear();
  }

  // void deleteFeedback() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => const AlertDialog(
  //       title: Text('Delete Feedback'),
  //       content: Text('Are you sure you want to delete the feedback?'),
  //     ),
  //   );
  // }

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
      drawer: const UserDrawerIcon(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldComponent(
                    hintText: 'Write your Feedback...',
                    obscureText: false,
                    controller: newFeedbackController,
                    icon: const Icon(Icons.edit),
                  ),
                ),
                FeedbackPostButton(onTap: postFeedback),
              ],
            ),
          ),

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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        "No Feedbacks Yet!!",
                        style: GoogleFonts.poppins(),
                      ),
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
                        String feedbackID = feedback.id;
                        //return as a list tile
                        return DataListTile(
                          title: post,
                          subtitle: userEmail,
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  contentTextStyle: GoogleFonts.poppins(
                                      color: buttonColor, fontSize: 16),
                                  titleTextStyle: GoogleFonts.poppins(
                                      color: buttonColor, fontSize: 19),
                                  title: const Text('Delete Feedback'),
                                  content: const Text(
                                      'Are you sure you want to delete the feedback?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        FirebaseFirestore.instance
                                            .collection("Feedbacks")
                                            .doc(feedbackID)
                                            .delete();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: GoogleFonts.poppins(
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            // Navigator.pop(context);
                            icon: const Icon(
                              Icons.delete,
                              color: buttonColor,
                            ),
                          ),
                        );
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
