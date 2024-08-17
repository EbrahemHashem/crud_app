// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:crud_app/views/forget_password_view.dart';
import 'package:flutter/material.dart';

class CustomRemember extends StatelessWidget {
  const CustomRemember({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            const Text('Remember me')
          ]),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgetPasswordView(),
                ),
              );
            },
            child: const Text(
              'Forget Password?',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
