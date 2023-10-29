import 'dart:ui';

import 'package:artify/screens/profile_section.dart';
import 'package:artify/widgets/constants.dart';
import 'package:artify/widgets/instruction_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:iconly/iconly.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../widgets/auction_class.dart';
import '../widgets/bid_class.dart';
import '../widgets/colors.dart';

class AuctionDescriptionScreen extends StatefulWidget {
  const AuctionDescriptionScreen({Key? key, required this.details})
      : super(key: key);
  final AuctionClass details;

  @override
  State<AuctionDescriptionScreen> createState() =>
      _AuctionDescriptionScreenState();
}

class _AuctionDescriptionScreenState extends State<AuctionDescriptionScreen> {
  late final Stream<List<BidClass>> _messagesStream;
  Map value = {};

  TextEditingController customBidController = TextEditingController();



  List<Instructions>instructions =[
  Instructions(value: 'Total Bids', key: '3948'),
  Instructions(value: 'Minimum bid interval', key: '2736'),
  Instructions(value: 'Note', key: 'Custom Bids can be placed using the rupee button on the slide bar'),

  ];



  @override
  void initState() {
    // TODO: implement initState
    

    double nextBidAmount = widget.details.basePrice;
    _messagesStream = supabase
        .from('bids')
        .stream(primaryKey: ['id'])
        .eq('auction_id', widget.details.auction_id)
        .order('created_at', ascending: false)
        .map((maps) {
          return maps.map((map) {
            return BidClass.fromMap(map: map);
          }).toList();
        });
    super.initState();
  }

