import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/default_button.dart';
import 'package:artify/widgets/nav_screen.dart';
import 'package:flutter/material.dart';

class ConfirmCategoryBar extends StatelessWidget {
  const ConfirmCategoryBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NavScreen()));
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xFFDADADA).withOpacity(0.15),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text.rich(
                TextSpan(
                  text: 'Selected:\n',
                  children: [
                    TextSpan(
                        text: '4/8',
                        style: TextStyle(fontSize: 16, color: Colors.black))
                  ],
                ),
              ),
              SizedBox(
                width: 190,
                child: DefaultButton(
                  text: 'Let\'s Go',
                  press: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )),
    );
  }
}
