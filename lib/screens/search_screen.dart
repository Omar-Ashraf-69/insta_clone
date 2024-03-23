import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/view_user_profile_screen.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_text_field.dart';
import 'package:social_app/widgets/search_screen_widgets/searched_user_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Find Users",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            CustomTextField(
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_outlined,
                    color: kPrimaryColor,
                  )),
              label: 'Search users',
              textEditingController: searchController,
              onChanged: (value) {
                searchController.text = value;
                setState(() {});
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: searchController.text.isEmpty
                  ? const Center(
                      child: Text('Enter a search query'),
                    )
                  : FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where('userName',
                              isGreaterThanOrEqualTo: searchController.text)
                          .where('userName',
                              isLessThan: '${searchController.text}z')
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // Show a loading indicator while waiting for data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text(
                              'No users found'); // Handle case when no users are found
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewUserProfileScreen(
                                            user: UserModel.fromDocument(
                                                snapshot.data!.docs[index]),
                                          )),
                                );
                              },
                              child: SearchedUserItemWidget(
                                userModel: UserModel.fromDocument(
                                    snapshot.data!.docs[index]),
                              ),
                            ), // Removed const from here
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
