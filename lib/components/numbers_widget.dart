import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {

  const NumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(text: 'Projects', value: 39),
        buildDivider(),
        buildButton(text: 'Following', value: 529),
        buildDivider(),
        buildButton(text: 'Followers', value: 5834),
      ],

    );
  }
  Widget buildDivider() => Container(
    height: 25,
    child: const VerticalDivider(
      width: 30,
    ),
  );
  Widget buildButton({
    required String text,
    required int? value
  }) => MaterialButton(
    padding: const EdgeInsets.symmetric(vertical: 4),
    onPressed: (){},
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
           '$value',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20
          ),
          

        ),
        const SizedBox(height: 2,),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w100
            
          ),
        )
      ],
    ),

  );
  
  
}
