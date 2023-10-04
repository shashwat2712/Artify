class CategoryModel {
  static final items = [
    Item(
        categoryName: 'Painting',
        imageLocation:
            'lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg'),
    Item(
        categoryName: 'Digital Art',
        imageLocation: 'lib/assets/images/digital_art.jpg'),
    Item(
        categoryName: 'Sculpture',
        imageLocation: 'lib/assets/images/pottery.png'),
    Item(
        categoryName: 'Origami',
        imageLocation: 'lib/assets/images/origami.jpg'),
    Item(
        categoryName: 'Relic',
        imageLocation:
            'lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg'),
    Item(
        categoryName: 'Photography',
        imageLocation:
            'lib/assets/images/deer-in-the-forest-beautiful-sunset.jpg'),
  ];
}

class Item {
  late final String categoryName;
  late final String imageLocation;

  Item({required this.categoryName, required this.imageLocation});
}
