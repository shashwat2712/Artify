import 'package:artify/widgets/messaging_utilty.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:artify/components/numbers_widget.dart';
import 'package:artify/components/rounded_button.dart';
import 'package:shimmer/shimmer.dart';


import '../widgets/community_post_view.dart';
import '../widgets/constants.dart';
import '../widgets/follow_utility.dart';
import '../widgets/loginOrRegisterPage.dart';
import '../widgets/market_place_view.dart';
import '../widgets/saved_posts_view.dart';
import '../widgets/users_class.dart';

class VisitingProfileSection extends StatefulWidget {
  UserClass authorData;
  VisitingProfileSection({Key? key,required this.authorData}) : super(key: key);

  @override
  State<VisitingProfileSection> createState() => _VisitingProfileSectionState();
}

class _VisitingProfileSectionState extends State<VisitingProfileSection> {
  final double coverHeight = 280;
  final double profileHeight = 140;
  bool isFollow = false;
  @override
  void initState() {
    // TODO: implement initState
    checkIfFollowedByUser();
    super.initState();
  }





  Future<void> signUserOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
          (route) => false,
    );
  }
  void checkIfFollowedByUser() async {
    final liked = await FollowingUtility.isFollowedByUser(supabase, widget.authorData!.user_id);
    setState(() {
      isFollow = liked;
    });
  }
  void toggleFollow() async {
    if (isFollow) {
      // Unlike the post
      try{
        await FollowingUtility.unfollowUser(widget.authorData.user_id);
      }
      catch(e){
      }
      setState(() {
        isFollow = false;
      });
    } else {
      // Like the post
      try{
        await FollowingUtility.followUser(widget.authorData.user_id);
      }catch(e){

      }
      setState(() {
        isFollow = true;
      });
    }
  }
  final List<Widget> tabs = const [
    Tab(
      icon: Icon(
          Icons.home
      ),
    ),
    Tab(
      icon: Icon(
          Icons.map
      ),
    ),
    Tab(
      icon: Icon(
          Icons.bookmark
      ),
    ),
  ];
  final List<Widget> tabBarViews = [
    //feed view
    const CommunityPostView(),
    const MarketPlacePostView(),
    const SavedPostView(),

  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final top = coverHeight - profileHeight / 2;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: ListView(
            padding: EdgeInsets.only(top: 0),
            children: [
              buildTop(),
              Center(
                  child: Text(
                    widget.authorData.user_name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900),
                  )),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    widget.authorData.bio,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey[700]),
                  )),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // GestureDetector(
                    //   onTap: signUserOut,
                    //   child: const RoundedButton(
                    //     text: 'Follow',
                    //     color: Colors.black87,
                    //     textColor: Colors.white,
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => SearchPage()));
                    //   },
                    //   child: const RoundedButton(
                    //     text: 'Message',
                    //     color: Colors.white,
                    //     textColor: Colors.black,
                    //   ),
                    // ),
                    Expanded(
                        child: GestureDetector(
                          onTap: toggleFollow,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isFollow ?Colors.green:Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                isFollow ?'Following': 'Follow',
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 10,),

                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            MessageUtility.creatingChatRoom(widget.authorData.user_id, context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Contact',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              Expanded(child: TabBar(tabs: tabs)),
              SizedBox(
                  height: 1000,
                  child: TabBarView(
                    children: tabBarViews,
                  ))
            ],
          )),
    );
  }

  Widget buildTop() {
    Size size = MediaQuery.of(context).size;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: profileHeight / 1.5),
            child: buildCoverImage()),
        Positioned(top: top, child: buildProfileImage()),
        Positioned(
            top: top / 3,
            left: size.width / 30,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                ))),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: CachedNetworkImage(
      imageUrl: widget.authorData.profile_url,
      placeholder: (context,url) => Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.white12,
          child: Container(
            height: coverHeight,
            width: double.infinity,
            color: Colors.grey.shade800,
          ),
      ),
      errorWidget: (context,url,error) => Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.white12,
          child: Container(
            height: coverHeight,
            width: double.infinity,
            color: Colors.grey.shade800,
          ),
      ),
      height: coverHeight,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => Row(
    children: [
       Column(

        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          SizedBox(height: 80,),
          FutureBuilder<dynamic>(
              future: supabase
                  .from('followers')
                  .select('follower_id')
                  .eq('user_id', widget.authorData.user_id),
              builder: (context, snapshot) {
                List l1 = snapshot.data?.toList() ?? [];
                if(snapshot.hasData){
                  return Text(
                    l1.length.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                }
                return const Text(
                  'loading',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                );
              }
          ),
          SizedBox(height: 5,),
          Text(
            'Following',
            style: TextStyle(
              color: Colors.grey,

            ),
          ),

        ],
      ),
      const SizedBox(width: 20,),
      CircleAvatar(
        radius: profileHeight / 1.8,
        backgroundColor: Colors.white,
        child: CircleAvatar(
            radius: profileHeight / 2,
            backgroundColor: Colors.grey.shade800,
            child:  CachedNetworkImage(
              imageUrl: widget.authorData.profile_url,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
                );
              },
              placeholder: (context,url) => Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.white12,
                child: CircleAvatar(
                    radius: profileHeight / 2,
                    backgroundColor: Colors.grey.shade800,
                )
              ),
              errorWidget: (context,url,error) => Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.white12,
                  child: CircleAvatar(
                    radius: profileHeight / 2,
                    backgroundColor: Colors.grey.shade800,
                  )
              ),
            )),
      ),
      const SizedBox(width: 20,),
       Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 80,),
          FutureBuilder<dynamic>(
            future: supabase
                .from('followers')
                .select('user_id')
                .eq('follower_id', widget.authorData.user_id),
            builder: (context, snapshot) {
              List l1 = snapshot.data?.toList() ?? [];
              if(snapshot.hasData){
                return Text(
                  l1.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                );
              }
              return const Text(
                'loading',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            }
          ),
          const SizedBox(height: 5,),
          const Text(
            'Followers',
            style: TextStyle(
              color: Colors.grey,

            ),
          ),

        ],
      ),
    ],
  );
}
