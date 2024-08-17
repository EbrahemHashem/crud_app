import 'package:crud_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 255, 255, 255),
      body: Padding(
          padding: const EdgeInsets.only(top: 65, right: 25, left: 25),
          child: ListView(children: [
            const Text(
              'Enter your email below,we will send instruction to reset your password',
              maxLines: 2,
              softWrap: true,
              style: TextStyle(fontSize: 12, height: 3.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            //text field
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(title: 'Submit'),
          ])),
    );
  }
}
