import 'package:artify/components/MyButton.dart';
import 'package:artify/components/new_textfield.dart';
import 'package:artify/screens/select_interest_section.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/constants.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var nameController = TextEditingController();

  var bioController = TextEditingController();

  var phoneController = TextEditingController();

  var domainController = TextEditingController();

  var emailController = TextEditingController();


  String currentName = '';
  String currentBranch = '';
  String currentHometown = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //   Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     leading: IconButton(onPressed: (){
    //       Navigator.pop(context);
    //     },icon: const Icon(Icons.arrow_back_ios),),
    //     title: Text('Edit Profile',
    //       textAlign: TextAlign.center,
    //       style: Theme.of(context).textTheme.headlineSmall,
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20),
    //
    //       child : Column(
    //         children: [
    //           Center(
    //             child: SizedBox(
    //
    //               child: Stack(
    //
    //                 // alignment: Alignment.center,
    //
    //                 children: [
    //                   Center(
    //                     child: CircleAvatar(
    //                       backgroundImage: const AssetImage(
    //                         'lib/assets/images/profile_image.jpg',
    //                       ),
    //                       radius: size.width/5,
    //                     ),
    //                   ),
    //                   Positioned(
    //                     bottom: 0,
    //                     right: size.width/3.5,
    //                     child: Container(
    //                       width: 35,
    //                       height: 35,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(100),
    //                         color: Colors.grey,
    //
    //                       ),
    //                       child: const Icon(
    //                         Icons.camera,
    //                       ),
    //
    //                     ),
    //                   ),
    //
    //
    //
    //                 ],
    //               ),
    //             ),
    //           ),
    //           const SizedBox(height: 50,),
    //            const Form(child: Column(
    //             children: [
    //               NewTextField(labelText: 'Email', icon: Icons.email,),
    //               SizedBox(height: 10,),
    //               NewTextField(labelText: 'Name', icon: Icons.person,),
    //               SizedBox(height: 10,),
    //               NewTextField(labelText: 'Domain', icon: Icons.domain_verification,),
    //               SizedBox(height: 10,),
    //               NewTextField(labelText: 'Address', icon: Icons.location_pin,),
    //               SizedBox(height: 10,),
    //               NewTextField(labelText: 'Phone', icon: Icons.phone,),
    //               SizedBox(height: 10,),
    //             ],
    //           )),
    //           SizedBox(height: 20,),
    //
    //           Container(
    //             height: 50,
    //             padding: EdgeInsets.symmetric(horizontal: 20),
    //             decoration : BoxDecoration(
    //                 color: Colors.grey.shade300,
    //                 borderRadius: BorderRadius.circular(50),
    //                 border: Border.all(color: Colors.black87)
    //
    //
    //             ),
    //
    //             child: const Center(
    //               child: Text(
    //                 'Save Changes',
    //                 style: TextStyle(
    //                     fontSize: 15,
    //                     color: Colors.black87,
    //                     fontWeight: FontWeight.w900
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 20,),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               const Text.rich(
    //                 TextSpan(
    //                   text: 'Joined ',
    //                   style: TextStyle(fontSize: 12),
    //                   children: [
    //                     TextSpan(
    //                         text: '28 December 2022',
    //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
    //                   ],
    //                 ),
    //               ),
    //               ElevatedButton(
    //                 onPressed: () {
    //                 },
    //                 style: ElevatedButton.styleFrom(
    //                     backgroundColor: Colors.redAccent.withOpacity(0.1),
    //                     elevation: 0,
    //                     foregroundColor: Colors.red,
    //                     shape: const StadiumBorder(),
    //                     side: BorderSide.none),
    //                 child: const Text('Change Domain'),
    //               ),
    //             ],
    //           )
    //
    //         ],
    //       )
    //     ),
    //   ),
    // );
    return StreamBuilder(
      //Fetching data from the documentId specified of the student
      stream: supabase.from('users').stream(primaryKey: ['id']).eq('user_id', supabase.auth.currentUser!.id),
      builder:
          (BuildContext context, AsyncSnapshot snapshot) {


        //Error Handling conditions
        if (snapshot.hasError) {
          return const Center(child: AlertDialog(title: Text("Something went wrong Please Refresh")));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: const Icon(Icons.arrow_back_ios),),
              title: Text('Edit Profile',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),

                  child : Column(
                    children: [
                      Center(
                        child: SizedBox(

                          child: Stack(

                            // alignment: Alignment.center,

                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundImage: const AssetImage(
                                    'lib/assets/images/profile_image.jpg',
                                  ),
                                  radius: size.width/5,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: size.width/3.5,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey,

                                  ),
                                  child: const Icon(
                                    Icons.camera,
                                  ),

                                ),
                              ),



                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,),
                       Form(child: Column(
                        children: [
                          NewTextField(labelText: 'Email', icon: Icons.email, controller: emailController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'Name', icon: Icons.person, controller: nameController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'Domain', icon: Icons.domain_verification, controller: domainController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'BIO', icon: Icons.location_pin, controller: bioController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'Phone', icon: Icons.phone, controller: phoneController,),
                          SizedBox(height: 10,),
                        ],
                      )),
                      SizedBox(height: 20,),

                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration : BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black87)


                        ),

                        child: const Center(
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: 'Joined ',
                              style: TextStyle(fontSize: 12),
                              children: [
                                TextSpan(
                                    text: '28 December 2022',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                side: BorderSide.none),
                            child: const Text('Change Domain'),
                          ),
                        ],
                      )

                    ],
                  )
              ),
            ),
          );
        }



        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.active) {
          final data = snapshot!.data;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: const Icon(Icons.arrow_back_ios),),
              title: Text('Edit Profile',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),

                  child : Column(
                    children: [
                      Center(
                        child: SizedBox(

                          child: Stack(

                            // alignment: Alignment.center,

                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'lib/assets/images/profile_image.jpg'
                                  ),
                                  radius: size.width/5,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: size.width/3.5,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey,

                                  ),
                                  child: const Icon(
                                    Icons.camera,
                                  ),

                                ),
                              ),



                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,),
                       Form(child: Column(
                        children: [
                          NewTextField(labelText: 'Email', icon: Icons.email, controller: emailController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'Name', icon: Icons.person, controller: nameController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'Age', icon: Icons.timelapse, controller: domainController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'BIO', icon: Icons.location_pin, controller: bioController,),
                          SizedBox(height: 10,),
                          NewTextField(labelText: 'Phone', icon: Icons.phone, controller: phoneController,),
                          SizedBox(height: 10,),
                        ],
                      )),
                      SizedBox(height: 20,),

                      GestureDetector(
                        onTap: () async {
                          if (nameController.text.isNotEmpty) {
                            await supabase.from('users').update({
                              'name': nameController.text.trim(),
                            }).eq('user_id', supabase.auth.currentUser!.id);

                            setState(() {
                              nameController.clear();
                            });
                          }
                          if (bioController.text.isNotEmpty) {
                            await supabase.from('users').update({
                              'bio': bioController.text.trim(),
                            }).eq('user_id', supabase.auth.currentUser!.id);
                            setState(() {
                              bioController.clear();
                            });
                          }
                          if (phoneController.text.isNotEmpty) {
                            await supabase.from('users').update({
                              'phone_no': phoneController.text.trim()
                            }).eq('user_id', supabase.auth.currentUser!.id);
                            setState(() {
                              phoneController.clear();
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration : BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black87)


                          ),

                          child: const Center(
                            child: Text(
                              'Save Changes',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: 'Joined ',
                              style: TextStyle(fontSize: 12),
                              children: [
                                TextSpan(
                                    text: '28 December 2022',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>const SelectInterest()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                side: BorderSide.none),
                            child: const Text('Change Domain'),
                          ),
                        ],
                      )

                    ],
                  )
              ),
            ),
          );
        }
        final data = snapshot!.data;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: const Icon(Icons.arrow_back_ios),),
            title: Text('Edit Profile',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),

                child : Column(
                  children: [
                    Center(
                      child: SizedBox(

                        child: Stack(

                          // alignment: Alignment.center,

                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundImage: const AssetImage(
                                  'lib/assets/images/profile_image.jpg',
                                ),
                                radius: size.width/5,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: size.width/3.5,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey,

                                ),
                                child: const Icon(
                                  Icons.camera,
                                ),

                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,),
                     Form(child: Column(
                      children: [
                        NewTextField(labelText: 'Email', icon: Icons.email, controller: emailController,),
                        SizedBox(height: 10,),
                        NewTextField(labelText: 'Name', icon: Icons.person, controller: nameController,),
                        SizedBox(height: 10,),
                        NewTextField(labelText: 'Domain', icon: Icons.domain_verification, controller: domainController,),
                        SizedBox(height: 10,),
                        NewTextField(labelText: 'BIO', icon: Icons.location_pin, controller: bioController,),
                        SizedBox(height: 10,),
                        NewTextField(labelText: 'Phone', icon: Icons.phone, controller: phoneController,),
                        SizedBox(height: 10,),
                      ],
                    )),
                    SizedBox(height: 20,),

                    GestureDetector(
                      onTap: () async {
                        try{
                          if (nameController.text.isNotEmpty) {
                            await supabase.from('users').update({
                              'name': nameController.text.trim(),
                            }).eq('uid', supabase.auth.currentUser!.id);

                            nameController.clear();
                          }
                          if (bioController.text.isNotEmpty) {
                            await supabase.from('users').update({
                              'bio': bioController.text.trim(),
                            }).eq('uid', supabase.auth.currentUser!.id);
                          }
                          if (phoneController.text.isNotEmpty) {
                            await supabase.from('users').update({
                              'phone_no': phoneController.text.trim()
                            }).eq('uid', supabase.auth.currentUser!.id);
                          }
                        }
                        catch(error){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())));
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration : BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black87)


                        ),

                        child: const Center(
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Joined ',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: '28 December 2022',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>const SelectInterest()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text('Change Category'),
                        ),
                      ],
                    )

                  ],
                )
            ),
          ),
        );

      },
    );
  }

}

