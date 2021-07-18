import 'package:flutter/material.dart';

import 'package:tomato_app/contants/color_properties.dart';

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

  Card _venderInfo(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      elevation: 5,
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          _image(),
          SizedBox(
            width: 30,
          ),
          _info(context),
        ],
      ),
    );
  }

  Widget _info(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 30),
      // color: Colors.green,
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Text(
                rating != null ? "$rating" : "4.6",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(width: 1),
              Icon(
                Icons.star_rounded,
                color: KColorRatingColor,
                size: 22,
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      child:networkUrl != null?
           CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage:  NetworkImage(
                networkUrl!,
              )
           ):
           CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(
                  "assets/venders/pizzahut.png",
                ),
           )
         
    );
  }
}
