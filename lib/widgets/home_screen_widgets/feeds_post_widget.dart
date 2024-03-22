import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/screens/auth/comment_screen.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/widgets/shimmer_image_container_widget.dart';

class FeedPostWidget extends StatefulWidget {
  const FeedPostWidget({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;

  @override
  State<FeedPostWidget> createState() => _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  int count = 0;
  getCommentsCount() async {
    QuerySnapshot commentCounter = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postModel.postId)
        .collection('comments')
        .get();
    if (this.mounted) {
      setState(() {
        count = commentCounter.docs.length;
      });
    }
  }

  @override
  void initState() {
    getCommentsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  8,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      widget.postModel.profilePic == ''
                          ? CircleAvatar(
                              radius: 24,
                              child: Image.asset('assets/man.png'),
                            )
                          : CircleAvatar(
                              radius: 24,
                              child: Image.network(widget.postModel.profilePic),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.postModel.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text("@${widget.postModel.userName}")
                        ],
                      ),
                      const Spacer(),
                      Text(DateFormat('dd/MM/yyyy HH:mm')
                          .format(widget.postModel.date)),
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ShimmerImageContainer(
                        imageUrl: widget.postModel.postPic)),
                // Container(
                //   height: 300,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     image: DecorationImage(
                //       image: NetworkImage(postModel.postPic),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.postModel.description,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                            right: 12,
                          ),
                          child: IconButton(
                            onPressed: () {
                              CloudMethods().likePost(
                                uId: widget.postModel.userId,
                                postId: widget.postModel.postId,
                                like: widget.postModel.like,
                              );
                              getCommentsCount();
                            },
                            icon: widget.postModel.like
                                    .contains(widget.postModel.userId)
                                ? Icon(
                                    Icons.favorite,
                                    color: kPrimaryColor,
                                  )
                                : const Icon(Icons.favorite_border_outlined),
                          )),
                      Text(widget.postModel.like.length.toString()),
                      Padding(
                          padding: const EdgeInsets.only(
                            right: 12,
                            left: 12,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommentScreen(
                                      postId: widget.postModel.postId,
                                    ),
                                  ));
                              getCommentsCount();
                            },
                            icon: const Icon(Icons.comment_outlined),
                          )),
                      Text(count.toString()),
                    ],
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
