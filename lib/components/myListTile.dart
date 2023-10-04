import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final IconData endIcon;
  final String text;
  final GestureTapCallback? onTap;
  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.endIcon,
    this.onTap
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 1.0,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          selectedTileColor: Colors.yellow,
          onTap: onTap,
          selectedColor: Colors.grey,
          leading: Container(
            width: 40,height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.blue.withOpacity(0.1)
            ),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          title: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Lobster',
                fontSize: 18,
                fontWeight: FontWeight.bold,

              )
            //Google Fonts
          ),
          trailing: Icon(endIcon),
        ),
      ),
    );
  }
}
