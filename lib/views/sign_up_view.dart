// ignore_for_file: must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:crud_app/views/home_view.dart';
import 'package:crud_app/views/sign_in_view.dart';
import 'package:crud_app/widgets/custom_button.dart';
import 'package:crud_app/widgets/custom_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key, this.email, this.password});

  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 65, right: 25, left: 25),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Login In",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 25,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //name
              CustomFormField(
                textInput: TextInputType.name,
                text: 'Name',
              ),
              //email
              CustomFormField(
                textInput: TextInputType.emailAddress,
                text: 'Email',
                onChanged: (data) {
                  email = data;
                },
              ),
              //password
              CustomFormField(
                textInput: TextInputType.visiblePassword,
                text: "Password",
                onChanged: (data) {
                  password = data;
                },
              ),
              //password confirm
              CustomFormField(textInput: TextInputType.visiblePassword, text: 'Password Confirmation'),
              //custom button
              CustomButton(
                title: 'Sign Up',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email!,
                        password: password!,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The password provided is too weak.'),
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The account already exists for that email.'),
                          ),
                        );
                      }
                    }
                    //success
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Account Created'),
                      ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
