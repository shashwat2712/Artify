import 'package:artify/components/appbar_home.dart';
import 'package:artify/components/auction_tile.dart';
import 'package:artify/widgets/auction_class.dart';
import 'package:flutter/material.dart';
import '../widgets/constants.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  late final Stream<List<AuctionClass>> _messagesStream;
  @override
  void initState() {
    // TODO: implement initState
    final myUserId = supabase.auth.currentUser!.id;
    // _messagesStream = supabase
    //     .from('marketplace_post')
    //     .stream(primaryKey: ['id'])
    //     .order('created_at',ascending: false)
    //     .map((maps) {
    //   return maps.map((map) {
    //     return AuctionClass.fromMap(map: map);
    //   }).toList();
    // });
    _messagesStream = supabase
        .from('marketplace_post')
        .select<List<Map<String, dynamic>>>('*, users(*)').order('created_at',ascending: false).asStream()
        .map((maps) {
      return maps.map((map) {
        return AuctionClass.fromMap(map: map);
      }).toList();
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                decoration: InputDecoration(

                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search marketplace...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(40)

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(40)
                    )
                ),

              ),
            ),
            const SizedBox(height: 20,),
            StreamBuilder<List<AuctionClass>>(

              stream: _messagesStream,
              builder: (BuildContext context, snapshot) {
                if(snapshot.hasData){
                  final auctions = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: auctions.length,
                      itemBuilder: (context,index){
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              AuctionTile(details: auctions[index]),
                                const SizedBox(height: 20,)
                            ],
                          ),
                        );
                      }
                  );
                }
                else if(snapshot.hasError){
                  return Center(
                   child: Text(snapshot.error.toString()),
                      );
                }
                else {
                  return const Center(
                    child: Text('loading')
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
