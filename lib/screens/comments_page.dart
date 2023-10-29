
import 'package:artify/components/comment_wall_post..dart';
import 'package:artify/screens/upload_message_image.dart';
import 'package:artify/widgets/constants.dart';
import 'package:flutter/material.dart';

import '../components/image_chat.dart';
import '../components/message_tile.dart';

class CommentsPage extends StatefulWidget {
  final int postId;
  const CommentsPage({Key? key,required this.postId}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}


class _CommentsPageState extends State<CommentsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  void onSendMessage(String messages)async{
    try{
      if(supabase.auth.currentUser != null){
        final chatRoomId = await supabase.from('comments').insert({
          'comment_text': _message.text,
          'community_post_id': widget.postId,
        });

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please try again')));
      }
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())));
    }
  }


  final _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              child: const Icon(Icons.expand_circle_down,size: 40,),
            ),
            Expanded(
              child: StreamBuilder(
                stream: supabase.from('comments').stream(primaryKey: ['comment_id']).order('timestamp').eq('community_post_id', widget.postId ),
                builder: (context, snapshot){

                  if(snapshot.hasData){
                    final messages = snapshot.data!;

                    return ListView.builder(



                        itemCount: messages.length,
                        itemBuilder: (context,index){

                          if(supabase.auth.currentUser != null){
                            return CommentPost(message: messages[index]['comment_text'], user: messages[index]['author_id'], postId: widget.postId, likes: []);
                          }
                          else{
                            return Container();
                          }
                        }
                    );
                  }
                  else{
                    return Container();
                  }

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black12
                        ),
                        borderRadius: BorderRadius.circular(20)

                    ),
                    height: size.height/12,
                    width: size.width/1.05,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: _message,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color:Colors.transparent)
                                ),

                                hintText: 'Send Message',
                              ),


                              obscureText: false,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: (){
                              onSendMessage(_message.text.trim());
                              _message.clear();
                            },
                            icon: const Icon(Icons.send)),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
