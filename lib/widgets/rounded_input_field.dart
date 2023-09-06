import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({Key? key,
    required this.hintText,
    required this.icon, required this.controller
  })
      : super(key: key);
  final String? hintText;
  final IconData icon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: kPrimaryCol,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryCol,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'OpenSans'),
          border: InputBorder.none,
        ),
        controller: controller,
      ),

    );
  }
}
