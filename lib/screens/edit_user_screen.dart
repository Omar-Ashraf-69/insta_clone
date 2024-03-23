import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/helpers/picker.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_text_field.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  @override
  Uint8List? profilePic;
  bool isUpdating = false;
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).user!;
    TextEditingController displayNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Profile Detials",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    profilePic == null
                        ? const CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage('assets/man.png'),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(profilePic!),
                          ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        onPressed: () async {
                          Uint8List? file = await pickImage();
                          setState(() {
                            profilePic = file;
                          });
                        },
                        alignment: Alignment.bottomRight,
                        style: IconButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(
                          Icons.edit,
                          size: 22,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                prefixIcon: const Icon(Icons.person_outline),
                label: 'Display Name',
                hintText: userData.displayName,
                textEditingController: displayNameController,
                isLabelSticked: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                prefixIcon: const Icon(Icons.person_outline),
                label: 'User Name',
                hintText: userData.userName,
                textEditingController: userNameController,
                isLabelSticked: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                prefixIcon: const Icon(Icons.person_outline),
                label: 'Bio',
                hintText: userData.bio,
                textEditingController: bioController,
                isLabelSticked: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonWidget(
                label: isUpdating
                    ? Center(
                        child: CircularProgressIndicator(
                          color: kWhiteColor,
                        ),
                      )
                    : Text(
                        "Update".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kWhiteColor,
                        ),
                      ),
                onTap: () async {
                  setState(() {
                    isUpdating = true;
                  });
                  await update(
                    displayName: displayNameController.text.isEmpty
                        ? userData.displayName
                        : displayNameController.text,
                    userName: userNameController.text.isEmpty
                        ? userData.userName
                        : userNameController.text,
                    bio: bioController.text.isEmpty ? "" : bioController.text,
                    file: profilePic,
                    uId: userData.userId,
                    context: context,
                  );
                  setState(() {
                    isUpdating = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  update({
    required String displayName,
    required String userName,
    required String bio,
    Uint8List? file,
    required String uId,
    required BuildContext context,
  }) async {
    String res = await CloudMethods().editProfile(
      displayName: displayName,
      uId: uId,
      userName: userName,
      bio: bio,
      file: file,
    );

    if (res == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated")),
      );
      Navigator.of(context).pop();
    } else {
      throw Exception(res);
    }
    Provider.of<UserProvider>(context, listen: false).getUserDetails();
  }
}
