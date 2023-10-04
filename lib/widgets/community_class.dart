class CommunityClass{

  final String imageUrl;
  final String creator_id;
  final String type;
  final String description;
  final String title;
  final int post_id;
  final int like_count;

  String name = '';
  String? author_name;
  Map users;
  // String author_url

  CommunityClass.fromMap({
    required Map<String, dynamic> map,
  })  : imageUrl = map['image_url'],
        description = map['description'],
        title = map['title'],
        post_id = map['post_id'],
        creator_id = map['creator_id'],
        type = map['genre'],
        like_count = map['likes_count'],
        users = map['users'];

}