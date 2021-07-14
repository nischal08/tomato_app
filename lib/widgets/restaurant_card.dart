import 'package:flutter/material.dart';

import 'package:tomato_app/contants/color_properties.dart';

class RestaurantCard extends StatelessWidget {
  final String title;
final double? rating ;
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: EdgeInsets.only(bottom: 20),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                networkUrl??"assets/venders/pizzahut.png",
                height: 100,
              ),
              Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                       rating!=null?  "$rating": "4.6",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(width: 1),
                        Icon(
                          Icons.star_rounded,
                          color: KColorRatingColor,
                          size: 22,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      favFood ?? "Pizza",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
