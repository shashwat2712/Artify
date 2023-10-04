import 'dart:async';

import 'package:artify/components/MyButton.dart';
import 'package:artify/screens/select_interest_section.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/nav_screen.dart';
import 'package:artify/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {

  //all the controller information

  //all the controller information

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final ageController = TextEditingController();



  Future<void> _recordData() async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Please Wait while we are registering you'),
          backgroundColor: Colors.green[500],
        ));
    try{
      await supabase.from('users').insert({
        'phone_no': phoneController.text.trim(),
        'user_id': supabase.auth.currentUser!.id.trim(),
        'name': nameController.text.trim(),
        'email' : emailController.text.trim(),
        'password' : passwordController.text.trim(),
        'location' : 'Null',
        'profile_url': 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'
      });
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Occurred please retry : $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
    }
  }
  void signUserUp() async {

    // // showing load circle
    // showDialog(
    //   context: context,
    //   builder: (context){
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );


    if(phoneController.text.isEmpty || nameController.text.isEmpty
        || passwordController.text.isEmpty ||confirmPasswordController.text.isEmpty
        || emailController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Please Enter all the entries'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
      return;
    }

    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('confirmPassword and Password does not match'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
      return;
    }





    try{
      final password = passwordController.text.trim();
      final phone = '+91${phoneController.text.trim()}';
      final email = emailController.text.trim();

      final AuthResponse res = await supabase.auth.signUp(password: password,email: email,
          // emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/'
      );
      final Session? session = res.session;



      // if (!mounted) return;
      //
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Check your messages')));
      if(session != null){


        await _recordData();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Successfully Signed Up'),
          backgroundColor: Colors.green,
        ));


        if(!mounted) return;
        Timer(
          const Duration(seconds: 2),
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>const SelectInterest()));
          },
        );

      }
    }on Exception catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error as String),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Occurred please retry : $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
    }




  }

  //Error Message to user
  void showErrorMessage(String message){
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(title: Text(message),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                           RoundedInputField(hintText: 'Name',
                            icon: Icons.person,
                            controller: nameController, obscure: false,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Email',
                            icon: Icons.email,
                            controller: emailController, obscure: false,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Age',
                            icon: Icons.timelapse,
                            controller: ageController, obscure: false
                            ,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Phone',
                            icon: Icons.phone,
                            controller: phoneController, obscure: false,
                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Password',
                            icon: Icons.password,
                            controller: passwordController, obscure: true,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Confirm Password',
                            icon: Icons.password,
                            controller: confirmPasswordController, obscure: true,
                          ),
                          SizedBox(height: size.height/20),
                          MyButton(onTap: signUserUp, text: 'Register'),
                          SizedBox(height: size.height/300),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextButton(onPressed: (){},
                                    child: const Text(
                                      'Forgot Password',
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
                              const Text('Already have an Account?  '),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: const Text('Login Here',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),),
                              )
                            ],
                          ),
                          SizedBox(height: 50,)


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
