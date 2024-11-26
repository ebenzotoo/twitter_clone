import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/components/mysettings_tile.dart';
import 'package:twitter_clone/themes/themeprovider.dart';

import '../helper/pagenavigator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        title: Center(child: const Text('SETTINGS')),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: Column(
        children: [

          MySettingsTile(title: 'Dark Mode', 
          action: CupertinoSwitch(
              onChanged: (value) => Provider.of<Themeprovider>(
                context, listen: false).toggleTheme(),
              value: Provider.of<Themeprovider>(
                context, listen: false).isDarkMode),
          ),

          MySettingsTile(
            title:"Blocked Users",
            action:  IconButton(
              onPressed: () => goBlockedUsersPage(context),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ),
              ),

          MySettingsTile(
            title:"Account Settings",
            action: IconButton(
              onPressed: () => goAccountSettingsPage(context),
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.primary
                ),
            ),
          )
        ],
      ),
    );
  }
}