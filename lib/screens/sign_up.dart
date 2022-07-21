import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Card(
          elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email")
                          ),
                    )
                  ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextFormField(
              obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password")
                          ),
                    )
                  ),
                  ElevatedButton(
                              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 20))),
                              child: Text("Submit", style:TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: signUp
                        ),

            Container(
              padding: EdgeInsets.all(20),
              child: RichText(text: TextSpan(text: "Have an account? ", style: TextStyle(color: Colors.black),children:[
              TextSpan(
                text: " Sign In",
                style: TextStyle(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> SignIn()));
                },)
          ] )),
            )
        ])),
      ),
    );
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
