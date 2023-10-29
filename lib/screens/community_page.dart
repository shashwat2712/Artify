import 'dart:ui';

import 'package:artify/components/appbar_home.dart';
import 'package:artify/components/community_post.dart';
import 'package:artify/components/glass_tile.dart';
import 'package:artify/components/like_utility.dart';
import 'package:artify/components/post.dart';
import 'package:artify/screens/search.dart';
import 'package:artify/widgets/community_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../components/auction_tile.dart';
import '../components/bullets.dart';
import '../widgets/constants.dart';
import '../widgets/loginOrRegisterPage.dart';
import '../widgets/users_class.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late final Stream<List<UserClass>> _messagesStream;
  late final Stream<List<CommunityClass>> _postStream;



  Future<void> signUserOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
      (route) => false,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    final myUserId = supabase.auth.currentUser!.id;
    _messagesStream = supabase
        .from('users')
        .stream(primaryKey: ['user_id'])
        .order('name',ascending: true)
        .map((maps) {
      return maps.map((map) {
        return UserClass.fromMap(map: map);
      }).toList();
    });
    _postStream = supabase
        .from('community_post')
        .select<List<Map<String, dynamic>>>('*, users(*)').order('created_at',ascending: false).asStream()
        .map((maps) {
      return maps.map((map) {
        return CommunityClass.fromMap(map: map);
      }).toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Container(
              //       padding: const EdgeInsets.symmetric(vertical: 20.0),
              //       decoration: BoxDecoration(color: Colors.pink[100],
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           //animation or picture
              //           Container(
              //             height: 125,
              //             width: 125,
              //             child: Lottie.network
              //               (
              //                 'https://assets1.lottiefiles.com/packages/lf20_p9cnyffr.json',
              //                 fit: BoxFit.cover,
              //                 alignment: Alignment.centerLeft
              //             ),
              //           ),
              //           SizedBox(width: 20,),
              //
              //           // What's next in the schedule
              //           Expanded(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [
              //                 Container(
              //
              //                   child: Center(
              //                     child: const Text("Let's Explore",
              //                       style:  TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 20.0
              //
              //                       ),),
              //                   ),
              //                 ),
              //                 SizedBox(height: 40,),
              //                 Container(
              //                   padding: EdgeInsets.all(12.0),
              //                   decoration: BoxDecoration(
              //                       color: Colors.deepPurple[300],
              //                       borderRadius: BorderRadius.circular(12)
              //                   ),
              //                   child: Center(
              //                     child: Text('Get Started',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 16,
              //                           ),
              //                         )),
              //                   ),
              //               ],
              //             ),
              //           )
              //
              //
              //         ],)
              //   ),
              // ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('Find People',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: Row(
                  children: [

                    StreamBuilder<List<UserClass>>(
                      stream: _messagesStream,

                      builder: ((context, snapshot){
                        if(snapshot.hasData){
                          final messages = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: messages.length,
                              itemBuilder: ((BuildContext context,index){

                                return Stack(
                                  children: [

                                    Container(
                                      width: 160,
                                      margin: EdgeInsets.only(left: 15,),
                                      decoration: BoxDecoration(

                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(15),

                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: messages[index].profile_url,
                                          fit: BoxFit.cover,
                                          placeholder: (context,url)=> Container(
                                            child: Shimmer.fromColors(
                                              highlightColor: Colors.white,
                                              baseColor: Colors.grey[500]!,
                                              child: Container(
                                                margin: const EdgeInsets.only(right : 0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                            ),
                                          ),


                                        ),
                                      ),

                                    ),


                                    Positioned(

                                      top: 0,
                                      right: 0,

                                      child: Container(
                                        padding: EdgeInsets.all(4),

                                        decoration: const BoxDecoration(

                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),

                                          ),

                                          color: Colors.white
                                        ),
                                        child: const Icon(Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                     Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        borderRadius:const BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),

                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          width: 160,
                                          child: Stack(
                                            children: [
                                              //blur effect
                                              BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 1,
                                                    sigmaY: 1
                                                ),
                                                child: Container(),
                                              ),

                                              //Gradient
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //       border: Border.all(color: Colors.white.withOpacity(0.2)),
                                              //       borderRadius: BorderRadius.circular(20.0),
                                              //       gradient: LinearGradient(
                                              //           begin: Alignment.topLeft,
                                              //           end: Alignment.bottomRight,
                                              //           colors: [
                                              //             Colors.white.withOpacity(0.4),
                                              //             Colors.white.withOpacity(0.1)
                                              //           ]
                                              //       )
                                              //   ),
                                              // ),
                                              Center(
                                                child: Column(
                                                  children: [


                                                    ElevatedButton(onPressed: (){}, child: Text(messages[index].user_name,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),)
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),

                                        ),

                                      )
                                    )
                                  ],
                                );
                              }),
                            ),
                          );
                        }
                        else {
                          return Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: ((BuildContext context,index){

                                return Container(
                                  width: 160,
                                  margin: const EdgeInsets.only(left: 15,),
                                  decoration: BoxDecoration(

                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Shimmer.fromColors(
                                      highlightColor: Colors.white,
                                      baseColor: Colors.white30,
                                      child: Container(
                                        margin: const EdgeInsets.only(right : 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),

                                );
                              }),
                            ),
                          );
                        }

                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              const SizedBox(height: 20,),
              StreamBuilder<List<CommunityClass>>(

                  stream: _postStream,
                  builder: (BuildContext context, snapshot) {
                    if(snapshot.hasData){
                      final posts = snapshot.data!;

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: posts.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  Post(username: posts[index].users['name'], postTime: '27/12/2003', content: posts[index].description, likeCount: '0', commentCount: '8', imageSrc: posts[index].imageUrl, profileImg: posts[index].users['profile_url'], postId: posts[index].post_id,),
                                  SizedBox(height: 20,)
                                ],
                              ),
                            );
                          }
                      );
                    }
                    else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    child: Container(

                                      margin: EdgeInsets.only(left: 15,),
                                      decoration: BoxDecoration(

                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),

                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Shimmer.fromColors(
                                          highlightColor: Colors.white,
                                          baseColor: Colors.grey[500]!,
                                          child: Container(
                                            margin: const EdgeInsets.only(right : 0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 20,)
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
              )

            ],
          ),
        ),
      );

  }
}
