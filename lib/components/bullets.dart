import 'package:flutter/material.dart';

class MyBullets extends StatelessWidget {
  final String text;
  const MyBullets({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(


      decoration:  BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(5),


      child:  Text(
        text,
          style :   TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),

      ),
    );

  }
}
