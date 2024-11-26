
import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/homepage.dart';
import 'package:twitter_clone/pages/profilepage.dart';

import '../models/post.dart';
import '../pages/accountsettingspage.dart';
import '../pages/blockeduserspage.dart';
import '../pages/postpage.dart';

void goUserPage(BuildContext context, String uid) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => ProfilePage(uid: uid),
    ),
  );
}


void goPostPage(BuildContext context, Post post) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => PostPage(post: post),
    )
  );
}


void goBlockedUsersPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => BlockedUsersPage(),
    ),
  );
}


void goAccountSettingsPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => AccountSettingsPage(),
    ),
  );
}


void goHomePage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Homepage(),
    ),

    (route) => route.isFirst,
  );
}