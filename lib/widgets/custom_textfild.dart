import 'package:flutter/material.dart';

class CustomformTextFiled extends StatelessWidget {
  CustomformTextFiled({super.key, this.hinttext, this.onChanged});
  String? hinttext;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'filed is reqired';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
