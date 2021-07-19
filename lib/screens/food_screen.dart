import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/products.dart';
import 'package:tomato_app/models/product_list.dart' as prod;
import 'package:tomato_app/widgets/custom_icon_button.dart';
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
 if(Provider.of<Products>(context, listen: false).categoryList.isEmpty)  Provider.of<Products>(context, listen: false).getCategory(context);
    await Provider.of<Products>(context, listen: false)
        .getItemAsPerCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    Products _products = Provider.of<Products>(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Provider.of<Products>(context, listen: false).ontoggleSearchbar();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 30,
              ),
              _search(context),
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
      ),
    );
  }

  _search(context) {
    return Consumer<Products>(
      builder: (context, products, _) => Container(
        padding: EdgeInsets.only(
          right: 20,
        ),
        child: products.toggleSearchbar
            ? _searchBar(context)
            : _searchButtonTitle(products),
      ),
    );
  }

  Widget _searchButtonTitle(products) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _greeting(context),
        CustomIconButton(
          elevation: 1,
          icon: Icons.search,
          onPressed: () => products.ontoggleSearchbar(),
        )
      ],
    );
  }

  Widget _searchBar(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: TextField(
          decoration: kSearchBarDecoration,
          onChanged: (word) {
            Provider.of<Products>(context, listen: false)
                .getItemAsPerCategory(context, searchWord: word);
          },
          onSubmitted: (word) {
            Provider.of<Products>(context, listen: false)
                .getItemAsPerCategory(context, searchWord: word);
          },
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

 _getRefresh(context, productData) async {
   await Provider.of<Products>(context,listen: false).onClickCategory(context,
        currentKey: productData.currentCategory,
        isAll: productData.currentCategory == "All" ? true : false);
  }

  Widget _productList(context, Products productData) {
    return RefreshIndicator(
      onRefresh:()=> _getRefresh(context, productData),
      child: Container(
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
      ),
    );
  }

  Widget _category(
    context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
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
