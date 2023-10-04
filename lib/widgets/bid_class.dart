class BidClass{
  BidClass( {
    required this.amount, required this.bid_by, required this.auction_id
  });
  final double amount;
  final String bid_by;
  final int auction_id;
  // String author_url

  BidClass.fromMap({
    required Map<String, dynamic> map,
  })  : bid_by = map['bid_by'],
        amount = double.parse((map['amount']).toStringAsFixed(2)),
        auction_id = map['auction_id'];

}