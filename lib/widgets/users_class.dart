class UserClass{
  String user_name;
  String profile_url;
  String bio;
  String user_id;
  UserClass.fromMap({
    required Map<String, dynamic> map,
  })  : user_name = map['name'],
        profile_url = map['profile_url'],
        bio = map['bio'],
        user_id = map['user_id'];
}