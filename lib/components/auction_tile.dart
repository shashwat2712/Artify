import 'dart:ui';

import 'package:artify/components/glass_tile.dart';
import 'package:artify/screens/product_overview.dart';
import 'package:artify/widgets/auction_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:iconly/iconly.dart';



import '../screens/profile_section.dart';
import '../widgets/colors.dart';
import '../widgets/constants.dart';

class AuctionTile extends StatefulWidget {
  const AuctionTile({Key? key, required this.details}) : super(key: key);
  final AuctionClass details;

  @override
  State<AuctionTile> createState() => _AuctionTileState();

}


class _AuctionTileState extends State<AuctionTile> {

  @override
  Widget build(BuildContext context) {
    print(widget.details.users.toString());
    print('////////////////////////////this is the thing');
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: widget.details.imageUrl.isEmpty ? Image.asset(
                        'lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg'): Image.network(widget.details.imageUrl,height: 200,width: double.infinity,)
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.1)
                              ]
                          )
                      ),

                      padding: EdgeInsets.all(10),
                        child: CountdownTimer(
                          endWidget: Text('00:00:00'),
                          endTime: widget.details.end_date.millisecondsSinceEpoch,
                          textStyle: const TextStyle(fontSize: 12, color: Colors.black),
                          onEnd: () {
                            // Timer has ended, you can perform some action here
                          },
                        ),
                    ),
                  )
                ],
              ),
            ],
          ),
           Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Text(
              widget.details.title ?? " ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   InkWell(
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) =>
                             const ProfileSection(),
                           ));
                     },
                     child: const CircleAvatar(
                       radius: 25,
                       backgroundColor: primary,
                       backgroundImage: AssetImage('lib/assets/images/profile_image.jpg'),
                     ),
                   ),
                   const SizedBox(
                     width: 5,
                   ),
                    Expanded(
                      child: Text(
                       widget.details.users['name'] ?? " ",
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                           fontSize: 16
                       ),

                   ),
                    ),
                   const Spacer(),
                   const CircleAvatar(
                     radius: 25,
                     backgroundColor: primary,
                     child: Icon(
                       IconlyLight.buy,
                       color: Colors.white,
                     ),
                   ),
                   const SizedBox(
                     width: 5,
                   ),
                    Column(
                     children: [
                       const Text('Current Bid',style: TextStyle(color: Colors.red),),
                       Text('\$${widget.details.basePrice}' ?? "loading",style: const TextStyle(color: Colors.red),),

                     ],
                   )

                 ],
               ),
               // FutureBuilder<List<Map<String, dynamic>>>(
               //     future: supabase
               //         .from('users')
               //         .stream(primaryKey: ['user_id'])
               //         .eq('user_id', supabase.auth.currentUser!.id)
               //         .first,
               //     builder: (context, snapshot) {
               //       if (snapshot.hasData) {
               //         final name = snapshot.data?[0]['name'];
               //         final imageUrl = snapshot.data?[0]['profile_url'];
               //         widget.details.name = name;
               //         // widget.details.
               //         return Row(
               //           children: [
               //             InkWell(
               //               onTap: () {
               //                 Navigator.push(
               //                     context,
               //                     MaterialPageRoute(
               //                       builder: (context) =>
               //                       const ProfileSection(),
               //                     ));
               //               },
               //               child: CircleAvatar(
               //                 radius: 25,
               //                 backgroundColor: primary,
               //                 backgroundImage: NetworkImage(imageUrl ?? 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'),
               //               ),
               //             ),
               //             const SizedBox(
               //                width: 5,
               //             ),
               //              Text(
               //               widget.details.author_name ?? " ",
               //                 style: const TextStyle(
               //                 fontSize: 16,
               //                 fontWeight: FontWeight.bold,
               //                   color: Colors.green
               //               ),),
               //
               //               const Spacer(),
               //               const CircleAvatar(
               //                 radius: 25,
               //                 backgroundColor: primary,
               //                 child: Icon(
               //                   IconlyLight.buy,
               //                   color: Colors.white,
               //                 ),
               //               ),
               //               const SizedBox(
               //                 width: 5,
               //               ),
               //                Column(
               //                 children: [
               //                   Text('Current Bid',style: TextStyle(color: Colors.red),),
               //                   Text('\$${widget.details.basePrice}' ?? " ",style: TextStyle(color: Colors.red),),
               //
               //                 ],
               //               )
               //           ],
               //         );
               //       }
               //       else {
               //         return Row(
               //           children: [
               //             InkWell(
               //               onTap: () {
               //                 Navigator.push(
               //                     context,
               //                     MaterialPageRoute(
               //                       builder: (context) =>
               //                       const ProfileSection(),
               //                     ));
               //               },
               //               child: const CircleAvatar(
               //                 radius: 25,
               //                 backgroundColor: primary,
               //                 backgroundImage: AssetImage('lib/assets/images/profile_image.jpg'),
               //               ),
               //             ),
               //             const SizedBox(
               //               width: 5,
               //             ),
               //             const Text(
               //               "Elena Shelby",
               //               style: TextStyle(
               //                   fontSize: 16
               //               ),
               //
               //             ),
               //             const Spacer(),
               //             const CircleAvatar(
               //               radius: 25,
               //               backgroundColor: primary,
               //               child: Icon(
               //                 IconlyLight.buy,
               //                 color: Colors.white,
               //               ),
               //             ),
               //             const SizedBox(
               //               width: 5,
               //             ),
               //             const Column(
               //               children: [
               //                 Text('Current Bid',style: TextStyle(color: Colors.red),),
               //                 Text('\$7677',style: TextStyle(color: Colors.red),),
               //
               //               ],
               //             )
               //
               //           ],);
               //
               //       }
               //
               //
               //     }
               // ),


             ],
           ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionDescriptionScreen(details: widget.details,)));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(10)

                    ),
                    child: Center(child: Text('Place a Bid',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),)),
                  ),
                ),
                const SizedBox(width: 2,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionDescriptionScreen(details: widget.details,)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.bookmark_add_outlined),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
