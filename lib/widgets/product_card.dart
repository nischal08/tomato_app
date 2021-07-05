import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/models/product.dart';
import 'package:tomato_app/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _homeControllerState = Provider.of<HomeController>(context);
    final product = Provider.of<Product>(
      context,
    );

    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen( product: product,),
                ),
              );
              // return _homeControllerState.onChangeWidget(2);
            },
            child: Container(
              child: _card(context, product),
            ),
          ),
          Positioned(
            right: 40,
            top: 1,
            child: GestureDetector(
              onTap: () async {
                await _homeControllerState.onBottomNavClick(2);
              },
              child: _addtoCart(context),
            ),
          ),
          Positioned(
            right: 35,
            bottom: 20,
            child: _favBtn(context, product.isFavorite),
          ),
        ],
      ),
    );
  }

  Widget _favBtn(context, isFav) {
    return Consumer<Product>(
      builder: (context, prod, child) => Material(
        color: Colors.transparent,
        child: IconButton(
          splashRadius: 1,
          onPressed: () {
            prod.toggleFavoriteStatus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            size: 22,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

  Widget _addtoCart(context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        size: 18,
        color: Theme.of(context).cardColor,
      ),
    );
  }

  Widget _card(context, product) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 160,
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 30,
        ),
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _itemImage(context, product),
              SizedBox(
                width: 20,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: _info(context, product),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemImage(context, product) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      padding: EdgeInsets.all(5),
      child: Image.network(
        product.image!,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _info(context, product) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rating(context, product),
          SizedBox(height: 4),
          _title(context, product),
          _type(context, product),
          SizedBox(height: 4),
          _price(context, product)
        ],
      ),
    );
  }

  Widget _price(context, product) {
    return Text(
      "Rs.${product.price}",
      style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _rating(context, product) {
    return Container(
      child: Row(
        children: [
          Text(
            "${product.rating}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 1,
          ),
          Icon(
            Icons.star_rounded,
            size: 22,
            color: kColorAmber,
          )
        ],
      ),
    );
  }

  Widget _title(context, product) {
    return Text(
      product.name!,
      overflow: TextOverflow.fade,
      softWrap: false,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _type(context, product) {
    return Text(
      product.type!,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}
