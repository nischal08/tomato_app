import 'package:flutter/material.dart';

import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';

class RestaurantCard extends StatelessWidget {
  final String title;
  final double? rating;
  final String? networkUrl;
  final String? favFood;

  RestaurantCard({
    Key? key,
    required this.title,
    this.rating,
    this.networkUrl,
    this.favFood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _venderInfo(context);
  }

  Container _venderInfo(BuildContext context) {
    return Container(
      height: 260,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).cardColor,
        boxShadow: [kBoxShadowSmall],
      ),
      child: Stack(
        children: [
          _image(),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _info(context),
          ),
          Positioned(
            left: 16,
            bottom: 112,
            child: _logo(),
          )
        ],
      ),
    );
  }

  _image() {
    return Container(
      child: Image.asset(
        "assets/foods/restaurant-foods.jpg",
      ),
    );
  }

  Widget _info(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  rating != null ? "$rating" : "4.6",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kColorWhiteText, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          Text(
            "36 -46 mins",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.grey.shade700),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
                text: "Rs. 99 / ",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.grey.shade700),
                children: [
                  TextSpan(
                    text: "Free Over Rs. 2000",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5,
        ),
        boxShadow: [
          kBoxShadowSmall,
        ],
        color: Colors.white,
      ),
      child: networkUrl != null
          ? Image.network(
              networkUrl!,
              fit: BoxFit.cover,
            )
          : Image.asset(
              "assets/venders/pizzahut.png",
            ),
    );
  }
}
