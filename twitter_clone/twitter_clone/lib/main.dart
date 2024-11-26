import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/firebase_options.dart';
import 'package:twitter_clone/services/DB/dbprovider.dart';
import 'package:twitter_clone/services/auth/auth_gate.dart';
import 'package:twitter_clone/themes/themeprovider.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Themeprovider(),),

        ChangeNotifierProvider(
        create: (context) => DatabaseProvider(),),
    ],
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/',
      routes:{
        '/': (context) => const AuthGate()},
      theme: Provider.of<Themeprovider>(context).themeData,
    );
  }
}