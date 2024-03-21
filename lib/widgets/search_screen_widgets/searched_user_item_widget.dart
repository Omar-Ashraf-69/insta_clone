
import 'package:flutter/material.dart';
import 'package:social_app/models/user.dart';

class SearchedUserItemWidget extends StatelessWidget {
  const SearchedUserItemWidget({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: userModel.profilePic == ''
            ? CircleAvatar(
                radius: 24,
                child: Image.asset('assets/man.png'),
              )
            : CircleAvatar(
                radius: 24,
                child: Image.network(userModel.profilePic),
              ),
        title: Text(
          userModel.displayName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text("@${userModel.userName}"),
      ),
    );
  }
}
