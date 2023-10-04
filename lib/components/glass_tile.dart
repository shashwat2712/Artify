import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {Key? key,
        required this.theChild,
        required this.theHeight,
        required this.theWidth,
        required this.borderRadiusGeometry

      })
      : super(key: key);

  final theWidth;
  final theHeight;
  final theChild;
  final BorderRadiusGeometry? borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: theWidth,
        height: theHeight,
        child: Stack(
          children: [
            //blur effect
            BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1
                ),
              child: Container(),
            ),

            //Gradient
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1)
                  ]
                )
              ),
            ),
            theChild

          ],
        ),

      ),
    );
  }
}
