import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_stack/image_stack.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:social_app/screens/edit_user_screen.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/widgets/home_screen_widgets/feeds_post_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';
import 'package:social_app/widgets/shimmer_image_container_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).user!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditUserScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () async {
              await Authentication().signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                user.profilePic == ''
                    ? const CircleAvatar(
                        radius: 34,
                        backgroundImage: AssetImage('assets/man.png'),
                      )
                    : CircleAvatar(
                        radius: 34,
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                Spacer(),
                FollowingCardWidget(
                  label: 'Followers',
                ),
                FollowingCardWidget(
                  label: 'Following',
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      user.displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "@${user.userName}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Follow'),
                      Icon(Icons.add),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSeconderyColor,
                    foregroundColor: kWhiteColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message,
                  ),
                  style: IconButton.styleFrom(
                    foregroundColor: kSeconderyColor,
                    backgroundColor: kWhiteColor,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: kSeconderyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomButtonWidget(
              label: Text(
                "BIO",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              buttonColor: kPinkColor,
            ),
            SizedBox(
              height: 30,
            ),
            TabBar(
              controller: tabController,
              indicatorColor: kSeconderyColor,
              labelColor: kPrimaryColor,
              tabs: [
                Tab(
                  text: 'Photos',
                ),
                Tab(
                  text: 'Posts',
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: getPostsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          log('Error: ${snapshot.error}');
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text(
                              'No Photos found'); // Handle case when no photos are found
                        } else {
                          return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return ShimmerImageContainer(
                                imageUrl: PostModel.fromDocument(
                                        snapshot.data!.docs[index])
                                    .postPic,
                              );
                            },
                          );
                        }
                      },
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: getPostsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          log('Error: ${snapshot.error}');
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text(
                              'No Photos found'); // Handle case when no photos are found
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return FeedPostWidget(
                                postModel: PostModel.fromDocument(
                                    snapshot.data!.docs[index]),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getPostsStream() {
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('posts')
        .where('userId',
            isEqualTo:
                currentUserUid) // Assuming 'userId' field in Firestore represents the user's UID
        .orderBy('date', descending: true)
        .snapshots();
  }
}

class FollowingCardWidget extends StatelessWidget {
  const FollowingCardWidget({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Column(
          children: [
            ImageStack(
              imageSource: ImageSource.Asset,
              imageList: [
                'assets/man.png',
                'assets/woman.png',
              ],
              imageRadius: 30,
              totalCount: 0,
              imageBorderWidth: 2,
              imageBorderColor: kWhiteColor,
            ),
            Text("0 $label"),
          ],
        ),
      ),
    );
  }
}
