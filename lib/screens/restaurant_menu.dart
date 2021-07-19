import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/products.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/widgets/product_card.dart';

class RestaurantMenu extends StatefulWidget {
  static const routeName = '/restaurant-menu';
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  late Products _productContr;
  bool isInit = false;
  late HomeController _homeControllerState;
  bool isLoading = false;
  var _theme;

  late TextTheme _themeData;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    isLoading = true;

    if (!isInit) {
      await _loadingData(context);
    }
    isInit = true;
    isLoading = false;
  }

  _loadingData(context) async {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    await Provider.of<Products>(context, listen: false)
        .getRestaurantItems(context, restaurantId: id);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _theme = Theme.of(context);
    _homeControllerState = Provider.of<HomeController>(context, listen: false);
    final Products productData = Provider.of<Products>(context);
    return _body(context, productData);
  }

  Widget _body(context, productData) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).canvasColor,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _customAppbar(),
              SizedBox(
                height: 20,
              ),
              _venderInfo(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: RefreshIndicator(
                    onRefresh: () => _loadingData(context),
                    child: _productList(context, productData)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
 Widget _productList(context, Products productData) {
    return Container(
      child: productData.showSpinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : productData.restaurantMenuItems.isEmpty
              ? Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Text(
                        "This restaurant is coming soon!!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      )),
                )
              : ListView.builder(
                  itemCount: productData.restaurantMenuItems.length,
                  itemBuilder: (context, index) =>
                      ChangeNotifierProvider<Datum>.value(
                    value: productData.restaurantMenuItems[index],
                    child: ProductCard(context),
                  ),
                ),
    );
  }
  _customAppbar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(),
          _backBtn(),
        ],
      ),
    );
  }

  GestureDetector _backBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        // return _homeControllerState.onChangeWidget(0);
      },
      child: Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: kColorLightGrey,
      ),
    );
  }

  _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose what you", style: _themeData.headline4),
        SizedBox(
          height: 5,
        ),
        Text("want to eat today", style: _themeData.headline5),
      ],
    );
  }

  Widget _venderInfo() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [kBoxShadowBigCard],
          borderRadius: BorderRadius.circular(20),
          color: _theme.cardColor,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        padding: EdgeInsets.only(
          left: 15,
          top: 5,
          bottom: 5,
        ),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _venderLogo(),
            _venderName(),
            SizedBox(
              width: 55,
            ),
          ],
        ));
  }

  Widget _venderLogo() {
    return SizedBox(
      height: 55,
      width: 55,
      child: Image.asset(
        'assets/venders/pizzahut.png',
      ),
    );
  }

  Widget _venderName() {
    return Text(
      "PizzaHut",
      style: _themeData.headline6,
    );
  }
}
