import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/products.dart';
import 'package:tomato_app/models/category_model.dart';

class FoodScreen extends StatefulWidget {
  static const routeName = "/food-category";

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  void initState() {
    _getCategory(context);
    super.initState();
  }

  Future<void> _getCategory(context) async {
    await Provider.of<Products>(context, listen: false).getCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    Products _products = Provider.of<Products>(
      context,
      listen: false,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 20,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Food at your service ",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Any food you like ",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          _category(context, _products),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _category(context, _products) {
    return Container(
      height: 100,
      child: Consumer<Products>(
        builder: (__, _products, _) =>
            ListView(scrollDirection: Axis.horizontal, children: [
          for (var data in _products.categoryItems)
            _products.categoryItems.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Transform.translate(
                    offset:
                        Offset(0, _products.categoryKey == data.name ? -10 : 0),
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(right: 30),
                      child: _eachCategory(context,
                          label: data.name,
                          assetUrl: _products.categoryList[data.name],
                          products: _products),
                    ),
                  ),
        ]),
      ),
    );
  }

  Widget _eachCategory(context,
      {required String assetUrl,
      required String label,
      required Products products}) {
    return GestureDetector(
      onTap: () {
        products.onClickCategory(currentKey: label);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2, bottom: 3),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
                // boxShadow: [kBoxShadowMeduimChipCard],
                borderRadius: BorderRadius.circular(25),
                color: products.categoryKey == label
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor),
            child: SizedBox(
              height: 32,
              child: Image.asset(
                assetUrl,
                fit: BoxFit.fitHeight,
                color: products.categoryKey == label
                    ? kColorWhiteText
                    : kColorBlackText,
              ),
            ),
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: kColorBlackText.withOpacity(0.6)
                    // color: _restaurantControllerState.categoryKey == label
                    //     ? Colors.white
                    //     : Colors.black
                    ),
          ),
        ],
      ),
    );
  }
}
