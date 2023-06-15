import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/screens/login.dart';


import '../auth.dart';
import '../validator.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
@override
_SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
final _registerFormKey = GlobalKey<FormState>();

final _nameTextController = TextEditingController();
final _emailTextController = TextEditingController();
final _passwordTextController = TextEditingController();

final _focusName = FocusNode();
final _focusEmail = FocusNode();
final _focusPassword = FocusNode();

bool _isProcessing = false;

@override
Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width),
            decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 36),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Create Your Account",
                            style: TextStyle(
                                color: Color.fromARGB(255, 211, 211, 211),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Form(
                key: _registerFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    TextFormField(
                      controller: _nameTextController,
                      focusNode: _focusName,
                      validator: (value) => Validator.validateName(
                        name: value,
                      ),
                     decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 229, 229, 229),
                                hintText: "Enter your name",
                                prefixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 229, 229, 229),
                                hintText: "Enter your email",
                                prefixIcon: const Icon(Icons.email)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      obscureText: true,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                       decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 229, 229, 229),
                                hintText: "Enter your password",
                                prefixIcon: const Icon(Icons.remove_red_eye)),
                    ),
                    const SizedBox(height: 40),
                    _isProcessing
                    ? const CircularProgressIndicator()
                    : Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isProcessing = true;
                              });

                              if (_registerFormKey.currentState!
                                  .validate()) {
                                User? user = await FirebaseAuthHelper
                                    .registerUsingEmailPassword(
                                  name: _nameTextController.text,
                                  email: _emailTextController.text,
                                  password:
                                  _passwordTextController.text,
                                );

                                setState(() {
                                  _isProcessing = false;
                                });

                                if (user != null) {
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(),
                                    ),
                                    ModalRoute.withName('/'),
                                  );
                                }
                              }else{
                                setState(() {
                                  _isProcessing = false;
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have account?",
                                style: TextStyle(fontSize: 18),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                           LoginScreen(),
                                    ));
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.deepOrange),
                                  ))
                            ],
                          )
                  ],
                ),
              )
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
}
}