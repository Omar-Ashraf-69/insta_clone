import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/helpers/picker.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:social_app/services/cloud.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Uint8List? file;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Post",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 5.0,
              top: 8,
            ),
            child: TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  uploadPost(
                    user:
                        Provider.of<UserProvider>(context, listen: false).user!,
                  );
                },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Post",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12,
          top: 14,
          bottom: 22,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Image.asset('assets/man.png'),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: 25,
                        left: 15,
                      ),
                      hintText: 'Type here...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: file == null
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(file!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                file = await pickImage();
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 35,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: kWhiteColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadPost({required UserModel user}) async {
    isLoading = true;
    setState(() {});
    try {
      await CloudMethods().addPost(
        userId: user.userId,
        displayName: user.displayName,
        userName: user.userName,
        file: file!,
        description: controller.text,
      );
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    setState(() {});
  }
}
