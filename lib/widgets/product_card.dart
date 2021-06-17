import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_app/contants/color_properties.dart';

class ProductCard extends StatelessWidget {
  final String favFood;
  final String venderName;
  final double? rating;
  final int? price;
  final String assetUrl;
  final double? productPadding;
  final bool addToCartFlag;
  final Color? priceColor;
  final bool isVenderCard;
  ProductCard({
    this.priceColor,
    this.productPadding,
    required this.assetUrl,
    required this.favFood,
    required this.venderName,
    this.rating,
    this.price,
    this.addToCartFlag = false,
    this.isVenderCard = false,
  });
  @override
  Widget build(BuildContext context) {
    return _venderCard(context);
  }

  Widget _venderCard(context) {
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
            mainAxisAlignment: isVenderCard
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.start,
            children: [
              _venderLogo(),
              SizedBox(
                width: isVenderCard ? 0 : 20,
              ),
              _venderInfo(context),
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

  Widget _venderLogo() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Image.asset(assetUrl),
    );
  }

  Widget _venderInfo(context) {
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
        venderName,
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
