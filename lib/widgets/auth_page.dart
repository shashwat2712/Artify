import 'package:artify/components/MyButton.dart';
import 'package:artify/screens/home_page.dart';
import 'package:artify/screens/intial_page.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot ){
          //User logged in
          if(snapshot.hasData){
              Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,);

            return HomePage();
          }
          else if(!snapshot.hasData){
            return const InitialPage();
          }
          else{
            return  const InitialPage();
          }
        }
      ),
    );
  }
}
