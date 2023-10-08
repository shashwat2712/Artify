import 'package:artify/screens/add_post_screen.dart';
import 'package:artify/screens/community_page.dart';
import 'package:artify/screens/marketplace_screen.dart';
import 'package:artify/screens/profile_section.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavScreen extends StatefulWidget {

  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  void signUserOut() {
    supabase.auth.signOut();
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
          (route) => false,);
  }

  final _screens = [
    const CommunityPage(),
    const AddPostScreen(),
    const MarketPlaceScreen(),
    const ProfileSection(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(

          children: _screens
              .asMap()
              .map((i, screen) => MapEntry(
            i,
            Offstage(
              offstage: _selectedIndex != i,
              child: screen,

            ),
          )).values.toList()

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        showUnselectedLabels: false  ,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(
          color: Colors.green
        ),
        unselectedItemColor: Colors.greenAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: const [

          BottomNavigationBarItem(

              icon: Icon(CupertinoIcons.home,color: Colors.black,),
              activeIcon: Icon(CupertinoIcons.home,color: Colors.blue,),
              label: 'Community',

          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add,color: Colors.black,),
              activeIcon: Icon(CupertinoIcons.add,color: Colors.blue,),
              label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart, color: Colors.black,),
              activeIcon: Icon(CupertinoIcons.shopping_cart,color: Colors.blue,),
              label: 'Market Place'
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled, color: Colors.black,),
              activeIcon: Icon(CupertinoIcons.profile_circled,color: Colors.blue,),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
}