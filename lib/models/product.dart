import 'package:flutter/widgets.dart';

class Product with ChangeNotifier {
  final double rating;
  final String title;
  final String type;
  final double price;
  final String image;
  bool isFavorite;

  Product({
    required this.image,
    required this.rating,
    required this.title,
    required this.type,
    required this.price,
    this.isFavorite = false,
  });

  // void _setFavValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  void toggleFavoriteStatus() {
    print("!!!!Toggle Fav Status!!!!");
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    print("!!!!Toggle Fav Status!!!!");
  }
}