  bool isLive() {
    return widget.details.end_date.compareTo(DateTime.now()) > 0;
  }
  Future<void> createCustomBid(String customBidString) async {

    // if(!isLive())return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Placing your Bid'),
      backgroundColor: Colors.green[500],
    ));
    try {
      value = await supabase
          .from('bids')
          .select()
          .eq('auction_id', widget.details.auction_id)
          .order('amount')
          .maybeSingle()
          .limit(1) ??
          {'amount': widget.details.basePrice};
      int customBid = int.parse(customBidString);
      if(customBid > widget.details.min_bid_interval + value['amount']){
        await supabase.from('bids').insert({
          'amount': customBid,
          'bid_by': supabase.auth.currentUser!.id,
          'auction_id': widget.details.auction_id
        });
      }
      else{
        if(!mounted)return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Invalid Bid !!'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }



    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error Occurred please retry : $error'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }
  Future<void> createBid() async {
    // if(!isLive())return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Placing your Bid'),
      backgroundColor: Colors.green[500],
    ));
    try {
      value = await supabase
              .from('bids')
              .select()
              .eq('auction_id', widget.details.auction_id)
              .order('amount')
              .maybeSingle()
              .limit(1) ??
          {'amount': widget.details.basePrice};

      double nextBidAmount = widget.details.min_bid_interval + value['amount'];
      print(value['amount']);
      print(widget.details.min_bid_interval);
      print('//////////////////nice///////////////////');

      await supabase.from('bids').insert({
        'amount': nextBidAmount,
        'bid_by': supabase.auth.currentUser!.id,
        'auction_id': widget.details.auction_id
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error Occurred please retry : $error'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height / 2.5,
            child: Image.asset(
              "lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg",
              fit: BoxFit.cover,
            ),
          ),
          buttonArrow(context),
          scroll(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 370,
                // padding: EdgeInsets.all(4.0),
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> _key = GlobalKey();

                    return SlideAction(
                      outerColor: Colors.grey,
                      key: _key,
                      onSubmit: () {
                        _key.currentState?.reset();
                        createBid();
                        // widget.details. =
                      },
                      borderRadius: 12,
                      elevation: 0,
                      // innerColor: Colors.deepPurple,
                      // outerColor: Colors.deepPurple,
                      sliderButtonIcon: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor:
                                    Colors.black,
                                builder: (context) => Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: TextFormField(
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  controller: customBidController,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                      'Enter the custom amount',
                                                      prefixIcon: Icon(Icons
                                                          .currency_bitcoin_outlined),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                      ),
                                                      floatingLabelStyle: TextStyle(
                                                          color: Colors.grey),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color: Colors.white),
                                                      )),


                                                  obscureText: false,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: (){
                                                  createCustomBid(customBidController.text.toString());
                                                  Navigator.pop(context);
                                                  customBidController.clear();
                                                },
                                                icon: const Icon(Icons.send)),




                                          ],
                                        ),

                                      ],
                                    ));
                          },
                          child: Container(
                              child: const Icon(Icons.currency_rupee))),
                      text: 'Slide to Bid',
                      textStyle: const TextStyle(fontSize: 24),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    Size size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: ListView(controller: scrollController, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75.0),
                      color: Colors.grey[100],
                    ),
                    height: 75,
                    width: size.width,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: size.width / 2.5,
                              child: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'HIGHEST BID',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    ),
                                    StreamBuilder<List<BidClass>>(
                                        stream: _messagesStream,
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData){
                                            final bids = snapshot.data!;
                                            return Text(
                                              bids[0].amount.toString() ??
                                                  widget.details.basePrice
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            );

                                          }
                                          else{
                                            return Text(
                                                  widget.details.basePrice
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }


                                        }),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Container(
                              width: size.width / 2.5,
                              child: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'AUCTION ENDS IN',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    ),
                                    Expanded(
                                      child: CountdownTimer(
                                        endWidget: const Text(
                                          '00:00:00',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        endTime: widget.details.end_date
                                            .millisecondsSinceEpoch,
                                        textStyle: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        onEnd: () async {
                                          try {
                                            await supabase
                                                .from('marketplace_post')
                                                .update({'is_live': false}).eq(
                                                    'id',
                                                    widget.details.auction_id);
                                          } catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Error Occurred please retry : $error'),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                            ));
                                          }
                                          // Timer has ended, you can perform some action here
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.details.title ?? "Loading",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isLive() ? Colors.redAccent : Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.all(4),
                    child: Text(isLive() ? "Live" : 'Completed',
                        style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileSection(),
                              ));
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("lib/assets/images/profile_image.jpg"),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(

                        child: Text(
                          widget.details.users['name'],
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: mainText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: primary,
                        child: Icon(
                          Icons.currency_rupee,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          const Text(
                            'BASE PRICE',
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                          Text(
                            widget.details.basePrice.toString() ?? 'loading',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Bid Chart",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Image(
                        image: AssetImage(
                          'lib/assets/images/auction.png',
                        ),
                        height: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: SingleChildScrollView(
                      child: StreamBuilder<List<BidClass>>(
                          stream: _messagesStream,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              final bids = snapshot.data!;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: bids.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {},
                                      leading: const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                          'lib/assets/images/profile_image.jpg',
                                        ),
                                      ),
                                      title: FutureBuilder<
                                              List<Map<String, dynamic>>>(
                                          future: supabase
                                              .from('users')
                                              .stream(primaryKey: ['user_id'])
                                              .eq('user_id', bids[index].bid_by)
                                              .first,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final name =
                                                  snapshot.data?[0]['name'];
                                              final imageUrl = snapshot.data?[0]
                                                  ['profile_url'];
                                              widget.details.name = name;
                                              // widget.details.
                                              return Text(
                                                name ?? " ",
                                              );
                                            } else {
                                              return const Text(
                                                "Loading",
                                                style: TextStyle(fontSize: 16),
                                              );
                                            }
                                          }),
                                      trailing: Text(
                                        '\$${bids[index].amount}' ?? " ",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else {
                              return const Center(child: Text('loading'));
                            }
                          }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Transform your photos into classic artworks',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: SecondaryText),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Instructions",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: instructions.length,
                    itemBuilder: (context, index) => ingredients(context,instructions[index].key,instructions[index].value),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Steps",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => steps(context, index),
                  ),
                ],
              ),
            ]),
          );
        });
  }

  ingredients(BuildContext context,String key,String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xFFE3FFF8),
            child: Icon(
              Icons.done,
              size: 15,
              color: primary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "$value : $key",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  steps(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: mainText,
            radius: 12,
            child: Text("${index + 1}"),
          ),
          Column(
            children: [
              SizedBox(
                width: 270,
                child: Text(
                  "An app for art collectors and enthusiasts! Sotheby’s application provides access to today’s current trends, global artworks, precious articles, and more! Find old masterpieces or contemporary art; or furniture to photography to prints; or dabble in fine wine and jewelry. Regardless, you are bound to find something of interest! Known for its unparalleled expertise, Sotheby’s world-class specialists have assembled quality art-based content for its users! ",
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: mainText),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg",
                height: 155,
                width: 270,
              )
            ],
          )
        ],
      ),
    );
  }
}
