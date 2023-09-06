import 'package:artify/screens/intial_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
final currentUserEmail = FirebaseAuth.instance.currentUser?.email;
class _HomePageState extends State<HomePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => InitialPage()),
          (route) => false,);
    }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout),
        ),
      ),
      body: Center(
        child: Text(
          'Signed In as $currentUserEmail.'
        ),
      ),
    );
  }
}
