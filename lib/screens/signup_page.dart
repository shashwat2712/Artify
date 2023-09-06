import 'package:artify/components/MyButton.dart';
import 'package:artify/screens/home_page.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/database.dart';
import 'package:artify/widgets/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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



  void signUserUp() async {

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
      final name = nameController.text.trim();
      final age = ageController.text.trim();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),

      );
      String currentUserId = FirebaseAuth.instance.currentUser?.uid ??"";
      DatabaseServices(uid: currentUserId).updateUserDetails(name, age,
          phone);

        if(!mounted) return;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));


    }on FirebaseAuthException catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message??'Error coming'),
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
                            controller: nameController,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Email',
                            icon: Icons.email,
                            controller: emailController,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Age',
                            icon: Icons.timelapse,
                            controller: ageController,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Phone',
                            icon: Icons.phone,
                            controller: phoneController,
                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Password',
                            icon: Icons.password,
                            controller: passwordController,

                          ),
                          SizedBox(height: size.height/200,),
                          RoundedInputField(hintText: 'Confirm Password',
                            icon: Icons.password,
                            controller: confirmPasswordController,
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
