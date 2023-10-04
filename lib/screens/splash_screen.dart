import 'package:artify/screens/intial_page.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:artify/widgets/nav_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _redirect();
  }
  Future<void> _redirect() async{
    await Future.delayed(Duration.zero);
    //supabase is just variable which is Supabase.instance.client
    //which we declared in main.dart.


    if(!mounted) return;

    final session = supabase.auth.currentSession;
    if(session != null){
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=> const NavScreen())
      );
    }
    else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> const InitialPage())
      );

    }



  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }
}
