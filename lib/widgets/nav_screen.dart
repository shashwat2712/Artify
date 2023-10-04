import 'package:artify/screens/add_post_screen.dart';
import 'package:artify/screens/community_page.dart';
import 'package:artify/screens/marketplace_screen.dart';
import 'package:artify/screens/profile_section.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:flutter/material.dart';


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

              icon: Icon(Icons.travel_explore_outlined),
              activeIcon: Icon(Icons.travel_explore,color: Colors.blue,),
              label: 'Community',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle,color: Colors.blue,),
              label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_bitcoin_outlined),
              activeIcon: Icon(Icons.currency_bitcoin_rounded,color: Colors.blue,),
              label: 'Market Place'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined),
              activeIcon: Icon(Icons.person,color: Colors.blue,),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
}