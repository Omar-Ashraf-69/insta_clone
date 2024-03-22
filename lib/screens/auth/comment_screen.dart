import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_text_field.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.postId});
  final String postId;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.postId)
                      .collection('comments')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error: ${snapshot.error}');
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Comments found 🙃',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ); // Handle case when no photos are found
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => CommentWidget(
                          comment: snapshot.data!.docs[index]['comment'],
                          displayName: snapshot.data!.docs[index]
                              ['displayName'],
                          profilePic: snapshot.data!.docs[index]['profilePic'],
                        ),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: CustomTextField(
                        label: 'Write a comment',
                        textEditingController: messageController,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: kPrimaryColor,
                      foregroundColor: kWhiteColor,
                    ),
                    onPressed: () async {
                      isLoading = true;

                      setState(() {});
                      await postComment(
                        message: messageController.text,
                        uId: userData.userId,
                        displayName: userData.displayName,
                        profilePic: userData.profilePic,
                      );
                      FocusScope.of(context).unfocus();

                      isLoading = false;
                      setState(() {});
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: kWhiteColor,
                          )
                        : const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  postComment({
    required String message,
    required String uId,
    required String displayName,
    required String profilePic,
  }) async {
    String comment = messageController.text;
    String res = await CloudMethods().commentToPost(
      uId: uId,
      postId: widget.postId,
      comment: comment,
      displayName: displayName,
      profilePic: profilePic,
    );
    if (res == 'success') {
      messageController.clear();
    }
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.profilePic,
    required this.displayName,
    required this.comment,
  });
  final String profilePic;
  final String displayName;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profilePic == ''
              ? const CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage('assets/man.png'),
                )
              : CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(profilePic),
                ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
