import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget{
  final String username;
  final String postTime;
  final String content;
  final String likeCount;
  final String commentCount;
  final String profileImg;
  final String imageSrc;

  const Post({Key? key, required this.username, required this.postTime, required this.content, required this.likeCount, required this.commentCount, required this.imageSrc, required this.profileImg});

  @override
  Widget build(BuildContext context){
    return Container(
      
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
                backgroundImage: NetworkImage(profileImg),
              ),
              SizedBox(width: 10,),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(username, style: TextStyle(fontFamily: 'Opensans', fontWeight: FontWeight.bold),),
                  Text(postTime, style: TextStyle(fontFamily: 'Opensans', fontWeight: FontWeight.w500),)
                ],
              )
            ],
          ),
            const SizedBox(height: 10, width: double.infinity,),
            Text(content, style: TextStyle(fontFamily: 'Opensans', fontWeight: FontWeight.w500),),
            const SizedBox(height: 10, width: double.infinity,),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image(image: NetworkImage(imageSrc)))
            ),
            const SizedBox(height: 10, width: double.infinity,),
            Row(
              children: [
                TextButton.icon(

                    onPressed: (){},
                    icon: const Icon(
                      color: Colors.black,
                      CupertinoIcons.hand_thumbsup
                    ),
                    label: Text(likeCount, style: TextStyle( fontFamily: 'Opensans', color: Colors.black),)
                ),
                TextButton.icon(

                    onPressed: (){},
                    icon: const Icon(
                        color: Colors.black,
                        CupertinoIcons.chat_bubble
                    ),
                    label: Text(commentCount, style: TextStyle( fontFamily: 'Opensans', color: Colors.black),)
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