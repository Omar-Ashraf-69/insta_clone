import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/widgets/home_screen_widgets/feeds_post_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';
import 'package:social_app/widgets/profile_screen_widgets/cons.dart';
import 'package:social_app/widgets/profile_screen_widgets/following_card_widget.dart';
import 'package:social_app/widgets/shimmer_image_container_widget.dart';

class ViewUserProfileScreen extends StatefulWidget {
  const ViewUserProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<ViewUserProfileScreen> createState() => _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  bool isFollowing = false;
  int followersCount = 0;
  int followingCount = 0;
  getFollowersAndFollwingCount() async {
    dynamic userInfo = await getUserDetials(uid: widget.user.userId);
    isFollowing =
        userInfo['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
    if (mounted) {
      setState(() {
        followersCount = userInfo['followers'].length;
        followingCount = userInfo['following'].length;
      });
    }
  }

  @override
  void initState() {
    getFollowersAndFollwingCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.user.profilePic == ''
                    ? const CircleAvatar(
                        radius: 34,
                        backgroundImage: AssetImage('assets/man.png'),
                      )
                    : CircleAvatar(
                        radius: 34,
                        backgroundImage: NetworkImage(widget.user.profilePic),
                      ),
                Spacer(),
                FollowingCardWidget(
                  label: 'Followers',
                  counter: followersCount.toString(),
                ),
                FollowingCardWidget(
                  label: 'Following',
                  counter: followingCount.toString(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      widget.user.displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "@${widget.user.userName}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    dynamic currentUser = await getUserDetials(
                        uid: FirebaseAuth.instance.currentUser!.uid);
                    CloudMethods().followUser(
                      uId: widget.user.userId,
                      following: currentUser['following'],
                      followers: widget.user.followers,
                    );
                    await getFollowersAndFollwingCount();
                  },
                  child: isFollowing
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Following'),
                            Icon(Icons.check),
                          ],
                        )
                      : Row(
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
            widget.user.bio == ''
                ? CustomButtonWidget(
                    label: Text(
                      "BIO",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    buttonColor: kPinkColor,
                  )
                : CustomButtonWidget(
                    label: Text(
                      widget.user.bio!,
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
                      stream: getPostsStream(userId: widget.user.userId),
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
                          return const Center(
                            child: Text('No Photos found'),
                          ); // Handle case when no photos are found
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
                      stream: getPostsStream(userId: widget.user.userId),
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
                          return const Center(
                            child: Text('No Posts found'),
                          ); // Handle case when no photos are found'); // Handle case when no photos are found
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
}
