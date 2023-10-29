import 'package:artify/screens/intial_page.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:artify/widgets/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    return Scaffold(
      body: Scaffold(
        backgroundColor: Color(0xFF50c879),
        body: Center(
            child : Container(
                height: 200,
                width: 200,
                child: Lottie.asset('lib/assets/Animation - 1698350084450.json')
            )
        ),
      )
    );
  }
}
