import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/widgets/home_screen_widgets/feeds_post_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/app_name_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final Stream<QuerySnapshot> _postsStream =
  //     FirebaseFirestore.instance.collection('posts').snapshots();
  final Stream<QuerySnapshot> postsStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date', descending: true)
      .snapshots(includeMetadataChanges: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt_outlined),
        ),
        title: const AppNameWidget(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // List<PostModel> posts = [];
          // for (int i = 0; i < snapshot.data!.docs.length; i++) {
          //   posts.add(PostModel.fromDocument(snapshot.data!.docs[i]));
          // }
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20,
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => FeedPostWidget(
                postModel: PostModel.fromDocument(snapshot.data!.docs[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
