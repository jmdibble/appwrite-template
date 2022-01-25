import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AWButtonOutline extends StatelessWidget {
  const AWButtonOutline({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(minHeight: 60, minWidth: 70),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: icon!,
                ),
              Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
