import 'package:artify/components/numbers_widget.dart';
import 'package:artify/components/rounded_button.dart';
import 'package:artify/screens/edit_profile.dart';
import 'package:artify/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/constants.dart';
import '../widgets/loginOrRegisterPage.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final double coverHeight = 280;
  final double profileHeight = 140;
  Future<void> signUserOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final top = coverHeight - profileHeight / 2;

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: supabase
            .from('users')
            .stream(primaryKey: ['user_id'])
            .eq('user_id', supabase.auth.currentUser!.id)
            .first,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // You can show a loading indicator while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data?.isEmpty ?? true) {
            return const Text('No data available'); // Handle the case where no data is available.
          }
          else{
            return Scaffold(
                body: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    buildTop(),
                    Center(
                        child: Text(
                          data?[0]['name'],
                          style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                        child: Text(
                          data?[0]['bio'],
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w200,color: Colors.grey[700]),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: signUserOut,
                          child: const RoundedButton(
                            text: 'Follow',
                            color: Colors.black87,
                            textColor: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          child: const RoundedButton(
                            text: 'Message',
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    const NumberWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                  ],
                ));
          }
        });
  }

  Widget buildTop() {
    Size size = MediaQuery.of(context).size;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: profileHeight / 1.5),
            child: buildCoverImage()),
        Positioned(top: top, child: buildProfileImage()),
        Positioned(top: top, child: buildProfileImage()),
        Positioned(
            top: top / 4,
            right: size.width / 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EditProfile()));
              },
              child: CircleAvatar(
                radius: size.width / 15,
                backgroundColor: Colors.grey,
                child: const Center(
                  child: Icon(Icons.edit),
                ),
              ),
            )),
        Positioned(
            top: top / 3,
            left: size.width / 30,
            child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                ))),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg',
          height: coverHeight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 1.8,
        backgroundColor: Colors.white,
        child: CircleAvatar(
            radius: profileHeight / 2,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: const AssetImage(
              'lib/assets/images/profile_image.jpg',
            )),
      );
}
