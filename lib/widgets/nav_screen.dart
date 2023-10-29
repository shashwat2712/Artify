import 'package:artify/screens/add_post_screen.dart';
import 'package:artify/screens/community_page.dart';
import 'package:artify/screens/marketplace_screen.dart';
import 'package:artify/screens/profile_section.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/loginOrRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
        children: [
          Stack(

              children: _screens
                  .asMap()
                  .map((i, screen) => MapEntry(
                i,
                Offstage(
                  offstage: _selectedIndex != i,
                  child: screen,

                ),
              )).values.toList(),

          ),
          Positioned(
            right: 10,
            left: 10,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(20)
              ),

              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[500]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.add,
                    text: 'ADD',
                  ),
                  GButton(
                    icon: LineIcons.shoppingCart,
                    text: 'Market',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black87,
      //   elevation: 0,
      //   showUnselectedLabels: false  ,
      //   showSelectedLabels: true,
      //   selectedLabelStyle: const TextStyle(
      //     color: Colors.green
      //   ),
      //   unselectedItemColor: Colors.greenAccent,
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      //   currentIndex: _selectedIndex,
      //   items: const [
      //
      //     BottomNavigationBarItem(
      //
      //         icon: Icon(CupertinoIcons.home,color: Colors.black,),
      //         activeIcon: Icon(CupertinoIcons.home,color: Colors.blue,),
      //         label: 'Community',
      //
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(CupertinoIcons.add,color: Colors.black,),
      //         activeIcon: Icon(CupertinoIcons.add,color: Colors.blue,),
      //         label: 'Add'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(CupertinoIcons.shopping_cart, color: Colors.black,),
      //         activeIcon: Icon(CupertinoIcons.shopping_cart,color: Colors.blue,),
      //         label: 'Market Place'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(CupertinoIcons.profile_circled, color: Colors.black,),
      //         activeIcon: Icon(CupertinoIcons.profile_circled,color: Colors.blue,),
      //         label: 'Profile'
      //     ),
      //   ],
      // ),
    );
  }
}












