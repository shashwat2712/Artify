class AuctionClass{
  AuctionClass({
    required this.imageUrl,
    required this.auction_id,
    required this.description,
    required this.title,
    required this.basePrice,
    required this.creator_id,
    required this.min_bid_interval,
    // required this.start_date,
    required this.type,
    required this.end_date,
    required this.author_name,
    required this.users
  });
  final String imageUrl;
  final String creator_id;
  final String type;
  final String description;
  final String title;
  final double min_bid_interval;
  final double basePrice;
  // final DateTime start_date;
  final int auction_id;
  final DateTime end_date;
  String name = '';
  String? author_name;
  Map users;
  // String author_url

  AuctionClass.fromMap({
    required Map<String, dynamic> map,
  })  : imageUrl = map['image_url'],
        description = map['description'],
        title = map['title'],
        auction_id = map['id'],
        basePrice = map['base_price'],
        creator_id = map['creator_id'],
        min_bid_interval = map['min_bid_interval'],
        // start_date = map['start_date'],
        type = map['type'],
        author_name = map['users[name]'],
        users = map['users'],
        end_date = DateTime.parse(map['end_date']);

}