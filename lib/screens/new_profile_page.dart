import 'package:artify/widgets/saved_posts_view.dart';
import 'package:flutter/material.dart';

import '../widgets/community_post_view.dart';
import '../widgets/market_place_view.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  final List<Widget> tabs = const [
    Tab(
      icon: Icon(
          Icons.home
      ),
    ),
    Tab(
      icon: Icon(
          Icons.home
      ),
    ),
    Tab(
      icon: Icon(
          Icons.home
      ),
    ),
  ];
  final List<Widget> tabBarViews = [
    //feed view
    const MarketPlacePostView(),
    const CommunityPostView(),
    const SavedPostView(),

  ];
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            children: [
              //profile details
              Row(
                children: [
                  Column(
                    children: [
                      Text('364'),
                      Text('Following')
                    ],
                  ),
                  //Profile page
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,

                    ),
                  ),

                  Column(
                    children: [
                      Text('364'),
                      Text('Following')
                    ],
                  ),
                ],
              ),
              //tab bar
              TabBar(tabs: tabs),
              Expanded(
                child: TabBarView(
                    children: tabBarViews
                ),
              )
            ],
          ),
        )
    );
  }
}
