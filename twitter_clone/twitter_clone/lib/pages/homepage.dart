
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/components/mydrawer.dart';
import 'package:twitter_clone/components/myinputalertbox.dart';
import 'package:twitter_clone/components/mypost_tile.dart';
import 'package:twitter_clone/helper/pagenavigator.dart';
import 'package:twitter_clone/services/DB/dbprovider.dart';

import '../models/post.dart';





class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final listeningProvider =  Provider.of<DatabaseProvider>(context);
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);



  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadAllPosts();
  }

    Future<void> loadAllPosts() async{
      await databaseProvider.loadAllPosts();
    }



  void _openPostMessageBox() {
    showDialog(context: context, 
    builder: (context) => MyInputAlertBox(
      textController: _messageController, 
      hintText: 'Say something...', 
      onPressed: ()  async{
        await postMessage(_messageController.text);
      }, 
      onPressedText: "Post"
      )
   );
  }


  Future<void> postMessage( String message) async{
    await databaseProvider.postMessage(message);
 
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer:  MyDrawer(),
        appBar: AppBar(
          title: const Text("HOME"),
          foregroundColor: Theme.of(context).colorScheme.primary,
          bottom:  TabBar(
          dividerColor: Colors.transparent,
          labelColor:  Theme.of(context).colorScheme.inversePrimary,
          unselectedLabelColor:  Theme.of(context).colorScheme.primary,
          indicatorColor:  Theme.of(context).colorScheme.secondary,
          tabs:const [
            Tab(
              text: ("For you"),
            ),
            Tab(
              text: ("Following"),
            )
          ] 
        ),
        ),
      
      
        floatingActionButton: FloatingActionButton(
          onPressed: _openPostMessageBox,
          child: const Icon(Icons.add),
          ),
        
        body: TabBarView(
          children: [
            _buildPostList(listeningProvider.allPosts),
            _buildPostList(listeningProvider.followingPosts)
          ]),
      ),
    );
  }

   Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty 
      ?

    const Center(
      child: Text("Nothing here"),
    )
    :

    ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return MyPostTile(post: post,
        onUserTap: () =>goUserPage(context, post.uid),
        onPostTap: () =>goPostPage(context, post),
        );
    },
    );
  }
}