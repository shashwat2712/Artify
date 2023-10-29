import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/MyButton.dart';
import '../components/appbar_home.dart';
import '../components/new_textfield.dart';
import '../widgets/constants.dart';
import '../widgets/nav_screen.dart';

class CommunityPostPreview extends StatefulWidget {
  CommunityPostPreview(this.file, {Key? key}) : super(key: key);
  XFile file;

  @override
  State<CommunityPostPreview> createState() => _CommunityPostPreviewState();
}

class _CommunityPostPreviewState extends State<CommunityPostPreview> {
  String? user_id = supabase.auth.currentUser?.id;
  String imageUrl = "";
  int views = 0;

  final titleController = TextEditingController();
  final styleController = TextEditingController();
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

    try{
      await supabase.from('community_post').insert({
        'image_url': image_url,
        'title': titleController.text.trim().toString(),
        'description': descriptionController.text.trim().toString(),
        'creator_id' : supabase.auth.currentUser?.id,
        'genre': styleChoosed,
        'likes_count' : 23
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
                  const SizedBox(height: 30.0),
                  NewTextField(
                      labelText: 'Description',
                      icon: Icons.description,
                      controller: descriptionController),
                  SizedBox(height: 30.0),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
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
                  SizedBox(height: 30.0),
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
                    .from('community_post_images')
                    .upload(
                    '$user_id/community/${widget.file.name}',
                    File(widget.file.path));



                publicUrl = await supabase
                    .storage
                    .from('community_post_images')
                    .getPublicUrl('$user_id/community/${widget.file.name}');


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
