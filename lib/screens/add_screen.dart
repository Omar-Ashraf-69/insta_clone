import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_app/colors/app_colors.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

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
                onPressed: () {},
                child: const Text(
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
                const Expanded(
                  child: TextField(
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
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
                child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/woman.png'),
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
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
}
