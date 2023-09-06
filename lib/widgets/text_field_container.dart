import 'package:artify/widgets/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
      width: size.width *0.85,
      decoration: BoxDecoration(
        color: kPrimaryLightCol,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            // offset: Offset(0,2)
        )
        ]

      ),
      child: child,
    );
  }
}
