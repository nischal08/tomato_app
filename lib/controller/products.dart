import 'package:flutter/widgets.dart';
import 'package:tomato_app/models/product.dart';

class Products with ChangeNotifier {
  List<Product> items = [
    Product(
      image:
          "https://siddharthabiz.com/wp-content/uploads/2020/07/quick_mom.jpg",
      title: "Momo",
      price: 100.0,
      rating: 4.2,
      type: "FastFood",
      // isFavorite: true,
    ),
    Product(
      image:
          "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F19%2F2014%2F07%2F10%2Fpepperoni-pizza-ck-x.jpg&q=85",
      title: "Pepperoni pizza",
      price: 533.0,
      rating: 4.5,
      type: "Mixed Pizza",
      // isFavorite: false,
    ),
    Product(
      image:
          "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
      title: "Burger",
      price: 230.0,
      rating: 4.4,
      type: "FastFood",
      // isFavorite: false,
    ),
    Product(
      image: "https://i.ytimg.com/vi/vZZYcW9Sz90/maxresdefault.jpg",
      title: "Chowmein",
      price: 100.0,
      rating: 4.7,
      type: "FastFood",
      // isFavorite: true,
    ),
    Product(
      image:
          "https://images-gmi-pmc.edge-generalmills.com/1fd2e37a-2c90-4e07-ad57-a3c218fe1ea9.jpg",
      title: "Meat balls",
      price: 222.0,
      rating: 4.6,
      type: "FastFood",
      // isFavorite: false,
    ),
    Product(
      image:
          "https://cookwithrenu.com/wp-content/uploads/2019/09/Thukpa_3-500x375.jpg",
      title: "Thukpa",
      price: 120.0,
      rating: 4.3,
      type: "FastFood",
      // isFavorite: true,
    ),
    Product(
      image:
          "https://media-cdn.grubhub.com/image/upload/f_auto,fl_lossy,q_80,c_fill,w_200,h_150/wbiy2owp7htth91araet",
      title: "Chirping Chicken",
      price: 420.0,
      rating: 4.2,
      type: "Continental",
      // isFavorite: false,
    ),
  ];
}
