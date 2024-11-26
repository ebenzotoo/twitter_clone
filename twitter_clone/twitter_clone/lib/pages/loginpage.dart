import 'package:flutter/material.dart';
import 'package:twitter_clone/components/mybuttons.dart';
import 'package:twitter_clone/components/myloadingcircle.dart';
import 'package:twitter_clone/components/mytextfield.dart';
import 'package:twitter_clone/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;


  const LoginPage({super.key,
  required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = AuthService();


  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async{

    showLoadingCircle(context);

    try{
      await _auth.loginEmailPassword(
        emailController.text, 
        passwordController.text);

    if (mounted) hideLoadingCircle(context);
    }
    catch(e) {
    if (mounted) hideLoadingCircle(context);

    if (mounted) {
      showDialog(context: context, 
      builder: (context)  => AlertDialog(
        title: Text(e.toString()),
      ),
      );
    }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_open_rounded,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
                ),
          
                const SizedBox(height: 50),
          
                Text("Welcome you've been missed!",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary
                ),),
          
                const SizedBox(height: 25),
          
                MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                 MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                ),

                const SizedBox(height: 10,),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text('forgot password?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  ),
                  )
                  ),

                  const SizedBox(height: 25),

                  MyButton(
                    text: "Login",
                    onTap: login,
                    ),

                    const SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not a member?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                        ),),

                        const SizedBox(width: 5),

                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text("Register now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold
                          ),))
                      ],
                    )

              ],
            ),
          ),
        ),
      ),
    );
  }
}