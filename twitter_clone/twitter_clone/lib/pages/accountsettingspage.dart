





import 'package:flutter/material.dart';
import 'package:twitter_clone/services/auth/auth_service.dart';


class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}




class _AccountSettingsPageState extends State<AccountSettingsPage> {

  void confirmDeletion(BuildContext content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete this account?"),
        actions:[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")
          ),

          TextButton(
            onPressed: () async{

              await AuthService().deleteAccount();

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route)=> false,
              );

            },
            child: const Text("Delete")
          ),
        ]
      )
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: Column(
        children:[
          GestureDetector(
            onTap: () => confirmDeletion(context),
                child: Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8)),
              
              child: Center(
                child: Text("Delete Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
              ),
          ),
        ]

      ),
    );
  }
}