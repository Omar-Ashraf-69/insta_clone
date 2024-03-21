import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/widgets/shimmer_image_container_widget.dart';

class FeedPostWidget extends StatelessWidget {
  const FeedPostWidget({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;
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
                      postModel.profilePic == ''
                          ? CircleAvatar(
                              radius: 24,
                              child: Image.asset('assets/man.png'),
                            )
                          : CircleAvatar(
                              radius: 24,
                              child: Image.network(postModel.profilePic),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postModel.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text("@${postModel.userName}")
                        ],
                      ),
                      const Spacer(),
                      Text(DateFormat('dd/MM/yyyy HH:mm')
                          .format(postModel.date)),
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ShimmerImageContainer(imageUrl: postModel.postPic)),
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
                  postModel.description,
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
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border_outlined),
                          )),
                      Text(postModel.like.toString()),
                      Padding(
                          padding: const EdgeInsets.only(
                            right: 12,
                            left: 12,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.comment_outlined),
                          )),
                      const Text('12'),
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
