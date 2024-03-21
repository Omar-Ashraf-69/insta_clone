import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
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
                CircleAvatar(
                  radius: 34,
                  backgroundImage: AssetImage('assets/valley of the kings.jpg'),
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
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "KKK",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                "@omar",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButtonWidget(
              label: Text(
                "aaa",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Photos',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Posts',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.3,
            ),
          ],
        ),
      ),
    );
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
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/man.png'),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/woman.png'),
                ),
              ],
            ),
            Text("0 $label"),
          ],
        ),
      ),
    );
  }
}
