import 'package:artify/widgets/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  const RoundedButton({Key? key, required this.text,required this.color,required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        child: Container(
          height: 50,
          width: size.width/3,
          decoration : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0,2)
                ),

              ]

          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17,
                color: textColor,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
    );
  }
}
