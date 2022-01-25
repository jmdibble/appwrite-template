import 'package:flutter/material.dart';

class AWTextField extends StatelessWidget {
  const AWTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 6),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "",
          ),
        ),
      ),
    );
  }
}
