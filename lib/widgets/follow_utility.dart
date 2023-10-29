import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';
class FollowingUtility{
  static Future<bool> isFollowedByUser(SupabaseClient client, String targetUserId) async {
    final currentUser = supabase.auth.currentUser;
    List<dynamic> response = await client
        .from('followers')
        .select()
        .eq('user_id', currentUser!.id)
        .eq('follower_id', targetUserId);
    return response.isNotEmpty ?? false;
  }

  static Future<void> unfollowUser(String targetUserId) async {
    final currentUser = supabase.auth.currentUser;

    if (currentUser != null) {
      await supabase
          .from('followers')
          .delete()
          .eq('user_id', currentUser.id)
          .eq('follower_id', targetUserId);
    }
  }
  static Future<void> followUser(String targetUserId) async {
    final currentUser = supabase.auth.currentUser;

        if (currentUser != null) {
          final response = await supabase.from('followers').upsert([
            {
              'user_id': currentUser.id,
              'follower_id': targetUserId,
            }


          ]);
          if (response.error != null) {
            throw Exception('Failed to check if post is liked: ${response.error!.message}');
          }
        }


  }
  static Future<List<int>> getFollowers(String userId) async {
    final response = await supabase
        .from('followers')
        .select('user_id')
        .eq('follower_id', userId);

    return response.data?.map<int>((e) => e['user_id'] as int).toList() ?? [];
  }
  static Future<List<int>> getFollowing(String userId) async {
    final response = await supabase
        .from('followers')
        .select('follower_id')
        .eq('user_id', userId);

    return response.data?.map<int>((e) => e['follower_id'] as int).toList() ?? [];
  }
}

