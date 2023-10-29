import 'package:artify/widgets/constants.dart';
import 'package:supabase/supabase.dart';

class LikeService {


  static Future<void> likePost(int postId, String userId) async {
    final response = await supabase
        .from('likes')
        .upsert([
      {'post_id': postId, 'user_id': userId},
    ]);

    if (response.error != null) {
      throw Exception('Failed to like post: ${response.error!.message}');
    }
  }

  static Future<void> unlikePost(int postId, String userId) async {
    final response = await supabase
        .from('likes')
        .delete()
        .eq('post_id', postId)
        .eq('user_id', userId);

    if (response.error != null) {
      throw Exception('Failed to unlike post: ${response.error!.message}');
    }
  }


  static Future<bool> isLikedByUser(SupabaseClient client, String userId, int postId) async {
    List<dynamic> response = await client
        .from('likes')
        .select()
        .eq('post_id', postId)
        .eq('user_id', userId);

    return response.isNotEmpty ?? false;
  }
}
