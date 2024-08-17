// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({super.key, required this.textInput, required this.text, this.onChanged});
  TextInputType textInput;
  String text;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 15,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: TextFormField(
          validator: (data) {
            if (data!.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
          onChanged: onChanged,
          keyboardType: textInput,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
