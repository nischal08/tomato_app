import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_app/contants/color_properties.dart';

class ProductCard extends StatelessWidget {
  final String favFood;
  final String title;
  final double? rating;
  final double? price;
  final String? networkUrl;
  final double? productPadding;
  final bool addToCartFlag;
  final Color? priceColor;
  final bool isVenderCard;
  final bool isCartCard;
  ProductCard({
    this.priceColor,
    this.productPadding,
    required this.networkUrl,
    required this.favFood,
    required this.title,
    this.rating,
    this.price,
    this.addToCartFlag = false,
    this.isVenderCard = false, this.isCartCard=false,
  });
  @override
  Widget build(BuildContext context) {
    return _card(context);
  }

  Widget _card(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 160,
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: productPadding ?? 10,
          horizontal: 30,
        ),
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(addToCartFlag ? 20 : 13),
          child: Row(
            mainAxisAlignment:isCartCard?MainAxisAlignment.start: isVenderCard
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.start,
            children: [
              _logo(context),
              SizedBox(
                width: isVenderCard ? 0 : 20,
              ),
              _info(context),
              if (isVenderCard)
                SizedBox(
                  width: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      padding: EdgeInsets.all(5),
      child: (isVenderCard || isCartCard)
          ? Image.asset(networkUrl!)
          : networkUrl == null
              ? Image.asset('assets/foods/polopizza.png')
              : Image.network(
                  networkUrl!,
                  fit: BoxFit.cover,
                ),
    );
  }

  Widget _info(context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addToCartFlag ? SizedBox() : _rating(context),
          _title(context),
          SizedBox(
            height: price != null ? 6 : 10,
          ),
          _type(context),
          price != null
              ? _price(context)
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }

  Widget _price(context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            "Rs.$price",
            style: GoogleFonts.openSans(
              fontSize: addToCartFlag ? 18 : 16,
              fontWeight: addToCartFlag ? FontWeight.w700 : FontWeight.w600,
              color: addToCartFlag
                  ? Theme.of(context).accentColor
                  : priceColor ?? kColorBlackText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _rating(context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$rating",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.star_rounded,
                size: 16,
                color: Colors.amber[300],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Container(
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _type(context) {
    return Container(
      child: Text(
        favFood,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
