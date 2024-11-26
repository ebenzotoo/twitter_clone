import 'package:flutter/material.dart';
import 'package:twitter_clone/components/mydrawer_tile.dart';
import 'package:twitter_clone/pages/profilepage.dart';
import 'package:twitter_clone/pages/searchpage.dart';
import 'package:twitter_clone/pages/settingspage.dart';
import 'package:twitter_clone/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});

  final _auth = AuthService();

  void logout(){
    _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Icon(Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary),
              ),
          
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              const SizedBox(height: 10),
          
              MyDrawerTile(
              title: "HOME", 
              icon: Icons.home, 
              onTap: (){
                Navigator.pop(context);
              }),
          
              MyDrawerTile(title: "PROFILE", 
              icon: Icons.person, 
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProfilePage(uid: _auth.getCurrentUid())
                  )
                  );
              }),
          
               MyDrawerTile(title: "SEARCH", 
              icon: Icons.search, 
              onTap: (){          
                Navigator.push(context, 
                MaterialPageRoute
                (builder: (context) => SearchPage(),),);
              }),
          
               MyDrawerTile(title: "SETTINGS", 
              icon: Icons.settings, 
              onTap: (){
                Navigator.pop(context);
          
                Navigator.push(context, 
                MaterialPageRoute
                (builder: (context) => const SettingsPage(),),);
              }
              ),

              const Spacer(),

              MyDrawerTile(title: "LOG OUT", 
              icon: Icons.logout, 
              onTap: logout)
            ],
          ),
        ),
      ),
    );
  }
}