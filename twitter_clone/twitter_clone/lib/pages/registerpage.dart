import 'package:flutter/material.dart';
import 'package:twitter_clone/components/mybuttons.dart';
import 'package:twitter_clone/components/myloadingcircle.dart';
import 'package:twitter_clone/components/mytextfield.dart';
import 'package:twitter_clone/services/DB/dbservice.dart';
import 'package:twitter_clone/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
final Function()? onTap;
  const RegisterPage({super.key,
  required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _auth = AuthService();
  final _db = DatabaseService();

  final TextEditingController nameController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();


  void register() async {
    if (passwordController.text == confirmpasswordController.text) {
      showLoadingCircle(context);

      try {
        await _auth.registerEmailPassword(
          emailController.text, 
          passwordController.text
          );

        if(mounted) hideLoadingCircle(context);


        await _db.savedUserInfoInFirebase(
        name: nameController.text, 
        email: emailController.text);
      }

      catch(e) {
        if(mounted) hideLoadingCircle(context);

        if (mounted) {
          showDialog(context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
         );
        }
      }
    }

        else{
          showDialog(context: context, 
          builder: (context) => const AlertDialog(
            title: Text("Passwords don't match"),
          ),
        );
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
          
                Text("Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary
                ),),
          
                const SizedBox(height: 25),
          
                MyTextField(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                 MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                ),

                const SizedBox(height: 10,),
          
                 MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                ),

                 const SizedBox(height: 10),
          
                 MyTextField(
                controller: confirmpasswordController,
                hintText: 'Confirm password',
                obscureText: true,
                ),


                 const SizedBox(height: 25),

                  MyButton(
                    text: "Register",
                    onTap: register
                    ),

                    const SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a member?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                        ),),

                        const SizedBox(width: 5),

                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text("Login now",
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