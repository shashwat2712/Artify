import 'dart:async';

import 'package:artify/components/MyButton.dart';
import 'package:artify/components/my_textfield.dart';
import 'package:artify/screens/home_page.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:  const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   colors: [
          //     Colors.yellow.shade900,
          //     Colors.orange.shade800,
          //     Colors.orange.shade400
          //   ]
          // ),
          color: Color(0xFF50c879),

        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Artify',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                        fontFamily: 'Lobster',
                        letterSpacing: 3
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        RoundedInputField(hintText: 'Email',
                          icon: Icons.email, controller: emailController,

                        ),
                        SizedBox(height: size.height/200,),
                        RoundedInputField(hintText: 'Password',
                          icon: Icons.password, controller: passwordController,

                        ),
                        SizedBox(height: size.height/20),
                        MyButton(

                              onTap: ()async{
                                try{
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  final response  = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Successfully logged in',),
                                        backgroundColor: Colors.green,
                                      ));
                                  final timer = Timer(
                                    const Duration(seconds: 2),
                                        () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>const HomePage()));
                                    },
                                  );
                                }
                                on FirebaseAuth catch(error){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error as String),
                                        backgroundColor: Theme.of(context).colorScheme.error,
                                      ));
                                }
                                catch(error){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: const Text('Error Occurred please retry '),
                                        backgroundColor: Theme.of(context).colorScheme.error,
                                      ));
                                }
                            },
                            text: 'Login'),
                        SizedBox(height: size.height/300),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextButton(onPressed: (){},
                                  child: const Text(
                                    'Forget Password',
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40,),
                         Row(
                          children: [
                            Expanded(child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )),

                            Text('     Or Continue with      '),

                            Expanded(child: Divider(
                              thickness: 0.5,
                              color: Colors.grey.shade400,
                            )),
                          ],
                        ),
                        const SizedBox(height: 40,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: kPrimaryLightCol,
                                ),
                                child: Center(
                                  child: Image.asset('lib/assets/images/google.png',
                                    height: 40,

                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30,),
                            Expanded(
                              child: Container(
                                // padding: EdgeInsets.all(5.0),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),

                                  color: kPrimaryLightCol
                                ),
                                child: Center(
                                  child: Image.asset('lib/assets/images/microsoft.png',height: 200,),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 25.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an Account?  '),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text('Register Now',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),),
                            )
                          ],
                        )


                      ],
                    ),
                  ),
                ),
              ))
            ],

          )
      )
    );
  }
}
