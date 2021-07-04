import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/product_detail_controller.dart';
import 'package:tomato_app/widgets/each_product_box.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';
import 'package:tomato_app/widgets/circular_button.dart';

class ProductDetailScreen extends StatelessWidget {
  late ProductDetailController _prodDetailContr;
  late HomeController _homeContrstate;

  bool _checkBigDeviceSize(context) {
    return MediaQuery.of(context).size.height > 530 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    _prodDetailContr = Provider.of<ProductDetailController>(context);
    _homeContrstate = Provider.of<HomeController>(context);
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _upperContainer(context),
            Expanded(child: _lowerContainer(context)),
          ],
        ),
      ),
    );
  }

  Widget _lowerContainer(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          _title(),
          Expanded(
            child: ListView(
              children: [
                _ingredient(context),
                SizedBox(height: 20),
                _productInfoRow(context),
                SizedBox(
                  height: _checkBigDeviceSize(context) ? 40 : 20,
                ),
                _transactionBtn(context),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _upperContainer(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          _appbarAction(context),
          _productImage(),
          SizedBox(
            height: 12,
          ),
          _productQuantity(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _productInfoRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _eachProductInfo(
          context,
          key: "Delivery",
          value: "45 min",
        ),
        _eachProductInfo(
          context,
          key: "Price",
          value: "650 ",
        ),
        _eachProductInfo(
          context,
          key: "Weight",
          value: "450 gm",
        ),
      ],
    );
  }

  Widget _productImage() {
    return Image.asset(
      'assets/foods/polopizza.png',
      height: 250,
    );
  }

  Widget _transactionBtn(context) {
    return Row(
      children: [
        Expanded(
          child: CircularButton(
            fgColor: kColorWhiteText,
            title: "Buy Now",
            bgColor: Theme.of(context).accentColor,
            onPressed: () async {
              await _homeContrstate.onBottomNavClick(2);
            },
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: CircularButton(
              title: "Add To Cart",
              bgColor: Theme.of(context).primaryColorDark,
              onPressed: () async {
                await _homeContrstate.onBottomNavClick(2);
              }),
        ),
      ],
    );
  }

  Widget _productQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _prodDetailContr.onDecrQuantity(),
          icon: Icon(Icons.remove),
        ),
        EachProductBox(
          label: _prodDetailContr.currentQuantity.toString(),
          onPressed: () {},
        ),
        IconButton(
          onPressed: () => _prodDetailContr.onIncrQuantity(),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _eachProductInfo(
    context, {
    required String key,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          key,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          value,
          style: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }

  // Widget _price(int price, context) {
  //   return Text(
  //     "Rs.$price",
  //     style: GoogleFonts.lato(
  //       fontSize: 22,
  //       color: Theme.of(context).accentColor,
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }

  Widget _ingredient(context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Salami, chilli peppers, tomatoes, oregano, basil",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbarAction(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          paddingLeft: 9,
          icon: Icons.arrow_back_ios,
          onPressed: () {
            _homeContrstate.onChangeWidget(1);
          },
        ),
        CustomIconButton(
          onPressed: () async {
            await _homeContrstate.onBottomNavClick(2);
            // Navigator.pushNamed(context, HomeScreen.routeName);
          },
          icon: Icons.shopping_bag_outlined,
        ),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "Pepperoni Pizza",
        style: GoogleFonts.raleway(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
