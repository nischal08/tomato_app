import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/products.dart';
import 'package:tomato_app/models/category_model.dart';
import 'package:tomato_app/models/product_list.dart' as prod;
import 'package:tomato_app/widgets/product_card.dart';

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
    Provider.of<Products>(context, listen: false).getCategory(context);
    await Provider.of<Products>(context, listen: false)
        .getItemAsPerCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    Products _products = Provider.of<Products>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 20,
            ),
            _greeting(context),
            SizedBox(
              height: 20,
            ),
            _category(
              context,
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(child: _productList(context, _products)),
          ],
        ),
      ),
    );
  }

  Container _greeting(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
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
    );
  }

  Widget _productList(context, Products productData) {
    return Container(
      child: productData.itemAsCategorySpinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : productData.itemAsPerCategory.isEmpty
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Text(
                      "This category has no food are unavailable!!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )
              : MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productData.itemAsPerCategory.length,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider<prod.Datum>.value(
                      value: productData.itemAsPerCategory[index],
                      child: ProductCard(context),
                    ),
                  ),
                ),
    );
  }

  Widget _category(
    context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      height: 100,
      child: Consumer<Products>(
        builder: (context, _products, child) => _products.categorySpinner
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _products.categoryItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var categoryItem = _products.categoryItems[index];
                  return Transform.translate(
                    offset: Offset(0,
                        _products.currentCategory == categoryItem.id ? -10 : 0),
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(right: 30),
                      child: _eachCategory(context,
                          label: categoryItem.name,
                          id: categoryItem.id,
                          assetUrl: _products.categoryList[categoryItem.name],
                          product: _products),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _eachCategory(
    context, {
    String? assetUrl,
    required String id,
    required Products product,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        if (label == "All") {
          product.onClickCategory(context, currentKey: id, isAll: true);
        } else {
          product.onClickCategory(context, currentKey: id, isAll: false);
        }
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
                color: product.currentCategory == id
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor),
            child: SizedBox(
              height: 32,
              child: Image.asset(
                assetUrl!,
                fit: BoxFit.fitHeight,
                color: product.currentCategory == id
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
