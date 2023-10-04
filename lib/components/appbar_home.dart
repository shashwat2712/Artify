import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  int func() {
    return 0;
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Row(
            children: <Widget>[
              Text(
                "Artify",
                style: TextStyle(fontFamily: 'Lobster', fontSize: 32),
              ),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.search),
                      color: Colors.black,
                      onPressed: () => {func()},
                    ),
                    SizedBox(width: 6),
                    IconButton(
                        icon: Icon(CupertinoIcons.bell_fill),
                        color: Colors.black,
                        onPressed: () => {func()}),
                    SizedBox(width: 6),
                    IconButton(
                        icon: Icon(CupertinoIcons.envelope_fill),
                        color: Colors.black,
                        onPressed: () => {func()}),
                  ]))
            ],
          ),
        ),
      ),
    ));
  }
}
