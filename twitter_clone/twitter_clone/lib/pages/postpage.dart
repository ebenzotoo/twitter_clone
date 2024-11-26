import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/components/mycomment_tile.dart';
import 'package:twitter_clone/components/mypost_tile.dart';
import 'package:twitter_clone/helper/pagenavigator.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/services/DB/dbprovider.dart';


class PostPage extends StatefulWidget {
  final Post post;

  const PostPage({super.key,
  required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);


  @override
  Widget build(BuildContext context) {

    final allComments = listeningProvider.getComments(widget.post.id);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),


      body: ListView(
        children: [
          MyPostTile(post: widget.post, 
          onUserTap: () => goUserPage(context, widget.post.uid), 
          onPostTap: () {},
          ),

          allComments.isEmpty
          ?
          Center(child: Text("No comments yet..."),)

          :

          ListView.builder(
            itemCount: allComments.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
            final comment = allComments[index];

            return MyCommentTile(
              comment:comment, 
              onUserTap: () =>goUserPage(context, comment.uid),
            );
          },
         )
        ],
      ),
    );
  }
}