import 'package:flutter/material.dart';

import '../screens/chatRoom_page.dart';
import 'constants.dart';

class MessageUtility{
  static String chatRoomId(String user1, String user2){
    if(user1[0].toLowerCase().codeUnits[0]>user2[0].toLowerCase().codeUnits[0]){
      return "$user1$user2";
    }
    else{
      return '$user2$user1';
    }
  }
  static Future<void>creatingChatRoom(String receiverId,BuildContext context)async {
    final user_id = supabase.auth.currentUser!.id;
    String roomId = chatRoomId(user_id, receiverId);


    final currentUserName = await supabase
        .from('users')
        .select('name')
        .eq('user_id', user_id).single();

    Map<String,dynamic> receiverMapData = {};

    try{
      receiverMapData = await supabase.from('users').select('*')
          .eq('user_id', receiverId).single();
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }

    List<dynamic> list  = await supabase.from('chat_room').select('*')
        .eq('chatRoomId', roomId);
    List<dynamic> messages  = await supabase.from('chat_room').select('*')
        .eq('chatRoomId', roomId);

    if(list.isEmpty){
      try{
        await supabase.from('chat_room').insert({

          'chatRoomId': roomId,
          'user1': currentUserName[0]['name'].toString(),
          'user2': messages[0]['name'],
        });
      }catch(error){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())));
      }
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>  ChatRoom(
          receiverUserMap: receiverMapData, chatRoomId: roomId,
          currentUserName: currentUserName['name'].toString(),
        ))
    );

  }
}