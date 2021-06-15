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
  ProductCard({
    this.priceColor,
    this.productPadding,
    required this.assetUrl,
    required this.favFood,
    required this.venderName,
    this.rating,
    this.price,
    this.addToCartFlag = false,
  });
  @override
  Widget build(BuildContext context) {
    return _venderCard(context);
  }

  Widget _venderCard(context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: productPadding ?? 10,
        horizontal: 30,
      ),
      height: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(addToCartFlag ? 20 : 13),
          child: Row(
            children: [
              _venderLogo(),
              SizedBox(
                width: addToCartFlag ? 10 : 35,
              ),
              _venderInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _venderLogo() {
    return Container(
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
              ? _price()
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }

  Widget _price() {
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
              fontWeight: addToCartFlag ? FontWeight.w800 : FontWeight.w600,
              color: addToCartFlag ? kColorLightRed : Colors.black,
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
