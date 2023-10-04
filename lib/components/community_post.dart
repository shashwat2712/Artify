import 'dart:ui';

import 'package:artify/components/glass_tile.dart';
import 'package:artify/widgets/community_class.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  const EventTile({Key? key,required this.details}) : super(key: key);
  final CommunityClass details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.lightBlue.shade50, borderRadius: BorderRadius.circular(20.0)),
      height: 500.0,
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                // color: Colors.pink[100],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                details.users['profile_url'] == Null ? Image.network(
                  details.users['image_url'],
                  height: 400,
                ) : CircleAvatar(
                  radius: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'lib/assets/images/profile_image.jpg',
                      fit: BoxFit.cover,
                      height: 400,
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Text(
                  details.users['name'] ?? 'loading',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pink[200],
              image: details.users['profile_url'] == Null ? DecorationImage(image:  AssetImage('lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg' ,
              ) ,
                  fit: BoxFit.cover

              ) : DecorationImage(image:  NetworkImage(details.imageUrl ,
              ) ,
                  fit: BoxFit.cover

              ) ,
            ),
            // margin: EdgeInsets.symmetric(horizontal: 10),
            height: 200,

          ),


           Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [

                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    details.title ?? 'loading',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                ),
                //Description

                Text(
                  "An app for art collectors and enthusiasts! Sotheby’s application provides access to today’s current trends, global artworks, precious articles, and more! Find old masterpieces or contemporary art; or furniture to photography to prints; or dabble in fine wine and jewelry. Regardless, you are bound to find something of interest! Known for its unparalleled expertise, Sotheby’s world-class specialists have assembled quality art-based content for its users! ",
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    Text(
                      ' 12 August 2023',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FrostedGlassBox(
            theWidth: double.infinity,
            theChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                    ),
                    Text(
                      ' 2345',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ()));
                      },
                      child: Container(
                        child: Icon(
                          Icons.share,
                          size: 30,
                        ),
                      ),
                    ),
                    Text(
                      ' 2345',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Icon(
                  Icons.insert_comment_sharp,
                  size: 30,
                ),
              ],
            ),
            theHeight: 40.0, borderRadiusGeometry: BorderRadius.only(
            bottomRight: Radius.circular(20),
          ),
          ),

        ],
      ),
    );
  }
}
