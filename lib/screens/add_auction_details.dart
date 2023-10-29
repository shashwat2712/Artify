import 'dart:io';

import 'package:artify/components/appbar_home.dart';
import 'package:artify/components/new_textfield.dart';
import 'package:artify/widgets/constants.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../components/MyButton.dart';
import '../widgets/nav_screen.dart';

class AuctionPreview extends StatefulWidget {
  AuctionPreview(this.file, {Key? key}) : super(key: key);
  XFile file;

  @override
  State<AuctionPreview> createState() => _AuctionPreviewState();
}

class _AuctionPreviewState extends State<AuctionPreview> {
  String? user_id = supabase.auth.currentUser?.id;
  String imageUrl = "";
  int views = 0;

  final titleController = TextEditingController();
  final styleController = TextEditingController();
  final durationController = TextEditingController();
  final basePriceController = TextEditingController();
  final descriptionController = TextEditingController();

  String? styleChoosed;
  List<String> styleList = [
    'Painting',
    'Photograph',
    'Origami',
    'Antic',
    'Sculpture'
  ];


  String? durationChoosed;
  List<String> durationList = [
    '1 Hour',
    '6 Hours',
    '12 Hours',
    '24 Hours',
    '1 Day',
    '2 Day',
    '3 Day'
  ] ;


  Future<void> postAuctionTile(String image_url) async {
    //store in supabase
    print('///////////////////////////////////////////////////');
    print(image_url);
    print(DateTime.now().add(durationMap[durationChoosed]!).toIso8601String());
    print(titleController.text.trim().toString());
    print(durationChoosed);
    print('//////////////////////');

    try{
      await supabase.from('marketplace_post').insert({
        'image_url': image_url,
        'end_date': DateTime.now().add(durationMap[durationChoosed]!).toIso8601String(),

        'min_bid_interval':
            5 * double.parse(basePriceController.text.trim().toString()) / 100,
        'title': titleController.text.trim().toString(),
        'description': descriptionController.text.trim().toString(),
        'base_price': double.parse(basePriceController.text.trim().toString()),
        'creator_id' : supabase.auth.currentUser?.id,
        'type': styleChoosed
      });
    }
    catch(error){
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('message${error.toString()}'))
      );
    }

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const NavScreen()),
      (route) => false,
    );

    //clear the text field
  }


  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.pink[200],
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    picture,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  NewTextField(
                      labelText: 'Title',
                      icon: Icons.title,
                      controller: titleController),
                  SizedBox(height: 30.0),
                  NewTextField(
                      labelText: 'Base Price',
                      icon: Icons.currency_rupee,
                      controller: basePriceController),
                  SizedBox(height: 30.0),
                  // NewTextField(
                  //     labelText: 'Durations',
                  //     icon: Icons.timelapse,
                  //     controller: durationController),
                  NewTextField(
                      labelText: 'Description',
                      icon: Icons.description,
                      controller: descriptionController),
                  // Container(
                  //   // padding: const EdgeInsets.symmetric(horizontal: 4),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(100),
                  //     border: Border.all(color: Colors.grey, width: 1),
                  //   ),
                  //   child: DropdownButton(
                  //     padding: EdgeInsets.all(8),
                  //     hint: const Text('Select Duartion: '),
                  //
                  //     dropdownColor: Colors.grey,
                  //     icon: const Icon(Icons.arrow_circle_down_rounded),
                  //     iconSize: 36,
                  //     isExpanded: true,
                  //     underline: const SizedBox(),
                  //     // style:
                  //     //     const TextStyle(color: Colors.black, fontSize: 22),
                  //     value: styleChoosed,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         styleChoosed = newValue.toString();
                  //       });
                  //     },
                  //     items: styleList.map((valueItem) {
                  //       return DropdownMenuItem(
                  //         value: valueItem,
                  //         child: Text(valueItem),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  SizedBox(height: 30.0),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.timelapse),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: DropdownButton(
                            padding: EdgeInsets.all(8),
                            hint: const Text('Select Duration: '),

                            dropdownColor: Colors.grey,
                            icon: const Icon(Icons.arrow_circle_down_rounded),
                            iconSize: 36,
                            isExpanded: true,

                            underline: const SizedBox(),
                            // style:
                            //     const TextStyle(color: Colors.black, fontSize: 22),
                            value: styleChoosed,
                            onChanged: (newValue) {
                              setState(() {
                                durationChoosed = newValue.toString();
                              });
                            },
                            items: durationList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.style),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: DropdownButton(
                            padding: EdgeInsets.all(8),
                            hint: const Text('Select Style: '),

                            dropdownColor: Colors.grey,
                            icon: const Icon(Icons.arrow_circle_down_rounded),
                            iconSize: 36,
                            isExpanded: true,
                            underline: const SizedBox(),
                            // style:
                            //     const TextStyle(color: Colors.black, fontSize: 22),
                            value: styleChoosed,
                            onChanged: (newValue) {
                              setState(() {
                                styleChoosed = newValue.toString();
                              });
                            },
                            items: styleList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 30.0),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 40,
            ),
            MyButton(onTap: () async {
              String publicUrl = '';
              if(widget.file == Null){
                return;
              }
              try{
                    final imageBytes = await widget.file.readAsBytes();
                    final userId = supabase.auth.currentUser!.id;

                    await supabase.storage
                        .from('marketplace_post_images')
                        .upload(
                        '$user_id/marketplace/${widget.file.name}',
                        File(widget.file.path));



                    publicUrl = await supabase
                        .storage
                        .from('marketplace_post_images')
                        .getPublicUrl('$user_id/marketplace/${widget.file.name}');


                  }
              catch(error){
                if(!mounted)return;
                ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Error Please try again'+ error.toString()))
                );
              }

              print('////////////////final/////////////////////////////////////////////////////////');
              print(publicUrl);
              print('////////////////final/////////////////////////////////////////////////////////');

              postAuctionTile(publicUrl);
                }, text: 'Post'),
          ],
        ),
      ),
    );
  }
}
