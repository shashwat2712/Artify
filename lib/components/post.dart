import 'package:artify/screens/comments_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/constants.dart';
import 'comment_wall_post..dart';
import 'like_utility.dart';

class Post extends StatefulWidget{
  final String username;
  final String postTime;
  final String content;
  final String likeCount;
  final String commentCount;
  final String profileImg;
  final String imageSrc;
  final int postId;

  const Post({Key? key, required this.username, required this.postTime, required this.content, required this.likeCount, required this.commentCount, required this.imageSrc, required this.profileImg,required this.postId});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    try{
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      print('WE ARe in the init function');
      checkIfLikedByUser();
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:  Text(e.toString()??""),
            backgroundColor: Colors.green[500],
          ));
    }
  }
  void checkIfLikedByUser() async {
    final liked = await LikeService.isLikedByUser(supabase, supabase.auth.currentUser!.id,widget.postId);
    print(liked);
    print(liked);
    print(liked);
    print(liked);
    print(liked);
    print(liked);
    print(liked);
    print(liked);

    setState(() {
      print('Successfully altered the value');
      print('Successfully altered the value');print('Successfully altered the value');
      print('Successfully altered the value');
      print('Successfully altered the value');
      print('Successfully altered the value');
      print('Successfully altered the value');
      print('Successfully altered the value');


      isLiked = liked;
    });
  }

  void toggleLike() async {
    if (isLiked) {
      // Unlike the post
      try{
        await LikeService.unlikePost(
            widget.postId, supabase.auth.currentUser!.id);
      }
      catch(e){

      }
      setState(() {
        isLiked = false;
      });
    } else {
      // Like the post
      try{
        await LikeService.likePost(
            widget.postId, supabase.auth.currentUser!.id);
      }catch(e){

      }
      setState(() {
        isLiked = true;
      });
    }
  }



  @override
  Widget build(BuildContext context){
    return Container(
      height: 400,

      decoration: BoxDecoration(

        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,


          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: <Widget>[ Row(

            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.profileImg),
              ),
              SizedBox(width: 10,),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(widget.username, style: const TextStyle(fontFamily: 'Opensans', fontWeight: FontWeight.bold),),
                  Text(widget.postTime, style: TextStyle(fontFamily: 'Opensans', fontWeight: FontWeight.w500),)
                ],
              )
            ],
          ),
            const SizedBox(height: 10, width: double.infinity,),
            Text(widget.content, style: const TextStyle(fontFamily: 'Opensans', fontWeight: FontWeight.w500),),
            const SizedBox(height: 10, width: double.infinity,),
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey
              ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // child: Image(
                    //   image: NetworkImage(widget.imageSrc),
                    //   fit: BoxFit.cover,)
                  child: CachedNetworkImage(
                    imageUrl: widget.imageSrc,
                    fit: BoxFit.cover,
                    placeholder:(context,url)=> ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.white12,
                        child: Container(
                          margin: const EdgeInsets.only(right : 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    errorWidget:(context,url,error)=> ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.white12,
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
                )
            ),
            const SizedBox(height: 10, width: double.infinity,),
            Row(
              children: [
                StreamBuilder(
                  stream: supabase.from('likes').stream(primaryKey: ['user_id','post_id']).eq('post_id', widget.postId),
                  builder: (context, snapshot){

                    if(snapshot.hasData){
                      final likes = snapshot.data!;

                      return TextButton.icon(

                          onPressed: (){
                            toggleLike();
                          },
                          icon: Icon(
                            isLiked ?Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          label: Text(likes.length.toString(), style: const TextStyle( fontFamily: 'Opensans', color: Colors.black),)
                      );
                    }
                    else{
                      return TextButton.icon(

                        onPressed: (){
                          // toggleLike();
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                        ),
                        label: Text(widget.likeCount, style: const TextStyle( fontFamily: 'Opensans', color: Colors.black),),
                      );
                    }

                  },
                ),
                TextButton.icon(

                    onPressed: (){
                      showModalBottomSheet(isScrollControlled: true, context: context, builder: ( context) {
                        return CommentsPage(postId: widget.postId,);
                      }

                      );
                    },
                    icon: const Icon(
                        color: Colors.black,
                        CupertinoIcons.chat_bubble
                    ),
                    label: StreamBuilder(
                      stream: supabase.from('comments').stream(primaryKey: ['comment_id']).order('timestamp').eq('community_post_id', widget.postId ),
                      builder: (context, snapshot){

                        if(snapshot.hasData){
                          final messages = snapshot.data!;

                          return Text(messages.length.toString(), style: const TextStyle( fontFamily: 'Opensans', color: Colors.black),);
                        }
                        else{
                          return Text(widget.commentCount, style: const TextStyle( fontFamily: 'Opensans', color: Colors.black),);
                        }

                      },
                    ),
                ),
                const Expanded(
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(
                        CupertinoIcons.share
                      )],
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}