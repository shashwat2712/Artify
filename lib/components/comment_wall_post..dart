import 'package:artify/widgets/constants.dart';
import 'package:flutter/material.dart';

class CommentPost extends StatefulWidget {
  final String message ;
  final String user;
  final int postId;
  final List<String> likes;
  const CommentPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
});

  @override
  State<CommentPost> createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {

  //Reply Controller
  final replyController = TextEditingController();


  //user
  final currentUser = supabase.auth.currentUser;
  bool isLiked = false;


  @override
  void initState(){
    super.initState();

    //Here Widget refers to the wallpost
    //i.e. we are accessing the property likes of wallpost
    //which was passed when it was called.
    // As we are using a stateful widget here we cannot directly access the
    // properties using 'likes' directly but with 'widget.likes'
    isLiked = widget.likes.contains(currentUser!.email);


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.0),
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 2.0,
        //   ),
        // ]
      ),
      margin: EdgeInsets.only(top: 25.0,left: 25,right: 25.0),
      padding: EdgeInsets.all(25.0),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Profile Picture
          FutureBuilder<
              List<Map<String, dynamic>>>(
              future: supabase
                  .from('users')
                  .stream(primaryKey: ['user_id'])
                  .eq('user_id', widget.user)
                  .first,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final name =
                  snapshot.data?[0]['name'];
                  final imageUrl = snapshot.data?[0]
                  ['profile_url'];
                  // widget.details.
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        name ?? " ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold

                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],

                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Loading",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }
              }),

          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10,),

              Text(widget.message),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  // LikedButton(
                  //   isLiked: isLiked,
                  //   onTap: toggleLike,
                  // ),
                  //Like count
                ],
              ),
              


              // Column(
              //   children: [
              //     ReplyButton(
              //       onTap: showReplyBox,
              //     ),
              //     const SizedBox(height: 10,),
              //
              //
              //     //Like count
              //     // int a = snapshot.data!.docs.length;
              //
              //
              //     Text(
              //       '$numberOfComments',
              //       style: const TextStyle(
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ],
              // ),


            ],
          ),
          SizedBox(height: 10.0,),
          //Replies under the post
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection('User_Posts')
          //         .doc(widget.postId).collection('Replies')
          //         .orderBy('ReplyTime',descending: true).snapshots(),
          //   builder: (context,snapshot){
          //     //show loading circle
          //     if(!snapshot.hasData){
          //       return const Center(
          //           child: CircularProgressIndicator()
          //       );
          //     }
          //     return ListView(
          //       shrinkWrap: true, //for nested lists
          //       physics : const NeverScrollableScrollPhysics(),
          //       children: snapshot.data!.docs.map((doc){
          //         final ReplyData = doc.data() as Map<String, dynamic>;
          //         return ReplyBar(
          //             text: ReplyData['ReplyText'],
          //             time: formatDate(ReplyData['ReplyTime']),
          //             user: ReplyData['RepliedBy']
          //         );
          //       }
          //     ).toList()
          //
          //     );
          //
          //
          // }),
        ],


      ),


    );
  }

  //toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    // DocumentReference postRef =  FirebaseFirestore.instance.collection('User_Posts')
    //     .doc(widget.postId);

    if (isLiked){
      //If the post is liked , add user's email to the 'Likes' field


      // arrayUnion and the arrayRemove : the terms arrayUnion and arrayRemove are
      // typically associated with the Firestore database and they are
      // used in update operations on Array fields within a document.

      //arrayUnion: It is used to add elements to an array field.
      // When you use arrayUnion, you specify one or more elements that you
      // want to add to the array. If the array field already exists,
      // the specified elements will be appended to it.
      // If the array field doesn't exist, it will be created with the specified
      //  elements.


    //   postRef.update(
    //     {
    //       'Likes' : FieldValue.arrayUnion([currentUser.email.toString()])
    //     }
    //
    //   );
    // }
    // else{
    //   //If the post is now unliked , remove the user's email to the 'Likes' field
    //   postRef.update({
    //     'Likes': FieldValue.arrayRemove([currentUser.email.toString()])
    //   });
    //
    // }
  }
  int numberOfComments = 0;
  // void getTheNumberOfComments(){
  //       setState(() async {
  //         numberOfComments = await FirebaseFirestore.instance.collection('User_Posts')
  //             .doc(widget.postId).collection('Replies').snapshots().length;
  //       });
  //       print('/////////////////////////////////////////////////////////////////');
  //       print('/////////////////////////////////////////////////////////////////');
  //       print('/////////////////////////////////////////////////////////////////');
  //       print(numberOfComments);
  //
  // }



  //Creating a method to make a reply box
  // void addReply(String CommentText){
  //   FirebaseFirestore.instance.collection('User_Posts')
  //       .doc(widget.postId)
  //       .collection('Replies')
  //       .add
  //     ({
  //     'ReplyText' : CommentText,
  //     'RepliedBy' : currentUser.email,
  //     'ReplyTime' : Timestamp.now(),
  //     });
  // }



  void showReplyBox(){
    showDialog(context: context,
        builder:(context) => AlertDialog(
          title: Text("Add Reply"),
          content: TextField(
            controller: replyController,
            decoration: const InputDecoration(
              hintText: "Write the reply here"
            ),
          ),
          actions: [
            //cancel button
            TextButton(onPressed:(){
              Navigator.pop(context);

              //clearing the text box
              replyController.clear();
            },
                child: Text('Cancel')),

            //Post Button
            // TextButton(onPressed:(){
            //   addReply(replyController.text.toString());
            //
            //   //Clearing the text box
            //   replyController.clear();
            //
            //   //poping the alert box
            //   Navigator.pop(context);
            //
            //   },
            //     child: Text('Post')),


            
          ],


        ) );
  }


  //Showing the dialog box for typing the replies





}}
