import 'dart:io';

import 'package:artify/components/myListTile.dart';
import 'package:artify/screens/add_community_post_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/MyButton.dart';
import '../widgets/constants.dart';
import '../widgets/rounded_input_field.dart';
import 'add_auction_details.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration:  const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   colors: [
              //     Colors.yellow.shade900,
              //     Colors.orange.shade800,
              //     Colors.orange.shade400
              //   ]
              // ),
              color: Color(0xFF50c879),

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Artify',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontFamily: 'Lobster',
                            letterSpacing: 3
                        ),),
                    ],
                  ),
                ),
                SizedBox(height: 200,),
                Expanded(child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                         MyListTile(
                            icon: Icons.camera, text: 'Post to community', endIcon: Icons.arrow_forward_ios_outlined,
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

                              print('${file?.path}');


                              if(file == null){
                                return;
                              }
                              if(!mounted)return;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>CommunityPostPreview(file)
                                  )
                              );
                            },
                        ),

                        SizedBox(height: 20,),

                         MyListTile(
                            icon: Icons.document_scanner, text: 'Pick from gallery', endIcon: Icons.arrow_forward_ios_outlined,
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

                            if(file == null){
                              return;
                            }
                            final uid = supabase.auth.currentUser!.id;
                            if(uid.isEmpty)return;
                            try{
                              await supabase.storage
                                  .from('images')
                                  .upload(
                                  '$uid/${file.name}',
                                  File(file.path));
                            }
                            catch(error){
                              if(!mounted)return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error Please try again'))
                              );
                            }
                            try{
                              final publicUrl = supabase
                                  .storage
                                  .from('images')
                                  .getPublicUrl('$uid/${file.name}');

                              await supabase.from('chats_ID').insert({

                              });
                            }
                            catch(error){
                              if(!mounted)return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('message${error.toString()}'))
                              );
                            }
                            if(!mounted)return;
                            Navigator.pop(context);

                          },
                        ),

                        SizedBox(height: 20),

                        MyListTile(
                            icon: Icons.tag, text: 'Post to marketplace', endIcon: Icons.arrow_forward_ios_outlined,
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

                            print('${file?.path}');


                            if(file == null){
                              return;
                            }
                            if(!mounted)return;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>AuctionPreview(file)
                                )
                            );
                          },
                        ),

                        SizedBox(height: 20),

                        const MyListTile(icon: Icons.style, text: 'Style', endIcon: Icons.arrow_forward_ios_outlined),

                        const SizedBox(height: 40,),
                        



                      ],
                    ),
                  ),
                ))
              ],

            )
        )
    );
  }
}
