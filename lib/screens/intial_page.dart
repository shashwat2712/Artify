import 'package:artify/components/glass_tile.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:flutter/material.dart';

import '../widgets/rounded_input_field.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [

          Image.asset(
            'lib/assets/images/img.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),


            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(



                children: [
                  SizedBox(height: 100.0,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The best ',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontFamily: 'Lobster'
                          ),
                        ),
                        Text(
                          'place for',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontFamily: 'Lobster'
                          ),
                        ),
                        Text(
                          'your Creativity',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontFamily: 'Lobster'
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 150,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const LoginOrRegisterPage())
                        );
                        },
                        child: FrostedGlassBox(

                          theChild: const Center(
                            child: Text('Login',
                              style: TextStyle(
                              fontFamily: 'Lobster',
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                // fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        theHeight: 50.0,
                        theWidth: size.width/1.2, borderRadiusGeometry: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(height: 10,),

                      const Text('Guest',
                        style: TextStyle(
                          color: Colors.white,
                            fontFamily: 'Lobster'
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),

          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     FrostedGlassBox(
          //         theChild:  Text('Hello',
          //           style: TextStyle(
          //             color: Colors.black38
          //           ),
          //         ),
          //         theHeight: 100.0,
          //         theWidth: 100.0
          //     ),
          //
          //
          //   ],
          // )
        ],
      ),
    );
  }
}
