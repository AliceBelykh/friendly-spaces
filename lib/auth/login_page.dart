import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendly_spaces/helper/helper_functions.dart';
import 'package:friendly_spaces/my_components/my_button.dart';
import 'package:friendly_spaces/my_components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async {
    //show loading circle
    showDialog(context: context,
        builder: (context) =>
        const Center(child: CircularProgressIndicator(),));

    //try sing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    }

    //display any errors
    on FirebaseAuthException catch(e) {
      //pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(Icons.circle_outlined,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .inversePrimary, size: 120),
                  const SizedBox(height: 20,),
                  //app name
                  const Text(
                    "Friendly Spaces",
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 20,),
                  //email
                  MyTextField(
                      hintText: "Email",
                      obscureText: false,
                      controller: emailController),
                  const SizedBox(height: 10,),

                  //password
                  MyTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: passwordController),
                  const SizedBox(height: 10,),

                  //forgot password
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot password?"),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  //sign in button
                  MyButton(text: "Login", onTap: login,),
                  const SizedBox(height: 10,),

                  //don't have an account? register here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text("Register here",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
