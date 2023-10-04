import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  const NewTextField({Key? key, required this.labelText, required this.icon, required this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          floatingLabelStyle: TextStyle(
              color: Colors.grey
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(width: 2,color: Colors.black87),

          )
      ),
    );
  }
}
