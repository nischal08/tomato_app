import 'package:flutter/widgets.dart';

class Product extends ChangeNotifier {
  final double? rating;
  final String? name;
  final String? type;
  final double? price;
  final String? image;
  bool? isFavorite;

  Product({
    this.image,
    this.rating,
    this.name,
    this.type,
    this.price,
    this.isFavorite = false,
  });

  // void _setFavValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  void toggleFavoriteStatus() {
    print("!!!!Toggle Fav Status!!!!");
    final oldStatus = isFavorite;
    isFavorite = !isFavorite!;
    notifyListeners();
    print("!!!!Toggle Fav Status!!!!");
  }
}
