import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import 'community_class.dart';
import 'constants.dart';


class CommunityPostView extends StatefulWidget {
  const CommunityPostView({Key? key}) : super(key: key);

  @override
  State<CommunityPostView> createState() => _CommunityPostViewState();
}

class _CommunityPostViewState extends State<CommunityPostView> {
  late final Stream<List<CommunityClass>> _postStream;
  @override
  void initState() {
    // TODO: implement initState
    _postStream = supabase
        .from('community_post')
        .select<List<Map<String, dynamic>>>('*, users(*)').order('created_at',ascending: false).asStream()
        .map((maps) {
      return maps.map((map) {
        return CommunityClass.fromMap(map: map);
      }).toList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommunityClass>>(

        stream: _postStream,
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData){
            final posts = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: MasonryGridView.builder(
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  ),
                itemCount: posts.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            imageUrl: posts[index].imageUrl,
                          placeholder:(context,url)=> ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Shimmer.fromColors(
                            highlightColor: Colors.white,
                            baseColor: Colors.white12,
                            child: Container(
                              margin: const EdgeInsets.only(right : 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                          errorWidget:(context,url,error)=> ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Shimmer.fromColors(
                              highlightColor: Colors.white,
                              baseColor: Colors.white12,
                              child: Container(
                                margin: const EdgeInsets.only(right : 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );

                },
              ),
            );
          }
          else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
